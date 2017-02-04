-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 04, 2017 at 09:53 AM
-- Server version: 10.1.20-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id599972_arkiladb`
--

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE IF NOT EXISTS `ads` (
  `AdsId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `UserId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Capacity` int(11) NOT NULL,
  `CarType` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `OtherDetails` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` bit(1) NOT NULL DEFAULT b'1',
  `DateCreated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`AdsId`),
  UNIQUE KEY `AdsId` (`AdsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`AdsId`, `UserId`, `Title`, `Capacity`, `CarType`, `OtherDetails`, `IsActive`, `DateCreated`) VALUES
('17012812390851594628', '17012811382291635759', 'Van', 11, 'Test', 'test', b'1', '2017-01-28 19:39:08.514818');

-- --------------------------------------------------------

--
-- Table structure for table `adsimage`
--

CREATE TABLE IF NOT EXISTS `adsimage` (
  `RecId` bigint(20) NOT NULL,
  `AdsId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Path` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CreatedFrom` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DateCreated` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `IsActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`RecId`),
  UNIQUE KEY `RecId` (`RecId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `adsimage`
--

INSERT INTO `adsimage` (`RecId`, `AdsId`, `Path`, `CreatedBy`, `CreatedFrom`, `DateCreated`, `IsActive`) VALUES
(1, 'test', 'test', '1test', '1test', '2017-01-25 22:20:53.989', b'1'),
(2, 'test', 'test', '1test', '1test', '2017-01-27 21:18:44.583', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE IF NOT EXISTS `bookings` (
  `BookingId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `UserId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `AdsId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Status` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'PENDING',
  `CreatedFrom` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DateCreated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `IsReadOwner` bit(1) NOT NULL DEFAULT b'1',
  `IsReadOwnerDate` datetime(6) DEFAULT NULL,
  `IsReadUser` bit(1) NOT NULL DEFAULT b'0',
  `IsReadUserDate` datetime(6) DEFAULT NULL,
  `IsActive` bit(1) NOT NULL DEFAULT b'1',
  `Remarks` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`BookingId`),
  UNIQUE KEY `BookingId` (`BookingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingId`, `UserId`, `AdsId`, `Status`, `CreatedFrom`, `DateCreated`, `IsReadOwner`, `IsReadOwnerDate`, `IsReadUser`, `IsReadUserDate`, `IsActive`, `Remarks`) VALUES
('1', '1', '1', 'PENDING', '1', '0000-00-00 00:00:00.000000', b'0', '0000-00-00 00:00:00.000000', b'0', '0000-00-00 00:00:00.000000', b'1', ''),
('17012705081357095226', 'test', 'test', 'PENDING', 'test', '2017-01-28 00:08:13.571454', b'0', '2017-01-28 00:08:13.571454', b'0', '2017-01-28 00:08:13.571454', b'1', ''),
('17012705091958673484', 'test', 'test', 'APPROVED', 'test', '2017-01-28 00:09:19.586229', b'0', NULL, b'0', NULL, b'1', 'Updated'),
('17012801030454826203', '17012801024370481400', '17012812390851594628', 'PENDING', 'testapp', '2017-01-28 20:03:04.548449', b'0', NULL, b'1', NULL, b'1', ''),
('17012809011072426062', 'testId', 'testads', 'PENDING', 'testapp', '2017-01-28 16:01:10.723812', b'0', NULL, b'1', NULL, b'1', ''),
('17012812362118134128', 'testId', 'testads', 'PENDING', 'testapp', '2017-01-28 19:36:21.182248', b'0', NULL, b'1', NULL, b'1', ''),
('17012812374308655856', '17012811382291635759', 'testads', 'PENDING', 'testapp', '2017-01-28 19:37:43.085932', b'0', NULL, b'1', NULL, b'1', '');

-- --------------------------------------------------------

--
-- Table structure for table `conversation`
--

CREATE TABLE IF NOT EXISTS `conversation` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_one` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_two` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time` datetime(6) DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`c_id`),
  KEY `user_one` (`user_one`),
  KEY `user_two` (`user_two`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_reply`
--

CREATE TABLE IF NOT EXISTS `conversation_reply` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT,
  `reply` text COLLATE utf8_unicode_ci,
  `user_id_fk` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `time` datetime(6) DEFAULT CURRENT_TIMESTAMP(6),
  `c_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`cr_id`),
  KEY `user_id_fk` (`user_id_fk`),
  KEY `c_id_fk` (`c_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `UserId` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `FirstName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MiddleName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `LastName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `BirthDate` date NOT NULL,
  `Gender` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `EmailAddress` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `UserName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `SaltPassword` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `MobileNo1` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `MobileNo2` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `TelNo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ProfilePicturePath` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `Province` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Municipality` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Barangay` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `StreetNo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CreatedAt` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CURRENT_TIMESTAMP(3)',
  `UpdatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `dropbox_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserId`, `FirstName`, `MiddleName`, `LastName`, `BirthDate`, `Gender`, `EmailAddress`, `UserName`, `Password`, `SaltPassword`, `MobileNo1`, `MobileNo2`, `TelNo`, `ProfilePicturePath`, `Province`, `Municipality`, `Barangay`, `StreetNo`, `Token`, `CreatedAt`, `UpdatedAt`, `dropbox_token`) VALUES
('17012801023111629389', 'MARRY ANN', '', 'Alcantara', '1996-09-21', 'm', 'decenamaan1@yahoo.com.ph', 'kontrasenyas1111', '$2y$10$SWCuRwYFm7KzvkXpT61sxuoKV5hXln69ldnYaXlUG8lnIZLTFGgZC', '', '09269772081', '09269772081', '', '', 'Cavite', 'Tanza', 'Paradahan', 'Blk 14', '', 'Mobile', '2017-01-28 20:02:31.183', ''),
('17012801024370481400', 'MARRY ANN', '', 'Alcantara', '1996-09-21', 'm', 'decenamaan12@yahoo.com.ph', 'kontrasenyas2', '$2y$10$XMDKdZrHFz3CfPJcxIZPIucQXYFm./UHKToUFrts0N6Y3WBhHoEK2', '', '09269772081', '09269772081', '', '', 'Cavite', 'Tanza', 'Paradahan', 'Blk 14', '', 'Mobile', '2017-01-28 20:02:43.770', ''),
('17012811382291635759', 'MARRY ANN_111111', '', 'Alcantara', '1996-09-21', 'm', 'decenamaan1211111@yahoo.com.ph', 'kontrasenyas', '$2y$10$kM/3Kcc19AjnE7Xx.moTEuiRr0SMHsCYxHX9gPZ8P9fN/PCLtDre.', '', '09269772081', '09269772081', '', '', 'Cavite', 'Tanza', 'Paradahan', 'Blk 14', '', 'Mobile', '2017-01-28 18:38:22.982', '');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `conversation`
--
ALTER TABLE `conversation`
  ADD CONSTRAINT `conversation_ibfk_1` FOREIGN KEY (`user_one`) REFERENCES `users` (`UserId`),
  ADD CONSTRAINT `conversation_ibfk_2` FOREIGN KEY (`user_two`) REFERENCES `users` (`UserId`);

--
-- Constraints for table `conversation_reply`
--
ALTER TABLE `conversation_reply`
  ADD CONSTRAINT `conversation_reply_ibfk_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`UserId`),
  ADD CONSTRAINT `conversation_reply_ibfk_2` FOREIGN KEY (`c_id_fk`) REFERENCES `conversation` (`c_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
