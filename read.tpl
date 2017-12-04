<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo $data['curr'];?>《<?php echo $data['title'];?>》 - Books 搜索 - Powered by 东城狗狗搜索</title>
<meta http-equiv="keywords" content="Fulltext Search Engine Books 东城狗狗搜索" />
<meta http-equiv="description" content="Fulltext Search for Books, Powered by 东城狗狗搜索/WEB2.0 " />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
</head>
<!-- search.tpl Books 搜索模板 -->  
<body style="background-color:#9fc383;color: #383838;">
<div class="container">
  <div class="row">
    <div class="col-md-12">
        <h1 id="title" style="margin: 40px 0; padding-bottom: 20px;border-bottom: 1px solid #91b965">《<?php echo $data['title'];?>》<?php echo $data['curr'];?></h1>
        <div id="body">加载中...</div>
        <?php 
        echo '<p><b>回到目录：</b><a href="/book.php?q='.$q.'">'.$data['title'].'</a>， <b>返回首页：</b><a href="/">搜索首页</a></p>';
        if($data['pre']) {
          echo '<p><b>上一章：</b><a id="pre_link" href="/read.php?q='.$q.'&id='.$data['pre'][0].'">'.$data['pre'][1].'</a></p>';
        }

        if($data['next']) {
          echo '<p><b>下一章：</b><a id="next_link" href="/read.php?q='.$q.'&id='.$data['next'][0].'">'.$data['next'][1].'</a></p>';
        }
        ?>
  </div>
</div>

<!-- footer -->
<footer>
    <p>(C)opyright 2011 - Books search - 页面处理总时间：0.1298秒<br>
      Powered by <a href="http://www.gouyg.com/" target="_blank" title="东城狗狗搜索">东城狗狗搜索/WEB2.0</a></p>
</footer>

<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.6.2/jquery.min.js"></script>
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
}); 
</script>
</body>
</html>
