
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="googlebot" content="index,noarchive,nofollow,noodp" />
<meta name="robots" content="index,nofollow,noarchive,noodp" />
<title>在线阅读《<?php echo $data['title'];?>》 - Books 搜索 - Powered by 东城狗狗搜索</title>
<meta http-equiv="keywords" content="Fulltext Search Engine Books 东城狗狗搜索" />
<meta http-equiv="description" content="Fulltext Search for Books, Powered by 东城狗狗搜索/WEB2.0 " />
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<link rel="stylesheet" href="http://apps.bdimg.com/libs/jqueryui/1.9.2/themes/redmond/jquery-ui.css" type="text/css" media="all" />
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
      <h1><a href="/index.php"><img src="img/logo.jpg" /></a></h1>
      <form class="form-search" id="q-form" method="get">
        <div class="input-append" id="q-input">
          <select name="search_type" style="width:85px;">
            <option value="book">电子书</option>
            <option value="online" selected="">在线阅读</option>
          </select> &nbsp;
          <input type="text" class="span6 search-query" name="q" title="输入任意关键词皆可搜索" value="<?php echo $data['title'];?>">
          <button type="submit" class="btn">搜索</button>
        </div>
        <div class="condition" id="q-options">
          <label class="radio inline"><input type="radio" name="f" value="title"  />书名</label>
            <label class="radio inline"><input type="radio" name="f" value="classname"  />分类</label>
            <label class="radio inline"><input type="radio" name="f" value="typename"  />栏目</label>
            <label class="radio inline"><input type="radio" name="f" value="author"  checked />作者</label>
          <label class="radio inline">
            <input type="radio" name="f" value="_all"  />全文
          </label>
          <label class="checkbox inline">
            <input type="checkbox" name="m" value="yes"  />模糊搜索 
          </label>
          <label class="checkbox inline">
            <input type="checkbox" name="syn" value="yes"  />同义词
          </label>
          按
          <select name="s" size="1">
            <option value="relevance">相关性</option>
            <option value="addtime_DESC" >按时间从大到小</option>
                    <option value="addtime_ASC" >按时间从小到大</option>
          </select>
          排序
        </div>
      </form>
    </div>

    <!-- begin search result -->
    <div class="span12">
            
      <!-- result doc list -->
      <dl class="result-list">
        <dt><h1><?php echo $data['title'];?></h1></dt>
        <dd><ul class="chapters_list">
        <?php 
        foreach($data['titles'] as $k=>$title){
            echo '<li><a href="'.$data['urls'][$k].'">'.$title.'</a></li>';
        }
        ?> 
        </ul></dd>
      </dl>
    </div>
        <!-- end search result -->
  </div>
</div>

<!-- footer -->
<footer>
  <div class="container">
    <p>(C)opyright 2011 - Books search - 页面处理总时间：0.1298秒<br>
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