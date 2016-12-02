<?php
 	$url = 'https://www.reddit.com/api/v1/access_token';

	// use key 'http' even if you send the request to https://...
	$options = array(
	    'http' => array(
	        'header'  => 'Content-type: application/x-www-form-urlencoded',
	        'method'  => 'POST',
	        'content' => http_build_query($_POST)
	    )
	);
	$context  = stream_context_create($options);
	$result = file_get_contents($url, false, $context);

	var_dump($_POST);
	var_dump(http_build_query($_POST));
	var_dump($result);
?>