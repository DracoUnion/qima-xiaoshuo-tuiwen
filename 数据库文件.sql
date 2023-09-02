/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.1.8
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : 192.168.1.8:3306
 Source Schema         : test123

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 12/08/2023 22:01:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
INSERT INTO `fa_admin` VALUES (1, 'admin', 'Admin', '48fea75fb1699a6bfd1049263cf01454', '630bc6', '/uploads/20230811/0412db336520adbe8a8280dce774d735.png', '858438539@qq.com', '', 0, 1691839489, '192.168.1.7', 1491635035, 1691839489, '35798f6e-b01b-4978-b230-3556799c8b1c', 'normal');

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 271 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
DROP TABLE IF EXISTS `fa_area`;
CREATE TABLE `fa_area`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_area
-- ----------------------------

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fa_attachment`;
CREATE TABLE `fa_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类别',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) NULL DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
INSERT INTO `fa_attachment` VALUES (1, '', 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1491635035, 1491635035, 1491635035, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `fa_attachment` VALUES (2, '', 1, 0, '/uploads/20230805/7ed448d8ef47fdaca16cbe1b47c1742f.jpg', '1280', '722', 'jpg', 0, 'QQ图片20230805093117.jpg', 91612, 'image/jpeg', '', 1691199090, 1691199090, 1691199090, 'local', '2301dd68110a7156ae8566a8e9c8ffa80cd58230');
INSERT INTO `fa_attachment` VALUES (3, '', 1, 0, '/uploads/20230811/0412db336520adbe8a8280dce774d735.png', '615', '617', 'png', 0, '0412db336520adbe8a8280dce774d735.png', 433849, 'image/png', '', 1691747247, 1691747247, 1691747247, 'local', '4b87c3b8c95427ec07b121eb5021131b6abb60d9');

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group`;
CREATE TABLE `fa_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
INSERT INTO `fa_auth_group` VALUES (1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group_access`;
CREATE TABLE `fa_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
INSERT INTO `fa_auth_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_rule`;
CREATE TABLE `fa_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
INSERT INTO `fa_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', 1, NULL, '', 'kzt', 'kongzhitai', 1491635035, 1491635035, 143, 'normal');
INSERT INTO `fa_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', '', 1, NULL, '', 'cggl', 'changguiguanli', 1491635035, 1491635035, 137, 'normal');
INSERT INTO `fa_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', 0, NULL, '', 'flgl', 'fenleiguanli', 1491635035, 1691814173, 119, 'normal');
INSERT INTO `fa_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', '', 'Addon tips', 0, NULL, '', 'cjgl', 'chajianguanli', 1491635035, 1691814177, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', '', 1, NULL, '', 'qxgl', 'quanxianguanli', 1491635035, 1491635035, 99, 'normal');
INSERT INTO `fa_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1491635035, 1491635035, 60, 'normal');
INSERT INTO `fa_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', 1, NULL, '', 'fjgl', 'fujianguanli', 1491635035, 1491635035, 53, 'normal');
INSERT INTO `fa_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', '', 1, NULL, '', 'grzl', 'gerenziliao', 1491635035, 1491635035, 34, 'normal');
INSERT INTO `fa_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', 1, NULL, '', 'glygl', 'guanliyuanguanli', 1491635035, 1491635035, 118, 'normal');
INSERT INTO `fa_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', 1, NULL, '', 'glyrz', 'guanliyuanrizhi', 1491635035, 1491635035, 113, 'normal');
INSERT INTO `fa_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', '', 'Group tips', 1, NULL, '', 'jsz', 'juesezu', 1491635035, 1491635035, 109, 'normal');
INSERT INTO `fa_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', 1, NULL, '', 'cdgz', 'caidanguize', 1491635035, 1491635035, 104, 'normal');
INSERT INTO `fa_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 136, 'normal');
INSERT INTO `fa_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 135, 'normal');
INSERT INTO `fa_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 133, 'normal');
INSERT INTO `fa_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 134, 'normal');
INSERT INTO `fa_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 132, 'normal');
INSERT INTO `fa_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 52, 'normal');
INSERT INTO `fa_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 51, 'normal');
INSERT INTO `fa_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 50, 'normal');
INSERT INTO `fa_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 49, 'normal');
INSERT INTO `fa_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 48, 'normal');
INSERT INTO `fa_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', 0, NULL, '', '', '', 1491635035, 1491635035, 59, 'normal');
INSERT INTO `fa_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 58, 'normal');
INSERT INTO `fa_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 57, 'normal');
INSERT INTO `fa_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 56, 'normal');
INSERT INTO `fa_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 55, 'normal');
INSERT INTO `fa_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 54, 'normal');
INSERT INTO `fa_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 33, 'normal');
INSERT INTO `fa_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 32, 'normal');
INSERT INTO `fa_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 31, 'normal');
INSERT INTO `fa_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 30, 'normal');
INSERT INTO `fa_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 29, 'normal');
INSERT INTO `fa_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 28, 'normal');
INSERT INTO `fa_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', 0, NULL, '', '', '', 1491635035, 1491635035, 142, 'normal');
INSERT INTO `fa_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 141, 'normal');
INSERT INTO `fa_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 140, 'normal');
INSERT INTO `fa_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 139, 'normal');
INSERT INTO `fa_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 138, 'normal');
INSERT INTO `fa_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', 0, NULL, '', '', '', 1491635035, 1491635035, 117, 'normal');
INSERT INTO `fa_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 116, 'normal');
INSERT INTO `fa_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 115, 'normal');
INSERT INTO `fa_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 114, 'normal');
INSERT INTO `fa_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', 0, NULL, '', '', '', 1491635035, 1491635035, 112, 'normal');
INSERT INTO `fa_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 111, 'normal');
INSERT INTO `fa_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 110, 'normal');
INSERT INTO `fa_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', 0, NULL, '', '', '', 1491635035, 1491635035, 108, 'normal');
INSERT INTO `fa_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 107, 'normal');
INSERT INTO `fa_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 106, 'normal');
INSERT INTO `fa_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 105, 'normal');
INSERT INTO `fa_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', 0, NULL, '', '', '', 1491635035, 1491635035, 103, 'normal');
INSERT INTO `fa_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 102, 'normal');
INSERT INTO `fa_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 101, 'normal');
INSERT INTO `fa_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-user-circle', '', '', '', 0, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1690987708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', '', 1, NULL, '', 'hyfz', 'huiyuanfenzu', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'hygz', 'huiyuanguize', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (85, 'file', 0, 'command', '在线命令管理', 'fa fa-terminal', '', '', '', 0, NULL, '', 'zxmlgl', 'zaixianminglingguanli', 1690977381, 1691814179, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (86, 'file', 85, 'command/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (87, 'file', 85, 'command/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (88, 'file', 85, 'command/detail', '详情', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xq', 'xiangqing', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (89, 'file', 85, 'command/command', '生成并执行命令', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'scbzxml', 'shengchengbingzhixingmingling', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (90, 'file', 85, 'command/execute', '再次执行命令', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zczxml', 'zaicizhixingmingling', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (91, 'file', 85, 'command/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (92, 'file', 85, 'command/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1690977381, 1690977381, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (93, 'file', 0, 'video', '七码', 'fa fa-github-alt', '', '', '', 1, 'addtabs', '', 'qm', 'qima', 1690977473, 1690987865, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (94, 'file', 93, 'video/task', '任务管理', 'fa fa-tasks', '', '', '', 1, 'addtabs', '', 'rwgl', 'renwuguanli', 1690977473, 1690987881, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (95, 'file', 94, 'video/task/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (96, 'file', 94, 'video/task/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (97, 'file', 94, 'video/task/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (98, 'file', 94, 'video/task/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (99, 'file', 94, 'video/task/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (100, 'file', 94, 'video/task/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (101, 'file', 94, 'video/task/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (102, 'file', 94, 'video/task/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1690977473, 1690977473, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (103, 'file', 93, 'video/item', '项目管理', 'fa fa-database', '', '', '', 1, 'addtabs', '', 'xmgl', 'xiangmuguanli', 1690979559, 1690987906, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (104, 'file', 103, 'video/item/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (105, 'file', 103, 'video/item/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (106, 'file', 103, 'video/item/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (107, 'file', 103, 'video/item/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (108, 'file', 103, 'video/item/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (109, 'file', 103, 'video/item/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (110, 'file', 103, 'video/item/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (111, 'file', 103, 'video/item/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1690979559, 1690979559, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (112, 'file', 93, 'video/tagger', '图片反推', 'fa fa-image', '', '', '', 1, 'addtabs', '', 'tpft', 'tupianfantui', 1691198034, 1691200073, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (113, 'file', 112, 'video/tagger/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', 1691198034, 1691198034, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (114, 'file', 112, 'video/tagger/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1691198034, 1691198034, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (115, 'file', 112, 'video/tagger/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1691198034, 1691198034, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (116, 'file', 112, 'video/tagger/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1691198034, 1691198034, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (117, 'file', 112, 'video/tagger/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1691198034, 1691198034, 0, 'normal');

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_category`;
CREATE TABLE `fa_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 159 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_category
-- ----------------------------
INSERT INTO `fa_category` VALUES (14, 0, 'voice', 'zhimiao_emo', '知妙_多情感', '', '', '', '', '', 1689389629, 1689389629, 14, 'normal');
INSERT INTO `fa_category` VALUES (15, 0, 'voice', 'zhimi_emo', '知米_多情感', '', '', '', '', '', 1689389641, 1689389641, 15, 'normal');
INSERT INTO `fa_category` VALUES (16, 0, 'voice', 'zhiyan_emo', '知燕_多情感', '', '', '', '', '', 1689389656, 1689389656, 16, 'normal');
INSERT INTO `fa_category` VALUES (17, 0, 'voice', 'zhibei_emo', '知贝_多情感', '', '', '', '', '', 1689389684, 1689389684, 17, 'normal');
INSERT INTO `fa_category` VALUES (18, 0, 'voice', 'zhitian_emo', '知甜_多情感', '', '', '', '', '', 1689389694, 1689389694, 18, 'normal');
INSERT INTO `fa_category` VALUES (19, 0, 'voice', 'xiaoyun', '小云', '', '', '', '', '', 1689389701, 1689389701, 19, 'normal');
INSERT INTO `fa_category` VALUES (20, 0, 'voice', 'xiaogang', '小刚', '', '', '', '', '', 1689389711, 1689389711, 20, 'normal');
INSERT INTO `fa_category` VALUES (21, 0, 'voice', 'ruoxi', '若兮', '', '', '', '', '', 1689389721, 1689389721, 21, 'normal');
INSERT INTO `fa_category` VALUES (22, 0, 'voice', 'siqi', '思琪', '', '', '', '', '', 1689389731, 1689389731, 22, 'normal');
INSERT INTO `fa_category` VALUES (23, 0, 'voice', 'sijia', '思佳', '', '', '', '', '', 1689389738, 1689389738, 23, 'normal');
INSERT INTO `fa_category` VALUES (24, 0, 'voice', 'sicheng', '思诚', '', '', '', '', '', 1689389749, 1689389749, 24, 'normal');
INSERT INTO `fa_category` VALUES (25, 0, 'voice', 'aiqi', '艾琪', '', '', '', '', '', 1689389756, 1689389756, 25, 'normal');
INSERT INTO `fa_category` VALUES (26, 0, 'voice', 'aijia', '艾佳', '', '', '', '', '', 1689389762, 1689389762, 26, 'normal');
INSERT INTO `fa_category` VALUES (27, 0, 'voice', 'aicheng', '艾诚', '', '', '', '', '', 1689389770, 1689389770, 27, 'normal');
INSERT INTO `fa_category` VALUES (28, 0, 'voice', 'aida', '艾达', '', '', '', '', '', 1689389777, 1689389777, 28, 'normal');
INSERT INTO `fa_category` VALUES (29, 0, 'voice', 'ninger', '宁儿', '', '', '', '', '', 1689389783, 1689389783, 29, 'normal');
INSERT INTO `fa_category` VALUES (30, 0, 'voice', 'ruilin', '瑞琳', '', '', '', '', '', 1689389790, 1689389790, 30, 'normal');
INSERT INTO `fa_category` VALUES (31, 0, 'voice', 'siyue', '思悦', '', '', '', '', '', 1689389797, 1689389797, 31, 'normal');
INSERT INTO `fa_category` VALUES (32, 0, 'voice', 'aiya', '艾雅', '', '', '', '', '', 1689389804, 1689389804, 32, 'normal');
INSERT INTO `fa_category` VALUES (33, 0, 'voice', 'aixia', '艾夏', '', '', '', '', '', 1689389810, 1689389810, 33, 'normal');
INSERT INTO `fa_category` VALUES (34, 0, 'voice', 'aimei', '艾美', '', '', '', '', '', 1689389817, 1689389817, 34, 'normal');
INSERT INTO `fa_category` VALUES (35, 0, 'voice', 'aiyu', '艾雨', '', '', '', '', '', 1689389831, 1689389831, 35, 'normal');
INSERT INTO `fa_category` VALUES (36, 0, 'voice', 'aiyue', '艾悦', '', '', '', '', '', 1689389837, 1689389837, 36, 'normal');
INSERT INTO `fa_category` VALUES (37, 0, 'voice', 'aijing', '艾婧', '', '', '', '', '', 1689389844, 1689389844, 37, 'normal');
INSERT INTO `fa_category` VALUES (38, 0, 'voice', 'xiaomei', '小美', '', '', '', '', '', 1689389850, 1689389850, 38, 'normal');
INSERT INTO `fa_category` VALUES (39, 0, 'voice', 'aina', '艾娜', '', '', '', '', '', 1689389859, 1689389859, 39, 'normal');
INSERT INTO `fa_category` VALUES (40, 0, 'voice', 'yina', '伊娜', '', '', '', '', '', 1689389867, 1689389867, 40, 'normal');
INSERT INTO `fa_category` VALUES (41, 0, 'voice', 'sijing', '思婧', '', '', '', '', '', 1689389873, 1689389873, 41, 'normal');
INSERT INTO `fa_category` VALUES (42, 0, 'voice', 'sitong', '思彤', '', '', '', '', '', 1689389885, 1689389885, 42, 'normal');
INSERT INTO `fa_category` VALUES (43, 0, 'voice', 'xiaobei', '小北', '', '', '', '', '', 1689389891, 1689389891, 43, 'normal');
INSERT INTO `fa_category` VALUES (44, 0, 'voice', 'aitong', '艾彤', '', '', '', '', '', 1689389898, 1689389898, 44, 'normal');
INSERT INTO `fa_category` VALUES (45, 0, 'voice', 'aiwei', '艾薇', '', '', '', '', '', 1689389907, 1689389907, 45, 'normal');
INSERT INTO `fa_category` VALUES (46, 0, 'voice', 'aibao', '艾宝', '', '', '', '', '', 1689389914, 1689389914, 46, 'normal');
INSERT INTO `fa_category` VALUES (47, 0, 'voice', 'harry', 'Harry', '', '', '', '', '', 1689389921, 1689389921, 47, 'normal');
INSERT INTO `fa_category` VALUES (48, 0, 'voice', 'abby', 'Abby', '', '', '', '', '', 1689389928, 1689389928, 48, 'normal');
INSERT INTO `fa_category` VALUES (49, 0, 'voice', 'andy', 'Andy', '', '', '', '', '', 1689389934, 1689389934, 49, 'normal');
INSERT INTO `fa_category` VALUES (50, 0, 'voice', 'eric', 'Eric', '', '', '', '', '', 1689389941, 1689389941, 50, 'normal');
INSERT INTO `fa_category` VALUES (51, 0, 'voice', 'emily', 'Emily', '', '', '', '', '', 1689389947, 1689389947, 51, 'normal');
INSERT INTO `fa_category` VALUES (52, 0, 'voice', 'luna', 'Luna', '', '', '', '', '', 1689389953, 1689389953, 52, 'normal');
INSERT INTO `fa_category` VALUES (53, 0, 'voice', 'luca', 'Luca', '', '', '', '', '', 1689389960, 1689389960, 53, 'normal');
INSERT INTO `fa_category` VALUES (54, 0, 'voice', 'wendy', 'Wendy', '', '', '', '', '', 1689389968, 1689389968, 54, 'normal');
INSERT INTO `fa_category` VALUES (55, 0, 'voice', 'william', 'William', '', '', '', '', '', 1689389975, 1689389975, 55, 'normal');
INSERT INTO `fa_category` VALUES (56, 0, 'voice', 'olivia', 'Olivia', '', '', '', '', '', 1689389983, 1689389983, 56, 'normal');
INSERT INTO `fa_category` VALUES (57, 0, 'voice', 'shanshan', '姗姗', '', '', '', '', '', 1689389990, 1689389990, 57, 'normal');
INSERT INTO `fa_category` VALUES (58, 0, 'voice', 'chuangirl', '小玥', '', '', '', '', '', 1689389997, 1689389997, 58, 'normal');
INSERT INTO `fa_category` VALUES (59, 0, 'voice', 'lydia', 'Lydia', '', '', '', '', '', 1689390003, 1689390003, 59, 'normal');
INSERT INTO `fa_category` VALUES (60, 0, 'voice', 'aishuo', '艾硕', '', '', '', '', '', 1689390010, 1689390010, 60, 'normal');
INSERT INTO `fa_category` VALUES (61, 0, 'voice', 'qingqing', '青青', '', '', '', '', '', 1689390017, 1689390017, 61, 'normal');
INSERT INTO `fa_category` VALUES (62, 0, 'voice', 'cuijie', '翠姐', '', '', '', '', '', 1689390025, 1689390025, 62, 'normal');
INSERT INTO `fa_category` VALUES (63, 0, 'voice', 'xiaoze', '小泽', '', '', '', '', '', 1689390030, 1689390030, 63, 'normal');
INSERT INTO `fa_category` VALUES (64, 0, 'voice', 'tomoka', '智香', '', '', '', '', '', 1689390037, 1689390037, 64, 'normal');
INSERT INTO `fa_category` VALUES (65, 0, 'voice', 'tomoya', '智也', '', '', '', '', '', 1689390043, 1689390043, 65, 'normal');
INSERT INTO `fa_category` VALUES (66, 0, 'voice', 'annie', 'Annie', '', '', '', '', '', 1689390051, 1689390051, 66, 'normal');
INSERT INTO `fa_category` VALUES (67, 0, 'voice', 'jiajia', '佳佳', '', '', '', '', '', 1689390064, 1689390064, 67, 'normal');
INSERT INTO `fa_category` VALUES (68, 0, 'voice', 'indah', 'Indah', '', '', '', '', '', 1689390070, 1689390070, 68, 'normal');
INSERT INTO `fa_category` VALUES (69, 0, 'voice', 'taozi', '桃子', '', '', '', '', '', 1689390076, 1689390076, 69, 'normal');
INSERT INTO `fa_category` VALUES (70, 0, 'voice', 'guijie', '柜姐', '', '', '', '', '', 1689390083, 1689390083, 70, 'normal');
INSERT INTO `fa_category` VALUES (71, 0, 'voice', 'stella', 'Stella', '', '', '', '', '', 1689390090, 1689390090, 71, 'normal');
INSERT INTO `fa_category` VALUES (72, 0, 'voice', 'stanley', 'Stanley', '', '', '', '', '', 1689390096, 1689390096, 72, 'normal');
INSERT INTO `fa_category` VALUES (73, 0, 'voice', 'kenny', 'Kenny', '', '', '', '', '', 1689390102, 1689390102, 73, 'normal');
INSERT INTO `fa_category` VALUES (74, 0, 'voice', 'rosa', 'Rosa', '', '', '', '', '', 1689390109, 1689390109, 74, 'normal');
INSERT INTO `fa_category` VALUES (75, 0, 'voice', 'farah', 'Farah', '', '', '', '', '', 1689390116, 1689390116, 75, 'normal');
INSERT INTO `fa_category` VALUES (76, 0, 'voice', 'mashu', '马树', '', '', '', '', '', 1689390167, 1689390167, 76, 'normal');
INSERT INTO `fa_category` VALUES (77, 0, 'voice', 'xiaoxian', '小仙', '', '', '', '', '', 1689390173, 1689390173, 77, 'normal');
INSERT INTO `fa_category` VALUES (78, 0, 'voice', 'yuer', '悦儿', '', '', '', '', '', 1689390179, 1689390179, 78, 'normal');
INSERT INTO `fa_category` VALUES (79, 0, 'voice', 'maoxiaomei', '猫小美', '', '', '', '', '', 1689390186, 1689390186, 79, 'normal');
INSERT INTO `fa_category` VALUES (80, 0, 'voice', 'aifei', '艾飞', '', '', '', '', '', 1689390192, 1689390192, 80, 'normal');
INSERT INTO `fa_category` VALUES (81, 0, 'voice', 'yaqun', '亚群', '', '', '', '', '', 1689390199, 1689390199, 81, 'normal');
INSERT INTO `fa_category` VALUES (82, 0, 'voice', 'qiaowei', '巧薇', '', '', '', '', '', 1689390207, 1689390207, 82, 'normal');
INSERT INTO `fa_category` VALUES (83, 0, 'voice', 'dahu', '大虎', '', '', '', '', '', 1689390216, 1689390216, 83, 'normal');
INSERT INTO `fa_category` VALUES (84, 0, 'voice', 'ava', 'ava', '', '', '', '', '', 1689390222, 1689390222, 84, 'normal');
INSERT INTO `fa_category` VALUES (85, 0, 'voice', 'ailun', '艾伦', '', '', '', '', '', 1689390228, 1689390228, 85, 'normal');
INSERT INTO `fa_category` VALUES (86, 0, 'voice', 'jielidou', '杰力豆', '', '', '', '', '', 1689390234, 1689390234, 86, 'normal');
INSERT INTO `fa_category` VALUES (87, 0, 'voice', 'laotie', '老铁', '', '', '', '', '', 1689390241, 1689390241, 87, 'normal');
INSERT INTO `fa_category` VALUES (88, 0, 'voice', 'laomei', '老妹', '', '', '', '', '', 1689390247, 1689390247, 88, 'normal');
INSERT INTO `fa_category` VALUES (89, 0, 'voice', 'aikan', '艾侃', '', '', '', '', '', 1689390253, 1689390253, 89, 'normal');
INSERT INTO `fa_category` VALUES (90, 0, 'voice', 'tala', 'Tala', '', '', '', '', '', 1689390259, 1689390259, 90, 'normal');
INSERT INTO `fa_category` VALUES (91, 0, 'voice', 'tien', 'Tien', '', '', '', '', '', 1689390266, 1689390266, 91, 'normal');
INSERT INTO `fa_category` VALUES (92, 0, 'voice', 'becca', 'Becca', '', '', '', '', '', 1689390274, 1689390274, 92, 'normal');
INSERT INTO `fa_category` VALUES (93, 0, 'voice', 'Kyong', 'Kyong', '', '', '', '', '', 1689390281, 1689390281, 93, 'normal');
INSERT INTO `fa_category` VALUES (94, 0, 'voice', 'masha', 'masha', '', '', '', '', '', 1689390288, 1689390288, 94, 'normal');
INSERT INTO `fa_category` VALUES (95, 0, 'voice', 'camila', 'camila', '', '', '', '', '', 1689390292, 1689390292, 95, 'normal');
INSERT INTO `fa_category` VALUES (96, 0, 'voice', 'perla', 'perla', '', '', '', '', '', 1689390297, 1689390297, 96, 'normal');
INSERT INTO `fa_category` VALUES (97, 0, 'voice', 'zhimao', '知猫', '', '', '', '', '', 1689390307, 1689390307, 97, 'normal');
INSERT INTO `fa_category` VALUES (98, 0, 'voice', 'zhiyuan', '知媛', '', '', '', '', '', 1689390314, 1689390314, 98, 'normal');
INSERT INTO `fa_category` VALUES (99, 0, 'voice', 'zhigui', '知柜', '', '', '', '', '', 1689390322, 1689390322, 99, 'normal');
INSERT INTO `fa_category` VALUES (100, 0, 'voice', 'zhiya', '知雅', '', '', '', '', '', 1689390328, 1689390328, 100, 'normal');
INSERT INTO `fa_category` VALUES (101, 0, 'voice', 'zhiyue', '知悦', '', '', '', '', '', 1689390335, 1689390335, 101, 'normal');
INSERT INTO `fa_category` VALUES (102, 0, 'voice', 'zhishuo', '知硕', '', '', '', '', '', 1689390342, 1689390342, 102, 'normal');
INSERT INTO `fa_category` VALUES (103, 0, 'voice', 'zhida', '知达', '', '', '', '', '', 1689390348, 1689390348, 103, 'normal');
INSERT INTO `fa_category` VALUES (104, 0, 'voice', 'zhistella', '知莎', '', '', '', '', '', 1689390355, 1689390355, 104, 'normal');
INSERT INTO `fa_category` VALUES (105, 0, 'voice', 'kelly', 'Kelly', '', '', '', '', '', 1689390363, 1689390363, 105, 'normal');
INSERT INTO `fa_category` VALUES (106, 14, 'voice', 'serious', '严肃', '', '', '', '', '', 1689390534, 1689390607, 106, 'normal');
INSERT INTO `fa_category` VALUES (107, 14, 'voice', 'sad', '悲伤', '', '', '', '', '', 1689390631, 1689390631, 107, 'normal');
INSERT INTO `fa_category` VALUES (108, 14, 'voice', 'disgust', '厌恶', '', '', '', '', '', 1689390693, 1689390693, 108, 'normal');
INSERT INTO `fa_category` VALUES (109, 14, 'voice', 'jealousy', '嫉妒', '', '', '', '', '', 1689390723, 1689390723, 109, 'normal');
INSERT INTO `fa_category` VALUES (110, 14, 'voice', 'embarrassed', '尴尬', '', '', '', '', '', 1689390747, 1689390747, 110, 'normal');
INSERT INTO `fa_category` VALUES (111, 14, 'voice', 'happy', '开心', '', '', '', '', '', 1689390765, 1689390765, 111, 'normal');
INSERT INTO `fa_category` VALUES (112, 14, 'voice', 'fear', '害怕', '', '', '', '', '', 1689390781, 1689390781, 112, 'normal');
INSERT INTO `fa_category` VALUES (113, 14, 'voice', 'surprise', '惊讶', '', '', '', '', '', 1689390809, 1689390809, 113, 'normal');
INSERT INTO `fa_category` VALUES (114, 14, 'voice', 'neutral', '中性', '', '', '', '', '', 1689390824, 1689390824, 114, 'normal');
INSERT INTO `fa_category` VALUES (115, 14, 'voice', 'frustrated', '沮丧', '', '', '', '', '', 1689390842, 1689390842, 115, 'normal');
INSERT INTO `fa_category` VALUES (116, 14, 'voice', 'affectionate', '深情', '', '', '', '', '', 1689390860, 1689390860, 116, 'normal');
INSERT INTO `fa_category` VALUES (117, 14, 'voice', 'gentle', '温柔', '', '', '', '', '', 1689390884, 1689390884, 117, 'normal');
INSERT INTO `fa_category` VALUES (118, 14, 'voice', 'angry', '生气', '', '', '', '', '', 1689390898, 1689390907, 118, 'normal');
INSERT INTO `fa_category` VALUES (119, 14, 'voice', 'newscast', '播报', '', '', '', '', '', 1689390926, 1689390926, 119, 'normal');
INSERT INTO `fa_category` VALUES (120, 14, 'voice', 'customer-service', '客服', '', '', '', '', '', 1689390942, 1689390942, 120, 'normal');
INSERT INTO `fa_category` VALUES (121, 14, 'voice', 'story', '小说', '', '', '', '', '', 1689390959, 1689390959, 121, 'normal');
INSERT INTO `fa_category` VALUES (122, 14, 'voice', 'living', '直播', '', '', '', '', '', 1689390974, 1689390974, 122, 'normal');
INSERT INTO `fa_category` VALUES (123, 15, 'voice', 'angry', '生气', '', '', '', '', '', 1689390995, 1689390995, 123, 'normal');
INSERT INTO `fa_category` VALUES (124, 15, 'voice', 'fear', '害怕', '', '', '', '', '', 1689391011, 1689391011, 124, 'normal');
INSERT INTO `fa_category` VALUES (125, 15, 'voice', 'happy', '开心', '', '', '', '', '', 1689391028, 1689391028, 125, 'normal');
INSERT INTO `fa_category` VALUES (126, 15, 'voice', 'hate', '憎恨', '', '', '', '', '', 1689391042, 1689391042, 126, 'normal');
INSERT INTO `fa_category` VALUES (127, 15, 'voice', 'neutral', '中性', '', '', '', '', '', 1689391059, 1689391059, 127, 'normal');
INSERT INTO `fa_category` VALUES (128, 15, 'voice', 'sad', '悲伤', '', '', '', '', '', 1689391075, 1689391075, 128, 'normal');
INSERT INTO `fa_category` VALUES (129, 15, 'voice', 'surprise', '惊讶', '', '', '', '', '', 1689391095, 1689391095, 129, 'normal');
INSERT INTO `fa_category` VALUES (130, 16, 'voice', 'neutral', '中性', '', '', '', '', '', 1689391147, 1689391147, 130, 'normal');
INSERT INTO `fa_category` VALUES (131, 16, 'voice', 'happy', '开心', '', '', '', '', '', 1689391161, 1689391161, 131, 'normal');
INSERT INTO `fa_category` VALUES (132, 16, 'voice', 'angry', '生气', '', '', '', '', '', 1689391173, 1689391173, 132, 'normal');
INSERT INTO `fa_category` VALUES (133, 16, 'voice', 'sad', '悲伤', '', '', '', '', '', 1689391189, 1689391189, 133, 'normal');
INSERT INTO `fa_category` VALUES (134, 16, 'voice', 'fear', '害怕', '', '', '', '', '', 1689391204, 1689391204, 134, 'normal');
INSERT INTO `fa_category` VALUES (135, 16, 'voice', 'fear', '害怕', '', '', '', '', '', 1689391218, 1689391218, 135, 'normal');
INSERT INTO `fa_category` VALUES (136, 16, 'voice', 'hate', '憎恨', '', '', '', '', '', 1689391235, 1689391235, 136, 'normal');
INSERT INTO `fa_category` VALUES (137, 16, 'voice', 'surprise', '惊讶', '', '', '', '', '', 1689391250, 1689391250, 137, 'normal');
INSERT INTO `fa_category` VALUES (138, 16, 'voice', 'arousal', '激动', '', '', '', '', '', 1689391268, 1689391268, 138, 'normal');
INSERT INTO `fa_category` VALUES (139, 17, 'voice', 'neutral', '中性', '', '', '', '', '', 1689391287, 1689391287, 139, 'normal');
INSERT INTO `fa_category` VALUES (140, 17, 'voice', 'happy', '开心', '', '', '', '', '', 1689391299, 1689391299, 140, 'normal');
INSERT INTO `fa_category` VALUES (141, 17, 'voice', 'angry', '生气', '', '', '', '', '', 1689391314, 1689391314, 141, 'normal');
INSERT INTO `fa_category` VALUES (142, 17, 'voice', 'sad', '悲伤', '', '', '', '', '', 1689391330, 1689391330, 142, 'normal');
INSERT INTO `fa_category` VALUES (143, 17, 'voice', 'fear', '害怕', '', '', '', '', '', 1689391347, 1689391347, 143, 'normal');
INSERT INTO `fa_category` VALUES (144, 17, 'voice', 'hate', '憎恨', '', '', '', '', '', 1689391360, 1689391360, 144, 'normal');
INSERT INTO `fa_category` VALUES (145, 17, 'voice', 'surprise', '惊讶', '', '', '', '', '', 1689391382, 1689391382, 145, 'normal');
INSERT INTO `fa_category` VALUES (146, 18, 'voice', 'neutral', '中性', '', '', '', '', '', 1689391413, 1689391413, 146, 'normal');
INSERT INTO `fa_category` VALUES (147, 18, 'voice', 'happy', '开心', '', '', '', '', '', 1689391429, 1689391429, 147, 'normal');
INSERT INTO `fa_category` VALUES (148, 18, 'voice', 'angry', '生气', '', '', '', '', '', 1689391442, 1689391442, 148, 'normal');
INSERT INTO `fa_category` VALUES (149, 18, 'voice', 'sad', '悲伤', '', '', '', '', '', 1689391453, 1689391453, 149, 'normal');
INSERT INTO `fa_category` VALUES (150, 18, 'voice', 'fear', '害怕', '', '', '', '', '', 1689391465, 1689391465, 150, 'normal');
INSERT INTO `fa_category` VALUES (151, 18, 'voice', 'hate', '憎恨', '', '', '', '', '', 1689391475, 1689391475, 151, 'normal');
INSERT INTO `fa_category` VALUES (152, 18, 'voice', 'surprise', '惊讶', '', '', '', '', '', 1689391487, 1689391487, 152, 'normal');

-- ----------------------------
-- Table structure for fa_command
-- ----------------------------
DROP TABLE IF EXISTS `fa_command`;
CREATE TABLE `fa_command`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `params` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数',
  `command` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '命令',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回结果',
  `executetime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '执行时间',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('successed','failured') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'failured' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线命令表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_command
-- ----------------------------

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '可见条件',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_config
-- ----------------------------
INSERT INTO `fa_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '', '七码小说推文系统Q群736647538', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '', '1.0.1', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', '', 'Asia/Shanghai', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请输入左侧菜单栏存在的链接', 'string', '', 'dashboard', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '', '{\"default\":\"默认\",\"voice\":\"发音人\"}', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '', '{\"basic\":\"基础配置\",\"email\":\"邮件配置\",\"dictionary\":\"字典配置\",\"user\":\"会员配置\",\"api\":\"API配置\",\"draft\":\"草稿配置\",\"prompt\":\"提示词配置\",\"task\":\"任务配置\"}', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `fa_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', '', 'smtp.qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '', '465', '', '', '', '');
INSERT INTO `fa_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '', '10000', '', '', '', '');
INSERT INTO `fa_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'string', '', 'password', '', '', '', '');
INSERT INTO `fa_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `fa_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '', '10000@qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '', '{\"category1\":\"分类一\",\"category2\":\"分类二\",\"custom\":\"自定义\"}', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (19, 'openai_api_key', 'api', 'Openai_Api_Key', 'ChatGpt的Key', 'string', '', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (20, 'access_key_id', 'api', 'AccessKeyId', '阿里云语音https://www.phpwc.com/archives/8372', 'string', '', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (21, 'access_key_secret', 'api', 'AccessKeySecret', '阿里云语音https://www.phpwc.com/archives/8372', 'string', '', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (24, 'draft_removable_storage_device', 'draft', '盘符', '', 'string', '', 'D:', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (25, 'draft_root_path', 'draft', '路径', '注意要在后边加上一个“/”', 'string', '', 'D:/JianyingPro Drafts/', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (26, 'draft_meta_info', 'draft', 'draft_meta_info', '', 'text', '', '{\r\n  \"draft_cloud_capcut_purchase_info\": \"\",\r\n  \"draft_cloud_last_action_download\": false,\r\n  \"draft_cloud_purchase_info\": \"\",\r\n  \"draft_cloud_template_id\": \"\",\r\n  \"draft_cloud_tutorial_info\": \"\",\r\n  \"draft_cloud_videocut_purchase_info\": \"\",\r\n  \"draft_cover\": \"\",\r\n  \"draft_deeplink_url\": \"\",\r\n  \"draft_enterprise_info\": {\r\n    \"draft_enterprise_extra\": \"\",\r\n    \"draft_enterprise_id\": \"\",\r\n    \"draft_enterprise_name\": \"\"\r\n  },\r\n  \"draft_fold_path\": \"\",\r\n  \"draft_id\": \"\",\r\n  \"draft_is_article_video_draft\": false,\r\n  \"draft_is_from_deeplink\": \"false\",\r\n  \"draft_materials\": [\r\n    { \"type\": 0, \"value\": [] },\r\n    { \"type\": 1, \"value\": [] },\r\n    { \"type\": 2, \"value\": [] },\r\n    { \"type\": 3, \"value\": [] },\r\n    { \"type\": 6, \"value\": [] },\r\n    { \"type\": 7, \"value\": [] },\r\n    { \"type\": 8, \"value\": [] }\r\n  ],\r\n  \"draft_materials_copied_info\": [],\r\n  \"draft_name\": \"\",\r\n  \"draft_new_version\": \"\",\r\n  \"draft_removable_storage_device\": \"\",\r\n  \"draft_root_path\": \"\",\r\n  \"draft_segment_extra_info\": [],\r\n  \"draft_timeline_materials_size_\": 0,\r\n  \"tm_draft_cloud_completed\": \"\",\r\n  \"tm_draft_cloud_modified\": 0,\r\n  \"tm_draft_create\": 0,\r\n  \"tm_draft_modified\": 0,\r\n  \"tm_duration\": 0\r\n}', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (27, 'draft_content', 'draft', 'draft_content', '', 'text', '', '{\r\n    \"canvas_config\": {\r\n        \"height\": 1920,\r\n        \"ratio\": \"original\",\r\n        \"width\": 1920\r\n    },\r\n    \"color_space\": 0,\r\n    \"config\": {\r\n        \"adjust_max_index\": 1,\r\n        \"attachment_info\": [],\r\n        \"combination_max_index\": 1,\r\n        \"export_range\": null,\r\n        \"extract_audio_last_index\": 1,\r\n        \"lyrics_recognition_id\": \"\",\r\n        \"lyrics_sync\": true,\r\n        \"lyrics_taskinfo\": [],\r\n        \"maintrack_adsorb\": true,\r\n        \"material_save_mode\": 0,\r\n        \"original_sound_last_index\": 1,\r\n        \"record_audio_last_index\": 1,\r\n        \"sticker_max_index\": 1,\r\n        \"subtitle_recognition_id\": \"\",\r\n        \"subtitle_sync\": true,\r\n        \"subtitle_taskinfo\": [],\r\n        \"system_font_list\": [],\r\n        \"video_mute\": false,\r\n        \"zoom_info_params\": null\r\n    },\r\n    \"cover\": null,\r\n    \"create_time\": 0,\r\n    \"duration\": 0,\r\n    \"extra_info\": null,\r\n    \"fps\": 30.0,\r\n    \"free_render_index_mode_on\": false,\r\n    \"group_container\": null,\r\n    \"id\": \"2AA5CCA4-83BF-46aa-B0CE-DC019CFD52FC\",\r\n    \"keyframe_graph_list\": [],\r\n    \"keyframes\": {\r\n        \"adjusts\": [],\r\n        \"audios\": [],\r\n        \"effects\": [],\r\n        \"filters\": [],\r\n        \"handwrites\": [],\r\n        \"stickers\": [],\r\n        \"texts\": [],\r\n        \"videos\": []\r\n    },\r\n    \"last_modified_platform\": {\r\n        \"app_id\": 3704,\r\n        \"app_source\": \"lv\",\r\n        \"app_version\": \"4.3.1\",\r\n        \"device_id\": \"b045139fe2412ca7399978cc929ea773\",\r\n        \"hard_disk_id\": \"a029880b76c8bfc839361046db4cf262\",\r\n        \"mac_address\": \"70e497d276a268e7e4235809962cccf0,d9aed9fab7102f4f36bd91f70f9b043e,10d2717e7d06a80d409fbb21516ebec0\",\r\n        \"os\": \"windows\",\r\n        \"os_version\": \"10.0.19045\"\r\n    },\r\n    \"materials\": {\r\n        \"audio_balances\": [],\r\n        \"audio_effects\": [],\r\n        \"audio_fades\": [],\r\n        \"audios\": [],\r\n        \"beats\": [],\r\n        \"canvases\": [],\r\n        \"chromas\": [],\r\n        \"color_curves\": [],\r\n        \"drafts\": [],\r\n        \"effects\": [],\r\n        \"green_screens\": [],\r\n        \"handwrites\": [],\r\n        \"hsl\": [],\r\n        \"images\": [],\r\n        \"log_color_wheels\": [],\r\n        \"manual_deformations\": [],\r\n        \"masks\": [],\r\n        \"material_animations\": [],\r\n        \"material_colors\": [],\r\n        \"placeholders\": [],\r\n        \"plugin_effects\": [],\r\n        \"primary_color_wheels\": [],\r\n        \"realtime_denoises\": [],\r\n        \"sound_channel_mappings\": [],\r\n        \"speeds\": [],\r\n        \"stickers\": [],\r\n        \"tail_leaders\": [],\r\n        \"text_templates\": [],\r\n        \"texts\": [],\r\n        \"transitions\": [],\r\n        \"video_effects\": [],\r\n        \"video_trackings\": [],\r\n        \"videos\": []\r\n    },\r\n    \"mutable_config\": null,\r\n    \"name\": \"\",\r\n    \"new_version\": \"77.0.0\",\r\n    \"platform\": {\r\n        \"app_id\": 3704,\r\n        \"app_source\": \"lv\",\r\n        \"app_version\": \"4.3.1\",\r\n        \"device_id\": \"b045139fe2412ca7399978cc929ea773\",\r\n        \"hard_disk_id\": \"a029880b76c8bfc839361046db4cf262\",\r\n        \"mac_address\": \"70e497d276a268e7e4235809962cccf0,d9aed9fab7102f4f36bd91f70f9b043e,10d2717e7d06a80d409fbb21516ebec0\",\r\n        \"os\": \"windows\",\r\n        \"os_version\": \"10.0.19045\"\r\n    },\r\n    \"relationships\": [],\r\n    \"render_index_track_mode_on\": false,\r\n    \"retouch_cover\": null,\r\n    \"source\": \"default\",\r\n    \"static_cover_image_path\": \"\",\r\n    \"tracks\": [],\r\n    \"update_time\": 0,\r\n    \"version\": 360000\r\n}', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (28, 'default_positive_prompt', 'prompt', '正向提示词', '正向提示词全局模板', 'text', '', '(masterpiece, best quality)', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (30, 'default_negative_prompt', 'prompt', '反向提示词', '反向提示词全局模板', 'text', '', 'NSFW, (worst quality:2), (low quality:2), (normal quality:2), lowres, normal quality, ((monochrome)), ((grayscale)), skin spots, acnes, skin blemishes, age spot, (ugly:1.331), (duplicate:1.331), (morbid:1.21), (mutilated:1.21), (tranny:1.331), mutated hands, (poorly drawn hands:1.5), blurry, (bad anatomy:1.21), (bad proportions:1.331), extra limbs, (disfigured:1.331), (missing arms:1.331), (extra legs:1.331), (fused fingers:1.61051), (too many fingers:1.61051), (unclear eyes:1.331), lowers, bad hands, missing fingers, extra digit,bad hands, missing fingers, (((extra arms and legs))),nsfw', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (31, 'appkey', 'api', 'appkey', '阿里云语音https://www.phpwc.com/archives/8372', 'string', '', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (32, 'stable_diffusion_url', 'api', 'Sd_Url', '填写Stable Diffusion的API域名即可，注意不要添加“/”<br>推荐使用https://www.autodl.com', 'string', '', 'http://192.168.1.7:7860', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (33, 'gpt_url', 'api', 'Gpt_Url', '这里添加GPT的API地址，注意要添加完整', 'string', '', 'https://api.openai.com/v1/chat/completions', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (34, 'is_windows', 'task', 'Windows', '', 'switch', '', '1', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (35, 'audio_time', 'task', '配音延时', '', 'number', '', '10', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (36, 'prompt_time', 'task', '提示词延时', '', 'number', '', '20', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (37, 'txt2img_time', 'task', '绘图延时', '', 'number', '', '60', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (38, 'draft_time', 'task', '草稿延时', '', 'number', '', '2', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (40, 'qima_key', 'api', '七码Key', '如果提示词模式选择七码则再这里填写七码的Key<br>获取方式：QQ群736647538', 'string', '', '', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
DROP TABLE IF EXISTS `fa_ems`;
CREATE TABLE `fa_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '邮箱验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_ems
-- ----------------------------

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
DROP TABLE IF EXISTS `fa_sms`;
CREATE TABLE `fa_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_sms
-- ----------------------------

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
DROP TABLE IF EXISTS `fa_test`;
CREATE TABLE `fa_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT 0 COMMENT '会员ID',
  `admin_id` int(10) NULL DEFAULT 0 COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '省市',
  `json` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '价格',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '点击',
  `workrange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '时间区间',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint(16) NULL DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '测试表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_test
-- ----------------------------
INSERT INTO `fa_test` VALUES (1, 1, 1, 12, '12,13', '互联网,计算机', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '我是一篇测试文章描述，内容过多时将自动隐藏', '广西壮族自治区/百色市/平果县', '{\"a\":\"1\",\"b\":\"2\"}', '[{\"title\":\"标题一\",\"intro\":\"介绍一\",\"author\":\"小明\",\"age\":\"21\"}]', 0.00, 0, '2020-10-01 00:00:00 - 2021-10-31 23:59:59', '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1491635035, 1491635035, 1491635035, NULL, 0, 1, 'normal', '1');

-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_user`;
CREATE TABLE `fa_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '组别ID',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '格言',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '积分',
  `successions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '连续登录天数',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` bigint(16) NULL DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `joinip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) NULL DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user
-- ----------------------------
INSERT INTO `fa_user` VALUES (1, 1, 'admin', 'admin', '4610c05d1eac3b82e33b970e2f673d88', '34f68d', 'admin@163.com', '13888888888', 'http://localhost/assets/img/avatar.png', 0, 0, '2017-04-08', '', 0.00, 0, 1, 1, 1491635035, 1491635035, '127.0.0.1', 0, '127.0.0.1', 1491635035, 0, 1491635035, '', 'normal', '');

-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_group`;
CREATE TABLE `fa_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '权限节点',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
INSERT INTO `fa_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_money_log`;
CREATE TABLE `fa_user_money_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更余额',
  `before` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更前余额',
  `after` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员余额变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_rule`;
CREATE TABLE `fa_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
INSERT INTO `fa_user_rule` VALUES (1, 0, 'index', 'Frontend', '', 1, 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_user_rule` VALUES (2, 0, 'api', 'API Interface', '', 1, 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_user_rule` VALUES (3, 1, 'user', 'User Module', '', 1, 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_user_rule` VALUES (4, 2, 'user', 'User Module', '', 1, 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_user_rule` VALUES (5, 3, 'index/user/login', 'Login', '', 0, 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_user_rule` VALUES (6, 3, 'index/user/register', 'Register', '', 0, 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_user_rule` VALUES (7, 3, 'index/user/index', 'User Center', '', 0, 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_user_rule` VALUES (8, 3, 'index/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_user_rule` VALUES (9, 4, 'api/user/login', 'Login', '', 0, 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_user_rule` VALUES (10, 4, 'api/user/register', 'Register', '', 0, 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_user_rule` VALUES (11, 4, 'api/user/index', 'User Center', '', 0, 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_user_rule` VALUES (12, 4, 'api/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 3, 'normal');

-- ----------------------------
-- Table structure for fa_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_score_log`;
CREATE TABLE `fa_user_score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员积分变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_token`;
CREATE TABLE `fa_user_token`  (
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员Token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
DROP TABLE IF EXISTS `fa_version`;
CREATE TABLE `fa_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_version
-- ----------------------------

-- ----------------------------
-- Table structure for fa_video_item
-- ----------------------------
DROP TABLE IF EXISTS `fa_video_item`;
CREATE TABLE `fa_video_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NULL DEFAULT NULL COMMENT '任务ID',
  `fragment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '片段',
  `translation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '译文',
  `positive_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '正向提示词',
  `negative_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '反向提示词',
  `images` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配图列表',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配图',
  `audiofile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配音',
  `videofile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频',
  `weigh` int(11) NULL DEFAULT NULL COMMENT '权重',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  `step` enum('0','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态:0=待执行,1=关键词,2=配图,3=配音',
  `draw_status` int(11) NULL DEFAULT 0 COMMENT '绘图状态:0=待执行,1=执行中,2=已完成',
  `lorajson` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'LORA配置',
  `stylestags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '风格模型',
  `batch_size` int(11) NULL DEFAULT 1 COMMENT '生成数量',
  `steps` int(255) NULL DEFAULT 20 COMMENT '步数',
  `width` int(11) NULL DEFAULT 512 COMMENT '图像宽度',
  `height` int(11) NULL DEFAULT 512 COMMENT '图像高度',
  `restore_faces_switch` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否修复面部',
  `video_animation` enum('0','1','2','3','-1','-2') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '-1' COMMENT '视频动画:-2=无,-1=随机,0=从上往下,1=从下往上,2=从左往右,3=从右往左',
  `video_speed` int(11) NULL DEFAULT 10 COMMENT '动画速度',
  `video_fps` int(11) NULL DEFAULT 24 COMMENT '视频FPS',
  `audio_voice_id` int(11) NULL DEFAULT NULL COMMENT '发音人',
  `audio_emotion_id` int(11) NULL DEFAULT NULL COMMENT '情感',
  `audio_volume` int(11) NULL DEFAULT 50 COMMENT '音量',
  `audio_speech_rate` int(11) NULL DEFAULT 0 COMMENT '语速',
  `audio_pitch_rate` int(11) NULL DEFAULT 0 COMMENT '语调',
  `audio_duration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时长',
  `prompt_modes` enum('0','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '提示词模式:0=直译,1=分析,2=上下,3=狗屁不通',
  `default_positive_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '正向提示词',
  `default_negative_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '反向提示词',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_video_item
-- ----------------------------

-- ----------------------------
-- Table structure for fa_video_task
-- ----------------------------
DROP TABLE IF EXISTS `fa_video_task`;
CREATE TABLE `fa_video_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modes` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态:0=文字,1=视频',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `translation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '译文',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `default_positive_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '正向提示词',
  `default_negative_prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '反向提示词',
  `prompt_modes` enum('0','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '提示词模式:0=直译,1=分析,2=上文,3=权重',
  `status` enum('0','1','2','3','4') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态:0=初始化,1=片段,2=合成,3=已完成,4=等待中',
  `weigh` int(11) NULL DEFAULT NULL COMMENT '权重',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  `videofile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '视频',
  `draftfile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '草稿',
  `srtfile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '字幕文件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_video_task
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
