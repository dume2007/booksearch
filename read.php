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

$id = $_GET['id'];
$cachefile = "/home/wwwroot/default/lnpan_queue/lnsuu/read_all/{$q}/{$id}";
if(file_exists($cachefile)) {
    $content = file_get_contents($cachefile);
    $content = json_decode($content, true);
}
$data = json_decode($book, true);

include dirname(__FILE__) . '/read.tpl';