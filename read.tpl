
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="googlebot" content="index,noarchive,nofollow,noodp" />
<meta name="robots" content="index,nofollow,noarchive,noodp" />
<title><?php echo $data['curr'];?>《<?php echo $data['title'];?>》 - Books 搜索 - Powered by 东城狗狗搜索</title>
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
<body style="background-color:#9fc383;">
<div class="container">
  <div class="row">
    <!-- begin search result -->
    <div class="span12">
            
      <!-- result doc list -->
      <dl class="result-list">
        <dt><h1 id="title">《<?php echo $data['title'];?>》<?php echo $data['curr'];?></h1></dt>
        <dd>
          <div id="body" style="line-height:28px;font-size:18px;">加载中...</div>
          <?php 
          echo '<p><b>回到目录：</b><a href="/book.php?q='.$q.'">'.$data['title'].'</a>, <b>返回首页：</b><a href="/">搜索首页</a></p>';
          if($data['pre']) {
            echo '<p><b>上一章：</b><a id="pre_link" href="/read.php?q='.$q.'&id='.$data['pre'][0].'">'.$data['pre'][1].'</a></p>';
          }

          if($data['next']) {
            echo '<p><b>下一章：</b><a id="next_link" href="/read.php?q='.$q.'&id='.$data['next'][0].'">'.$data['next'][1].'</a></p>';
          }
          ?>
        </dd>
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
var g_b = 0;
function _body(yurl) {
  $.ajax({
      url: yurl,
      type: 'get',
      cache: true,
      dataType: 'jsonp',
      data: undefined,
      jsonpCallback: 'jcall',
      timeout: 3000,
      success: function(json) {
        $('#body').hide().html(json.body).slideDown('slow');
        document.cookie = "_read_history=" + escape(json.title) + ',' + escape('<?php echo $q;?>') + ',' + escape('<?php echo $id;?>');
      },
      error: function (XMLHttpRequest, textStatus) {
        console.log(textStatus);
        if(g_b == 0) {
          g_b++;
          _body('/book/read_all/<?php echo $q;?>/<?php echo $id;?>');
        } else {
          $('#body').html('加载超时请刷新页面重试！');
        }
      }
  });
}

$(function(){
    _body('http://lnpan.b0.upaiyun.com/book/read_all/<?php echo $q;?>/<?php echo $id;?>');
    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        console.log(e.keyCode);
        if(e && e.keyCode==39 && $('#next_link')){ // 按 ->
          window.location.replace($('#next_link').attr('href'));
        }
        if(e && e.keyCode==37 && $('#pre_link')){ // 按 <-
          window.location.replace($('#pre_link').attr('href'));
        }
    };

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
