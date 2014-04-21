/*
 Navicat Premium Data Transfer

 Source Server         : 106-mysql
 Source Server Type    : MySQL
 Source Server Version : 50166
 Source Host           : 172.16.8.106
 Source Database       : athene

 Target Server Type    : MySQL
 Target Server Version : 50166
 File Encoding         : utf-8

 Date: 03/19/2013 21:09:52 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `quest`
-- ----------------------------
DROP TABLE IF EXISTS `quest`;
CREATE TABLE `quest` (
  `userid` int(11) NOT NULL,
  `key` varchar(20) NOT NULL,
  `quest_id` varchar(20) NOT NULL,
  `time` varchar(20) NOT NULL,
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
  `add_attr10` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

