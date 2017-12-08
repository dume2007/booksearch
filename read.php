<?php
include_once('./include/config.php');
include_once('./include/Db.class.php');
$model = new Db;

$q = $_GET['q'];
$q = preg_replace('/[^\w]+/i', '', $q);

$book = $model->find('book', "md5id='{$q}'");
if(empty($book)) {
    die('404 Not Found');
}

$id = $_GET['id'];
$id = preg_replace('/[^\w]+/i', '', $id);

//查找章节
$chapter = $model->find('book_chapter', "md5url='{$id}'");
if(empty($chapter)) {
    die('404 Not Found');
}

//查找上下章
$sql = "(select id,page_id,md5url,title from book_chapter where book_id='".$book['id']."' and id<".$chapter['id']." order by id desc limit 1) union (select id,page_id,md5url,title from book_chapter where book_id='".$book['id']."' and id>".$chapter['id']." order by id asc limit 1)";
$relates = $model->query($sql);
foreach ($relates as $item) {
    if($item['id'] < $chapter['id']) {
        $data['pre'] = [$item['md5url'], $item['title']];
    }
    elseif($item['id'] > $chapter['id']) {
        $data['next'] = [$item['md5url'], $item['title']];
    }
}

include dirname(__FILE__) . '/read.tpl';