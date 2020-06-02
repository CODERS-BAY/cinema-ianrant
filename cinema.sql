-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 02, 2020 at 06:26 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema`
--

-- --------------------------------------------------------

--
-- Table structure for table `cinema`
--

CREATE TABLE `cinema` (
  `cinema_id` int(11) NOT NULL,
  `cinema_address` varchar(100) DEFAULT NULL,
  `cinema_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hall`
--

CREATE TABLE `hall` (
  `hall_id` int(11) NOT NULL,
  `cinema_id` int(11) DEFAULT NULL,
  `features` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `inf_staff_assoc`
--

CREATE TABLE `inf_staff_assoc` (
  `inf_staff_assoc` int(11) NOT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `movie_inf`
--

CREATE TABLE `movie_inf` (
  `movie_inf_id` int(11) NOT NULL,
  `distribution` varchar(50) DEFAULT NULL,
  `duration` int(3) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `prod_country` varchar(50) DEFAULT NULL,
  `prod_year` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `movie_staff`
--

CREATE TABLE `movie_staff` (
  `staff_id` int(11) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_death` date DEFAULT NULL,
  `is_director` bit(1) DEFAULT NULL,
  `is_actor` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `row`
--

CREATE TABLE `row` (
  `row_id` int(11) NOT NULL,
  `hall_id` int(11) DEFAULT NULL,
  `cinema_id` int(11) DEFAULT NULL,
  `normal_price` float DEFAULT NULL,
  `special_price` float DEFAULT NULL,
  `is_box` bit(1) DEFAULT NULL,
  `pricing_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `schedule_item` int(11) NOT NULL,
  `hall_id` int(11) DEFAULT NULL,
  `cinema_id` int(11) DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `time` varchar(15) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_inf_staff_assoc`
--

CREATE TABLE `schedule_inf_staff_assoc` (
  `schedule_inf_staff_assoc_id` int(11) NOT NULL,
  `inf_staff_assoc_id` int(11) DEFAULT NULL,
  `schedule_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `seating_plan`
--

CREATE TABLE `seating_plan` (
  `seat_id` int(11) NOT NULL,
  `row_id` int(11) DEFAULT NULL,
  `hall_id` int(11) DEFAULT NULL,
  `cinema_id` int(11) DEFAULT NULL,
  `is_available` bit(1) DEFAULT NULL,
  `screening_number` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_number` int(11) NOT NULL,
  `cinema_id` int(11) DEFAULT NULL,
  `hall_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(15) DEFAULT NULL,
  `row_id` int(11) DEFAULT NULL,
  `seat_id` int(11) DEFAULT NULL,
  `schedule_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cinema`
--
ALTER TABLE `cinema`
  ADD PRIMARY KEY (`cinema_id`);

--
-- Indexes for table `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`hall_id`),
  ADD UNIQUE KEY `cinema_id` (`cinema_id`);

--
-- Indexes for table `inf_staff_assoc`
--
ALTER TABLE `inf_staff_assoc`
  ADD PRIMARY KEY (`inf_staff_assoc`),
  ADD UNIQUE KEY `movie_id` (`movie_id`,`staff_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `movie_inf`
--
ALTER TABLE `movie_inf`
  ADD PRIMARY KEY (`movie_inf_id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `movie_staff`
--
ALTER TABLE `movie_staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `row`
--
ALTER TABLE `row`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `hall_id` (`hall_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`schedule_item`),
  ADD UNIQUE KEY `hall_id` (`hall_id`,`cinema_id`,`movie_id`);

--
-- Indexes for table `schedule_inf_staff_assoc`
--
ALTER TABLE `schedule_inf_staff_assoc`
  ADD PRIMARY KEY (`schedule_inf_staff_assoc_id`),
  ADD UNIQUE KEY `inf_staff_assoc_id` (`inf_staff_assoc_id`,`schedule_item`),
  ADD KEY `schedule_item` (`schedule_item`);

--
-- Indexes for table `seating_plan`
--
ALTER TABLE `seating_plan`
  ADD PRIMARY KEY (`seat_id`),
  ADD UNIQUE KEY `row_id` (`row_id`,`hall_id`),
  ADD KEY `hall_id` (`hall_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_number`),
  ADD UNIQUE KEY `cinema_id` (`cinema_id`,`hall_id`,`title`,`row_id`,`seat_id`),
  ADD UNIQUE KEY `schedule_item` (`schedule_item`),
  ADD KEY `hall_id` (`hall_id`),
  ADD KEY `title` (`title`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cinema`
--
ALTER TABLE `cinema`
  MODIFY `cinema_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hall`
--
ALTER TABLE `hall`
  MODIFY `hall_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inf_staff_assoc`
--
ALTER TABLE `inf_staff_assoc`
  MODIFY `inf_staff_assoc` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movie_staff`
--
ALTER TABLE `movie_staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `row`
--
ALTER TABLE `row`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `schedule_item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seating_plan`
--
ALTER TABLE `seating_plan`
  MODIFY `seat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_number` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hall`
--
ALTER TABLE `hall`
  ADD CONSTRAINT `hall_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `cinema` (`cinema_id`);

--
-- Constraints for table `inf_staff_assoc`
--
ALTER TABLE `inf_staff_assoc`
  ADD CONSTRAINT `inf_staff_assoc_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie_inf` (`movie_inf_id`),
  ADD CONSTRAINT `inf_staff_assoc_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `movie_staff` (`staff_id`);

--
-- Constraints for table `row`
--
ALTER TABLE `row`
  ADD CONSTRAINT `row_ibfk_1` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`hall_id`);

--
-- Constraints for table `schedule_inf_staff_assoc`
--
ALTER TABLE `schedule_inf_staff_assoc`
  ADD CONSTRAINT `schedule_inf_staff_assoc_ibfk_1` FOREIGN KEY (`schedule_item`) REFERENCES `schedule` (`schedule_item`),
  ADD CONSTRAINT `schedule_inf_staff_assoc_ibfk_2` FOREIGN KEY (`inf_staff_assoc_id`) REFERENCES `inf_staff_assoc` (`inf_staff_assoc`);

--
-- Constraints for table `seating_plan`
--
ALTER TABLE `seating_plan`
  ADD CONSTRAINT `seating_plan_ibfk_1` FOREIGN KEY (`row_id`) REFERENCES `row` (`row_id`),
  ADD CONSTRAINT `seating_plan_ibfk_2` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`hall_id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `cinema` (`cinema_id`),
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`hall_id`),
  ADD CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`title`) REFERENCES `movie_inf` (`title`),
  ADD CONSTRAINT `ticket_ibfk_4` FOREIGN KEY (`schedule_item`) REFERENCES `schedule` (`schedule_item`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
