<?php
$redis = new Redis();  
$ret = $redis->connect("localhost", "6379");  //php客户端设置的ip及端口
$redis->auth('dc0623');
$redis->select(2);

$q = $_GET['q'];
$book = $redis->get('books:'.$q);
if(empty($book)) {
    die('404 Not Found');
}

$data = json_decode($book, true);

include dirname(__FILE__) . '/book.tpl';