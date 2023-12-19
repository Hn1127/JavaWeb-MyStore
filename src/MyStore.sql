-- demo.product_type definition

CREATE TABLE `product_type` (
  `product_type` int NOT NULL,
  `real_type` text NOT NULL,
  PRIMARY KEY (`product_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='将product.product_type中的属性转换';


-- demo.`user` definition

CREATE TABLE `user` (
  `uin` bigint NOT NULL,
  `username` varchar(20) NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `register_time` date DEFAULT NULL,
  PRIMARY KEY (`uin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- demo.product definition

CREATE TABLE `product` (
  `product_id` bigint NOT NULL,
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品名',
  `product_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '商品描述',
  `product_price` decimal(10,2) NOT NULL COMMENT '价格',
  `product_type` int NOT NULL DEFAULT '1' COMMENT '商品分类',
  `product_inventory` int DEFAULT '0' COMMENT '库存',
  `product_valid` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`product_id`),
  KEY `product_FK` (`product_type`),
  CONSTRAINT `product_FK` FOREIGN KEY (`product_type`) REFERENCES `product_type` (`product_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- demo.userhistory definition

CREATE TABLE `userhistory` (
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `userhistory_FK_product` (`product_id`),
  CONSTRAINT `userhistory_FK_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `userhistory_FK_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`uin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- demo.cart definition

CREATE TABLE `cart` (
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  UNIQUE KEY `cart_un` (`user_id`,`product_id`),
  KEY `cart_user_id_IDX` (`user_id`) USING BTREE,
  KEY `cart_FK_productID` (`product_id`),
  CONSTRAINT `cart_FK_productID` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `cart_FK_userID` FOREIGN KEY (`user_id`) REFERENCES `user` (`uin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='cart项，用户加入购物车的product，按照user_id聚簇排序';


-- demo.`order` definition

CREATE TABLE `order` (
  `order_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `product_price` decimal(10,0) DEFAULT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `order_FK_product` (`product_id`),
  KEY `order_FK_user` (`user_id`),
  CONSTRAINT `order_FK_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `order_FK_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`uin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='oder项，每个cart对应生成一个order，按照user_id,order_date聚簇排序';