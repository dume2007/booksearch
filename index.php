<?php
/**
 * search.php 
 * Books 搜索项目入口文件
 * 
 * 该文件由 xunsearch PHP-SDK 工具自动生成，请根据实际需求进行修改
 * 创建时间：2017-10-17 20:47:07
 * 默认编码：UTF-8
 */
// 加载 XS 入口文件
//ini_set('display_errors','on');
//error_reporting(E_ALL ^ E_NOTICE);
include_once('./include/config.php');
include_once('./include/Db.class.php');
require_once '/var/www/html/xunsearch/sdk/php/lib/XS.php';
require_once './include/function.php';

//
// 支持的 GET 参数列表
// q: 查询语句
// m: 开启模糊搜索，其值为 yes/no
// f: 只搜索某个字段，其值为字段名称，要求该字段的索引方式为 self/both
// s: 排序字段名称及方式，其值形式为：xxx_ASC 或 xxx_DESC
// p: 显示第几页，每页数量为 XSSearch::PAGE_SIZE 即 10 条
// ie: 查询语句编码，默认为 UTF-8
// oe: 输出编码，默认为 UTF-8
// xml: 是否将搜索结果以 XML 格式输出，其值为 yes/no
//
// variables
$eu = '';
$__ = array('q', 'm', 'f', 's', 'p', 'ie', 'oe', 'syn', 'xml', 'i', 'st');
foreach ($__ as $_) {
	$$_ = isset($_GET[$_]) ? $_GET[$_] : '';
}

// input encoding
if (!empty($ie) && !empty($q) && strcasecmp($ie, 'UTF-8')) {
	$q = XS::convert($q, $cs, $ie);
	$eu .= '&ie=' . $ie;
}

// output encoding
if (!empty($oe) && strcasecmp($oe, 'UTF-8')) {

	function xs_output_encoding($buf)
	{
		return XS::convert($buf, $GLOBALS['oe'], 'UTF-8');
	}
	ob_start('xs_output_encoding');
	$eu .= '&oe=' . $oe;
} else {
	$oe = 'UTF-8';
}

// recheck request parameters
$m = (empty($m) || $m == 'yes') ? 'yes' : $m;
//$m = 'no';
$q = get_magic_quotes_gpc() ? stripslashes($q) : $q;
$f = empty($f) ? '_all' : $f;
${'m_check'} = ($m == 'yes' ? ' checked' : '');
${'syn_check'} = ($syn == 'yes' ? ' checked' : '');
${'f_' . $f} = ' checked';
${'s_' . $s} = ' selected';

if ($f == 'index') {
	$f__all = ' checked';
}
$q = $q == 'all' ? '*' : $q;
$s = empty($s) ? 'relevance' : $s;
if($s != 'relevance' && $st == 'online') {
	$s = str_replace('addtime', 'indextime', $s);
}

// base url
$bu = $_SERVER['SCRIPT_NAME'] . '?q=' . urlencode($q) . "&st={$st}" . '&m=' . $m . '&f=' . $f . '&s=' . $s . $eu;

// other variable maybe used in tpl
$count = $total = $search_cost = 0;
$docs = $related = $corrected = $hot = array();
$error = $pager = '';
$total_begin = microtime(true);

// output the data
$redis = new Redis();  
$ret = $redis->connect("redis", "6379");  //php客户端设置的ip及端口
$redis->auth('dc0623');
$redis->select(2);

// perform the search
try {
	$xs_index = $st == 'online' ? 'booksonline' : 'books';
	$xs = new XS($xs_index);
	$search = $xs->search;
	$search->setCharset('UTF-8');
	if (empty($q) || $i == 1) {
		// just show hot query
		$hot = $search->getHotQuery(80, 'currnum');
		
		// 取最近入库的数据
		$model = new Db;
	    $nbook = $model->query('select md5id,title,addtime from ebook order by id desc limit 30');

	    // 热门标签
	    $ntag = $redis->get('ebook_classname_tag'); 
	    if(!$ntag) {
	    	$ntag = $model->query('SELECT DISTINCT classname FROM `ebook`');
	    	$redis->setEx('ebook_classname_tag', 2592000, json_encode($ntag));
	    } else {
	    	$ntag = json_decode($ntag, true);
	    }

        // get related query
        $related = $search->getRelatedQuery('小说', 10);
	} else {
		// fuzzy search
		$search->setFuzzy($m === 'yes');

		// synonym search
		$search->setAutoSynonyms($syn === 'yes');

		// set query
		if (!empty($f) && $f != '_all') {
			$search->setQuery($f . ':(' . $q . ')');
		} else {
			$search->setQuery($q);
		}

		// set sort
		if (($pos = strrpos($s, '_')) !== false) {
			$sf = substr($s, 0, $pos);
			$st = substr($s, $pos + 1);
			$search->setSort($sf, $st === 'ASC');
		}

		// set offset, limit
		$p = max(1, intval($p));
		$n = XSSearch::PAGE_SIZE;
		$search->setLimit($n, ($p - 1) * $n);

		// get the result
		$search_begin = microtime(true);
		$docs = $search->search();
		$search_cost = microtime(true) - $search_begin;

		// get other result
		$count = $search->getLastCount();
		$total = $search->getDbTotal();

		if ($xml !== 'yes') {
			// try to corrected, if resul too few
			if ($count < 1 || $count < ceil(0.001 * $total)) {
				$corrected = $search->getCorrectedQuery();
			}

            // get related query
            $related = $search->getRelatedQuery($q, 10);
		}

		// gen pager
		if ($count > $n) {
			$pb = max($p - 5, 1);
			$pe = min($pb + 10, ceil($count / $n) + 1);
			$pager = '';
			do {
				$pager .= ($pb == $p) ? '<li class="disabled"><a>' . $p . '</a></li>' : '<li><a href="/'.$st.'/'.urlencode($q).'/'.$pb.'">' . $pb . '</a></li>';
			} while (++$pb < $pe);
		}
	}
} catch (XSException $e) {
	$error = strval($e);
        var_dump($error);
}

// calculate total time cost
$total_cost = microtime(true) - $total_begin;

// XML OUPUT
if ($xml === 'yes' && !empty($q)) {
	header("Content-Type: text/xml; charset=$oe");
	echo "<?xml version=\"1.0\" encoding=\"$oe\" ?>\n";
	echo "<xs:result count=\"$count\" total=\"$total\" cost=\"$total_cost\" xmlns:xs=\"http://www.gouyg.com\">\n";
	if ($error !== '') {
		echo "  <error><![CDATA[" . $error . "]]></error>\n";
	}
	foreach ($docs as $doc) {
		echo "  <doc index=\"" . $doc->rank() . "\" percent=\"" . $doc->percent() . "%\">\n";
		foreach ($doc as $k => $v) {
			echo "    <$k>";
			echo is_numeric($v) ? $v : "\n      <![CDATA[" . $v . "]]>\n    ";
			echo "</$k>\n";
		}
		echo "  </doc>\n";
	}
	echo "</xs:result>\n";
	exit(0);
}

if ($ret && $q) {
	$ret = $redis->hIncrBy('BOOK_SEARCH_QUEUE_MAP', $q, 1);
	if($ret >= 5) {
		$redis->hIncrBy('BOOK_SEARCH_QUEUE_MAP_HOT', $q, $ret);
		$redis->hDel('BOOK_SEARCH_QUEUE_MAP', $q);
	}
}

if ($st == 'online') {
	include dirname(__FILE__) . '/booksonline.tpl';
}
elseif ($i == 1) {
	$model = new Db;
	$ebook = $model->find('ebook', "md5id='{$q}'");
	if($ebook) {
		$doc = json_decode(json_encode($ebook));
		$count = 1;
	}

	$title = $doc ? $doc->title : $q;
    $related = $search->getRelatedQuery($title, 10);
	include dirname(__FILE__) . '/show.tpl';
} else {
	include dirname(__FILE__) . '/search.tpl';
}


