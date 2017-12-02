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
$data = json_decode($book, true);

//查找上下章
$total = count($data['urls']);
foreach ($data['urls'] as $k=>$url) {
    $md5url = md5($url);
    if($md5url == $id) {
        $data['pre'] = $k>0 ? [$data['urls'][$k-1], $data['titles'][$k-1]] : [];
        $data['next'] = $k<$total ? [$data['urls'][$k+1], $data['titles'][$k+1]] : [];
        break;
    }
}

include dirname(__FILE__) . '/read.tpl';