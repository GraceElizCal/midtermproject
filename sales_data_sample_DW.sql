# DROP database `sales_data_sample_DW`;
CREATE DATABASE `sales_data_sample_DW` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE sales_data_sample_DW;

CREATE TABLE `dim_product_hierarchy` (
  `product_hierarchy_key` int NOT NULL AUTO_INCREMENT,
  `product_length` varchar(1024) DEFAULT NULL,
  `product_depth` varchar(1024) DEFAULT NULL,
  `product_width` varchar(1024) DEFAULT NULL,
  `cluster_id` varchar(1024) DEFAULT NULL,
  `hierarchy1_id` varchar(1024) DEFAULT NULL,
  `hierarchy2_id` varchar(1024) DEFAULT NULL,
  `hierarchy3_id` varchar(1024) DEFAULT NULL,
  `hierarchy4_id` varchar(1024) DEFAULT NULL,
  `hierarchy5_id` varchar(1024) DEFAULT NULL,
PRIMARY KEY (`product_hierarchy_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dim_sales` (
  `sales_key` int NOT NULL AUTO_INCREMENT,
  `store_id` varchar(1024) DEFAULT NULL,
  `date` varchar(1024) DEFAULT NULL,
  `sales` bigint DEFAULT NULL,
  `revenue` varchar(1024) DEFAULT NULL,
  `stock` bigint DEFAULT NULL,
  `price` varchar(1024) DEFAULT NULL,
  `promo_type_1` varchar(1024) DEFAULT NULL,
  `promo_type_2` varchar(1024) DEFAULT NULL,
PRIMARY KEY (`sales_key`), 
KEY `store_id` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dim_store_cities` (
  `store_cities_key` int NOT NULL AUTO_INCREMENT,
  `storetype_id` varchar(1024) DEFAULT NULL,
  `store_size` bigint DEFAULT NULL,
  `city_id` varchar(1024) DEFAULT NULL,
PRIMARY KEY (`store_cities_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `fact_sales` (
  `fact_sales_key` int NOT NULL AUTO_INCREMENT,
  `sales_id` int DEFAULT NULL,
  `product_length` varchar(1024) DEFAULT NULL,
  `product_depth` varchar(1024) DEFAULT NULL,
  `product_width` varchar(1024) DEFAULT NULL,
  `hierarchy1_id` varchar(1024) DEFAULT NULL,
  `hierarchy2_id` varchar(1024) DEFAULT NULL,
  `hierarchy3_id` varchar(1024) DEFAULT NULL,
  `hierarchy4_id` varchar(1024) DEFAULT NULL,
  `hierarchy5_id` varchar(1024) DEFAULT NULL,
  `store_id` varchar(1024) DEFAULT NULL,
  `date` varchar(1024) DEFAULT NULL,
  `sales` bigint DEFAULT NULL,
  `revenue` varchar(1024) DEFAULT NULL,
  `stock` bigint DEFAULT NULL,
  `price` varchar(1024) DEFAULT NULL,
  `storetype_id` varchar(1024) DEFAULT NULL,
  `store_size` bigint DEFAULT NULL,
  `city_id` varchar(1024) DEFAULT NULL,
PRIMARY KEY (`fact_sales_key`),
KEY `product_id` (`sales_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

TRUNCATE TABLE `sales_data_sample_DW` . `fact_sales`;

INSERT INTO `sales_data_sample_DW`.`dim_product_hierarchy`
(`product_hierarchy_key`,
`product_length`,
`product_depth`,
`product_width`,
`cluster_id`,
`hierarchy1_id`,
`hierarchy2_id`,
`hierarchy3_id`,
`hierarchy4_id`,
`hierarchy5_id`)

SELECT `product_hierarchy`.`product_id`,
    `product_hierarchy`.`product_length`,
    `product_hierarchy`.`product_depth`,
    `product_hierarchy`.`product_width`,
    `product_hierarchy`.`cluster_id`,
    `product_hierarchy`.`hierarchy1_id`,
    `product_hierarchy`.`hierarchy2_id`,
    `product_hierarchy`.`hierarchy3_id`,
    `product_hierarchy`.`hierarchy4_id`,
    `product_hierarchy`.`hierarchy5_id`
FROM `sales_data_sample`.`product_hierarchy`;

INSERT INTO `sales_data_sample_DW`.`dim_sales`
(`sales_key`,
`store_id`,
`date`,
`sales`,
`revenue`,
`stock`,
`price`,
`promo_type_1`,
`promo_type_2`)
SELECT
    `sales`.`product_id`,
    `sales`.`store_id`,
    `sales`.`date`,
    `sales`.`sale`,
    `sales`.`revenue`,
    `sales`.`stock`,
    `sales`.`price`,
    `sales`.`promo_type_1`,
    `sales`.`promo_type_2`
FROM `sales_data_sample`.`sales`;

INSERT INTO `sales_data_sample_DW`.`dim_store_cities`
(`store_cities_key`,
`storetype_id`,
`store_size`,
`city_id`)
SELECT 
    `store_cities`.`store_id`,
    `store_cities`.`storetype_id`,
    `store_cities`.`store_size`,
    `store_cities`.`city_id`
FROM `sales_data_sample`.`store_cities`;

INSERT INTO `sales_data_sample_DW`.`fact_sales`
(`sales_id`,
`product_length`,
`product_depth`,
`product_width`,
`hierarchy1_id`,
`hierarchy2_id`,
`hierarchy3_id`,
`hierarchy4_id`,
`hierarchy5_id`,
`store_id`,
`date`,
`sales`,
`revenue`,
`stock`,
`price`,
`storetype_id`,
`store_size`,
`city_id`)
SELECT `product_hierarchy`.`product_id`,
    `product_hierarchy`.`product_length`,
    `product_hierarchy`.`product_depth`,
    `product_hierarchy`.`product_width`,
    `product_hierarchy`.`hierarchy1_id`,
    `product_hierarchy`.`hierarchy2_id`,
    `product_hierarchy`.`hierarchy3_id`,
    `product_hierarchy`.`hierarchy4_id`,
    `product_hierarchy`.`hierarchy5_id`,
    `sales`.`store_id`,
    `sales`.`date`,
    `sales`.`sale`,
    `sales`.`revenue`,
    `sales`.`stock`,
    `sales`.`price`,
    `store_cities`.`storetype_id`,
    `store_cities`.`store_size`,
    `store_cities`.`city_id`
FROM `sales_data_sample`.`product_hierarchy` 
INNER JOIN `sales_data_sample`.`sales` 
ON   `product_hierarchy` .`product_id` = `sales`.`product_id` 
RIGHT OUTER JOIN  `sales_data_sample`.`store_cities` 
ON `sales`.`store_id` = `store_cities`.`store_id`  




