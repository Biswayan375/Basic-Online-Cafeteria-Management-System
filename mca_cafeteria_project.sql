-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2023 at 11:34 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mca_cafeteria_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `bid` varchar(20) NOT NULL,
  `cid` varchar(20) DEFAULT NULL,
  `tid` int(3) DEFAULT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `time` time NOT NULL DEFAULT current_timestamp(),
  `remarks` varchar(15) NOT NULL DEFAULT 'PENDING' COMMENT 'CANCELLED - means cancelled by user\r\nSETTLED - means settled\r\nPENDING - means still pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bid`, `cid`, `tid`, `date`, `time`, `remarks`) VALUES
('BOK6C495344', 'biswayan@', 2, '2023-02-26', '13:02:25', 'SETTLED'),
('BOK94A62B40', 'biswayan@', 4, '2023-02-26', '13:35:57', 'CANCELLED'),
('BOKA5D6128F', '@Ena', 5, '2023-02-06', '20:49:54', 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_no` varchar(20) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `item_price` int(11) NOT NULL,
  `delivery_charges` int(11) NOT NULL,
  `item_image` varchar(100) NOT NULL,
  `cid` varchar(20) DEFAULT NULL,
  `mobile_no` int(11) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `order_status` varchar(20) DEFAULT NULL COMMENT 'Values:\r\n1. DELIVERED\r\n2. PENDING\r\n3. CANCELLED\r\n4. ON THE WAY\r\n\r\norder status ''DELIVERED'' signifies that the order is delivered to the customer.\r\n\r\norder status ''PENDING'' signifies that the order is pending now.\r\n\r\norder status ''CANCELLED'' signifies that the order is cancelled due to some unavoidable circumstances.\r\n\r\norder status ''ON THE WAY'' signifies that the order is on the way to delivery to the customer.',
  `order_date` date NOT NULL DEFAULT current_timestamp(),
  `order_time` time NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_no`, `item_name`, `item_quantity`, `item_price`, `delivery_charges`, `item_image`, `cid`, `mobile_no`, `address`, `order_status`, `order_date`, `order_time`) VALUES
('OOK8365EAA2', 'Capuccino Coffee', 3, 56, 30, 'Capuccino_Coffee.jpeg', '@Ena', 1234567890, 'Memari Old Circus Maidan, Opposite Memari Police Station', 'CANCELLED', '2023-02-06', '21:44:48'),
('OOKBBA36903', 'Black Coffee', 2, 55, 30, 'Black_Coffee.jpg', '@Ena', 1234567890, 'Memari Old Circus Maidan, Opposite Memari Police Station', 'PENDING', '2023-02-06', '21:43:48'),
('OOKC96339BB', 'Masala Pasta', 1, 126, 30, 'Masala_Pasta.jpg', '@Ena', 1234567890, 'Memari Old Circus Maidan, Opposite Memari Police Station', 'PENDING', '2023-02-06', '21:44:16'),
('OOKE35A5EB1', 'Masala Pasta', 2, 126, 30, 'Masala_Pasta.jpg', 'biswayan@', 1234567890, 'Memari Old Circus Maidan, Opposite Memari Police Station', 'DELIVERED', '2023-02-06', '21:52:48');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `image` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`name`, `price`, `quantity`, `image`) VALUES
('Black Coffee', 55, 16, 'Black_Coffee.jpg'),
('Capuccino Coffee', 56, 76, 'Capuccino_Coffee.jpeg'),
('Masala Pasta', 126, 0, 'Masala_Pasta.jpg'),
('Veg Noodles', 90, 12, 'Veg_Noodles.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `seating_table`
--

CREATE TABLE `seating_table` (
  `id` int(3) NOT NULL,
  `capacity` int(3) NOT NULL,
  `table_no` int(3) NOT NULL,
  `is_available` int(1) NOT NULL DEFAULT 1 COMMENT '0 if seat is not available 1 if available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seating_table`
--

INSERT INTO `seating_table` (`id`, `capacity`, `table_no`, `is_available`) VALUES
(1, 2, 1, 1),
(2, 2, 2, 1),
(3, 4, 10, 1),
(4, 4, 11, 1),
(5, 2, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobile_no` int(11) NOT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `email`, `mobile_no`, `password`) VALUES
('@Ena', 'Ena@mailing.com', 0, '12abCD@#'),
('biswayan@', 'biswayannandi1947@gmail.com', 0, 'abCD12!@'),
('root', 'sales@technoduce.com', 0, 'qwBC12!@');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `cid` (`cid`),
  ADD KEY `tid` (`tid`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_no`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `seating_table`
--
ALTER TABLE `seating_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `seating_table`
--
ALTER TABLE `seating_table`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `users` (`username`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `seating_table` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
