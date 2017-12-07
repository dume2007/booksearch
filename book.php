<?php
include_once('../include/config.php');
include_once('../include/Db.class.php');

$model = new Db;

$q = $_GET['q'];
$q = preg_replace('/(^\w)/i', '', $q);
$book = $model->find('book', "md5id='{$q}'");
if(empty($book)) {
    die('404 Not Found');
}

$chapters = $model->query("select * from book_chapter where book_id='".$book['id']."' order by page_id asc,id asc");

include dirname(__FILE__) . '/book.tpl';