-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2025 at 05:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `revforce_motosports`
--

-- --------------------------------------------------------

--
-- Table structure for table `cancelled_races`
--

CREATE TABLE `cancelled_races` (
  `cancel_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `race_date` date NOT NULL,
  `race_time` time NOT NULL,
  `laps` int(11) NOT NULL,
  `cancel_reason` varchar(255) DEFAULT NULL,
  `cancel_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cancelled_races`
--

INSERT INTO `cancelled_races` (`cancel_id`, `race_id`, `track_id`, `race_date`, `race_time`, `laps`, `cancel_reason`, `cancel_date`) VALUES
(2, 2, 1, '2026-07-24', '12:30:00', 50, '', '2025-08-17 03:31:46');

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `car_id` int(11) NOT NULL,
  `car_name` varchar(100) NOT NULL,
  `price` bigint(20) NOT NULL,
  `engine_power` int(11) DEFAULT NULL,
  `max_speed` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`car_id`, `car_name`, `price`, `engine_power`, `max_speed`, `team_id`) VALUES
(1, 'Aston Martin AMR25', 100000, 345, 421, 1),
(2, 'Alpine A525', 950000, 415, 462, 1);

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `driver_id` int(11) NOT NULL,
  `driver_name` varchar(100) NOT NULL,
  `skill_level` int(11) NOT NULL,
  `joined_date` date NOT NULL,
  `rental_price` bigint(20) NOT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`driver_id`, `driver_name`, `skill_level`, `joined_date`, `rental_price`, `nationality`, `team_id`) VALUES
(1, 'Max Verstappen', 90, '2025-08-16', 99000, 'Available', 2);

-- --------------------------------------------------------

--
-- Table structure for table `races`
--

CREATE TABLE `races` (
  `race_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `race_date` date NOT NULL,
  `race_time` time NOT NULL,
  `laps` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `races`
--

INSERT INTO `races` (`race_id`, `track_id`, `race_date`, `race_time`, `laps`) VALUES
(1, 1, '2025-08-18', '10:30:00', 50);

-- --------------------------------------------------------

--
-- Table structure for table `race_participations`
--

CREATE TABLE `race_participations` (
  `participation_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `race_participations`
--

INSERT INTO `race_participations` (`participation_id`, `race_id`, `team_id`, `position`, `points`) VALUES
(1, 1, 1, NULL, 0),
(2, 1, 3, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sponsors`
--

CREATE TABLE `sponsors` (
  `sponsor_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `contract_value` bigint(20) NOT NULL,
  `contract_duration_months` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sponsors`
--

INSERT INTO `sponsors` (`sponsor_id`, `name`, `industry`, `contract_value`, `contract_duration_months`) VALUES
(1, 'Oracle', 'Software', 1500000, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sponsorship_offers`
--

CREATE TABLE `sponsorship_offers` (
  `offer_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `sponsor_name` varchar(100) NOT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `amount` bigint(20) NOT NULL,
  `contract_duration_months` int(11) NOT NULL,
  `status` enum('pending','accepted','declined') DEFAULT 'pending',
  `offer_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sponsorship_offers`
--

INSERT INTO `sponsorship_offers` (`offer_id`, `team_id`, `sponsor_name`, `industry`, `amount`, `contract_duration_months`, `status`, `offer_date`) VALUES
(1, 2, 'Oracle', 'Software', 1500000, 2, 'pending', '2025-08-17'),
(2, 1, 'Oracle', 'Software', 1000000, 2, 'accepted', '2025-08-17'),
(3, 3, 'Oracle', 'Software', 500000, 2, 'pending', '2025-08-17');

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `team_id` int(11) NOT NULL,
  `team_name` varchar(100) NOT NULL,
  `budget` bigint(20) DEFAULT 2000000,
  `origin` varchar(100) DEFAULT NULL,
  `founding_year` int(11) DEFAULT year(curdate()),
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`team_id`, `team_name`, `budget`, `origin`, `founding_year`, `email`) VALUES
(1, 'Red Bull Racing', 1950000, 'United Kingdom', 2025, 'redbullracing@email.com'),
(2, 'Scuderia Ferrari', 1901000, 'Italy', 2025, 'scuderiaferrari@email.com'),
(3, 'BWT Alpine F1', 2000000, 'France', 2025, 'bwtalpinef1@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `track_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `length_km` float DEFAULT NULL,
  `track_img_url` varchar(1500) DEFAULT NULL,
  `difficulty_level` varchar(50) DEFAULT NULL,
  `track_type` enum('Street','Circuit','Off-road') DEFAULT 'Circuit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tracks`
--

INSERT INTO `tracks` (`track_id`, `name`, `location`, `length_km`, `track_img_url`, `difficulty_level`, `track_type`) VALUES
(1, 'Japanese Grand Prix', 'Suzuka, Japan', 5.807, 'https://tse1.mm.bing.net/th/id/OIP.tJkEhdna42HUitCbpp_pLgAAAA?rs=1&pid=ImgDetMain&o=7&rm=3', 'Hard', 'Circuit');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `team_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `username`, `email`, `password`, `role`, `team_id`) VALUES
(1, 'Admin', 'Admin', 'Admin', 'admin@gmail.com', 'Admin@81626;', 'admin', NULL),
(2, 'Krish', 'patel', 'Krishp', 'Krishp123@gmail.com', 'Krishp@123;', 'user', 1),
(3, 'Ayush', 'Mali', 'AyushM', 'ayushm123@gmail.com', 'Ayushm@123;', 'user', 2),
(4, 'Ashka', 'Shah', 'AshkaS', 'AshkaH123@gmail.com', 'Ashkas@123;', 'user', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cancelled_races`
--
ALTER TABLE `cancelled_races`
  ADD PRIMARY KEY (`cancel_id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`),
  ADD UNIQUE KEY `car_name` (`car_name`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`driver_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `races`
--
ALTER TABLE `races`
  ADD PRIMARY KEY (`race_id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `race_participations`
--
ALTER TABLE `race_participations`
  ADD PRIMARY KEY (`participation_id`),
  ADD KEY `team_id` (`team_id`),
  ADD KEY `race_participations_ibfk_1` (`race_id`);

--
-- Indexes for table `sponsors`
--
ALTER TABLE `sponsors`
  ADD PRIMARY KEY (`sponsor_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `sponsorship_offers`
--
ALTER TABLE `sponsorship_offers`
  ADD PRIMARY KEY (`offer_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`team_id`),
  ADD UNIQUE KEY `team_name` (`team_name`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`track_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `team_id` (`team_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cancelled_races`
--
ALTER TABLE `cancelled_races`
  MODIFY `cancel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `car_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `driver_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `races`
--
ALTER TABLE `races`
  MODIFY `race_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `race_participations`
--
ALTER TABLE `race_participations`
  MODIFY `participation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sponsors`
--
ALTER TABLE `sponsors`
  MODIFY `sponsor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sponsorship_offers`
--
ALTER TABLE `sponsorship_offers`
  MODIFY `offer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cancelled_races`
--
ALTER TABLE `cancelled_races`
  ADD CONSTRAINT `cancelled_races_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`track_id`);

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`);

--
-- Constraints for table `drivers`
--
ALTER TABLE `drivers`
  ADD CONSTRAINT `drivers_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`);

--
-- Constraints for table `races`
--
ALTER TABLE `races`
  ADD CONSTRAINT `races_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`track_id`);

--
-- Constraints for table `race_participations`
--
ALTER TABLE `race_participations`
  ADD CONSTRAINT `race_participations_ibfk_1` FOREIGN KEY (`race_id`) REFERENCES `races` (`race_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `race_participations_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`);

--
-- Constraints for table `sponsorship_offers`
--
ALTER TABLE `sponsorship_offers`
  ADD CONSTRAINT `sponsorship_offers_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
