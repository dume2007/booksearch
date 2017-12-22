<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>在线阅读《<?php echo $book['title'];?>》 - 狗狗搜索资源 - Powered by 东城狗狗搜索</title>
<meta http-equiv="keywords" content="在线阅读《<?php echo $book['title'];?>》,狗狗搜索资源" />
<meta http-equiv="description" content="在线阅读《<?php echo $book['title'];?>》 - 狗狗搜索资源" />
<link rel="stylesheet" href="http://apps.bdimg.com/libs/bootstrap/3.3.4/css/bootstrap.min.css" />
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?d8fb9a8b96acc1cbe4f380fdf3fe0354";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
</head>
<!-- search.tpl Books 搜索模板 -->  
<body style="background-color:#9fc383;color: #383838;">
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/"><span class="glyphicon glyphicon-phone" aria-hidden="true"></span> 东城狗狗搜索</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
      <form class="navbar-form navbar-left">
        <div class="form-group">
          <input type="text" name="q" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">搜一下</button>
      </form>
    </div>
  </div>
</nav>
    
<div class="container">
  <div class="row">
    <div class="col-md-12">
        <h1><?php echo $book['title'];?> <sup><a href="/">[返回首页]</a></sup></h1>
        <div id="body">
        <?php 
        foreach($chapters as $item){
            echo '<p class="col-md-4"><a href="/read.php?q='.$q.'&id='.$item['md5url'].'">'.$item['title'].'</a></p>';
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
