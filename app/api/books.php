<?php 

$app->get('/api/books', function() {

	require_once('dbconnect.php');

	$query = "select * from books order by id";
	$result = $mysqli->query($query);

	while ($row = $result->fetch_assoc()) {
		$data[] = $row;
	}	

	if (isset($data)) {
		header('Content-Type: application/json');
		echo json_encode($data);
	}
	else{
		echo "No Data";
	}
});

$app->get('/api/books/{id}', function($request) {
	
	require_once('dbconnect.php');
	$id = $request->getAttribute('id');
	
	$query = "Select * from books where id = $id";
	$result = $mysqli->query($query);

	while ($row = $result->fetch_assoc()) {
		$data[] = $row;
	}	

	header('Content-Type: application/json');
	echo json_encode($data);

});

$app->post('/api/books', function($request) {

	// $my_name = $request->getParsedBody()['my_name'];
	// echo "hello ".$my_name;
	require_once('dbconnect.php');
	$query = "INSERT INTO `books` (`title`, `author`, `amazon_url`) VALUES (?,?,?)";
	$stmt = $mysqli->prepare($query);
	$stmt->bind_param("sss", $title, $author, $amazon_url);

	$title = $request->getParsedBody()['title'];
	$author = $request->getParsedBody()['author'];
	$amazon_url = $request->getParsedBody()['amazon_url'];

	$stmt->execute();

	echo "Done";

});

$app->put('/api/books/{id}', function($request) {

	require_once('dbconnect.php');
	$id = $request->getAttribute('id');
	$query = "UPDATE `books` SET `title` = ?, `author` = ?, `amazon_url` = ? WHERE `books`.`id` = $id";
	$stmt = $mysqli->prepare($query);
	$stmt->bind_param("sss", $title, $author, $amazon_url);

	$title = $request->getParsedBody()['title'];
	$author = $request->getParsedBody()['author'];
	$amazon_url = $request->getParsedBody()['amazon_url'];

	$stmt->execute();

	echo "Done";
});