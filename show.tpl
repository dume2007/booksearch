<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?php if (!empty($q)) echo $title . " - "; ?>狗狗电子书，小说下载 - Powered by 东城狗狗搜索</title>
    <meta http-equiv="keywords"
          content="<?php echo $title.','.$doc->classname.','.mb_substr(htmlspecialchars($doc->description),0,120,'utf-8');?>，狗狗电子书txt免费下载"/>
    <meta http-equiv="description" content="<?php echo $title;?>"/>
    <link rel="stylesheet" href="http://cdn.staticfile.org/twitter-bootstrap/3.3.4/css/bootstrap.min.css"/>
    <style type="text/css">
        @media (min-width: 768px) {
            .form-inline .form-control {width: 400px;}
        }
    </style>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?dea9de4391f100a569a0db9df14f545c";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script type="text/javascript">
        function ad_gg() {
	  document.writeln("<script async src='https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js'><\/script>");
document.writeln("<!-- 自适应广告 -->");
document.writeln("<ins class=\'adsbygoogle\'");
document.writeln("     style=\'display:block\'");
document.writeln("     data-ad-client=\'ca-pub-4158540502440532\'");
document.writeln("     data-ad-slot=\'4112439016\'");
document.writeln("     data-ad-format=\'auto\'");
document.writeln("     data-full-width-responsive=\'true\'></ins>");
document.writeln("<script>");
document.writeln("     (adsbygoogle = window.adsbygoogle || []).push({});");
document.writeln("<\/script>");
        }
    </script>
</head>
<body style="background-color:#f9f9f9;color: #383838;">
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <a href="/">
                <h1 style="margin: 40px 0;padding-bottom: 20px; border-bottom: 1px solid #c7c0c0; color: #1773a0;font-weight: bold;">
                    <span class="glyphicon glyphicon-phone" aria-hidden="true"></span>狗狗电子书</h1>
            </a>
        </div>
        <div class="col-md-12">
            <script type="text/javascript">ad_gg();</script><br/>
        </div>
        <div class="col-md-12">
            <form class="form-inline" id="q-form" action="/">
                <div class="form-group">
                    <label class="radio-inline">
                        <input type="radio" name="st" id="inlineRadio1" value="book" checked="checked"> 电子书
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="st" id="inlineRadio2" value="online"> 在线阅读
                    </label>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="inputQ">关键词</label>
                    <input type="text" name="q" class="form-control" id="inputQ" title="输入任意关键词皆可搜索"
                           placeholder="输入任意关键词皆可搜索" value="<?php echo htmlspecialchars($title); ?>"/>
                </div>
                <input type="hidden" name="f" value="_all"/>
                <input type="hidden" name="m" value="yes"/>
                <button type="submit" class="btn btn-primary">搜一下</button>
            </form>
        </div>
    </div>

    <div class="clearfix"><br/></div>

    <!-- begin search result -->
    <?php if (!empty($q)): ?>
    <div class="row">
        <div class="col-md-12">
            <!-- neck bar -->
            <?php if (!empty($error)): ?>
            <p class="text-error"><strong>错误：</strong><?php echo $error; ?></p>
            <?php else: ?>
            <p class="result">
                大约有<b><?php echo number_format($count); ?></b>项符合查询结果，库内数据总量为<b><?php echo number_format($total); ?></b>项。（搜索耗时：<?php printf('%.4f', $search_cost); ?>
                秒） [<a href="<?php echo " $bu&o=$o&n=$n&xml=yes"; ?>" target="_blank">XML</a>]</p>
            <?php endif; ?>

            <!-- fixed query -->
            <?php if (count($corrected) > 0): ?>
            <div class="link corrected">
                <h4>您是不是要找：</h4>
                <p>
                    <?php foreach ($corrected as $word): ?>
                    <span><a href="<?php echo '/book/' . urlencode($word); ?>/1"
                             class="text-error"><?php echo $word; ?></a></span>
                    <?php endforeach; ?>
                </p>
            </div>
            <?php endif; ?>
        </div>

        <!-- empty result -->
        <?php if ($count === 0 && empty($error)): ?>
        <div class="col-md-12">
            <p class="text-error">找不到和 <em><?php echo htmlspecialchars($q); ?></em> 相符的内容或信息。</p>
            <h5>建议您：</h5>
            <ul>
                <li>1.请检查输入字词有无错误。</li>
                <li>2.请换用另外的查询字词。</li>
                <li>3.请改用较短、较为常见的字词。</li>
            </ul>
        </div>
        <?php endif; ?>

        <!-- result doc list -->
        <div class="col-md-12">
            <?php if ($doc): ?>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><span class="glyphicon glyphicon-book"
                                                  aria-hidden="true"></span> <?php echo $search->
                        highlight(strip_tags($doc->title)); ?></h3>
                </div>
                <div class="panel-body">
                    <?php
          if($doc->thumb) {
                    echo '<img src="'.$doc->thumb.'" width="115" alt="'.$doc->title.'">';
                    }
                    ?>
                    <p><?php echo $doc->description; ?></p>
                    <p class="field-info text-error">
                        <ul>
                            <li><strong>分类:</strong> <a
                                        href="/book/classname/<?php echo $doc->classname;?>/1"><?php echo $doc->
                                    classname; ?></a></li>
                            <li><strong>栏目:</strong> <a
                                        href="/book/typename/<?php echo $doc->typename;?>/1"><?php echo $doc->typename;
                                    ?></a></li>
                            <li><strong>作者:</strong> <a
                                        href="/book/author/<?php echo $doc->author;?>/1"><?php echo $doc->author; ?></a>
                            </li>
                            <li><strong>录入时间:</strong> <?php echo date('Y-m-d', $doc->addtime); ?></li>
                            <li><strong>信息:</strong> <?php echo str_replace('||',',',$doc->info); ?></li>
                            <li><strong>下载地址:</strong>
                    <p><script type="text/javascript">ad_gg();</script></p>
                                <?php
                		$downs = explode('||', $doc->download);
                                if(!$downs || stristr($doc->download, '99xsw') || stristr($doc->download, 'jjxsw') ||
                                stristr($doc->download, 'jjxs') || stristr($doc->download, 'txt99')) {
                                $downs = explode(',http', $doc->download);
                                foreach($downs as &$item){
                                if(!stristr($item, 'http')) {
                                $item = 'http' . $item;
                                }
                                $item = urldecode(basename2($item));
                                $item = "http://yun.gouyg.com/ebook/".$item;
                                }
                                }
                                else {
                                array_unshift($downs,
                                'http://yun.gouyg.com/book/'.$doc->classname.'/'.$doc->typename.'/'.$doc->title.'.rar');
                                }

                                foreach($downs as $k=>$url) {
                                $arr = explode('.', $url);
                                $ext = array_pop($arr);
                                $url_title = $doc->title . '.' . $ext;

                                if($k == 0) {
                                $icon = 'glyphicon glyphicon-thumbs-up';
                                } else {
                                $icon = 'glyphicon glyphicon-hand-right';
                                }
                                echo '
                    <p><a class="ui-button ui-button-text-icon-primary" target="_blank" href="'.$url.'">
                            <button class="btn btn-default"><span class="'.$icon.'" aria-hidden="true"></span>
                                '.$url_title.'
                            </button>
                        </a></p>
                    ';
                    }
                    ?>
                    </li>
                    </ul></p>
                </div>
            </div>
            <?php endif; ?>
        </div>

    </div>
    <?php endif; ?>
    <!-- end search result -->

    <!-- ntag search -->
    <?php if (count($ntag) > 0): ?>
    <div class="row">
        <div class="col-md-12">
            <h4>分类标签:</h4>
            <p>
                <?php foreach($ntag as $item):
        ?>
                <span><a href="<?php echo '/book/classname/' . urlencode($item['classname']) . '/1'; ?>"><?php echo $item['classname']; ?></a></span>
                <?php endforeach; ?>
            </p>
        </div>
    </div>
    <?php endif; ?>

    <!-- related query -->
    <?php if (count($related) > 0): ?>
    <div class="row">
        <div class="col-md-12">
            <h4>相关搜索:</h4>
            <p>
                <?php foreach ($related as $word): ?>
                <span><a href="<?php echo '/book/' . urlencode($word) . '/1'; ?>"><?php echo $word; ?></a></span>
                <?php endforeach; ?>
            </p>
        </div>
    </div>
    <?php endif; ?>

    <div class="row">
        <script type="text/javascript">ad_gg();</script><br/>
    </div>

    <!-- hot search -->
    <?php if (count($hot) > 0): ?>
    <div class="row">
        <div class="col-md-12">
            <h4>热门搜索:</h4>
            <p>
                <?php foreach($hot as $word => $freq):
                $word2 = trim(preg_replace('/[\'\w\s%]+/', '', $word));
                if(empty($word2) || strlen($word) > 16 || in_array(urlencode($word), ['%CC%D8%D6%D6','%C3%FE%B9%C7%C9','%C8%A5+%C4%BC','%D1%AA+%D6%AE%CE%D2%CA%C7+%DB%CD'])) {
                    continue;
                }
                ?>
                <span><a href="<?php echo '/book/' . urlencode($word); ?>/1"><?php echo $word; ?></a></span>
                <?php endforeach; ?>
            </p>
        </div>
    </div>
    <?php endif; ?>

    <!-- footer -->
    <footer>
        <p>(C)opyright 2011 - Books search - 页面处理总时间：<?php printf('%.4f', $total_cost); ?>秒<br>
            Powered by <a href="http://www.gouyg.com/" target="_blank" title="东城狗狗搜索">东城狗狗搜索/WEB2.0</a></p>
    </footer>
</div>

<script type="text/javascript" src="http://cdn.staticfile.org/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/twitter-bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>
