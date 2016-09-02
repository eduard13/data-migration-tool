/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `core_store`;
CREATE TABLE `core_store` (
	`store_id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
	`code` VARCHAR(32) NULL DEFAULT NULL COMMENT 'Code',
	`website_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Website Id',
	`group_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Group Id',
	`name` VARCHAR(255) NOT NULL COMMENT 'Store Name',
	`sort_order` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
	`is_active` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Store Activity',
	PRIMARY KEY (`store_id`),
	UNIQUE INDEX `UNQ_CORE_STORE_CODE` (`code`),
	INDEX `IDX_CORE_STORE_WEBSITE_ID` (`website_id`),
	INDEX `IDX_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`, `sort_order`),
	INDEX `IDX_CORE_STORE_GROUP_ID` (`group_id`),
	CONSTRAINT `FK_CORE_STORE_GROUP_ID_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `core_store_group` (`group_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_CORE_STORE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='Stores'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
INSERT INTO `core_store` VALUES
(0, 'admin', 0, 0, 'Admin', 0, 1),
(1, 'default', 1, 1, 'Default Store View', 0, 1);

DROP TABLE IF EXISTS `core_store_group`;
CREATE TABLE `core_store_group` (
	`group_id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
	`website_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Website Id',
	`name` VARCHAR(255) NOT NULL COMMENT 'Store Group Name',
	`root_category_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
	`default_store_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
	PRIMARY KEY (`group_id`),
	INDEX `IDX_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
	INDEX `IDX_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
	CONSTRAINT `FK_CORE_STORE_GROUP_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='Store Groups'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
INSERT INTO `core_store_group` VALUES
(0, 0, 'Default', 0, 0),
(1, 1, 'Main Website Store', 2, 1);

DROP TABLE IF EXISTS `eav_entity_store`;
CREATE TABLE `eav_entity_store` (
	`entity_store_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
	`entity_type_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
	`store_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Store Id',
	`increment_prefix` VARCHAR(20) NULL DEFAULT NULL COMMENT 'Increment Prefix',
	`increment_last_id` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Last Incremented Id',
	PRIMARY KEY (`entity_store_id`),
	INDEX `IDX_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
	INDEX `IDX_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
	CONSTRAINT `FK_EAV_ENTITY_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_EAV_ENTT_STORE_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='Eav Entity Store'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
INSERT INTO `eav_entity_store` VALUES
(1, 1, 0, '0', '000000001'),
(2, 11, 1, '1', '100000003'),
(3, 16, 1, '1', '100000001'),
(4, 19, 1, '1', '100000001');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;