/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : galaxy

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 08/02/2023 10:09:47
*/

CREATE DATABASE IF NOT EXISTS galaxy default charset utf8 COLLATE utf8_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`
(
    `id`          bigint(20)                                               NOT NULL COMMENT '主键',
    `name`        varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL DEFAULT '' COMMENT '名称',
    `menu_code`   varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL DEFAULT '' COMMENT '菜单编码',
    `parent_id`   bigint(20)                                               NULL     DEFAULT NULL COMMENT '父节点',
    `node_type`   tinyint(4)                                               NOT NULL DEFAULT 1 COMMENT '节点类型，1文件夹，2页面，3按钮',
    `icon_url`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT '' COMMENT '图标地址',
    `sort`        int(11)                                                  NOT NULL DEFAULT 1 COMMENT '排序号',
    `link_url`    varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT '' COMMENT '页面对应的地址',
    `level`       int(11)                                                  NOT NULL DEFAULT 0 COMMENT '层次',
    `path`        varchar(2500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT '' COMMENT '树id的路径 整个层次上的路径id，逗号分隔，想要找父节点特别快',
    `deleted`     tinyint(4)                                               NULL     DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time` datetime(0)                                              NULL     DEFAULT NULL COMMENT '创新时间',
    `update_time` datetime(0)                                              NULL     DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '菜单表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`
(
    `id`          bigint(20)                                              NOT NULL COMMENT '主键',
    `title`       varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限简称',
    `descr`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限描述',
    `url`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限访问路径',
    `perms`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '进行细细粒度划分时需要的一个标识',
    `parent_id`   int(11)                                                 NULL DEFAULT NULL COMMENT '父级权限ID',
    `type`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限所属类型：菜单控制，按钮控制，页面控制',
    `icon`        varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标地址',
    `deleted`     tinyint(4)                                              NULL DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time` datetime(0)                                             NULL DEFAULT NULL COMMENT '创新时间',
    `update_time` datetime(0)                                             NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '权限表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`
(
    `id`          bigint(20)                                              NOT NULL AUTO_INCREMENT,
    `role_name`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '角色名字',
    `role_desc`   varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
    `role_mark`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色标识',
    `deleted`     tinyint(4)                                              NULL DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time` datetime(0)                                             NULL DEFAULT NULL COMMENT '创新时间',
    `update_time` datetime(0)                                             NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '角色表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`
(
    `id`          bigint(20) UNSIGNED NOT NULL COMMENT '主键',
    `role_id`     bigint(20)          NOT NULL COMMENT '角色ID',
    `menu_id`     bigint(20)          NOT NULL COMMENT '菜单ID',
    `deleted`     tinyint(4)          NULL DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time` datetime(0)         NULL DEFAULT NULL COMMENT '创新时间',
    `update_time` datetime(0)         NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_role_id` (`role_id`) USING BTREE,
    INDEX `idx_menu_id` (`menu_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '角色菜单关系表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`
(
    `id`            bigint(20)  NOT NULL COMMENT '主键',
    `permission_id` bigint(20)  NULL DEFAULT NULL COMMENT '权限id',
    `role_id`       bigint(20)  NULL DEFAULT NULL COMMENT '角色id',
    `deleted`       tinyint(4)  NULL DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time`   datetime(0) NULL DEFAULT NULL COMMENT '创新时间',
    `update_time`   datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '角色权限关系表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id`          bigint(20)                                              NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `username`    varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
    `password`    varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
    `nick_name`   varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '昵称',
    `real_name`   varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '真实姓名',
    `email`       varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '邮箱',
    `mobile`      varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '手机电话',
    `gender`      varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '性别',
    `wechat`      varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '微信号',
    `birthday`    datetime(0)                                             NULL DEFAULT NULL COMMENT '出生日期',
    `avatar`      varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
    `lasted`      datetime(0)                                             NULL DEFAULT NULL COMMENT '最后的登陆时间',
    `deleted`     tinyint(4)                                              NULL DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time` datetime(0)                                             NULL DEFAULT NULL COMMENT '创新时间',
    `update_time` datetime(0)                                             NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '用户表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES (1, 'admin', '123', 'admin', 'admin', '1', '1', '男', '1', '2023-02-07 16:05:46', '111', '2023-02-07 16:05:50',
        0, '2023-02-07 16:05:59', '2023-02-07 16:06:02');
INSERT INTO `user`
VALUES (2, 'admin1', '123', 'admin1', 'admin1', '1', '1', '男', '1', '2023-02-07 16:05:46', '111',
        '2023-02-07 16:05:50', 0, '2023-02-07 16:05:59', '2023-02-07 16:06:02');
INSERT INTO `user`
VALUES (3, 'admin1', '123', 'admin1', 'admin1', '1', '1', '男', '1', '2023-02-07 16:05:46', '111',
        '2023-02-07 16:05:50', 0, '2023-02-07 16:56:06', '2023-02-07 16:56:06');
INSERT INTO `user`
VALUES (4, 'admin1', '123', 'admin1', 'admin1', '1', '1', '男', '1', '2023-02-07 16:05:46', '111',
        '2023-02-07 16:05:50', 0, '2023-02-07 17:06:30', '2023-02-07 17:06:30');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`
(
    `id`          bigint(20)  NOT NULL COMMENT '主键',
    `role_id`     bigint(20)  NULL DEFAULT NULL COMMENT '角色id',
    `user_id`     bigint(20)  NULL DEFAULT NULL COMMENT '用户id',
    `deleted`     tinyint(4)  NULL DEFAULT 0 COMMENT '是否删除 1：已删除；0：未删除',
    `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创新时间',
    `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '用户角色关系表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
