<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php if (!empty($q)) echo "标签：" . strip_tags($q) . " - "; ?>狗狗电子书，小说下载 - Powered by 东城狗狗搜索</title>
<meta http-equiv="keywords" content="东城狗狗搜索,狗狗电子书,小说下载,狗狗搜索小说,狗狗搜索数据,狗狗搜索在线阅读" />
<meta http-equiv="description" content="东城狗狗搜索,狗狗电子书,txt小说下载,狗狗搜索小说,狗狗搜索数据,狗狗搜索在线阅读" />
<link rel="stylesheet" href="http://cdn.staticfile.org/twitter-bootstrap/3.3.4/css/bootstrap.min.css" />
<link rel="stylesheet" href="http://cdn.staticfile.org/jqueryui/1.8.16/themes/redmond/jquery-ui.css" type="text/css" media="all" />
<style type="text/css">
@media (min-width: 768px) {
  .form-inline .form-control {width: 400px;}
}
h4 em{color: red;}
.panel-body em, .nbook em{color: #f44336;}
</style>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?dea9de4391f100a569a0db9df14f545c";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
  <script type="text/javascript">
    function ad_gg() {
      document.writeln("<script async src='https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js'><\/script>");
      document.writeln("<!-- 自适应广告 -->");
      document.writeln("<ins class=\'adsbygoogle\'");
      document.writeln("     style=\'display:block\'");
      document.writeln("     data-ad-client=\'ca-pub-4158540502440532\'");
      document.writeln("     data-ad-slot=\'4112439016\'");
      document.writeln("     data-ad-format=\'auto\'");
      document.writeln("     data-full-width-responsive=\'true\'></ins>");
      document.writeln("<script>");
      document.writeln("     (adsbygoogle = window.adsbygoogle || []).push({});");
      document.writeln("<\/script>");
    }
  </script>
</head>
<!-- search.tpl Books 搜索模板 -->  
<body style="background-color:#f9f9f9;color: #383838;">

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <a href="/">
        <h1 style="margin: 40px 0;padding-bottom: 20px; border-bottom: 1px solid #c7c0c0; color: #1773a0;font-weight: bold;"><span class="glyphicon glyphicon-phone" aria-hidden="true"></span>狗狗电子书</h1>
      </a>
    </div>
    <div class="col-md-12">
      <script type="text/javascript">ad_gg();</script><br/>
    </div>
    <div class="col-md-12">
      <form class="form-inline" id="q-form" action="/">
        <div class="form-group">
          <label class="radio-inline">
            <input type="radio" name="st" id="inlineRadio1" value="book" checked="checked"> 电子书
          </label>
          <label class="radio-inline">
            <input type="radio" name="st" id="inlineRadio2" value="online"> 在线阅读
          </label>
        </div>
        <div class="form-group">
          <label class="sr-only" for="inputQ">关键词</label>
          <input type="text" name="q" class="form-control" id="inputQ" title="输入任意关键词皆可搜索" placeholder="输入任意关键词皆可搜索" value="<?php echo htmlspecialchars($q); ?>" />
        </div>
        <input type="hidden" name="f" value="_all" />
        <input type="hidden" name="m" value="yes" />
        <button type="submit" class="btn btn-primary">搜一下</button>
      </form>
    </div>
  </div>

  <div class="clearfix"><br/></div>

  <!-- begin search result -->
  <?php if (!empty($q)): ?>
  <div class="row">
    <div class="col-md-12">
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
          <span><a href="<?php echo '/book/' . urlencode($word); ?>/1" class="text-error"><?php echo $word; ?></a></span>
          <?php endforeach; ?>
        </p>
      </div>
      <?php endif; ?>
    </div>
    
    <!-- empty result -->
    <?php if ($count === 0 && empty($error)): ?>
    <div class="col-md-12">
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
    <div class="col-md-12">      
      <?php foreach ($docs as $k=>$doc):
        $local_count = (int) $redis->get('chapters:'.$doc->md5id);
        if ($k == 2) {
          echo '<div class="row"><script type="text/javascript">ad_gg();</script><br/></div>';
        }
      ?>
      <div class="panel panel-default">
        <div class="panel-heading">
          <a href="/book/<?php echo urlencode($doc->index); ?>.html"><h4><?php echo $doc->rank(); ?>. <?php echo $search->highlight(strip_tags($doc->title)); ?> <small>[<?php echo $doc->percent(); ?>%]</small></h4></a>     
        </div>
        <div class="panel-body">
          <p><?php echo $search->highlight(strip_tags($doc->description)); ?></p>
          <p class="field-info text-error"><small>
            <!--<span><strong>Index:</strong><?php echo htmlspecialchars($doc->index); ?></span>-->
            <span><strong>分类:</strong><a href="/book/classname/<?php echo $doc->classname;?>/1"><?php echo $search->highlight($doc->classname); ?></a></span>
            <span><strong>栏目:</strong><a href="/book/typename/<?php echo $doc->typename;?>/1"><?php echo $search->highlight($doc->typename); ?></a></span>
            <span><strong>作者:</strong><a href="/book/author/<?php echo $doc->author;?>/1"><?php echo $search->highlight($doc->author); ?></a></span>
            <span><strong>录入时间:</strong><?php echo date('Y-m-d', $doc->addtime); ?></span>
            <span><strong>信息:</strong><?php echo str_replace('||',',',$doc->info); ?></span>
            <!--<span><strong>Indextime:</strong><?php echo htmlspecialchars($doc->indextime); ?></span>-->
          </small></p>
        </div>
      </div>
      <?php endforeach; ?>
    </div>
    
    <!-- pager -->
    <?php if (!empty($pager)): ?>
    <div class="col-md-12">
      <nav aria-label="Page navigation">
        <ul class="pagination">
          <!--<li><a href="#">Prev</a></li>-->
          <?php echo $pager; ?>
          <!--<li><a href="#">Next</a></li>-->
        </ul>
      </nav>
    </div>
    <?php endif; ?>

  </div>
  <?php endif; ?>
  <!-- end search result -->
  
  <!-- nbook search -->
  <?php if (count($nbook) > 0): ?>
  <div class="row">
    <div class="col-md-12">
      <h4>最新入库:</h4>
      <div class="row nbook">
        <?php foreach($nbook as $item):
          $title = $item['title'];
          if($item['addtime'] > strtotime(date('Y-m-d'))) {
            $title = "<em>{$title}</em>";
          }
        ?>
        <div class="col-xs-6 col-sm-3">
            <a href="<?php echo '/book/' . $item['md5id'] . '.html'; ?>"><?php echo $title; ?></a>
        </div>
        <?php endforeach; ?>
      </div>
    </div>
  </div>
  <?php endif; ?>

  <!-- ntag search -->
  <?php if (count($ntag) > 0): ?>
  <div class="row">
    <div class="col-md-12">
      <h4>分类标签:</h4>
      <p>
        <?php foreach($ntag as $item):
        ?>
        <span><a href="<?php echo '/book/classname/' . urlencode($item['classname']) . '/1'; ?>"><?php echo $item['classname']; ?></a></span>
        <?php endforeach; ?>
      </p>
    </div>
  </div>
  <?php endif; ?>

  <!-- related query -->
  <?php if (count($related) > 0): ?>
  <div class="row">
    <div class="col-md-12">
      <h4>相关搜索:</h4>
      <p>
        <?php foreach ($related as $word): ?>
        <span><a href="<?php echo '/book/' . urlencode($word) . '/1'; ?>"><?php echo $word; ?></a></span>
        <?php endforeach; ?>
      </p>
    </div>
  </div>
  <?php endif; ?>

  <div class="row">
    <script type="text/javascript">ad_gg();</script><br/>
  </div>

  <!-- hot search -->
  <?php if (count($hot) > 0): ?>
  <div class="row">
    <div class="col-md-12">
      <h4>热门搜索:</h4>
      <p>
        <?php foreach($hot as $word => $freq):
        $word2 = trim(preg_replace('/[\w\s%]+/', '', $word));
        var_dump([$word, $word2]);
        if(empty($word2) || strlen($word) > 16 || urlencode($word) == '%CC%D8%D6%D6' || urlencode($word) == '%C3%FE%B9%C7%C9') {
        continue;
        }
        ?>
        <span><a href="<?php echo '/book/' . urlencode($word) . '/1'; ?>"><?php echo $word; ?></a></span>
        <?php endforeach; ?>
      </p>
    </div>
  </div>
  <?php endif; ?>

  <!-- footer -->
  <footer>
      <p>(C)opyright 2011 - Books search - 页面处理总时间：<?php printf('%.4f', $total_cost); ?>秒<br>
        Powered by <a href="http://www.gouyg.com/" target="_blank" title="东城狗狗搜索">东城狗狗搜索/WEB2.0</a></p>
  </footer>
</div>

<script type="text/javascript" src="http://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/twitter-bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>
