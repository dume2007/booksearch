<?php
function getFrom($url)
{
	if(stristr($url, 'woquge')) {
		$from = '笔趣阁';
	}
	elseif(stristr($url, 'biquge')) {
		$from = '笔趣阁TW';
	}
	elseif(stristr($url, 'vodtw')) {
		$from = '品书网';
	}
	else {
		$from = '网络';
	}

	return $from;
}