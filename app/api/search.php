<?php

$app->post('/api/search', function($request) {
	$this->logger->addInfo("Search");
	require_once('dbconnect.php');

	$searchQueryTitle = $request->getParsedBody()['searchQueryTitle'];
	$searchQueryLocation = $request->getParsedBody()['searchQueryLocation'];

	if ($searchQueryLocation == null) {
		$query = "select * from ads WHERE title LIKE '%$searchQueryTitle%' OR OtherDetails LIKE '%$searchQueryTitle%'
			order by DateCreated";
	}
	else {
		$query = "SELECT A.*, B.Province FROM `ads` as A INNER JOIN `users` AS B on A.UserId = B.UserId WHERE (A.title LIKE '%$searchQueryTitle%' OR A.OtherDetails LIKE '%$searchQueryTitle%') AND B.Province LIKE '%$searchQueryLocation%' ORDER BY A.DateCreated DESC";
	}

	$result = $mysqli->query($query);

	if (mysqli_num_rows($result) === 0) {
		echo "Error: No match found.";
	}
	else {
		$data = $result->fetch_all(MYSQLI_ASSOC);
		header('Content-Type: application/json');
		echo json_encode($data);
	}
});