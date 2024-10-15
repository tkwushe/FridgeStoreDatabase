-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 30, 2023 at 10:05 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `2215901_Databse_Implementation`
--

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `Category_id` int(11) NOT NULL,
  `Category_name` varchar(20) NOT NULL,
  `Parent_category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This stores all the Categories available ';

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `User_id` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(150) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Registration_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This Table holds all the customer details';

-- --------------------------------------------------------

--
-- Table structure for table `customers_addresses`
--

CREATE TABLE `customers_addresses` (
  `Address_id` int(11) NOT NULL,
  `Address_type` enum('Billing','Delivery') NOT NULL,
  `City` varchar(150) NOT NULL,
  `County` varchar(50) NOT NULL,
  `Country` varchar(100) NOT NULL,
  `Postcode` varchar(8) NOT NULL,
  `User_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This table holds all the customer addresses ';

-- --------------------------------------------------------

--
-- Table structure for table `Delivery_information`
--

CREATE TABLE `Delivery_information` (
  `Delivery_id` int(11) NOT NULL,
  `Order_id` int(11) NOT NULL,
  `Address_id` int(11) NOT NULL,
  `Delivery_method` enum('Standard','Express','Next-Day','Same-Day','In-Store Pickup') NOT NULL,
  `Tracking_Number` varchar(50) NOT NULL,
  `Delivery_Status` enum('Successful','Unsuccessful','In Transit') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This table holds all the delivery information';

-- --------------------------------------------------------

--
-- Table structure for table `Discounts`
--

CREATE TABLE `Discounts` (
  `Discount_id` int(11) NOT NULL,
  `Fridge_id` int(11) NOT NULL,
  `Discount_code` varchar(50) NOT NULL,
  `Usage_limit` varchar(50) NOT NULL,
  `Usage_counter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='this table holds all the discounts available ';

-- --------------------------------------------------------

--
-- Table structure for table `Fridges`
--

CREATE TABLE `Fridges` (
  `Fridge_id` int(10) NOT NULL,
  `Category_id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(150) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Brand` varchar(50) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Stock_Level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This table holds all the fridge information ';

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `Order_id` int(10) NOT NULL,
  `User_id` int(11) NOT NULL,
  `Order_date` date NOT NULL,
  `Status` enum('Unsuccessful','Successful','Pending') NOT NULL,
  `Total_Amount` decimal(10,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This table holds all the customer order details';

-- --------------------------------------------------------

--
-- Table structure for table `Order_addons`
--

CREATE TABLE `Order_addons` (
  `Order_id` int(11) NOT NULL,
  `Warranty` enum('Yes','No') NOT NULL,
  `Additional_services` enum('Gift Wrapping','Product Insurance','Assembly Service','Customization','Subscription','Installation Service') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Order_items`
--

CREATE TABLE `Order_items` (
  `Order_item_id` int(11) NOT NULL,
  `Order_id` int(11) NOT NULL,
  `Fridge_id` int(11) NOT NULL,
  `Quantity` int(5) UNSIGNED NOT NULL,
  `Unit_Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Payment_information`
--

CREATE TABLE `Payment_information` (
  `Payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `Fridge_id` int(11) NOT NULL,
  `Payment_Method` enum('credit card','Credit','Paypal','') NOT NULL,
  `Credit_card_number` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `CVV` int(5) NOT NULL,
  `Expiration_Date` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='This table holds all the payment information';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`Category_id`),
  ADD UNIQUE KEY `Parent_category_id` (`Parent_category_id`),
  ADD UNIQUE KEY `Category_id` (`Category_id`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`User_id`),
  ADD UNIQUE KEY `User_id` (`User_id`);

--
-- Indexes for table `customers_addresses`
--
ALTER TABLE `customers_addresses`
  ADD PRIMARY KEY (`Address_id`),
  ADD UNIQUE KEY `Address_id` (`Address_id`),
  ADD UNIQUE KEY `User_id` (`User_id`),
  ADD KEY `User_id_2` (`User_id`);

--
-- Indexes for table `Delivery_information`
--
ALTER TABLE `Delivery_information`
  ADD PRIMARY KEY (`Delivery_id`),
  ADD UNIQUE KEY `Delivery_id` (`Delivery_id`),
  ADD UNIQUE KEY `Order_id` (`Order_id`),
  ADD UNIQUE KEY `Address_id` (`Address_id`),
  ADD UNIQUE KEY `Tracking_Number` (`Tracking_Number`);

--
-- Indexes for table `Discounts`
--
ALTER TABLE `Discounts`
  ADD PRIMARY KEY (`Discount_id`),
  ADD UNIQUE KEY `Discount_id` (`Discount_id`),
  ADD UNIQUE KEY `Fridge_id` (`Fridge_id`),
  ADD UNIQUE KEY `Discount_code` (`Discount_code`);

--
-- Indexes for table `Fridges`
--
ALTER TABLE `Fridges`
  ADD PRIMARY KEY (`Fridge_id`),
  ADD UNIQUE KEY `Category_id` (`Category_id`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`Order_id`),
  ADD KEY `User_id` (`User_id`);

--
-- Indexes for table `Order_addons`
--
ALTER TABLE `Order_addons`
  ADD PRIMARY KEY (`Order_id`),
  ADD UNIQUE KEY `Order_id` (`Order_id`);

--
-- Indexes for table `Order_items`
--
ALTER TABLE `Order_items`
  ADD PRIMARY KEY (`Order_item_id`),
  ADD KEY `Order_id` (`Order_id`),
  ADD KEY `Fridge_id` (`Fridge_id`);

--
-- Indexes for table `Payment_information`
--
ALTER TABLE `Payment_information`
  ADD PRIMARY KEY (`Payment_id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD UNIQUE KEY `Payment_id` (`Payment_id`),
  ADD UNIQUE KEY `Fridge_id` (`Fridge_id`),
  ADD UNIQUE KEY `Credit_card_number` (`Credit_card_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers_addresses`
--
ALTER TABLE `customers_addresses`
  MODIFY `Address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Fridges`
--
ALTER TABLE `Fridges`
  MODIFY `Fridge_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `Order_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Payment_information`
--
ALTER TABLE `Payment_information`
  MODIFY `Payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers_addresses`
--
ALTER TABLE `customers_addresses`
  ADD CONSTRAINT `customers_addresses_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `Customers` (`User_id`);

--
-- Constraints for table `Delivery_information`
--
ALTER TABLE `Delivery_information`
  ADD CONSTRAINT `delivery_information_ibfk_1` FOREIGN KEY (`Order_id`) REFERENCES `Orders` (`Order_id`),
  ADD CONSTRAINT `delivery_information_ibfk_2` FOREIGN KEY (`Address_id`) REFERENCES `customers_addresses` (`Address_id`);

--
-- Constraints for table `Discounts`
--
ALTER TABLE `Discounts`
  ADD CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`Fridge_id`) REFERENCES `Fridges` (`Fridge_id`);

--
-- Constraints for table `Fridges`
--
ALTER TABLE `Fridges`
  ADD CONSTRAINT `fridges_ibfk_1` FOREIGN KEY (`Category_id`) REFERENCES `Categories` (`Category_id`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `Customers` (`User_id`);

--
-- Constraints for table `Order_addons`
--
ALTER TABLE `Order_addons`
  ADD CONSTRAINT `order_addons_ibfk_1` FOREIGN KEY (`Order_id`) REFERENCES `Orders` (`Order_id`);

--
-- Constraints for table `Order_items`
--
ALTER TABLE `Order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`Order_id`) REFERENCES `Orders` (`Order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`Fridge_id`) REFERENCES `Fridges` (`Fridge_id`);

--
-- Constraints for table `Payment_information`
--
ALTER TABLE `Payment_information`
  ADD CONSTRAINT `payment_information_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`Order_id`),
  ADD CONSTRAINT `payment_information_ibfk_3` FOREIGN KEY (`Fridge_id`) REFERENCES `Fridges` (`Fridge_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
