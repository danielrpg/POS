/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50508
Source Host           : localhost:3306
Source Database       : pos

Target Server Type    : MYSQL
Target Server Version : 50508
File Encoding         : 65001

Date: 2013-09-09 16:44:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ospos_app_config`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_app_config`;
CREATE TABLE `ospos_app_config` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_app_config
-- ----------------------------
INSERT INTO `ospos_app_config` VALUES ('address', 'Calle valenzuela');
INSERT INTO `ospos_app_config` VALUES ('company', 'Point of Sale');
INSERT INTO `ospos_app_config` VALUES ('currency_symbol', 'Bs.');
INSERT INTO `ospos_app_config` VALUES ('default_tax_1_name', 'Entrega');
INSERT INTO `ospos_app_config` VALUES ('default_tax_1_rate', '2');
INSERT INTO `ospos_app_config` VALUES ('default_tax_2_name', 'Impuesto de Ventas 2');
INSERT INTO `ospos_app_config` VALUES ('default_tax_2_rate', '');
INSERT INTO `ospos_app_config` VALUES ('default_tax_rate', '8');
INSERT INTO `ospos_app_config` VALUES ('email', 'admin@pappastech.com');
INSERT INTO `ospos_app_config` VALUES ('fax', '');
INSERT INTO `ospos_app_config` VALUES ('language', 'spanish');
INSERT INTO `ospos_app_config` VALUES ('phone', '591 65755850');
INSERT INTO `ospos_app_config` VALUES ('print_after_sale', 'print_after_sale');
INSERT INTO `ospos_app_config` VALUES ('return_policy', 'Codigo de Seguridad');
INSERT INTO `ospos_app_config` VALUES ('timezone', 'America/La_Paz');
INSERT INTO `ospos_app_config` VALUES ('website', '');

-- ----------------------------
-- Table structure for `ospos_customers`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_customers`;
CREATE TABLE `ospos_customers` (
  `person_id` int(10) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `taxable` int(1) NOT NULL DEFAULT '1',
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_customers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_customers
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_employees`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_employees`;
CREATE TABLE `ospos_employees` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `username` (`username`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_employees_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_employees
-- ----------------------------
INSERT INTO `ospos_employees` VALUES ('admin', '439a6de57d475c1a0ba9bcb1c39f0af6', '1', '0');

-- ----------------------------
-- Table structure for `ospos_giftcards`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_giftcards`;
CREATE TABLE `ospos_giftcards` (
  `giftcard_id` int(11) NOT NULL AUTO_INCREMENT,
  `giftcard_number` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `value` double(15,2) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`giftcard_id`),
  UNIQUE KEY `giftcard_number` (`giftcard_number`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ospos_giftcards
-- ----------------------------
INSERT INTO `ospos_giftcards` VALUES ('48', '566466122', '50.00', '0');

-- ----------------------------
-- Table structure for `ospos_inventory`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_inventory`;
CREATE TABLE `ospos_inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL DEFAULT '0',
  `trans_user` int(11) NOT NULL DEFAULT '0',
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text NOT NULL,
  `trans_inventory` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`trans_id`),
  KEY `ospos_inventory_ibfk_1` (`trans_items`),
  KEY `ospos_inventory_ibfk_2` (`trans_user`),
  CONSTRAINT `ospos_inventory_ibfk_1` FOREIGN KEY (`trans_items`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_inventory_ibfk_2` FOREIGN KEY (`trans_user`) REFERENCES `ospos_employees` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_inventory
-- ----------------------------
INSERT INTO `ospos_inventory` VALUES ('1', '1', '1', '2013-08-22 09:45:22', 'Edición Manual de Cantidad', '50');
INSERT INTO `ospos_inventory` VALUES ('2', '1', '1', '2013-08-22 09:46:50', 'Cajas en invetarios', '50');
INSERT INTO `ospos_inventory` VALUES ('3', '1', '1', '2013-08-22 09:51:57', 'POS 1', '-5');
INSERT INTO `ospos_inventory` VALUES ('4', '2', '1', '2013-08-22 09:56:06', 'Edición Manual de Cantidad', '1000');

-- ----------------------------
-- Table structure for `ospos_items`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_items`;
CREATE TABLE `ospos_items` (
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item_number` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `cost_price` double(15,2) NOT NULL,
  `unit_price` double(15,2) NOT NULL,
  `quantity` double(15,2) NOT NULL DEFAULT '0.00',
  `reorder_level` double(15,2) NOT NULL DEFAULT '0.00',
  `location` varchar(255) NOT NULL,
  `item_id` int(10) NOT NULL AUTO_INCREMENT,
  `allow_alt_description` tinyint(1) NOT NULL,
  `is_serialized` tinyint(1) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_number` (`item_number`),
  KEY `ospos_items_ibfk_1` (`supplier_id`),
  CONSTRAINT `ospos_items_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `ospos_suppliers` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_items
-- ----------------------------
INSERT INTO `ospos_items` VALUES ('Cuna Termica', 'CUNA', '2', '78989', 'Cuna termica', '200.00', '250.00', '95.00', '1.00', '78-LKJ', '1', '1', '1', '0');
INSERT INTO `ospos_items` VALUES ('cuna', 'CUNA', '2', '788897', 'lk-542315', '400.00', '350.00', '1000.00', '454.00', 'lk-9521', '2', '1', '1', '0');

-- ----------------------------
-- Table structure for `ospos_items_taxes`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_items_taxes`;
CREATE TABLE `ospos_items_taxes` (
  `item_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `percent` double(15,2) NOT NULL,
  PRIMARY KEY (`item_id`,`name`,`percent`),
  CONSTRAINT `ospos_items_taxes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_items_taxes
-- ----------------------------
INSERT INTO `ospos_items_taxes` VALUES ('1', 'Entrega', '2.00');
INSERT INTO `ospos_items_taxes` VALUES ('2', 'Entrega', '2.00');

-- ----------------------------
-- Table structure for `ospos_item_kits`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_item_kits`;
CREATE TABLE `ospos_item_kits` (
  `item_kit_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`item_kit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_item_kits
-- ----------------------------
INSERT INTO `ospos_item_kits` VALUES ('1', 'CUNA TERMICA', 'cuna termica');

-- ----------------------------
-- Table structure for `ospos_item_kit_items`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_item_kit_items`;
CREATE TABLE `ospos_item_kit_items` (
  `item_kit_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` double(15,2) NOT NULL,
  PRIMARY KEY (`item_kit_id`,`item_id`,`quantity`),
  KEY `ospos_item_kit_items_ibfk_2` (`item_id`),
  CONSTRAINT `ospos_item_kit_items_ibfk_1` FOREIGN KEY (`item_kit_id`) REFERENCES `ospos_item_kits` (`item_kit_id`) ON DELETE CASCADE,
  CONSTRAINT `ospos_item_kit_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_item_kit_items
-- ----------------------------
INSERT INTO `ospos_item_kit_items` VALUES ('1', '1', '5.00');

-- ----------------------------
-- Table structure for `ospos_modules`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_modules`;
CREATE TABLE `ospos_modules` (
  `name_lang_key` varchar(255) NOT NULL,
  `desc_lang_key` varchar(255) NOT NULL,
  `sort` int(10) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `desc_lang_key` (`desc_lang_key`),
  UNIQUE KEY `name_lang_key` (`name_lang_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_modules
-- ----------------------------
INSERT INTO `ospos_modules` VALUES ('module_config', 'module_config_desc', '100', 'config');
INSERT INTO `ospos_modules` VALUES ('module_customers', 'module_customers_desc', '10', 'customers');
INSERT INTO `ospos_modules` VALUES ('module_employees', 'module_employees_desc', '80', 'employees');
INSERT INTO `ospos_modules` VALUES ('module_giftcards', 'module_giftcards_desc', '90', 'giftcards');
INSERT INTO `ospos_modules` VALUES ('module_items', 'module_items_desc', '20', 'items');
INSERT INTO `ospos_modules` VALUES ('module_item_kits', 'module_item_kits_desc', '30', 'item_kits');
INSERT INTO `ospos_modules` VALUES ('module_receivings', 'module_receivings_desc', '60', 'receivings');
INSERT INTO `ospos_modules` VALUES ('module_reports', 'module_reports_desc', '50', 'reports');
INSERT INTO `ospos_modules` VALUES ('module_sales', 'module_sales_desc', '70', 'sales');
INSERT INTO `ospos_modules` VALUES ('module_suppliers', 'module_suppliers_desc', '40', 'suppliers');

-- ----------------------------
-- Table structure for `ospos_people`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_people`;
CREATE TABLE `ospos_people` (
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_1` varchar(255) NOT NULL,
  `address_2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `comments` text NOT NULL,
  `person_id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_people
-- ----------------------------
INSERT INTO `ospos_people` VALUES ('John', 'Doe', '555-555-5555', 'admin@pappastech.com', 'Address 1', '', '', '', '', '', '', '1');
INSERT INTO `ospos_people` VALUES ('GIMA', 'GIMA SRL', '5613321551', 'gima@gmail.com', 'Calle garcialzao de la vega # 445556', '', 'Cochabamba', 'Cercado', '51002', 'Bolivia', 'Gima SRL', '2');

-- ----------------------------
-- Table structure for `ospos_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_permissions`;
CREATE TABLE `ospos_permissions` (
  `module_id` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  PRIMARY KEY (`module_id`,`person_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_permissions_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_permissions_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `ospos_modules` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_permissions
-- ----------------------------
INSERT INTO `ospos_permissions` VALUES ('config', '1');
INSERT INTO `ospos_permissions` VALUES ('customers', '1');
INSERT INTO `ospos_permissions` VALUES ('employees', '1');
INSERT INTO `ospos_permissions` VALUES ('giftcards', '1');
INSERT INTO `ospos_permissions` VALUES ('items', '1');
INSERT INTO `ospos_permissions` VALUES ('item_kits', '1');
INSERT INTO `ospos_permissions` VALUES ('receivings', '1');
INSERT INTO `ospos_permissions` VALUES ('reports', '1');
INSERT INTO `ospos_permissions` VALUES ('sales', '1');
INSERT INTO `ospos_permissions` VALUES ('suppliers', '1');

-- ----------------------------
-- Table structure for `ospos_receivings`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_receivings`;
CREATE TABLE `ospos_receivings` (
  `receiving_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `receiving_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`receiving_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ospos_receivings_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_receivings_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `ospos_suppliers` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_receivings
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_receivings_items`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_receivings_items`;
CREATE TABLE `ospos_receivings_items` (
  `receiving_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL,
  `quantity_purchased` int(10) NOT NULL DEFAULT '0',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`receiving_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_receivings_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_receivings_items_ibfk_2` FOREIGN KEY (`receiving_id`) REFERENCES `ospos_receivings` (`receiving_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_receivings_items
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_sales`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales`;
CREATE TABLE `ospos_sales` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ospos_sales_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_sales_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ospos_customers` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales
-- ----------------------------
INSERT INTO `ospos_sales` VALUES ('2013-08-22 09:51:56', null, '1', '0', '1', 'Efectivo: Bs.-1249.50<br />');

-- ----------------------------
-- Table structure for `ospos_sales_items`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_items`;
CREATE TABLE `ospos_sales_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_sales_items_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_items
-- ----------------------------
INSERT INTO `ospos_sales_items` VALUES ('1', '1', 'Cuna termica', '', '1', '5.00', '200.00', '250.00', '2');

-- ----------------------------
-- Table structure for `ospos_sales_items_taxes`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_items_taxes`;
CREATE TABLE `ospos_sales_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_items_taxes_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_items` (`sale_id`),
  CONSTRAINT `ospos_sales_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_items_taxes
-- ----------------------------
INSERT INTO `ospos_sales_items_taxes` VALUES ('1', '1', '1', 'Entrega', '2.00');

-- ----------------------------
-- Table structure for `ospos_sales_payments`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_payments`;
CREATE TABLE `ospos_sales_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`),
  CONSTRAINT `ospos_sales_payments_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_payments
-- ----------------------------
INSERT INTO `ospos_sales_payments` VALUES ('1', 'Efectivo', '1249.50');

-- ----------------------------
-- Table structure for `ospos_sales_suspended`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_suspended`;
CREATE TABLE `ospos_sales_suspended` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ospos_sales_suspended_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_sales_suspended_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ospos_customers` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_suspended
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_sales_suspended_items`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_suspended_items`;
CREATE TABLE `ospos_sales_suspended_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_suspended_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_sales_suspended_items_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_suspended_items
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_sales_suspended_items_taxes`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_suspended_items_taxes`;
CREATE TABLE `ospos_sales_suspended_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_suspended_items_taxes_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended_items` (`sale_id`),
  CONSTRAINT `ospos_sales_suspended_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_suspended_items_taxes
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_sales_suspended_payments`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sales_suspended_payments`;
CREATE TABLE `ospos_sales_suspended_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`),
  CONSTRAINT `ospos_sales_suspended_payments_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sales_suspended_payments
-- ----------------------------

-- ----------------------------
-- Table structure for `ospos_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_sessions`;
CREATE TABLE `ospos_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(50) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_sessions
-- ----------------------------
INSERT INTO `ospos_sessions` VALUES ('123cd2c1634e4a0a08bc89ba45c5a654', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/53', '1378756232', 'a:8:{s:9:\"person_id\";s:1:\"1\";s:8:\"cartRecv\";a:0:{}s:9:\"recv_mode\";s:7:\"receive\";s:8:\"supplier\";s:2:\"-1\";s:4:\"cart\";a:0:{}s:9:\"sale_mode\";s:4:\"sale\";s:8:\"customer\";s:2:\"-1\";s:8:\"payments\";a:0:{}}');
INSERT INTO `ospos_sessions` VALUES ('88bc5b1f25e5065b66c2941203bad0e4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/53', '1377181972', 'a:8:{s:9:\"person_id\";s:1:\"1\";s:4:\"cart\";a:0:{}s:9:\"sale_mode\";s:4:\"sale\";s:8:\"customer\";s:2:\"-1\";s:8:\"payments\";a:0:{}s:8:\"cartRecv\";a:0:{}s:9:\"recv_mode\";s:7:\"receive\";s:8:\"supplier\";s:2:\"-1\";}');

-- ----------------------------
-- Table structure for `ospos_suppliers`
-- ----------------------------
DROP TABLE IF EXISTS `ospos_suppliers`;
CREATE TABLE `ospos_suppliers` (
  `person_id` int(10) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_suppliers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ospos_suppliers
-- ----------------------------
INSERT INTO `ospos_suppliers` VALUES ('2', 'GIMA', '4566541233', '0');
