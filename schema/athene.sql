-- MySQL dump 10.13  Distrib 5.5.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: athene
-- ------------------------------------------------------
-- Server version	5.5.30-rel30.2-log

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
-- Table structure for table `attr_log`
--

DROP TABLE IF EXISTS `attr_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attr_log` (
  `userid` bigint(20) NOT NULL,
  `attr` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `old_data` int(11) NOT NULL,
  `delta_type` smallint(6) NOT NULL,
  `delta_data` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `time_tail` int(11) NOT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1',
  `balance` int(11) DEFAULT '0',
  PRIMARY KEY (`userid`,`timestamp`,`attr`,`time_tail`),
  KEY `attr_log_source` (`source`),
  KEY `attr_log_timestamp` (`timestamp`),
  KEY `index_name` (`userid`),
  KEY `index_name_time` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `behavior_log`
--

DROP TABLE IF EXISTS `behavior_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `behavior_log` (
  `userid` bigint(20) NOT NULL,
  `action` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_tail` int(11) DEFAULT NULL,
  `serverid` int(11) DEFAULT NULL,
  KEY `index_behavior_log` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `create_log`
--

DROP TABLE IF EXISTS `create_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `create_log` (
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `create_log_new`
--

DROP TABLE IF EXISTS `create_log_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `create_log_new` (
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL,
  PRIMARY KEY (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `online_log`
--

DROP TABLE IF EXISTS `online_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `online_log` (
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `online_log_t`
--

DROP TABLE IF EXISTS `online_log_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `online_log_t` (
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL,
  PRIMARY KEY (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package` (
  `userid` bigint(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time_tail` int(20) NOT NULL,
  `itemtype` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `type` int(255) NOT NULL,
  `itemid` varchar(64) DEFAULT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userid`,`timestamp`,`time_tail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quest_log`
--

DROP TABLE IF EXISTS `quest_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_log` (
  `userid` bigint(20) NOT NULL,
  `key` varchar(20) NOT NULL,
  `quest_id` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `new_exp` int(11) NOT NULL,
  `new_gold` int(11) NOT NULL,
  `new_attr1` int(11) NOT NULL,
  `new_attr2` int(11) NOT NULL,
  `new_attr3` int(11) NOT NULL,
  `new_attr4` int(11) NOT NULL,
  `new_attr5` int(11) NOT NULL,
  `new_attr6` int(11) NOT NULL,
  `new_attr7` int(11) NOT NULL,
  `new_attr8` int(11) NOT NULL,
  `new_attr9` int(11) NOT NULL,
  `new_attr10` int(11) NOT NULL,
  `add_gold` int(11) NOT NULL,
  `add_exp` int(11) NOT NULL,
  `add_attr1` int(11) NOT NULL,
  `add_attr2` int(11) NOT NULL,
  `add_attr3` int(11) NOT NULL,
  `add_attr4` int(11) NOT NULL,
  `add_attr5` int(11) NOT NULL,
  `add_attr6` int(11) NOT NULL,
  `add_attr7` int(11) NOT NULL,
  `add_attr8` int(11) NOT NULL,
  `add_attr9` int(11) NOT NULL,
  `add_attr10` int(11) NOT NULL,
  `reward_item` varchar(255) NOT NULL,
  `time_tail` int(11) NOT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userid`,`quest_id`,`timestamp`,`time_tail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `userid` bigint(20) NOT NULL,
  `attr` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `old_data` int(11) NOT NULL,
  `delta_type` smallint(6) NOT NULL,
  `delta_data` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `time_tail` int(11) NOT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1',
  `balance` int(11) DEFAULT '0',
  PRIMARY KEY (`userid`,`timestamp`,`attr`,`time_tail`),
  KEY `attr_log_source` (`source`),
  KEY `attr_log_timestamp` (`timestamp`),
  KEY `index_name` (`userid`),
  KEY `index_name_time` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token_and_coupons_log`
--

DROP TABLE IF EXISTS `token_and_coupons_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_and_coupons_log` (
  `userid` bigint(20) NOT NULL,
  `attr` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `old_data` int(11) NOT NULL,
  `delta_type` smallint(6) NOT NULL,
  `delta_data` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  `time_tail` int(11) NOT NULL,
  `serverid` int(11) NOT NULL DEFAULT '1',
  `balance` int(11) DEFAULT '0',
  PRIMARY KEY (`userid`,`timestamp`,`attr`,`time_tail`),
  KEY `attr_log_source` (`source`),
  KEY `attr_log_timestamp` (`timestamp`),
  KEY `index_name` (`userid`),
  KEY `index_name_time` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-11 14:20:30
