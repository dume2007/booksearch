<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>在线阅读《<?php echo $data['title'];?>》 - Books 搜索 - Powered by 东城狗狗搜索</title>
<meta http-equiv="keywords" content="Fulltext Search Engine Books 东城狗狗搜索" />
<meta http-equiv="description" content="Fulltext Search for Books, Powered by 东城狗狗搜索/WEB2.0 " />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
</head>
<!-- search.tpl Books 搜索模板 -->  
<body style="background-color:#9fc383;color: #383838;">
<div class="container">
  <div class="row">
    <div class="col-md-12">
        <h1><?php echo $data['title'];?> <sup><a href="/">[返回首页]</a></sup></h1>
        <div id="body">
        <?php 
        foreach($data['titles'] as $k=>$title){
            echo '<p class="col-md-4"><a href="/read.php?q='.$q.'&id='.md5($data['urls'][$k]).'">'.$title.'</a></p>';
        }
        ?>
        </div>
    </div>
        <!-- end search result -->
  </div>

  <!-- footer -->
  <footer>
    <p>(C)opyright 2011 - Books search - 页面处理总时间：0.1298秒<br>
        Powered by <a href="http://www.gouyg.com/" target="_blank" title="东城狗狗搜索">东城狗狗搜索/WEB2.0</a></p>
  </footer>
</div>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.6.2/jquery.min.js"></script>
</body>
</html>
