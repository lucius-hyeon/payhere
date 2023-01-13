CREATE DATABASE  IF NOT EXISTS `payhere` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `payhere`;
-- MySQL dump 10.13  Distrib 5.7.39, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: payhere
-- ------------------------------------------------------
-- Server version	5.7.39-log

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

--
-- Table structure for table `accountbooks`
--

DROP TABLE IF EXISTS `accountbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountbooks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `income` int(11) NOT NULL,
  `expenses` int(11) NOT NULL,
  `balance` int(11) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `AccountBooks_author_id_dd8ba0df_fk_users_user_id` (`author_id`),
  CONSTRAINT `AccountBooks_author_id_dd8ba0df_fk_users_user_id` FOREIGN KEY (`author_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountbooks`
--

LOCK TABLES `accountbooks` WRITE;
/*!40000 ALTER TABLE `accountbooks` DISABLE KEYS */;
INSERT INTO `accountbooks` VALUES (1,5000,0,5000,'입금테스트','2023-01-13 18:06:05.091756','2023-01-13 18:06:05.091756',1,'2023-01-13'),(2,5000,0,10000,'입금테스트','2023-01-13 18:06:43.254774','2023-01-13 18:06:43.254774',1,'2023-01-13'),(3,0,5000,5000,'메모 내용 수정','2023-01-13 18:06:58.410735','2023-01-13 22:24:42.792666',1,'2023-01-13'),(4,20000,0,25000,'입금테스트','2023-01-13 22:22:51.291579','2023-01-13 22:22:51.291579',1,'2023-01-13'),(5,0,10000,15000,'출금테스트','2023-01-13 22:23:10.687453','2023-01-13 22:23:10.687453',1,'2023-01-13'),(6,5000,0,20000,'입금테스트','2023-01-13 22:23:20.940968','2023-01-13 22:23:20.940968',1,'2023-01-13');
/*!40000 ALTER TABLE `accountbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add blacklisted token',6,'add_blacklistedtoken'),(22,'Can change blacklisted token',6,'change_blacklistedtoken'),(23,'Can delete blacklisted token',6,'delete_blacklistedtoken'),(24,'Can view blacklisted token',6,'view_blacklistedtoken'),(25,'Can add outstanding token',7,'add_outstandingtoken'),(26,'Can change outstanding token',7,'change_outstandingtoken'),(27,'Can delete outstanding token',7,'delete_outstandingtoken'),(28,'Can view outstanding token',7,'view_outstandingtoken'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add account books',9,'add_accountbooks'),(34,'Can change account books',9,'change_accountbooks'),(35,'Can delete account books',9,'delete_accountbooks'),(36,'Can view account books',9,'view_accountbooks'),(37,'Can add url',10,'add_url'),(38,'Can change url',10,'change_url'),(39,'Can delete url',10,'delete_url'),(40,'Can view url',10,'view_url');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (9,'account_books','accountbooks'),(10,'account_books','url'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(6,'token_blacklist','blacklistedtoken'),(7,'token_blacklist','outstandingtoken'),(8,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'users','0001_initial','2023-01-13 18:03:20.651623'),(2,'account_books','0001_initial','2023-01-13 18:03:20.731624'),(3,'account_books','0002_url','2023-01-13 18:03:20.762629'),(4,'account_books','0003_url_created_at','2023-01-13 18:03:20.818661'),(5,'account_books','0004_alter_accountbooks_options_accountbooks_date','2023-01-13 18:03:20.875540'),(6,'account_books','0005_alter_accountbooks_balance','2023-01-13 18:03:20.939426'),(7,'contenttypes','0001_initial','2023-01-13 18:03:20.999062'),(8,'admin','0001_initial','2023-01-13 18:03:21.140398'),(9,'admin','0002_logentry_remove_auto_add','2023-01-13 18:03:21.147438'),(10,'admin','0003_logentry_add_action_flag_choices','2023-01-13 18:03:21.154442'),(11,'contenttypes','0002_remove_content_type_name','2023-01-13 18:03:21.242288'),(12,'auth','0001_initial','2023-01-13 18:03:21.538668'),(13,'auth','0002_alter_permission_name_max_length','2023-01-13 18:03:21.595062'),(14,'auth','0003_alter_user_email_max_length','2023-01-13 18:03:21.602062'),(15,'auth','0004_alter_user_username_opts','2023-01-13 18:03:21.610062'),(16,'auth','0005_alter_user_last_login_null','2023-01-13 18:03:21.619063'),(17,'auth','0006_require_contenttypes_0002','2023-01-13 18:03:21.622062'),(18,'auth','0007_alter_validators_add_error_messages','2023-01-13 18:03:21.630064'),(19,'auth','0008_alter_user_username_max_length','2023-01-13 18:03:21.637585'),(20,'auth','0009_alter_user_last_name_max_length','2023-01-13 18:03:21.645586'),(21,'auth','0010_alter_group_name_max_length','2023-01-13 18:03:21.704870'),(22,'auth','0011_update_proxy_permissions','2023-01-13 18:03:21.714840'),(23,'auth','0012_alter_user_first_name_max_length','2023-01-13 18:03:21.722010'),(24,'sessions','0001_initial','2023-01-13 18:03:21.773843'),(25,'token_blacklist','0001_initial','2023-01-13 18:03:21.948711'),(26,'token_blacklist','0002_outstandingtoken_jti_hex','2023-01-13 18:03:22.001027'),(27,'token_blacklist','0003_auto_20171017_2007','2023-01-13 18:03:22.015862'),(28,'token_blacklist','0004_auto_20171017_2013','2023-01-13 18:03:22.159523'),(29,'token_blacklist','0005_remove_outstandingtoken_jti','2023-01-13 18:03:22.223045'),(30,'token_blacklist','0006_auto_20171017_2113','2023-01-13 18:03:22.245047'),(31,'token_blacklist','0007_auto_20171017_2214','2023-01-13 18:03:22.453535'),(32,'token_blacklist','0008_migrate_to_bigautofield','2023-01-13 18:03:22.759590'),(33,'token_blacklist','0010_fix_migrate_to_bigautofield','2023-01-13 18:03:22.772107'),(34,'token_blacklist','0011_linearizes_history','2023-01-13 18:03:22.775105'),(35,'token_blacklist','0012_alter_outstandingtoken_user','2023-01-13 18:03:22.786104');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_blacklistedtoken` VALUES (1,'2023-01-13 22:22:15.087432',1);
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `jti` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_users_use` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_users_use` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY3MzY4NzA0MSwiaWF0IjoxNjczNjAwNjQxLCJqdGkiOiJmNTY2ZWZkNTk1M2M0YzBlYWIxMDE5OWUxZDdmYmE4NiIsInVzZXJfaWQiOjF9.dmgVB7oy4ENJVQQMo2XsAynb-rg9TVMB-cjSRTVIGxI','2023-01-13 09:04:01.563699','2023-01-14 09:04:01.000000',1,'f566efd5953c4c0eab10199e1d7fba86');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `origin_url` varchar(255) NOT NULL,
  `new_url` varchar(200) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` VALUES (1,'http://127.0.0.1:8000/account_books/1/1','http://127.0.0.1:8000/9HrG73Pw','2023-01-13 22:23:38.185593');
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES (1,'pbkdf2_sha256$390000$7cwKq6ETLkOqa5DlJYzVxx$d/JBMIcQgvNkAsWjoc874f5PW+gSab/+w9X6BRTPeIg=',NULL,'test@naver.com',1,0);
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-13 23:35:39
