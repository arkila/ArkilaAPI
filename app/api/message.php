<?php

$app->get('/api/message/all/{UserId}', function($request) {
	require_once('dbconnect.php');

	$UserId = $request->getAttribute('UserId');

	$query = "SELECT DISTINCT C.user_two, U2.FirstName, U2.LastName FROM `conversation` C 
				INNER JOIN `users` U1 ON C.user_one = U1.UserId
				INNER JOIN `users` U2 ON C.user_two = U2.UserId
				WHERE U1.UserId = '$UserId'";
	$result = $mysqli->query($query);

	if (mysqli_num_rows($result) === 0) {
		echo "Error: No message.";
	}
	else {
		$data = $result->fetch_all(MYSQLI_ASSOC);
		header('Content-Type: application/json');
		echo json_encode($data);
	}
});

$app->post('/api/message/t/{UserId}', function($request) {
	require_once('dbconnect.php');

	$sentTo = $request->getAttribute('UserId');
	$sentFrom = $request->getParsedBody()['CurrentUser'];

	$querycidfk = "SELECT c_id FROM conversation WHERE user_one = '$sentFrom' AND user_two = '$sentTo' LIMIT 1";
	$querycidfkResult = $mysqli->query($querycidfk);
	$rowcidfk = $querycidfkResult->fetch_row();

	$c_id_fk = $rowcidfk[0];

	$queryConversation = "SELECT R.cr_id, R.time, R.reply, U.UserId, U.UserName, U.EmailAddress FROM users U, conversation_reply R WHERE R.user_id_fk = U.UserId AND R.c_id_fk = '$c_id_fk' ORDER BY R.cr_id DESC";

	$result = $mysqli->query($queryConversation);

	if (mysqli_num_rows($result) === 0) {
		echo "Error: No message.";
	}
	else {
		$data = $result->fetch_all(MYSQLI_ASSOC);
		header('Content-Type: application/json');
		echo json_encode($data);
	}
});

$app->post('/api/message', function($request) {
	require_once('dbconnect.php');

	$sentTo = $request->getParsedBody()['SentTo'];
	$sentFrom = $request->getParsedBody()['SentFrom'];
	$ip = $_SERVER['REMOTE_ADDR'];
	$msg = $request->getParsedBody()['Message'];



	//Validation
	$errorMsg = "Error:";

	if ($sentTo == null) { $errorMsg .= " sentTo must not be empty."; }
	if ($sentFrom == null) { $errorMsg .= " sentFrom must not be empty."; }
	if ($msg == null) { $errorMsg .= " message must not be empty."; }

	if ($errorMsg == "Error:") {
		$queryValidate = "SELECT c_id FROM `conversation` WHERE (user_one = '$sentFrom' and user_two = '$sentTo') or (user_one = '$sentTo' and user_two = '$sentFrom')";
		$queryValidateResult = $mysqli->query($queryValidate);

		if (mysqli_num_rows($queryValidateResult) == 0) {
			$queryConversation = "INSERT INTO `conversation` (`user_one`, `user_two`, `ip`) VALUES (?, ?, ?)";
			$stmt = $mysqli->prepare($queryConversation);
			$stmt->bind_param("sss", $sentFrom, $sentTo, $ip);

			$stmt->execute();
		}
		//Select the latest conversation
		$querySelectConvesation = "SELECT c_id FROM `conversation` WHERE `user_one` = '$sentFrom' ORDER BY c_id DESC limit 1";
		$querySelectConvesationResult = $mysqli->query($querySelectConvesation);
		$rowSelectConvesation = $querySelectConvesationResult->fetch_row();

		$c_id_fk = $rowSelectConvesation[0];

		$queryConversationReply = "INSERT INTO `conversation_reply` (`reply`, `user_id_fk`, `ip`, `c_id_fk`) VALUES (?, ?, ?, ?)";
		$stmt2 = $mysqli->prepare($queryConversationReply);
		$stmt2->bind_param("ssss", $msg, $sentFrom, $ip, $c_id_fk);

		$stmt2->execute();
		echo "Success";
	}
	else {
		echo $errorMsg;
	}


});