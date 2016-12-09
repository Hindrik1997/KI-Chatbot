<?php
 	$username = '8MKVSb9CStTzqg';
 	$password = 'orM09nyTv7x0nD947-CbtgHrDWo';

	$postvals = http_build_query($_POST);

	$ch = curl_init("https://www.reddit.com/api/v1/access_token");
	$options = array(
	    CURLOPT_RETURNTRANSFER => true,
	    CURLOPT_CONNECTTIMEOUT => 5,
	    CURLOPT_TIMEOUT => 10,
	    CURLOPT_USERAGENT => "Prolog test",
	    CURLOPT_POST => true,
	    CURLOPT_POSTFIELDS => $postvals,
	    CURLOPT_HTTPAUTH => CURLAUTH_BASIC,
	    CURLOPT_USERPWD => $username .":". $password
	);
	curl_setopt_array($ch, $options);

	$api_response = curl_exec($ch);
	$response = json_decode($api_response);
	curl_close($ch);

	echo $api_response;
	// var_dump($response);
?>