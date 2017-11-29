-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 29, 2017 at 09:07 AM
-- Server version: 10.2.7-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `axgg`
--

-- --------------------------------------------------------

--
-- Table structure for table `all_attribute_types`
--

CREATE TABLE `all_attribute_types` (
  `id` int(11) NOT NULL,
  `attribute_name` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `attribute_category` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT 'routine'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `animals`
--

CREATE TABLE `animals` (
  `id` int(11) NOT NULL,
  `hh_id` int(11) NOT NULL,
  `datetime_added` datetime NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `animal_id` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Primary id of the animal. Should be unique',
  `other_id` varchar(50) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Can be the bola id or any other name/marking the animal is referred to',
  `rfid` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `species_id` int(11) NOT NULL DEFAULT 1,
  `sex` enum('Male','Female','3','4') CHARACTER SET latin1 NOT NULL,
  `origin` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sire` int(11) DEFAULT NULL,
  `dam` int(11) DEFAULT NULL,
  `status` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `animal_attributes`
--

CREATE TABLE `animal_attributes` (
  `id` int(11) NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `attribute_value` text DEFAULT NULL,
  `attribute_date` datetime NOT NULL,
  `record_date` timestamp NOT NULL DEFAULT current_timestamp
) ;

-- --------------------------------------------------------

--
-- Table structure for table `animal_events`
--

CREATE TABLE `animal_events` (
  `id` int(11) NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `event_value` text DEFAULT NULL,
  `event_date` date NOT NULL,
  `record_date` datetime NOT NULL,
  `performed_by` int(11) DEFAULT NULL,
  `recorded_by` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `animal_event_types`
--

CREATE TABLE `animal_event_types` (
  `id` int(11) NOT NULL,
  `event` varchar(255) NOT NULL DEFAULT '',
  `event_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

CREATE TABLE `coordinators` (
  `id` int(11) UNSIGNED NOT NULL,
  `name1` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `name2` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `language` enum('english','french') CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role1` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role2` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `organisation` int(11) UNSIGNED NOT NULL,
  `country` char(2) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `name` varchar(80) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `iso3` char(3) CHARACTER SET latin1 DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `phonecode` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dictionary_items`
--

CREATE TABLE `dictionary_items` (
  `id` int(11) NOT NULL,
  `date_created` datetime(6) NOT NULL DEFAULT current_timestamp
) ;

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `district_code` char(2) NOT NULL,
  `district_name` int(11) DEFAULT NULL,
  `region` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hh_attributes`
--

CREATE TABLE `hh_attributes` (
  `id` int(11) NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `hh_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `attribute_value` varchar(1000) DEFAULT NULL,
  `date_collected` date NOT NULL,
  `datetime_added` timestamp NOT NULL DEFAULT current_timestamp
) ;

-- --------------------------------------------------------

--
-- Table structure for table `hh_events`
--

CREATE TABLE `hh_events` (
  `id` int(11) NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `hh_id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `event_value` text DEFAULT NULL,
  `event_date` datetime NOT NULL,
  `record_date` timestamp NOT NULL DEFAULT current_timestamp
) ;

-- --------------------------------------------------------

--
-- Table structure for table `households`
--

CREATE TABLE `households` (
  `id` int(11) NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `hh_id` varchar(100) NOT NULL COMMENT 'Can be phone number, voters card, etc',
  `language` enum('english','french','amharic','kiswahili') DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `date_added` datetime NOT NULL DEFAULT current_timestamp
) ;

-- --------------------------------------------------------

--
-- Table structure for table `instance_meta`
--

CREATE TABLE `instance_meta` (
  `id` int(11) NOT NULL,
  `uuid` varchar(50) NOT NULL,
  `source_device` varchar(50) NOT NULL,
  `date_submitted` date NOT NULL,
  `latitude` double(15,12) NOT NULL,
  `longitude` double(15,12) NOT NULL,
  `altitude` double(16,12) NOT NULL,
  `gps_accuracy` double(9,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `partner_id` int(11) UNSIGNED NOT NULL,
  `short_name` varchar(55) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `organisation` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `contact` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT '',
  `phone` varchar(255) CHARACTER SET latin1 DEFAULT '',
  `country` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET latin1 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `last_name` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `language` enum('english','french') CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role1` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role2` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `organisation` int(11) NOT NULL,
  `coordinator` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `reg_code` char(2) NOT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  `country` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `species_types`
--

CREATE TABLE `species_types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET latin1 NOT NULL,
  `nominal_value` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ward`
--

CREATE TABLE `ward` (
  `idWARD` char(2) NOT NULL,
  `ward_name` varchar(45) DEFAULT NULL,
  `disctrict` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `all_attribute_types`
--
ALTER TABLE `all_attribute_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `animal_id` (`animal_id`),
  ADD KEY `sire` (`sire`),
  ADD KEY `dam` (`dam`),
  ADD KEY `HH` (`hh_id`),
  ADD KEY `instance_meta_id` (`instance_meta_id`);

--
-- Indexes for table `animal_events`
--
ALTER TABLE `animal_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instance_meta_id` (`instance_meta_id`),
  ADD KEY `animal_id` (`animal_id`),
  ADD KEY `event_type_id` (`event_type_id`);

--
-- Indexes for table `animal_event_types`
--
ALTER TABLE `animal_event_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organisation` (`organisation`),
  ADD KEY `FK_coordinators_countries` (`country`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`district_code`),
  ADD KEY `region_idx` (`region`);

--
-- Indexes for table `instance_meta`
--
ALTER TABLE `instance_meta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`partner_id`),
  ADD KEY `countries` (`country`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`reg_code`);

--
-- Indexes for table `species_types`
--
ALTER TABLE `species_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `ward`
--
ALTER TABLE `ward`
  ADD PRIMARY KEY (`idWARD`),
  ADD KEY `district_idx` (`disctrict`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `all_attribute_types`
--
ALTER TABLE `all_attribute_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `animals`
--
ALTER TABLE `animals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53193;
--
-- AUTO_INCREMENT for table `animal_attributes`
--
ALTER TABLE `animal_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `animal_events`
--
ALTER TABLE `animal_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `animal_event_types`
--
ALTER TABLE `animal_event_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `coordinators`
--
ALTER TABLE `coordinators`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dictionary_items`
--
ALTER TABLE `dictionary_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hh_attributes`
--
ALTER TABLE `hh_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hh_events`
--
ALTER TABLE `hh_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `households`
--
ALTER TABLE `households`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `instance_meta`
--
ALTER TABLE `instance_meta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57438;
--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `partner_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `species_types`
--
ALTER TABLE `species_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `animals`
--
ALTER TABLE `animals`
  ADD CONSTRAINT `animals_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  ADD CONSTRAINT `animals_ibfk_2` FOREIGN KEY (`hh_id`) REFERENCES `households` (`id`);

--
-- Constraints for table `animal_events`
--
ALTER TABLE `animal_events`
  ADD CONSTRAINT `animal_events_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  ADD CONSTRAINT `animal_events_ibfk_2` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`),
  ADD CONSTRAINT `animal_events_ibfk_3` FOREIGN KEY (`event_type_id`) REFERENCES `animal_events` (`id`);

--
-- Constraints for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD CONSTRAINT `FK_coordinators_countries` FOREIGN KEY (`country`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `coordinators_ibfk_1` FOREIGN KEY (`organisation`) REFERENCES `partners` (`partner_id`);

--
-- Constraints for table `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `region` FOREIGN KEY (`region`) REFERENCES `regions` (`reg_code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `partners`
--
ALTER TABLE `partners`
  ADD CONSTRAINT `partners_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`id`);

--
-- Constraints for table `ward`
--
ALTER TABLE `ward`
  ADD CONSTRAINT `district` FOREIGN KEY (`disctrict`) REFERENCES `districts` (`district_code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
