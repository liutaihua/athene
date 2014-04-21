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

 Date: 03/19/2013 21:09:58 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `attr_log`
-- ----------------------------
DROP TABLE IF EXISTS `attr_log`;
CREATE TABLE `attr_log` (
  `userid` int(11) NOT NULL,
  `attr` varchar(20) NOT NULL,
  `time` varchar(30) NOT NULL,
  `old_data` int(11) NOT NULL,
  `delta_type` smallint(6) NOT NULL,
  `delta_data` int(11) NOT NULL,
  `source` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`,`time`,`attr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `attr_log`
-- ----------------------------
BEGIN;
INSERT INTO `attr_log` VALUES ('1154', 'gold', '2013-03-19_20:18:19.691518\n', '569426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.701636\n', '563426', '0', '8000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.709671\n', '555426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.718101\n', '549426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.727246\n', '545426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.736404\n', '539426', '0', '8000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.744769\n', '531426', '0', '10000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.752462\n', '521426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.759383\n', '515426', '0', '8000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.769068\n', '507426', '0', '10000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.778242\n', '497426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.785300\n', '491426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.793167\n', '487426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.800047\n', '481426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.807173\n', '477426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.818241\n', '475426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.824934\n', '473426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.831646\n', '471426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.838409\n', '467426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:18:19.845073\n', '461426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:47.070097\n', '457426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.070281\n', '458426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.070413\n', '459426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.070542\n', '460426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.070670\n', '461426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.070815\n', '462426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.071016\n', '463426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.071151\n', '464426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:47.071280\n', '465426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:48.129913\n', '466426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.137180\n', '464426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.144225\n', '462426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.151526\n', '460426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.158503\n', '456426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.165503\n', '454426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.172564\n', '452426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.180077\n', '448426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.187354\n', '446426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.194453\n', '444426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.201316\n', '440426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.208083\n', '438426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.214642\n', '434426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.222932\n', '432426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.230910\n', '428426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.237927\n', '422426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.245041\n', '418426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.253498\n', '416426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:48.263681\n', '414426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:50.462273\n', '412426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.462438\n', '413426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.462569\n', '414426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.462696\n', '415426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.462821\n', '416426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.462967\n', '417426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463096\n', '418426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463222\n', '419426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463348\n', '420426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463474\n', '421426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463599\n', '422426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463724\n', '423426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463850\n', '424426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.463995\n', '425426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.464122\n', '426426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.464248\n', '427426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:50.464374\n', '428426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:19:51.869341\n', '429426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.879022\n', '427426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.885629\n', '425426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.892332\n', '423426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.899153\n', '419426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.905881\n', '417426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.912567\n', '415426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.919435\n', '411426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.926631\n', '409426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.933600\n', '405426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.941943\n', '403426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.953274\n', '401426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.963538\n', '397426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.972776\n', '395426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.979431\n', '393426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.985960\n', '391426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.992740\n', '387426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:51.999285\n', '381426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:52.005803\n', '377426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:19:52.012270\n', '375426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:20:33.868703\n', '49235', '0', '5', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:33.868939\n', '49230', '0', '10', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.684143\n', '49220', '0', '15', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.684360\n', '49205', '0', '20', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.684542\n', '49185', '0', '25', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.684720\n', '49160', '0', '30', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.684909\n', '49130', '0', '35', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.685095\n', '49095', '0', '40', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.685272\n', '49055', '0', '45', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:35.685449\n', '49010', '0', '50', 'enlarge_package'), ('1154', 'gold', '2013-03-19_20:20:59.211264\n', '373426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.211500\n', '374426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.211690\n', '375426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.211928\n', '376426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212097\n', '377426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212229\n', '378426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212358\n', '379426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212496\n', '380426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212624\n', '381426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212751\n', '382426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:20:59.212886\n', '383426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:00.031250\n', '384426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.037992\n', '380426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.046207\n', '378426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.052996\n', '376426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.060782\n', '374426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.068763\n', '372426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.078070\n', '370426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.085071\n', '366426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.094104\n', '360426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.101110\n', '356426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.108225\n', '354426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.115494\n', '350426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.122566\n', '348426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.129740\n', '344426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.136853\n', '342426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.143806\n', '338426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.150424\n', '336426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.157731\n', '334426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.164479\n', '330426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:00.171802\n', '324426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:03.841239\n', '320426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.841443\n', '321426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.841574\n', '322426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.841702\n', '323426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.841829\n', '324426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.841981\n', '325426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.842110\n', '326426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.842237\n', '327426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.842364\n', '328426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:03.842490\n', '329426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:04.568074\n', '330426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.574707\n', '324426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.581450\n', '320426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.589130\n', '314426', '0', '8000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.595776\n', '306426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.602356\n', '300426', '0', '8000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.608803\n', '292426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.615453\n', '286426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.622072\n', '282426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.628671\n', '276426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.635292\n', '272426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.642140\n', '270426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.648588\n', '268426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.655186\n', '264426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.661642\n', '258426', '0', '8000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.668181\n', '250426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.674623\n', '244426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.681119\n', '240426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.687846\n', '238426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:04.694492\n', '236426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:08.202962\n', '232426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203163\n', '233426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203296\n', '234426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203425\n', '235426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203552\n', '236426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203679\n', '237426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203806\n', '238426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.203947\n', '239426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204075\n', '240426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204202\n', '241426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204329\n', '242426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204457\n', '243426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204583\n', '244426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204711\n', '245426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.204854\n', '246426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:08.973016\n', '247426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:08.979869\n', '241426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:08.986475\n', '237426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:08.993092\n', '235426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.000339\n', '233426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.007795\n', '229426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.020095\n', '227426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.027082\n', '225426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.033976\n', '221426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.041590\n', '215426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.050156\n', '211426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.057149\n', '209426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.064551\n', '207426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.072061\n', '203426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.079273\n', '201426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.087328\n', '199426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.094366\n', '195426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.101280\n', '193426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.108094\n', '189426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:09.114835\n', '183426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.279747\n', '179426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.279943\n', '180426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280078\n', '181426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280208\n', '182426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280336\n', '183426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280464\n', '184426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280591\n', '185426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280718\n', '186426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280855\n', '187426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.280996\n', '188426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.281125\n', '189426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.281252\n', '190426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.281379\n', '191426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:12.945957\n', '192426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.952864\n', '186426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.959622\n', '182426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.966376\n', '176426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.972966\n', '172426', '0', '6000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.979623\n', '166426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.987236\n', '162426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:12.995082\n', '160426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.002714\n', '156426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.011812\n', '154426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.024835\n', '150426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.031648\n', '148426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.038306\n', '146426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.044873\n', '144426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.051502\n', '142426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.058796\n', '138426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.066620\n', '136426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.074546\n', '134426', '0', '4000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.082063\n', '130426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:13.088914\n', '128426', '0', '2000', 'shortcut_start'), ('1154', 'gold', '2013-03-19_20:21:15.804307\n', '126426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:15.804485\n', '127426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:15.804616\n', '128426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:15.804743\n', '129426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:15.804880\n', '130426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:15.805020\n', '131426', '1', '1000', 'shortcut_sell'), ('1154', 'gold', '2013-03-19_20:21:15.805147\n', '132426', '1', '1000', 'shortcut_sell');
COMMIT;

