<?php

$app->get('/api/notification/{UserId}', function($request) {
	require_once('dbconnect.php');

	$UserId = $request->getAttribute('UserId');

	$query = "SELECT a.UserId FROM `bookings` b 
			INNER JOIN `ads` a ON b.adsid = a.adsid
			WHERE a.UserId = '$UserId'";

	$result = $mysqli->query($query);

	$data = $result->fetch_all(MYSQLI_ASSOC);

	if (!empty($data)) {
		if ($data[0]['UserId'] == $UserId) {
			$queryOwner = "SELECT a.UserId, b.BookingId, b.AdsId, b.IsReadOwner FROM `bookings` b 
				INNER JOIN `ads` a ON b.adsid = a.adsid
				WHERE a.UserId = '$UserId'";

			$result = $mysqli->query($queryOwner);
			$data = $result->fetch_all(MYSQLI_ASSOC);
			header('Content-Type: application/json');
	 		echo json_encode($data);
		}
	}
	else {
		$queryUser = "SELECT b.UserId, b.BookingId, b.AdsId, b.IsReadUser FROM `bookings` b 
			INNER JOIN `ads` a ON b.adsid = a.adsid
			WHERE b.UserId = '$UserId'";

		$result = $mysqli->query($queryUser);
		$data = $result->fetch_all(MYSQLI_ASSOC);
	 	header('Content-Type: application/json');
	 	echo json_encode($data);
	}
	// else {
	// 	$data = $result->fetch_all(MYSQLI_ASSOC);
	// 	echo $data[0]['UserId'] . " " . $UserId;

	// 	header('Content-Type: application/json');
	// 	echo json_encode($data);
	// }	
});

$app->post('/api/notification/{BookingId}', function($request) {
	require_once('dbconnect.php');

	$UserId = $request->getParsedBody()['UserId'];
	$BookingId = $request->getAttribute('BookingId');

	$query = "SELECT a.UserId FROM `bookings` b 
			INNER JOIN `ads` a ON b.adsid = a.adsid
			WHERE a.UserId = '$UserId'";

	$result = $mysqli->query($query);

	$data = $result->fetch_all(MYSQLI_ASSOC);

	if (!empty($data)) {
		if ($data[0]['UserId'] == $UserId) {
			$query = "UPDATE `bookings` SET `IsReadOwner` = b'1' WHERE `bookings`.`BookingId` = '$BookingId';";
			$stmt = $mysqli->prepare($query);
			$stmt->execute();

			// printf("rows affected: %d\n", $stmt->affected_rows);
			header('Content-Type: application/json');
	 		echo json_encode($stmt->affected_rows);
		}
	}
	else {
			$query = "UPDATE `bookings` SET `IsReadUser` = b'1' WHERE `bookings`.`BookingId` = '$BookingId' AND UserId = '$UserId';";
			$stmt = $mysqli->prepare($query);
			$stmt->execute();

			//printf("rows affected: %d\n", $stmt->affected_rows);
			header('Content-Type: application/json');
	 		echo json_encode($stmt->affected_rows);
	}
});