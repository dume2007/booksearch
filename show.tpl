<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo $oe; ?>" />
<meta name="googlebot" content="index,noarchive,nofollow,noodp" />
<meta name="robots" content="index,nofollow,noarchive,noodp" />
<title><?php if (!empty($q)) echo "信息：" . $title . " - "; ?>狗狗搜索资源 - Powered by 东城狗狗搜索</title>
<meta http-equiv="keywords" content="东城狗狗搜索,狗狗搜索小说,狗狗搜索数据,狗狗搜索在线阅读" />
<meta http-equiv="description" content="东城狗狗搜索,狗狗搜索小说,狗狗搜索数据,狗狗搜索在线阅读" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<link rel="stylesheet" href="http://apps.bdimg.com/libs/jqueryui/1.9.2/themes/redmond/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://apps.bdimg.com/libs/jqueryui/1.9.2/themes/redmond/jquery.ui.theme.css" type="text/css" media="all" />
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!--[if lte IE 6]>
<link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.css" />
<link rel="stylesheet" type="text/css" href="css/ie.css" />
<![endif]-->
</head>
<!-- search.tpl Books 搜索模板 -->	
<body>
<div class="container">
  <div class="row">
	<!-- search form -->
    <div class="span12">
      <h1><a href="<?php echo $_SERVER['SCRIPT_NAME']; ?>"><img src="img/logo.jpg" /></a></h1>
      <form class="form-search" id="q-form" method="get">
        <div class="input-append" id="q-input">
          <select name="st" style="width:85px;">
            <option value="book">电子书</option>
            <option value="online">在线阅读</option>
          </select> &nbsp;
          <input type="text" class="span6 search-query" name="q" title="输入任意关键词皆可搜索" value="<?php echo htmlspecialchars($title); ?>">
          <button type="submit" class="btn">搜索</button>
        </div>
        <div class="condition" id="q-options">
          <label class="radio inline"><input type="radio" name="f" value="title" <?php echo $f_title; ?> />书名</label>
			<!--<label class="radio inline"><input type="radio" name="f" value="index" <?php echo $f_index; ?> />索引</label>-->
			<label class="radio inline"><input type="radio" name="f" value="classname" <?php echo $f_classname; ?> />分类</label>
			<label class="radio inline"><input type="radio" name="f" value="typename" <?php echo $f_typename; ?> />栏目</label>
			<label class="radio inline"><input type="radio" name="f" value="author" <?php echo $f_author; ?> />作者</label>
          <label class="radio inline">
            <input type="radio" name="f" value="_all" <?php echo $f__all; ?> />全文
          </label>
          <label class="checkbox inline">
            <input type="checkbox" name="m" value="yes" <?php echo $m_check; ?> />模糊搜索 
          </label>
          <label class="checkbox inline">
            <input type="checkbox" name="syn" value="yes" <?php echo $syn_check; ?> />同义词
          </label>
          按
          <select name="s" size="1">
            <option value="relevance">相关性</option>
			<option value="addtime_DESC" <?php echo $s_addtime_DESC; ?>>按时间从大到小</option>
					<option value="addtime_ASC" <?php echo $s_addtime_ASC; ?>>按时间从小到大</option>
          </select>
          排序
		</div>
      </form>
    </div>

    <!-- begin search result -->
    <?php if (!empty($q)): ?>
    <div class="span12">
      <!-- neck bar -->
      <?php if (!empty($error)): ?>
      <p class="text-error"><strong>错误：</strong><?php echo $error; ?></p>
	  <?php else: ?>
	  <p class="result">大约有<b><?php echo number_format($count); ?></b>项符合查询结果，库内数据总量为<b><?php echo number_format($total); ?></b>项。（搜索耗时：<?php printf('%.4f', $search_cost); ?>秒） [<a href="<?php echo "$bu&o=$o&n=$n&xml=yes"; ?>" target="_blank">XML</a>]</p>
      <?php endif; ?>
      
      <!-- fixed query -->
      <?php if (count($corrected) > 0): ?>
      <div class="link corrected">
        <h4>您是不是要找：</h4>
        <p>
          <?php foreach ($corrected as $word): ?>
          <span><a href="<?php echo $_SERVER['SCRIPT_NAME'] . '?q=' . urlencode($word); ?>" class="text-error"><?php echo $word; ?></a></span>
          <?php endforeach; ?>
        </p>
      </div>
      <?php endif; ?>
      
      <!-- empty result -->
      <?php if ($count === 0 && empty($error)): ?>
      <div class="demo-error">
        <p class="text-error">找不到和 <em><?php echo htmlspecialchars($q); ?></em> 相符的内容或信息。</p>
        <h5>建议您：</h5>
        <ul>
          <li>1.请检查输入字词有无错误。</li>
          <li>2.请换用另外的查询字词。</li>
          <li>3.请改用较短、较为常见的字词。</li>
        </ul>
      </div>
      <?php endif; ?>
      
      <!-- result doc list -->
      <dl class="result-list">
        <?php if ($doc): ?>
        <dt>
          <h1><?php echo $search->highlight(strip_tags($doc->title)); ?></h1>   
        </dt>
        <dd>
          <?php 
          if($doc->thumb) {
            echo '<img src="'.$doc->thumb.'" width="115" alt="'.$doc->title.'">';
          }
          ?>
          <p><?php echo $doc->description; ?></p>
          <p class="field-info text-error">
            <!--<span><strong>Index:</strong><?php echo htmlspecialchars($doc->index); ?></span>-->
				    <li><strong>分类:</strong> <a href="/?q=<?php echo $doc->classname;?>&f=classname&s=relevance"><?php echo $doc->classname; ?></a></li>
				    <li><strong>栏目:</strong> <a href="/?q=<?php echo $doc->typename;?>&f=typename&s=relevance"><?php echo $doc->typename; ?></a></li>
				    <li><strong>作者:</strong> <a href="/?q=<?php echo $doc->author;?>&f=author&s=relevance"><?php echo $doc->author; ?></a></li>
            <li><strong>录入时间:</strong> <?php echo date('Y-m-d', $doc->addtime); ?></li>
				    <li><strong>信息:</strong> <?php echo str_replace('||',',',$doc->info); ?></li>
            <li><strong>下载地址:</strong>
              <?php
                $downs = explode('||', $doc->download);
                array_unshift($downs, 'http://lnpan.b0.upaiyun.com/book/'.$doc->classname.'/'.$doc->typename.'/'.$doc->title.'.rar');
                foreach($downs as $url) {
                  $arr = explode('.', $url);
                  $ext = array_pop($arr);
                  $url_title = $doc->title . '.' . $ext;
                  echo '<p><a class="ui-button ui-button-text-icon-primary" href="'.$url.'"><button>'.$url_title.'</button></a></p>';
                }
              ?>
            </li>
				    <!--<span><strong>Indextime:</strong><?php echo htmlspecialchars($doc->indextime); ?></span>-->
          </p>
        </dd>
        <?php endif; ?>
      </dl>
      
      <!-- pager -->
      <?php if (!empty($pager)): ?>
      <div class="pagination pagination-centered">
        <ul>
          <!--<li><a href="#">Prev</a></li>-->
          <?php echo $pager; ?>
          <!--<li><a href="#">Next</a></li>-->
        </ul>
      </div>
      <?php endif; ?>

    </div>
    <?php endif; ?>
    <!-- end search result -->
  </div>
</div>

<!-- hot search -->
<?php if (count($hot) > 0): ?>
<section class="link">
  <div class="container">
    <h4>热门搜索:</h4>
    <p>
      <?php foreach($hot as $word => $freq): ?>
      <span><a href="<?php echo $_SERVER['SCRIPT_NAME'] . '?q=' . urlencode($word); ?>"><?php echo $word; ?></a></span>
      <?php endforeach; ?>	
    </p>
  </div>
</section>
<?php endif; ?>

<!-- related query -->
<?php if (count($related) > 0): ?>
<section class="link">
  <div class="container">
    <h4>相关搜索:</h4>
    <p>
      <?php foreach ($related as $word): ?>
      <span><a href="<?php echo $_SERVER['SCRIPT_NAME'] . '?q=' . urlencode($word); ?>"><?php echo $word; ?></a></span>
      <?php endforeach; ?>	
	</p>
  </div>
</section>
<?php endif; ?>

<!-- footer -->
<footer>
  <div class="container">
    <p>(C)opyright 2011 - Books search - 页面处理总时间：<?php printf('%.4f', $total_cost); ?>秒<br>
      Powered by <a href="http://www.gouyg.com/" target="_blank" title="东城狗狗搜索">东城狗狗搜索/WEB2.0</a></p>
  </div>
</footer>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
<script type="text/javascript">
$(function(){
	// input tips
	$('#q-input .search-query').focus(function(){
		if ($(this).val() == $(this).attr('title')) {
			$(this).val('').removeClass('tips');
		}
	}).blur(function(){
		if ($(this).val() == '' || $(this).val() == $(this).attr('title')) {
			$(this).addClass('tips').val($(this).attr('title'));
		}
	}).blur().autocomplete({
		'source':'suggest.php',
		'select':function(ev,ui) {
			$('#q-input .search-query').val(ui.item.label);
			$('#q-form').submit();
		}
	});
	// submit check
	$('#q-form').submit(function(){
		var $input = $('#q-input .search-query');
		if ($input.val() == $input.attr('title')) {
			alert('请先输入关键词');
			$input.focus();
			return false;
		}
	});	
});	
</script>
</body>
</html>
