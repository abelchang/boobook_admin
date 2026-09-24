-- BooBook 訂房管理筆記系統 - 完整 MySQL 資料庫結構初始化腳本
-- Compatible with MySQL 5.7+ / 8.0+ / MariaDB 10.3+

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 1. 用戶與權限表 (users)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `phone` VARCHAR(50) NOT NULL DEFAULT '',
  `password` VARCHAR(255) NOT NULL DEFAULT '',
  `permission` ENUM('helper', 'level1', 'level2', 'level3', 'admin') NOT NULL DEFAULT 'level3' COMMENT '權限等級：helper=小幫手, level1=普通會員, level2=進階會員, level3=旗艦會員, admin=管理員',
  `period` DATETIME NULL DEFAULT NULL COMMENT '會員有效截止日期',
  `ftoken` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FCM 推播 Token',
  `code` VARCHAR(100) NULL DEFAULT NULL COMMENT '推薦或關聯碼',
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_phone_unique` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系統使用者表';

-- ----------------------------
-- 2. 國家與城市表 (countries / cities)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `countries` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='國家字典表';

CREATE TABLE IF NOT EXISTS `cities` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(100) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cities_country_id_foreign` (`country_id`),
  CONSTRAINT `fk_cities_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='城市縣市字典表';

-- ----------------------------
-- 3. 民宿 / 旅宿實體表 (bnbs)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `bnbs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT '民宿擁有者',
  `bnb_name` VARCHAR(255) NOT NULL DEFAULT '',
  `order_sample` TEXT NULL COMMENT '訂單成立訊息範本',
  `cancel_sample` TEXT NULL COMMENT '取消訂單訊息範本',
  `delay_sample` TEXT NULL COMMENT '延期訂房訊息範本',
  `check_sample` TEXT NULL COMMENT '入住確認訊息範本',
  `deposit` INT NOT NULL DEFAULT 50 COMMENT '訂金成數 % (預設50%)',
  `deposit_period` INT NOT NULL DEFAULT 2 COMMENT '訂金保留天數 (預設2天)',
  `activity` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否營運中 (1:啟用, 0:停用)',
  `delay` INT NOT NULL DEFAULT 6 COMMENT '延期保留期限 (月數)',
  `code` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '民宿代碼',
  `city_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `country_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `bnbs_user_id_foreign` (`user_id`),
  KEY `bnbs_city_id_foreign` (`city_id`),
  CONSTRAINT `fk_bnbs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bnbs_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='民宿資料表';

-- ----------------------------
-- 4. 房型 / 房間表 (rooms)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bnb_id` BIGINT UNSIGNED NOT NULL,
  `room_name` VARCHAR(255) NOT NULL DEFAULT '',
  `default_price` INT NOT NULL DEFAULT 0 COMMENT '定價',
  `normal_price` INT NOT NULL DEFAULT 0 COMMENT '平日價',
  `holiday_price` INT NOT NULL DEFAULT 0 COMMENT '假日價',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `rooms_bnb_id_foreign` (`bnb_id`),
  CONSTRAINT `fk_rooms_bnb` FOREIGN KEY (`bnb_id`) REFERENCES `bnbs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='民宿房間/房型表';

-- ----------------------------
-- 5. 客戶 / 房客資料表 (customers)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `customers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bnb_id` BIGINT UNSIGNED NOT NULL,
  `customer_name` VARCHAR(255) NOT NULL DEFAULT '',
  `phone` VARCHAR(50) NOT NULL DEFAULT '',
  `id_card` VARCHAR(50) NULL DEFAULT '' COMMENT '身分證字號/護照號碼',
  `address` VARCHAR(255) NULL DEFAULT '',
  `birthday` DATE NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `city_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `country_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `blacklist` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否為黑名單 (1:黑名單, 0:正常)',
  `blacklist_memo` TEXT NULL COMMENT '黑名單原因備註',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customers_bnb_id_foreign` (`bnb_id`),
  KEY `customers_phone_index` (`phone`),
  CONSTRAINT `fk_customers_bnb` FOREIGN KEY (`bnb_id`) REFERENCES `bnbs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客戶資料表';

-- ----------------------------
-- 6. 訂房管道來源表 (order_places)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `order_places` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bnb_id` BIGINT UNSIGNED NOT NULL,
  `order_place` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '來源名稱，如 Booking, Agoda, 官網',
  `commission` INT NOT NULL DEFAULT 0 COMMENT '抽成趴數 (%)',
  `activity` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否啟用',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_places_bnb_id_foreign` (`bnb_id`),
  CONSTRAINT `fk_order_places_bnb` FOREIGN KEY (`bnb_id`) REFERENCES `bnbs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂單來源管道表';

-- ----------------------------
-- 7. 訂單狀態字典表 (order_statuses)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `order_statuses` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(100) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂單狀態表';

-- 預設插入狀態
INSERT IGNORE INTO `order_statuses` (`id`, `status`) VALUES
(1, '新訂單/待確認'),
(2, '已付訂金'),
(3, '已付全額'),
(4, '已入住'),
(5, '已退房'),
(6, '已取消'),
(7, '已延期');

-- ----------------------------
-- 8. 訂房訂單主表 (orders)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `orders` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bnb_id` BIGINT UNSIGNED NOT NULL,
  `customer_id` BIGINT UNSIGNED NOT NULL,
  `room_id` BIGINT UNSIGNED NOT NULL,
  `order_status_id` BIGINT UNSIGNED NOT NULL,
  `order_place_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `checkin` DATE NOT NULL COMMENT '入住日期',
  `checkout` DATE NOT NULL COMMENT '退房日期',
  `price` INT NOT NULL DEFAULT 0 COMMENT '房價總計',
  `deposit_pay` INT NOT NULL DEFAULT 0 COMMENT '已收訂金',
  `photo_path` VARCHAR(255) NULL DEFAULT NULL COMMENT '匯款或證件截圖路徑',
  `memo` TEXT NULL COMMENT '訂單備忘',
  `delay_perid` DATE NULL DEFAULT NULL COMMENT '延期保留期限',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `orders_bnb_id_foreign` (`bnb_id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_room_id_foreign` (`room_id`),
  KEY `orders_checkin_checkout_idx` (`checkin`, `checkout`),
  CONSTRAINT `fk_orders_bnb` FOREIGN KEY (`bnb_id`) REFERENCES `bnbs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orders_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orders_status` FOREIGN KEY (`order_status_id`) REFERENCES `order_statuses` (`id`),
  CONSTRAINT `fk_orders_place` FOREIGN KEY (`order_place_id`) REFERENCES `order_places` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂單資料表';

-- ----------------------------
-- 9. 訂金查帳與核銷表記錄 (deposits)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `deposits` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bnb_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `account` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '匯款末五碼或帳號',
  `deposit_pay` INT NOT NULL DEFAULT 0 COMMENT '匯款金額',
  `check` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已核對查帳 (1:已核, 0:未核)',
  `code` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '查帳對應碼',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `deposits_bnb_id_foreign` (`bnb_id`),
  KEY `deposits_order_id_foreign` (`order_id`),
  CONSTRAINT `fk_deposits_bnb` FOREIGN KEY (`bnb_id`) REFERENCES `bnbs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_deposits_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂金與匯款回報表';

-- ----------------------------
-- 10. 訂單推播通知紀錄 (order_notifies)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `order_notifies` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `type` INT NOT NULL DEFAULT 0 COMMENT '通知類型 (1:訂金通知, 2:入住前提醒, 3:取消通知等)',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_notifies_order_id_foreign` (`order_id`),
  CONSTRAINT `fk_order_notifies_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂單通知排程與發送紀錄';

-- ----------------------------
-- 11. 國定假日與行事曆表 (holidays)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `holidays` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL COMMENT '假日日期',
  `name` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '節日名稱',
  `is_holiday` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否放假',
  `holiday_category` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '假日類別 (如放假之紀念日、補假等)',
  `description` TEXT NULL COMMENT '備註說明',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `holidays_date_unique` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='政府國定假日行事曆';

-- ----------------------------
-- 12. 自訂備忘日表 (memodays)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `memodays` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bnb_id` BIGINT UNSIGNED NOT NULL,
  `date` DATE NOT NULL,
  `memo` VARCHAR(255) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `memodays_bnb_id_foreign` (`bnb_id`),
  CONSTRAINT `fk_memodays_bnb` FOREIGN KEY (`bnb_id`) REFERENCES `bnbs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='民宿業主自訂備忘提醒日';

-- ----------------------------
-- 13. 二十四節氣表 (solars)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `solars` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `name` VARCHAR(50) NOT NULL DEFAULT '',
  `description` TEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `solars_date_index` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='二十四節氣資料表';

-- ----------------------------
-- 14. 註冊邀請碼與授權碼 (icodes)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `icodes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(100) NOT NULL DEFAULT '',
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `phone` VARCHAR(50) NOT NULL DEFAULT '',
  `type` INT NOT NULL DEFAULT 0 COMMENT '方案代碼 (如 1:level1, 2:level2, 3:level3)',
  `status` INT NOT NULL DEFAULT 0 COMMENT '0:未使用, 1:已啟用, 2:過期',
  `user_id` BIGINT UNSIGNED NULL DEFAULT NULL COMMENT '核銷該碼的用戶',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `icodes_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='會員邀請碼與授權序號表';

-- ----------------------------
-- 15. App 版本控制與強制更新 (app_versions)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `app_versions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `version` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '版號 (例如 2.0.11)',
  `build` INT NOT NULL DEFAULT 0 COMMENT 'Build 號 (例如 29)',
  `force` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否強制更新 (1:是, 0:否)',
  `link` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '商店下載網址',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='App版本控制表';

SET FOREIGN_KEY_CHECKS = 1;
