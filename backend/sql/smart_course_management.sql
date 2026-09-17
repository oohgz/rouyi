/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : smart_course_management

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 31/10/2025 23:29:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'tb_student', '学生信息表', NULL, NULL, 'Student', 'crud', 'element-plus', 'com.ruoyi.manage', 'manage', 'student', '学生信息（学生个人信息）', 'hgz', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:27', NULL);
INSERT INTO `gen_table` VALUES (2, 'tb_student_selection', '学生选课表', NULL, NULL, 'StudentSelection', 'crud', 'element-plus', 'com.ruoyi.manage', 'manage', 'selection', '学生选课', 'hgz', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:50', NULL);
INSERT INTO `gen_table` VALUES (3, 'tb_teacher', '教师信息表', NULL, NULL, 'Teacher', 'crud', 'element-plus', 'com.ruoyi.manage', 'manage', 'teacher', '教师信息', 'hgz', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:19:25', NULL);
INSERT INTO `gen_table` VALUES (4, 'tb_course', '课程信息表', NULL, NULL, 'Course', 'crud', 'element-plus', 'com.ruoyi.manage', 'manage', 'course', '课程信息', 'hgz', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22', NULL);
INSERT INTO `gen_table` VALUES (5, 'tb_score', '学生成绩表', NULL, NULL, 'Score', 'crud', 'element-plus', 'com.ruoyi.manage', 'manage', 'score', '学生成绩', 'hgz', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:24', NULL);
INSERT INTO `gen_table` VALUES (6, 'tb_selection_exception', '选课异常记录表', NULL, NULL, 'SelectionException', 'crud', 'element-plus', 'com.ruoyi.manage', 'manage', 'exception', '选课异常记录', 'hgz', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:59', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '学生ID（主键）', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:27');
INSERT INTO `gen_table_column` VALUES (2, 1, 'student_no', '学号（如S2023001）', 'varchar(20)', 'String', 'studentNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:27');
INSERT INTO `gen_table_column` VALUES (3, 1, 'student_name', '学生姓名', 'varchar(20)', 'String', 'studentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:27');
INSERT INTO `gen_table_column` VALUES (4, 2, 'id', '选课ID（主键）', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:50');
INSERT INTO `gen_table_column` VALUES (5, 2, 'course_id', '课程ID（关联tb_course.id）', 'bigint', 'Long', 'courseId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:50');
INSERT INTO `gen_table_column` VALUES (6, 2, 'student_id', '学生ID（关联tb_student.id）', 'bigint', 'Long', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:50');
INSERT INTO `gen_table_column` VALUES (7, 2, 'status', '状态（0-已选，1-已退）', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:50');
INSERT INTO `gen_table_column` VALUES (8, 2, 'select_time', '选课时间', 'datetime', 'Date', 'selectTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:18:50');
INSERT INTO `gen_table_column` VALUES (9, 3, 'id', '教师ID（主键）', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:19:25');
INSERT INTO `gen_table_column` VALUES (10, 3, 'teacher_no', '教师工号（如T001）', 'varchar(20)', 'String', 'teacherNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:19:25');
INSERT INTO `gen_table_column` VALUES (11, 3, 'teacher_name', '教师姓名', 'varchar(20)', 'String', 'teacherName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:19:25');
INSERT INTO `gen_table_column` VALUES (12, 3, 'title', '职称（如教授/讲师）', 'varchar(30)', 'String', 'title', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-10-22 23:11:35', '', '2025-10-22 23:19:25');
INSERT INTO `gen_table_column` VALUES (13, 4, 'id', '课程ID（主键）', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22');
INSERT INTO `gen_table_column` VALUES (14, 4, 'course_code', '课程编码（如JSJ001）', 'varchar(20)', 'String', 'courseCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22');
INSERT INTO `gen_table_column` VALUES (15, 4, 'course_name', '课程名称', 'varchar(100)', 'String', 'courseName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22');
INSERT INTO `gen_table_column` VALUES (16, 4, 'teacher_id', '授课教师ID（关联tb_teacher.id）', 'bigint', 'Long', 'teacherId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22');
INSERT INTO `gen_table_column` VALUES (17, 4, 'max_students', '最大选课人数', 'int', 'Long', 'maxStudents', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22');
INSERT INTO `gen_table_column` VALUES (18, 4, 'status', '状态（0-正常，1-停用）', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', 'sys_normal_disable', 6, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:16:22');
INSERT INTO `gen_table_column` VALUES (19, 5, 'id', '成绩ID（主键）', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:24');
INSERT INTO `gen_table_column` VALUES (20, 5, 'course_id', '课程ID（关联tb_course.id）', 'bigint', 'Long', 'courseId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:24');
INSERT INTO `gen_table_column` VALUES (21, 5, 'student_id', '学生ID（关联tb_student.id）', 'bigint', 'Long', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:24');
INSERT INTO `gen_table_column` VALUES (22, 5, 'score', '成绩（如85.5，NULL表示未录入）', 'decimal(5,2)', 'BigDecimal', 'score', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:24');
INSERT INTO `gen_table_column` VALUES (23, 5, 'remark', '备注（如缺考/缓考）', 'varchar(50)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:24');
INSERT INTO `gen_table_column` VALUES (24, 6, 'id', '异常ID（主键）', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:59');
INSERT INTO `gen_table_column` VALUES (25, 6, 'course_id', '课程ID（关联tb_course.id）', 'bigint', 'Long', 'courseId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:59');
INSERT INTO `gen_table_column` VALUES (26, 6, 'student_id', '学生ID（关联tb_student.id）', 'bigint', 'Long', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:59');
INSERT INTO `gen_table_column` VALUES (27, 6, 'exception_type', '异常类型（1-重复选课，2-超员选课）', 'tinyint', 'Long', 'exceptionType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:59');
INSERT INTO `gen_table_column` VALUES (28, 6, 'create_time', '记录时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 'admin', '2025-10-22 23:11:42', '', '2025-10-22 23:17:59');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-10-22 23:01:04', 'admin', '2025-10-22 23:07:06', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-10-22 23:01:04', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-10-22 23:01:03', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (101, '选课状态', 'selection_status', '0', 'admin', '2025-10-23 22:21:24', 'admin', '2025-10-23 22:21:40', '字典标签：已选，字典值：0，排序：1\n字典标签：已退，字典值：1，排序：2');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-10-22 23:01:04', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 295 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-22 23:06:50');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 23:06:54');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 10:22:07');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:00:19');
INSERT INTO `sys_logininfor` VALUES (104, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:00:23');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:00:30');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:01:55');
INSERT INTO `sys_logininfor` VALUES (107, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:02:00');
INSERT INTO `sys_logininfor` VALUES (108, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:02:11');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:02:16');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:03:07');
INSERT INTO `sys_logininfor` VALUES (111, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:03:15');
INSERT INTO `sys_logininfor` VALUES (112, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:03:44');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:03:46');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:07:19');
INSERT INTO `sys_logininfor` VALUES (115, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:07:27');
INSERT INTO `sys_logininfor` VALUES (116, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:07:31');
INSERT INTO `sys_logininfor` VALUES (117, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:07:54');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:07:55');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:10:14');
INSERT INTO `sys_logininfor` VALUES (120, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:10:21');
INSERT INTO `sys_logininfor` VALUES (121, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:10:45');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:10:48');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:14:30');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:14:36');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:14:40');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:14:49');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:15:34');
INSERT INTO `sys_logininfor` VALUES (128, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 11:15:37');
INSERT INTO `sys_logininfor` VALUES (129, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:15:43');
INSERT INTO `sys_logininfor` VALUES (130, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 11:15:57');
INSERT INTO `sys_logininfor` VALUES (131, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 11:16:08');
INSERT INTO `sys_logininfor` VALUES (132, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 18:01:18');
INSERT INTO `sys_logininfor` VALUES (133, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 18:02:01');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 18:02:06');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 19:58:19');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 20:05:57');
INSERT INTO `sys_logininfor` VALUES (137, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 20:06:06');
INSERT INTO `sys_logininfor` VALUES (138, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 20:20:01');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 20:20:10');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 21:16:07');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 21:18:31');
INSERT INTO `sys_logininfor` VALUES (142, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 21:18:34');
INSERT INTO `sys_logininfor` VALUES (143, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 21:21:11');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 21:21:16');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 22:56:21');
INSERT INTO `sys_logininfor` VALUES (146, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 22:56:25');
INSERT INTO `sys_logininfor` VALUES (147, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 22:57:43');
INSERT INTO `sys_logininfor` VALUES (148, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 22:57:47');
INSERT INTO `sys_logininfor` VALUES (149, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:08:12');
INSERT INTO `sys_logininfor` VALUES (150, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:08:15');
INSERT INTO `sys_logininfor` VALUES (151, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:10:23');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:10:28');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:21:34');
INSERT INTO `sys_logininfor` VALUES (154, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:21:38');
INSERT INTO `sys_logininfor` VALUES (155, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:24:09');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:24:16');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:24:31');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-23 23:24:35');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:24:41');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:24:56');
INSERT INTO `sys_logininfor` VALUES (161, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:25:06');
INSERT INTO `sys_logininfor` VALUES (162, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:25:17');
INSERT INTO `sys_logininfor` VALUES (163, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:25:25');
INSERT INTO `sys_logininfor` VALUES (164, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:25:38');
INSERT INTO `sys_logininfor` VALUES (165, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:25:42');
INSERT INTO `sys_logininfor` VALUES (166, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:25:44');
INSERT INTO `sys_logininfor` VALUES (167, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:26:00');
INSERT INTO `sys_logininfor` VALUES (168, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 23:26:13');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 23:26:30');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 14:43:24');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:26:23');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:26:33');
INSERT INTO `sys_logininfor` VALUES (173, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:26:36');
INSERT INTO `sys_logininfor` VALUES (174, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:26:53');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:26:57');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:29:16');
INSERT INTO `sys_logininfor` VALUES (177, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:29:19');
INSERT INTO `sys_logininfor` VALUES (178, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:29:35');
INSERT INTO `sys_logininfor` VALUES (179, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:29:38');
INSERT INTO `sys_logininfor` VALUES (180, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:29:47');
INSERT INTO `sys_logininfor` VALUES (181, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:29:51');
INSERT INTO `sys_logininfor` VALUES (182, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:30:28');
INSERT INTO `sys_logininfor` VALUES (183, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:30:33');
INSERT INTO `sys_logininfor` VALUES (184, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:30:45');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:30:49');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:31:43');
INSERT INTO `sys_logininfor` VALUES (187, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:31:46');
INSERT INTO `sys_logininfor` VALUES (188, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:31:54');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:31:58');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:32:02');
INSERT INTO `sys_logininfor` VALUES (191, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-31 16:32:43');
INSERT INTO `sys_logininfor` VALUES (192, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-10-31 16:32:50');
INSERT INTO `sys_logininfor` VALUES (193, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:32:55');
INSERT INTO `sys_logininfor` VALUES (194, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:33:12');
INSERT INTO `sys_logininfor` VALUES (195, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:33:21');
INSERT INTO `sys_logininfor` VALUES (196, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 16:33:35');
INSERT INTO `sys_logininfor` VALUES (197, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 16:33:40');
INSERT INTO `sys_logininfor` VALUES (198, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 17:10:42');
INSERT INTO `sys_logininfor` VALUES (199, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 17:11:12');
INSERT INTO `sys_logininfor` VALUES (200, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 17:11:18');
INSERT INTO `sys_logininfor` VALUES (201, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 17:11:32');
INSERT INTO `sys_logininfor` VALUES (202, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 17:11:35');
INSERT INTO `sys_logininfor` VALUES (203, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 17:13:37');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 17:13:40');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 18:16:54');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 18:37:04');
INSERT INTO `sys_logininfor` VALUES (207, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 18:37:09');
INSERT INTO `sys_logininfor` VALUES (208, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 18:37:15');
INSERT INTO `sys_logininfor` VALUES (209, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 18:37:19');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 18:50:13');
INSERT INTO `sys_logininfor` VALUES (211, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:05:36');
INSERT INTO `sys_logininfor` VALUES (212, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:14:10');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:14:13');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:26:24');
INSERT INTO `sys_logininfor` VALUES (215, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:26:27');
INSERT INTO `sys_logininfor` VALUES (216, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:26:37');
INSERT INTO `sys_logininfor` VALUES (217, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:26:40');
INSERT INTO `sys_logininfor` VALUES (218, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:30:29');
INSERT INTO `sys_logininfor` VALUES (219, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:30:31');
INSERT INTO `sys_logininfor` VALUES (220, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:47:55');
INSERT INTO `sys_logininfor` VALUES (221, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:47:59');
INSERT INTO `sys_logininfor` VALUES (222, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:48:17');
INSERT INTO `sys_logininfor` VALUES (223, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:48:21');
INSERT INTO `sys_logininfor` VALUES (224, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:48:27');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:48:31');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:54:49');
INSERT INTO `sys_logininfor` VALUES (227, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:54:53');
INSERT INTO `sys_logininfor` VALUES (228, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 19:55:05');
INSERT INTO `sys_logininfor` VALUES (229, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 19:55:08');
INSERT INTO `sys_logininfor` VALUES (230, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:04:08');
INSERT INTO `sys_logininfor` VALUES (231, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:04:12');
INSERT INTO `sys_logininfor` VALUES (232, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:06:20');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:06:23');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:07:19');
INSERT INTO `sys_logininfor` VALUES (235, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:07:22');
INSERT INTO `sys_logininfor` VALUES (236, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:07:28');
INSERT INTO `sys_logininfor` VALUES (237, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:07:31');
INSERT INTO `sys_logininfor` VALUES (238, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:11:25');
INSERT INTO `sys_logininfor` VALUES (239, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:11:28');
INSERT INTO `sys_logininfor` VALUES (240, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:11:36');
INSERT INTO `sys_logininfor` VALUES (241, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:11:40');
INSERT INTO `sys_logininfor` VALUES (242, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:11:47');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:11:52');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:12:00');
INSERT INTO `sys_logininfor` VALUES (245, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:12:06');
INSERT INTO `sys_logininfor` VALUES (246, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:12:13');
INSERT INTO `sys_logininfor` VALUES (247, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:12:18');
INSERT INTO `sys_logininfor` VALUES (248, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:13:04');
INSERT INTO `sys_logininfor` VALUES (249, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:13:08');
INSERT INTO `sys_logininfor` VALUES (250, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:14:28');
INSERT INTO `sys_logininfor` VALUES (251, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:14:31');
INSERT INTO `sys_logininfor` VALUES (252, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:14:48');
INSERT INTO `sys_logininfor` VALUES (253, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:14:51');
INSERT INTO `sys_logininfor` VALUES (254, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:16:37');
INSERT INTO `sys_logininfor` VALUES (255, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:16:41');
INSERT INTO `sys_logininfor` VALUES (256, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:19:48');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:19:52');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:21:14');
INSERT INTO `sys_logininfor` VALUES (259, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:21:17');
INSERT INTO `sys_logininfor` VALUES (260, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:26:54');
INSERT INTO `sys_logininfor` VALUES (261, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:26:58');
INSERT INTO `sys_logininfor` VALUES (262, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:27:46');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:27:48');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:28:38');
INSERT INTO `sys_logininfor` VALUES (265, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:28:40');
INSERT INTO `sys_logininfor` VALUES (266, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:33:48');
INSERT INTO `sys_logininfor` VALUES (267, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:33:50');
INSERT INTO `sys_logininfor` VALUES (268, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:35:40');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:35:43');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:41:49');
INSERT INTO `sys_logininfor` VALUES (271, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:41:54');
INSERT INTO `sys_logininfor` VALUES (272, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:42:08');
INSERT INTO `sys_logininfor` VALUES (273, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:42:11');
INSERT INTO `sys_logininfor` VALUES (274, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:42:17');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:42:19');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:42:50');
INSERT INTO `sys_logininfor` VALUES (277, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:42:53');
INSERT INTO `sys_logininfor` VALUES (278, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 20:42:57');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 20:42:59');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 21:03:06');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 21:37:52');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 23:03:21');
INSERT INTO `sys_logininfor` VALUES (283, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:03:25');
INSERT INTO `sys_logininfor` VALUES (284, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 23:05:16');
INSERT INTO `sys_logininfor` VALUES (285, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:05:20');
INSERT INTO `sys_logininfor` VALUES (286, 'student-xh', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 23:06:24');
INSERT INTO `sys_logininfor` VALUES (287, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:06:28');
INSERT INTO `sys_logininfor` VALUES (288, 'student-xm', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 23:06:45');
INSERT INTO `sys_logininfor` VALUES (289, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:06:50');
INSERT INTO `sys_logininfor` VALUES (290, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:24:00');
INSERT INTO `sys_logininfor` VALUES (291, 'teacher-zhang', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 23:25:27');
INSERT INTO `sys_logininfor` VALUES (292, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:25:30');
INSERT INTO `sys_logininfor` VALUES (293, 'teacher-li', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-31 23:25:55');
INSERT INTO `sys_logininfor` VALUES (294, 'manage', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-31 23:25:59');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2037 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-10-22 23:01:04', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-10-22 23:01:04', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-10-22 23:01:04', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-10-22 23:01:04', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-10-22 23:01:04', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-10-22 23:01:04', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-10-22 23:01:04', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-10-22 23:01:04', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-10-22 23:01:04', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-10-22 23:01:04', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-10-22 23:01:04', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-10-22 23:01:04', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-10-22 23:01:04', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-10-22 23:01:04', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-10-22 23:01:04', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-10-22 23:01:04', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-10-22 23:01:04', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-10-22 23:01:04', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-10-22 23:01:04', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-10-22 23:01:04', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-10-22 23:01:04', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-10-22 23:01:04', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-10-22 23:01:04', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-10-22 23:01:04', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '智慧课程管理系统', 0, 0, 'manage', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, '#', 'admin', '2025-10-22 23:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2001, '课程信息', 2000, 1, 'course', 'manage/course/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:course:list', '#', 'admin', '2025-10-22 23:20:16', 'admin', '2025-10-23 11:12:20', '课程信息菜单');
INSERT INTO `sys_menu` VALUES (2002, '课程信息查询', 2001, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:course:query', '#', 'admin', '2025-10-22 23:20:16', 'admin', '2025-10-23 11:12:40', '');
INSERT INTO `sys_menu` VALUES (2003, '课程信息新增', 2001, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:course:add', '#', 'admin', '2025-10-22 23:20:16', 'admin', '2025-10-23 11:12:47', '');
INSERT INTO `sys_menu` VALUES (2004, '课程信息修改', 2001, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:course:edit', '#', 'admin', '2025-10-22 23:20:16', 'admin', '2025-10-23 11:12:55', '');
INSERT INTO `sys_menu` VALUES (2005, '课程信息删除', 2001, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:course:remove', '#', 'admin', '2025-10-22 23:20:16', 'admin', '2025-10-23 11:13:06', '');
INSERT INTO `sys_menu` VALUES (2006, '课程信息导出', 2001, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:course:export', '#', 'admin', '2025-10-22 23:20:16', 'admin', '2025-10-23 11:13:15', '');
INSERT INTO `sys_menu` VALUES (2007, '选课异常记录', 2000, 1, 'exception', 'manage/exception/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:exception:list', '#', 'admin', '2025-10-22 23:20:22', 'admin', '2025-10-23 11:10:06', '选课异常记录菜单');
INSERT INTO `sys_menu` VALUES (2008, '选课异常记录查询', 2007, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:exception:query', '#', 'admin', '2025-10-22 23:20:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '选课异常记录新增', 2007, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:exception:add', '#', 'admin', '2025-10-22 23:20:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '选课异常记录修改', 2007, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:exception:edit', '#', 'admin', '2025-10-22 23:20:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '选课异常记录删除', 2007, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:exception:remove', '#', 'admin', '2025-10-22 23:20:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '选课异常记录导出', 2007, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:exception:export', '#', 'admin', '2025-10-22 23:20:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '学生成绩', 2000, 1, 'score', 'manage/score/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:score:list', '#', 'admin', '2025-10-22 23:20:28', 'admin', '2025-10-23 11:13:33', '学生成绩菜单');
INSERT INTO `sys_menu` VALUES (2014, '学生成绩查询', 2013, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:score:query', '#', 'admin', '2025-10-22 23:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '学生成绩新增', 2013, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:score:add', '#', 'admin', '2025-10-22 23:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '学生成绩修改', 2013, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:score:edit', '#', 'admin', '2025-10-22 23:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '学生成绩删除', 2013, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:score:remove', '#', 'admin', '2025-10-22 23:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '学生成绩导出', 2013, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:score:export', '#', 'admin', '2025-10-22 23:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '学生选课', 2000, 1, 'selection', 'manage/selection/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:selection:list', '#', 'admin', '2025-10-22 23:20:35', 'admin', '2025-10-23 11:13:47', '学生选课菜单');
INSERT INTO `sys_menu` VALUES (2020, '学生选课查询', 2019, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:selection:query', '#', 'admin', '2025-10-22 23:20:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '学生选课新增', 2019, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:selection:add', '#', 'admin', '2025-10-22 23:20:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '学生选课修改', 2019, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:selection:edit', '#', 'admin', '2025-10-22 23:20:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '学生选课删除', 2019, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:selection:remove', '#', 'admin', '2025-10-22 23:20:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '学生选课导出', 2019, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:selection:export', '#', 'admin', '2025-10-22 23:20:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '学生信息', 2000, 1, 'student', 'manage/student/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:student:list', '#', 'admin', '2025-10-22 23:20:41', 'admin', '2025-10-23 11:13:58', '学生信息（学生个人信息）菜单');
INSERT INTO `sys_menu` VALUES (2026, '学生信息（学生个人信息）查询', 2025, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:student:query', '#', 'admin', '2025-10-22 23:20:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '学生信息（学生个人信息）新增', 2025, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:student:add', '#', 'admin', '2025-10-22 23:20:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '学生信息（学生个人信息）修改', 2025, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:student:edit', '#', 'admin', '2025-10-22 23:20:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '学生信息（学生个人信息）删除', 2025, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:student:remove', '#', 'admin', '2025-10-22 23:20:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '学生信息（学生个人信息）导出', 2025, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:student:export', '#', 'admin', '2025-10-22 23:20:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '教师信息', 2000, 1, 'teacher', 'manage/teacher/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:teacher:list', '#', 'admin', '2025-10-22 23:20:46', 'admin', '2025-10-23 11:14:11', '教师信息菜单');
INSERT INTO `sys_menu` VALUES (2032, '教师信息查询', 2031, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:teacher:query', '#', 'admin', '2025-10-22 23:20:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '教师信息新增', 2031, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:teacher:add', '#', 'admin', '2025-10-22 23:20:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '教师信息修改', 2031, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:teacher:edit', '#', 'admin', '2025-10-22 23:20:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '教师信息删除', 2031, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:teacher:remove', '#', 'admin', '2025-10-22 23:20:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '教师信息导出', 2031, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:teacher:export', '#', 'admin', '2025-10-22 23:20:46', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-10-22 23:01:04', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-10-22 23:01:04', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 251 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:01:04\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:07:06', 15);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"智慧课程管理系统\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"manage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:11:17', 16);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"tb_student,tb_student_selection,tb_teacher\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:11:35', 65);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"tb_course,tb_score,tb_selection_exception\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:11:42', 37);
INSERT INTO `sys_oper_log` VALUES (104, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"课程状态\",\"dictType\":\"int\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:13:16', 9);
INSERT INTO `sys_oper_log` VALUES (105, '字典类型', 3, 'com.ruoyi.web.controller.system.SysDictTypeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/100', '127.0.0.1', '内网IP', '[100]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:13:45', 10);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"course\",\"className\":\"Course\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"课程ID（主键）\",\"columnId\":13,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CourseCode\",\"columnComment\":\"课程编码（如JSJ001）\",\"columnId\":14,\"columnName\":\"course_code\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"courseCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CourseName\",\"columnComment\":\"课程名称\",\"columnId\":15,\"columnName\":\"course_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"courseName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TeacherId\",\"columnComment\":\"授课教师ID（关联tb_teacher.id）\",\"columnId\":16,\"columnName\":\"teacher_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:16:22', 24);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"score\",\"className\":\"Score\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"成绩ID（主键）\",\"columnId\":19,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CourseId\",\"columnComment\":\"课程ID（关联tb_course.id）\",\"columnId\":20,\"columnName\":\"course_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"courseId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID（关联tb_student.id）\",\"columnId\":21,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Score\",\"columnComment\":\"成绩（如85.5，NULL表示未录入）\",\"columnId\":22,\"columnName\":\"score\",\"columnType\":\"decimal(5,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:17:24', 10);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"exception\",\"className\":\"SelectionException\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"异常ID（主键）\",\"columnId\":24,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CourseId\",\"columnComment\":\"课程ID（关联tb_course.id）\",\"columnId\":25,\"columnName\":\"course_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"courseId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID（关联tb_student.id）\",\"columnId\":26,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ExceptionType\",\"columnComment\":\"异常类型（1-重复选课，2-超员选课）\",\"columnId\":27,\"columnName\":\"exception_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:17:59', 16);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"student\",\"className\":\"Student\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"学生ID（主键）\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentNo\",\"columnComment\":\"学号（如S2023001）\",\"columnId\":2,\"columnName\":\"student_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentName\",\"columnComment\":\"学生姓名\",\"columnId\":3,\"columnName\":\"student_name\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"hgz\",\"functionName\":\"学生信息（学生个人信息）\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"manage\",\"options\":\"{\\\"parentMenuId\\\":2000}\",\"packageName\":\"com.ruoyi.manage\",\"params\":{\"parentMenuId\":2000},\"parentMenuId\":2000,\"sub\":false,\"tableComment\":\"学生信息表\",\"tableId\":1,\"tableName\":\"tb_student\",\"tplCategory\":\"crud\",\"tpl', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:18:27', 10);
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"selection\",\"className\":\"StudentSelection\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"选课ID（主键）\",\"columnId\":4,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CourseId\",\"columnComment\":\"课程ID（关联tb_course.id）\",\"columnId\":5,\"columnName\":\"course_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"courseId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID（关联tb_student.id）\",\"columnId\":6,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态（0-已选，1-已退）\",\"columnId\":7,\"columnName\":\"status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuer', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:18:50', 10);
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"teacher\",\"className\":\"Teacher\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"教师ID（主键）\",\"columnId\":9,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TeacherNo\",\"columnComment\":\"教师工号（如T001）\",\"columnId\":10,\"columnName\":\"teacher_no\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"teacherNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TeacherName\",\"columnComment\":\"教师姓名\",\"columnId\":11,\"columnName\":\"teacher_name\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"teacherName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"职称（如教授/讲师）\",\"columnId\":12,\"columnName\":\"title\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-22 23:11:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:19:25', 13);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"tb_course,tb_score,tb_selection_exception,tb_student,tb_student_selection,tb_teacher\"}', NULL, 0, NULL, '2025-10-22 23:19:30', 283);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/student/index\",\"createTime\":\"2025-10-22 23:20:41\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"学生信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"student\",\"perms\":\"manage:student:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:21:12', 7);
INSERT INTO `sys_oper_log` VALUES (114, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"123\",\"courseName\":\"123\",\"params\":{},\"teacherId\":21}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT)\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\CourseMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.CourseMapper.insertCourse-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_course          ( course_code,             course_name,             teacher_id )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT)\n; Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT)', '2025-10-22 23:45:53', 150);
INSERT INTO `sys_oper_log` VALUES (115, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"123\",\"courseName\":\"123\",\"params\":{},\"teacherId\":21}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT)\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\CourseMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.CourseMapper.insertCourse-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_course          ( course_code,             course_name,             teacher_id )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT)\n; Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`smart_course_management`.`tb_course`, CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT)', '2025-10-22 23:46:05', 9);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/course/index\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"课程信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"course\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:56:03', 30);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/teacher/index\",\"createTime\":\"2025-10-22 23:20:46\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"教师信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"teacher\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:56:10', 8);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/student/index\",\"createTime\":\"2025-10-22 23:20:41\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"学生信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"student\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:56:12', 8);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/selection/index\",\"createTime\":\"2025-10-22 23:20:35\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"学生选课\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"selection\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:56:15', 7);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/score/index\",\"createTime\":\"2025-10-22 23:20:28\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"学生成绩\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"score\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:56:18', 10);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/exception/index\",\"createTime\":\"2025-10-22 23:20:22\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"选课异常记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"exception\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 23:56:20', 8);
INSERT INTO `sys_oper_log` VALUES (122, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"123\",\"courseName\":\"123\",\"id\":6,\"maxStudents\":222,\"params\":{},\"status\":0,\"teacherId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 00:05:54', 103);
INSERT INTO `sys_oper_log` VALUES (123, '课程信息', 3, 'com.ruoyi.manage.controller.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/course/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 00:06:21', 12);
INSERT INTO `sys_oper_log` VALUES (124, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036],\"params\":{},\"roleId\":100,\"roleKey\":\"campus_admin\",\"roleName\":\"教务员\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 10:54:29', 46);
INSERT INTO `sys_oper_log` VALUES (125, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2002,2014,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"campus_student\",\"roleName\":\"student\",\"roleSort\":1,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 10:57:44', 16);
INSERT INTO `sys_oper_log` VALUES (126, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2002,2014,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"campus_student\",\"roleName\":\"student\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 10:57:54', 17);
INSERT INTO `sys_oper_log` VALUES (127, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2002,2014,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"campus_student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 10:58:09', 14);
INSERT INTO `sys_oper_log` VALUES (128, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:54:29\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036],\"params\":{},\"roleId\":100,\"roleKey\":\"manage\",\"roleName\":\"教务员\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 10:58:23', 19);
INSERT INTO `sys_oper_log` VALUES (129, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2002,2014,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 10:58:56', 12);
INSERT INTO `sys_oper_log` VALUES (130, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2019,2025,2031,2002,2006,2013,2014,2015,2016,2017,2018,2020,2026,2030,2032,2036],\"params\":{},\"roleKey\":\"student\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"新增角色\'老师\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-10-23 11:00:01', 1);
INSERT INTO `sys_oper_log` VALUES (131, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2019,2025,2031,2002,2006,2013,2014,2015,2016,2017,2018,2020,2026,2030,2032,2036],\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:00:10', 18);
INSERT INTO `sys_oper_log` VALUES (132, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"教务员\",\"params\":{},\"postIds\":[],\"roleIds\":[100],\"status\":\"0\",\"userId\":100,\"userName\":\"manage\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:01:06', 80);
INSERT INTO `sys_oper_log` VALUES (133, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"李讲师\",\"params\":{},\"postIds\":[],\"roleIds\":[102],\"status\":\"0\",\"userId\":101,\"userName\":\"teacher-li\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:01:49', 83);
INSERT INTO `sys_oper_log` VALUES (134, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-10-23 11:01:06\",\"delFlag\":\"0\",\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"教务员\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"manage\",\"roleName\":\"教务员\",\"roleSort\":0,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"manage\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:02:46', 10);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"课程信息查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:07:04', 12);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"课程信息新增\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:07:06', 12);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"课程信息修改\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:07:10', 6);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"课程信息删除\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:07:13', 5);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"课程信息导出\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:07:16', 6);
INSERT INTO `sys_oper_log` VALUES (140, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:54:29\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036],\"params\":{},\"roleId\":100,\"roleKey\":\"manage\",\"roleName\":\"教务员\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:08:18', 12);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/exception/index\",\"createTime\":\"2025-10-22 23:20:22\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"选课异常记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"exception\",\"perms\":\"manage:exception:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:10:06', 8);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/course/index\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"课程信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"course\",\"perms\":\"manage:course:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:12:20', 6);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"课程信息查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"manage:course:query\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:12:40', 9);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"课程信息新增\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"manage:course:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:12:47', 3);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"课程信息修改\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"manage:course:edit\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:12:55', 11);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"课程信息删除\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"manage:course:remove\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:13:06', 8);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-10-22 23:20:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"课程信息导出\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"manage:course:export\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:13:15', 11);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/score/index\",\"createTime\":\"2025-10-22 23:20:28\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"学生成绩\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"score\",\"perms\":\"manage:score:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:13:33', 8);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/selection/index\",\"createTime\":\"2025-10-22 23:20:35\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"学生选课\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"selection\",\"perms\":\"manage:selection:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:13:47', 5);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/student/index\",\"createTime\":\"2025-10-22 23:20:41\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"学生信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"student\",\"perms\":\"manage:student:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:13:58', 7);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/teacher/index\",\"createTime\":\"2025-10-22 23:20:46\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"教师信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"teacher\",\"perms\":\"manage:teacher:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:14:12', 6);
INSERT INTO `sys_oper_log` VALUES (152, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"修改密码失败，旧密码错误\",\"code\":500}', 0, NULL, '2025-10-23 11:15:21', 74);
INSERT INTO `sys_oper_log` VALUES (153, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 11:15:29', 218);
INSERT INTO `sys_oper_log` VALUES (154, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"小明\",\"params\":{},\"postIds\":[],\"roleIds\":[101],\"status\":\"0\",\"userId\":102,\"userName\":\"student-xm\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 20:05:54', 91);
INSERT INTO `sys_oper_log` VALUES (155, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"张教授\",\"params\":{},\"postIds\":[],\"roleIds\":[102],\"status\":\"0\",\"userId\":103,\"userName\":\"teacher-zhang\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 21:17:34', 87);
INSERT INTO `sys_oper_log` VALUES (156, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"小红\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":104,\"userName\":\"student-xh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 21:18:13', 78);
INSERT INTO `sys_oper_log` VALUES (157, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-10-23 21:18:13\",\"delFlag\":\"0\",\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"小红\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[101],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":104,\"userName\":\"student-xh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 21:18:28', 10);
INSERT INTO `sys_oper_log` VALUES (158, '选课异常记录', 5, 'com.ruoyi.manage.controller.SelectionExceptionController.export()', 'POST', 1, 'admin', '研发部门', '/manage/exception/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-10-23 21:44:03', 704);
INSERT INTO `sys_oper_log` VALUES (159, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"选课状态\",\"dictType\":\"selection_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 22:21:24', 77);
INSERT INTO `sys_oper_log` VALUES (160, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-10-23 22:21:24\",\"dictId\":101,\"dictName\":\"选课状态\",\"dictType\":\"selection_status\",\"params\":{},\"remark\":\"字典标签：已选，字典值：0，排序：1\\n字典标签：已退，字典值：1，排序：2\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 22:21:40', 29);
INSERT INTO `sys_oper_log` VALUES (161, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\StudentSelectionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.StudentSelectionMapper.insertStudentSelection-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_student_selection          ( course_id,             student_id,             status )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'\n; Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'', '2025-10-23 22:44:03', 44);
INSERT INTO `sys_oper_log` VALUES (162, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"1\",\"maxStudents\":12,\"params\":{},\"status\":0,\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\CourseMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.CourseMapper.insertCourse-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_course          ( course_code,             course_name,             teacher_id,             max_students,             status )           values ( ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'\n; Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'', '2025-10-23 22:45:25', 8);
INSERT INTO `sys_oper_log` VALUES (163, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:54:29\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2007,2001,2002,2003,2004,2005,2006,2008,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036],\"params\":{},\"roleId\":100,\"roleKey\":\"manage\",\"roleName\":\"教务员\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 22:54:27', 19);
INSERT INTO `sys_oper_log` VALUES (164, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2025,2002,2006,2014,2018,2019,2020,2021,2022,2023,2024,2026,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 22:55:12', 13);
INSERT INTO `sys_oper_log` VALUES (165, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 11:00:10\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2019,2025,2031,2002,2006,2013,2014,2015,2016,2017,2018,2020,2024,2026,2030,2032,2036],\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 22:56:17', 12);
INSERT INTO `sys_oper_log` VALUES (166, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2019,2025,2002,2006,2014,2018,2020,2024,2026,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 23:10:42', 11);
INSERT INTO `sys_oper_log` VALUES (167, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'manage', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 23:24:05', 205);
INSERT INTO `sys_oper_log` VALUES (168, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 23:24:29', 207);
INSERT INTO `sys_oper_log` VALUES (169, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'teacher-li', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 23:25:15', 211);
INSERT INTO `sys_oper_log` VALUES (170, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'student-xh', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 23:25:35', 210);
INSERT INTO `sys_oper_log` VALUES (171, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'student-xm', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 23:26:11', 212);
INSERT INTO `sys_oper_log` VALUES (172, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'teacher-zhang', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 16:33:32', 211);
INSERT INTO `sys_oper_log` VALUES (173, '课程信息', 5, 'com.ruoyi.manage.controller.CourseController.export()', 'POST', 1, 'student-xh', NULL, '/manage/course/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\",\"status\":\"0\"}', NULL, 0, NULL, '2025-10-31 17:13:13', 712);
INSERT INTO `sys_oper_log` VALUES (174, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"id\":3,\"params\":{},\"teacherName\":\"王讲师\",\"teacherNo\":\"T003\",\"title\":\"讲师\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 17:14:25', 12);
INSERT INTO `sys_oper_log` VALUES (175, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'manage', NULL, '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"123\",\"courseName\":\"123\",\"id\":8,\"maxStudents\":123,\"params\":{},\"status\":1,\"teacherId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:21:56', 19);
INSERT INTO `sys_oper_log` VALUES (176, '课程信息', 3, 'com.ruoyi.manage.controller.CourseController.remove()', 'DELETE', 1, 'manage', NULL, '/manage/course/8', '127.0.0.1', '内网IP', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:21:59', 16);
INSERT INTO `sys_oper_log` VALUES (177, '课程信息', 2, 'com.ruoyi.manage.controller.CourseController.edit()', 'PUT', 1, 'manage', NULL, '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"DB001\",\"courseName\":\"数据库原理\",\"id\":3,\"maxStudents\":25,\"params\":{},\"status\":0,\"teacherId\":3,\"teacherName\":\"李讲师\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:22:07', 8);
INSERT INTO `sys_oper_log` VALUES (178, '课程信息', 2, 'com.ruoyi.manage.controller.CourseController.edit()', 'PUT', 1, 'manage', NULL, '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"DB001\",\"courseName\":\"数据库原理\",\"id\":3,\"maxStudents\":25,\"params\":{},\"status\":0,\"teacherId\":2,\"teacherName\":\"王讲师\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:22:10', 10);
INSERT INTO `sys_oper_log` VALUES (179, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'manage', NULL, '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\StudentSelectionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.StudentSelectionMapper.insertStudentSelection-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_student_selection          ( course_id,             student_id,             status )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'\n; Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'', '2025-10-31 20:24:17', 54);
INSERT INTO `sys_oper_log` VALUES (180, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'manage', NULL, '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\StudentSelectionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.StudentSelectionMapper.insertStudentSelection-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_student_selection          ( course_id,             student_id,             status )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'\n; Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_student_selection.uk_course_student\'', '2025-10-31 20:24:30', 8);
INSERT INTO `sys_oper_log` VALUES (181, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 11:00:10\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2019,2025,2031,2002,2006,2013,2014,2015,2016,2017,2018,2020,2024,2026,2030,2036],\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:28:16', 17);
INSERT INTO `sys_oper_log` VALUES (182, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2019,2025,2002,2006,2014,2018,2020,2024,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:28:35', 6);
INSERT INTO `sys_oper_log` VALUES (183, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 11:00:10\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2019,2025,2031,2002,2006,2013,2014,2015,2016,2017,2018,2020,2024,2026,2030,2036],\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:36:00', 12);
INSERT INTO `sys_oper_log` VALUES (184, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 11:00:10\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2019,2025,2031,2002,2006,2013,2014,2015,2016,2017,2018,2020,2024,2026,2030,2036],\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:41:33', 11);
INSERT INTO `sys_oper_log` VALUES (185, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-10-23 11:01:49\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-10-31 20:33:51\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"李讲师\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-10-23 23:25:15\",\"roleIds\":[102],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":102,\"roleKey\":\"teacher\",\"roleName\":\"老师\",\"roleSort\":0,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":101,\"userName\":\"teacher-li\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:41:45', 10);
INSERT INTO `sys_oper_log` VALUES (186, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2019,2025,2002,2006,2014,2018,2020,2024,2030,2031,2032,2033,2034,2035,2036],\"params\":{},\"roleId\":101,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:42:47', 9);
INSERT INTO `sys_oper_log` VALUES (187, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-10-23 10:57:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2013,2019,2025,2002,2006,2014,2018,2020,2024,2030],\"params\":{},\"roleId\":101,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 20:43:07', 9);
INSERT INTO `sys_oper_log` VALUES (188, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', '{\"msg\":\"您已选过该课程，系统已自动记录异常\",\"code\":200}', 0, NULL, '2025-10-31 21:03:24', 63);
INSERT INTO `sys_oper_log` VALUES (189, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', '{\"msg\":\"您已选过该课程，系统已自动记录异常\",\"code\":200}', 0, NULL, '2025-10-31 21:07:04', 10);
INSERT INTO `sys_oper_log` VALUES (190, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', '{\"msg\":\"您已选过该课程，系统已自动记录异常\",\"code\":200}', 0, NULL, '2025-10-31 21:07:20', 10);
INSERT INTO `sys_oper_log` VALUES (191, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:07:34', 6);
INSERT INTO `sys_oper_log` VALUES (192, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:07:36', 6);
INSERT INTO `sys_oper_log` VALUES (193, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:07:37', 6);
INSERT INTO `sys_oper_log` VALUES (194, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', '{\"msg\":\"您已选过该课程，系统已记录重复选课异常\",\"code\":200}', 0, NULL, '2025-10-31 21:23:09', 135);
INSERT INTO `sys_oper_log` VALUES (195, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:23:19', 9);
INSERT INTO `sys_oper_log` VALUES (196, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:23:21', 6);
INSERT INTO `sys_oper_log` VALUES (197, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ003\",\"courseName\":\"操作系统\",\"id\":9,\"maxStudents\":1,\"params\":{},\"status\":0,\"teacherId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:23:59', 8);
INSERT INTO `sys_oper_log` VALUES (198, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":9,\"id\":14,\"params\":{},\"selectTime\":\"2025-10-31\",\"status\":0,\"studentId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:24:20', 10);
INSERT INTO `sys_oper_log` VALUES (199, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":9,\"params\":{},\"selectTime\":\"2025-10-31\",\"status\":0,\"studentId\":2}', '{\"msg\":\"该课程已达最大选课人数，系统已记录超员异常\",\"code\":200}', 0, NULL, '2025-10-31 21:24:34', 11);
INSERT INTO `sys_oper_log` VALUES (200, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"123\",\"courseName\":\"123\",\"id\":10,\"maxStudents\":123,\"params\":{},\"teacherId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:25:08', 9);
INSERT INTO `sys_oper_log` VALUES (201, '课程信息', 3, 'com.ruoyi.manage.controller.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/course/10', '127.0.0.1', '内网IP', '[10]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:25:11', 5);
INSERT INTO `sys_oper_log` VALUES (202, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"123\",\"maxStudents\":123,\"params\":{},\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\CourseMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.CourseMapper.insertCourse-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_course          ( course_code,             course_name,             teacher_id,             max_students )           values ( ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'\n; Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'JSJ001\' for key \'tb_course.course_code\'', '2025-10-31 21:25:24', 5);
INSERT INTO `sys_oper_log` VALUES (203, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ004\",\"courseName\":\"操作系统\",\"id\":12,\"maxStudents\":12,\"params\":{},\"status\":0,\"teacherId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:28:42', 8);
INSERT INTO `sys_oper_log` VALUES (204, '课程信息', 3, 'com.ruoyi.manage.controller.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/course/12', '127.0.0.1', '内网IP', '[12]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:28:49', 8);
INSERT INTO `sys_oper_log` VALUES (205, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"12\",\"maxStudents\":12,\"params\":{},\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\SelectionExceptionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.SelectionExceptionMapper.insertSelectionException-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_selection_exception          ( exception_type,             create_time )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\n; Field \'course_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'course_id\' doesn\'t have a default value', '2025-10-31 21:37:26', 16);
INSERT INTO `sys_oper_log` VALUES (206, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"12\",\"maxStudents\":12,\"params\":{},\"status\":0,\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\SelectionExceptionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.SelectionExceptionMapper.insertSelectionException-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_selection_exception          ( exception_type,             create_time )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\n; Field \'course_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'course_id\' doesn\'t have a default value', '2025-10-31 21:38:09', 45);
INSERT INTO `sys_oper_log` VALUES (207, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"12\",\"maxStudents\":12,\"params\":{},\"status\":0,\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\SelectionExceptionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.SelectionExceptionMapper.insertSelectionException-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_selection_exception          ( exception_type,             create_time )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\n; Field \'course_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'course_id\' doesn\'t have a default value', '2025-10-31 21:38:13', 5);
INSERT INTO `sys_oper_log` VALUES (208, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"11\",\"maxStudents\":1,\"params\":{},\"status\":0,\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\SelectionExceptionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.SelectionExceptionMapper.insertSelectionException-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_selection_exception          ( exception_type,             create_time )           values ( ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'course_id\' doesn\'t have a default value\n; Field \'course_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'course_id\' doesn\'t have a default value', '2025-10-31 21:38:44', 10);
INSERT INTO `sys_oper_log` VALUES (209, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"12\",\"maxStudents\":123,\"params\":{},\"status\":0,\"teacherId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'course_id\' cannot be null\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\SelectionExceptionMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.SelectionExceptionMapper.insertSelectionException-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_selection_exception          ( course_id,               student_id,              exception_type,               create_time )           values ( ?,             ?,             ?,             CURRENT_TIMESTAMP )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'course_id\' cannot be null\n; Column \'course_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'course_id\' cannot be null', '2025-10-31 21:45:14', 15);
INSERT INTO `sys_oper_log` VALUES (210, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSj001\",\"courseName\":\"123\",\"maxStudents\":12,\"params\":{},\"status\":0,\"teacherId\":1}', '{\"msg\":\"课程编码已存在，系统已记录异常\",\"code\":200}', 0, NULL, '2025-10-31 21:49:33', 14);
INSERT INTO `sys_oper_log` VALUES (211, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"123\",\"maxStudents\":12,\"params\":{},\"status\":0,\"teacherId\":1}', '{\"msg\":\"课程编码已存在\",\"code\":200}', 0, NULL, '2025-10-31 21:53:38', 9);
INSERT INTO `sys_oper_log` VALUES (212, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"123\",\"teacherNo\":\"T001\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\TeacherMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.TeacherMapper.insertTeacher-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_teacher          ( teacher_no,             teacher_name )           values ( ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\n; Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'', '2025-10-31 21:54:58', 8);
INSERT INTO `sys_oper_log` VALUES (213, '学生信息（学生个人信息）', 1, 'com.ruoyi.manage.controller.StudentController.add()', 'POST', 1, 'admin', '研发部门', '/manage/student', '127.0.0.1', '内网IP', '{\"params\":{},\"studentName\":\"12\",\"studentNo\":\"S2023002\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'S2023002\' for key \'tb_student.student_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\StudentMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.StudentMapper.insertStudent-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_student          ( student_no,             student_name )           values ( ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'S2023002\' for key \'tb_student.student_no\'\n; Duplicate entry \'S2023002\' for key \'tb_student.student_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'S2023002\' for key \'tb_student.student_no\'', '2025-10-31 21:55:12', 5);
INSERT INTO `sys_oper_log` VALUES (214, '学生信息（学生个人信息）', 1, 'com.ruoyi.manage.controller.StudentController.add()', 'POST', 1, 'admin', '研发部门', '/manage/student', '127.0.0.1', '内网IP', '{\"params\":{},\"studentName\":\"12\",\"studentNo\":\"S2023002\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'S2023002\' for key \'tb_student.student_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\StudentMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.StudentMapper.insertStudent-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_student          ( student_no,             student_name )           values ( ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'S2023002\' for key \'tb_student.student_no\'\n; Duplicate entry \'S2023002\' for key \'tb_student.student_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'S2023002\' for key \'tb_student.student_no\'', '2025-10-31 21:55:40', 3);
INSERT INTO `sys_oper_log` VALUES (215, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"id\":5,\"params\":{},\"teacherName\":\"123\",\"teacherNo\":\"T0001\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:55:53', 6);
INSERT INTO `sys_oper_log` VALUES (216, '教师信息', 3, 'com.ruoyi.manage.controller.TeacherController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/teacher/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 21:55:57', 10);
INSERT INTO `sys_oper_log` VALUES (217, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"123\",\"teacherNo\":\"T001\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\TeacherMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.TeacherMapper.insertTeacher-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_teacher          ( teacher_no,             teacher_name )           values ( ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\n; Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'', '2025-10-31 21:56:03', 6);
INSERT INTO `sys_oper_log` VALUES (218, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\TeacherMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.TeacherMapper.insertTeacher-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_teacher          ( teacher_no,             teacher_name,             title )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\n; Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'', '2025-10-31 22:12:22', 14);
INSERT INTO `sys_oper_log` VALUES (219, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\TeacherMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.TeacherMapper.insertTeacher-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_teacher          ( teacher_no,             teacher_name,             title )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\n; Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'', '2025-10-31 22:12:47', 4);
INSERT INTO `sys_oper_log` VALUES (220, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"123\",\"teacherNo\":\"T001\",\"title\":\"1\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\TeacherMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.TeacherMapper.insertTeacher-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_teacher          ( teacher_no,             teacher_name,             title )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'\n; Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'T001\' for key \'tb_teacher.teacher_no\'', '2025-10-31 22:13:43', 110);
INSERT INTO `sys_oper_log` VALUES (221, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:15:22', 114);
INSERT INTO `sys_oper_log` VALUES (222, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:22:27', 106);
INSERT INTO `sys_oper_log` VALUES (223, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:25:47', 109);
INSERT INTO `sys_oper_log` VALUES (224, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"1\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:26:14', 6);
INSERT INTO `sys_oper_log` VALUES (225, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:26:43', 5);
INSERT INTO `sys_oper_log` VALUES (226, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"123\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:32:17', 13);
INSERT INTO `sys_oper_log` VALUES (227, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:33:12', 106);
INSERT INTO `sys_oper_log` VALUES (228, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:34:09', 108);
INSERT INTO `sys_oper_log` VALUES (229, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":200}', 0, NULL, '2025-10-31 22:38:50', 4);
INSERT INTO `sys_oper_log` VALUES (230, '学生信息（学生个人信息）', 1, 'com.ruoyi.manage.controller.StudentController.add()', 'POST', 1, 'admin', '研发部门', '/manage/student', '127.0.0.1', '内网IP', '{\"id\":7,\"params\":{},\"studentName\":\"123\",\"studentNo\":\"S1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 22:39:06', 9);
INSERT INTO `sys_oper_log` VALUES (231, '学生信息（学生个人信息）', 1, 'com.ruoyi.manage.controller.StudentController.add()', 'POST', 1, 'admin', '研发部门', '/manage/student', '127.0.0.1', '内网IP', '{\"params\":{},\"studentName\":\"1\",\"studentNo\":\"S1\"}', '{\"msg\":\"您输入的学号已存在，请更换学号\",\"code\":200}', 0, NULL, '2025-10-31 22:39:11', 7);
INSERT INTO `sys_oper_log` VALUES (232, '学生信息（学生个人信息）', 1, 'com.ruoyi.manage.controller.StudentController.add()', 'POST', 1, 'admin', '研发部门', '/manage/student', '127.0.0.1', '内网IP', '{\"params\":{},\"studentName\":\"1233\",\"studentNo\":\"S1\"}', '{\"msg\":\"您输入的学号已存在，请更换学号\",\"code\":200}', 0, NULL, '2025-10-31 22:39:48', 6);
INSERT INTO `sys_oper_log` VALUES (233, '学生信息（学生个人信息）', 3, 'com.ruoyi.manage.controller.StudentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/student/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 22:39:50', 10);
INSERT INTO `sys_oper_log` VALUES (234, '学生成绩', 1, 'com.ruoyi.manage.controller.ScoreController.add()', 'POST', 1, 'admin', '研发部门', '/manage/score', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"score\":12,\"studentId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_score.uk_course_student\'\r\n### The error may exist in file [D:\\RuoYi\\backend\\ruoyi-manage\\target\\classes\\mapper\\manage\\ScoreMapper.xml]\r\n### The error may involve com.ruoyi.manage.mapper.ScoreMapper.insertScore-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_score          ( course_id,             student_id,             score )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_score.uk_course_student\'\n; Duplicate entry \'1-1\' for key \'tb_score.uk_course_student\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'tb_score.uk_course_student\'', '2025-10-31 22:46:09', 9);
INSERT INTO `sys_oper_log` VALUES (235, '学生成绩', 1, 'com.ruoyi.manage.controller.ScoreController.add()', 'POST', 1, 'admin', '研发部门', '/manage/score', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"score\":12,\"studentId\":1}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-10-31 22:51:33', 110);
INSERT INTO `sys_oper_log` VALUES (236, '学生成绩', 1, 'com.ruoyi.manage.controller.ScoreController.add()', 'POST', 1, 'admin', '研发部门', '/manage/score', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"score\":12,\"studentId\":1}', '{\"msg\":\"该学生在该课程中的成绩已存在，请不要重复添加\",\"code\":200}', 0, NULL, '2025-10-31 22:52:53', 11);
INSERT INTO `sys_oper_log` VALUES (237, '学生成绩', 1, 'com.ruoyi.manage.controller.ScoreController.add()', 'POST', 1, 'admin', '研发部门', '/manage/score', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"remark\":\"1\",\"score\":12,\"studentId\":1}', '{\"msg\":\"该学生在该课程中的成绩已存在，请不要重复添加\",\"code\":500}', 0, NULL, '2025-10-31 22:59:19', 14);
INSERT INTO `sys_oper_log` VALUES (238, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"12\",\"maxStudents\":12,\"params\":{},\"teacherId\":1}', '{\"msg\":\"课程编码已存在\",\"code\":500}', 0, NULL, '2025-10-31 23:00:27', 110);
INSERT INTO `sys_oper_log` VALUES (239, '课程信息', 1, 'com.ruoyi.manage.controller.CourseController.add()', 'POST', 1, 'admin', '研发部门', '/manage/course', '127.0.0.1', '内网IP', '{\"courseCode\":\"JSJ001\",\"courseName\":\"12\",\"maxStudents\":1,\"params\":{},\"status\":0,\"teacherId\":1}', '{\"msg\":\"课程编码已存在\",\"code\":500}', 0, NULL, '2025-10-31 23:01:39', 110);
INSERT INTO `sys_oper_log` VALUES (240, '学生成绩', 1, 'com.ruoyi.manage.controller.ScoreController.add()', 'POST', 1, 'admin', '研发部门', '/manage/score', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"remark\":\"2\",\"score\":12,\"studentId\":2}', '{\"msg\":\"该学生在该课程中的成绩已存在，请不要重复添加\",\"code\":500}', 0, NULL, '2025-10-31 23:01:57', 10);
INSERT INTO `sys_oper_log` VALUES (241, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"status\":0,\"studentId\":1}', '{\"msg\":\"您已选过该课程，系统已记录重复选课异常\",\"code\":500}', 0, NULL, '2025-10-31 23:02:10', 28);
INSERT INTO `sys_oper_log` VALUES (242, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 23:02:26', 8);
INSERT INTO `sys_oper_log` VALUES (243, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'admin', '研发部门', '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":9,\"params\":{},\"status\":0,\"studentId\":2}', '{\"msg\":\"该课程已达最大选课人数，系统已记录超员异常\",\"code\":500}', 0, NULL, '2025-10-31 23:02:39', 11);
INSERT INTO `sys_oper_log` VALUES (244, '选课异常记录', 3, 'com.ruoyi.manage.controller.SelectionExceptionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/manage/exception/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 23:02:47', 5);
INSERT INTO `sys_oper_log` VALUES (245, '学生信息（学生个人信息）', 1, 'com.ruoyi.manage.controller.StudentController.add()', 'POST', 1, 'admin', '研发部门', '/manage/student', '127.0.0.1', '内网IP', '{\"params\":{},\"studentName\":\"12\",\"studentNo\":\"S2023003\"}', '{\"msg\":\"您输入的学号已存在，请更换学号\",\"code\":500}', 0, NULL, '2025-10-31 23:03:00', 7);
INSERT INTO `sys_oper_log` VALUES (246, '教师信息', 1, 'com.ruoyi.manage.controller.TeacherController.add()', 'POST', 1, 'admin', '研发部门', '/manage/teacher', '127.0.0.1', '内网IP', '{\"params\":{},\"teacherName\":\"12\",\"teacherNo\":\"T001\",\"title\":\"1\"}', '{\"msg\":\"您输入的教师工号已存在，请更换工号\",\"code\":500}', 0, NULL, '2025-10-31 23:03:13', 7);
INSERT INTO `sys_oper_log` VALUES (247, '学生成绩', 1, 'com.ruoyi.manage.controller.ScoreController.add()', 'POST', 1, 'manage', NULL, '/manage/score', '127.0.0.1', '内网IP', '{\"courseId\":9,\"id\":12,\"params\":{},\"score\":67,\"studentId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 23:04:09', 9);
INSERT INTO `sys_oper_log` VALUES (248, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'manage', NULL, '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"id\":16,\"params\":{},\"selectTime\":\"2025-10-31\",\"status\":0,\"studentId\":4}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 23:04:42', 9);
INSERT INTO `sys_oper_log` VALUES (249, '学生选课', 3, 'com.ruoyi.manage.controller.StudentSelectionController.remove()', 'DELETE', 1, 'manage', NULL, '/manage/selection/16', '127.0.0.1', '内网IP', '[16]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-31 23:04:44', 4);
INSERT INTO `sys_oper_log` VALUES (250, '学生选课', 1, 'com.ruoyi.manage.controller.StudentSelectionController.add()', 'POST', 1, 'manage', NULL, '/manage/selection', '127.0.0.1', '内网IP', '{\"courseId\":1,\"params\":{},\"selectTime\":\"2025-10-03\",\"status\":0,\"studentId\":1}', '{\"msg\":\"您已选过该课程，系统已记录重复选课异常\",\"code\":500}', 0, NULL, '2025-10-31 23:04:50', 8);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-10-22 23:01:04', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-10-22 23:01:04', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-10-22 23:01:04', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '教务员', 'manage', 0, '1', 1, 1, '0', '0', 'admin', '2025-10-23 10:54:29', 'admin', '2025-10-23 22:54:27', NULL);
INSERT INTO `sys_role` VALUES (101, '学生', 'student', 0, '1', 1, 1, '0', '0', 'admin', '2025-10-23 10:57:44', 'admin', '2025-10-31 20:43:07', NULL);
INSERT INTO `sys_role` VALUES (102, '老师', 'teacher', 0, '1', 1, 1, '0', '0', 'admin', '2025-10-23 11:00:10', 'admin', '2025-10-31 20:41:33', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2001);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2004);
INSERT INTO `sys_role_menu` VALUES (100, 2005);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2011);
INSERT INTO `sys_role_menu` VALUES (100, 2012);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2016);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2025);
INSERT INTO `sys_role_menu` VALUES (100, 2026);
INSERT INTO `sys_role_menu` VALUES (100, 2027);
INSERT INTO `sys_role_menu` VALUES (100, 2028);
INSERT INTO `sys_role_menu` VALUES (100, 2029);
INSERT INTO `sys_role_menu` VALUES (100, 2030);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (100, 2032);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2036);
INSERT INTO `sys_role_menu` VALUES (101, 2000);
INSERT INTO `sys_role_menu` VALUES (101, 2001);
INSERT INTO `sys_role_menu` VALUES (101, 2002);
INSERT INTO `sys_role_menu` VALUES (101, 2006);
INSERT INTO `sys_role_menu` VALUES (101, 2013);
INSERT INTO `sys_role_menu` VALUES (101, 2014);
INSERT INTO `sys_role_menu` VALUES (101, 2018);
INSERT INTO `sys_role_menu` VALUES (101, 2019);
INSERT INTO `sys_role_menu` VALUES (101, 2020);
INSERT INTO `sys_role_menu` VALUES (101, 2024);
INSERT INTO `sys_role_menu` VALUES (101, 2025);
INSERT INTO `sys_role_menu` VALUES (101, 2030);
INSERT INTO `sys_role_menu` VALUES (102, 2000);
INSERT INTO `sys_role_menu` VALUES (102, 2001);
INSERT INTO `sys_role_menu` VALUES (102, 2002);
INSERT INTO `sys_role_menu` VALUES (102, 2006);
INSERT INTO `sys_role_menu` VALUES (102, 2013);
INSERT INTO `sys_role_menu` VALUES (102, 2014);
INSERT INTO `sys_role_menu` VALUES (102, 2015);
INSERT INTO `sys_role_menu` VALUES (102, 2016);
INSERT INTO `sys_role_menu` VALUES (102, 2017);
INSERT INTO `sys_role_menu` VALUES (102, 2018);
INSERT INTO `sys_role_menu` VALUES (102, 2019);
INSERT INTO `sys_role_menu` VALUES (102, 2020);
INSERT INTO `sys_role_menu` VALUES (102, 2024);
INSERT INTO `sys_role_menu` VALUES (102, 2025);
INSERT INTO `sys_role_menu` VALUES (102, 2026);
INSERT INTO `sys_role_menu` VALUES (102, 2030);
INSERT INTO `sys_role_menu` VALUES (102, 2031);
INSERT INTO `sys_role_menu` VALUES (102, 2036);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$pFDW5yfyqphrzfGXnrebmuHfN1hzcnLEgK8Kd1Q6r6I62hRyvtBhG', '0', '0', '127.0.0.1', '2025-10-31 21:37:53', '2025-10-23 23:24:29', 'admin', '2025-10-22 23:01:04', '', '2025-10-23 23:24:29', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-22 23:01:04', '2025-10-22 23:01:04', 'admin', '2025-10-22 23:01:04', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, 'manage', '教务员', '00', '', '', '0', '', '$2a$10$HC6U4qmTqaov5ztckFsa5OZQY5UmTIeG/oe5oP11t93VspWYLVbq6', '0', '0', '127.0.0.1', '2025-10-31 23:25:59', '2025-10-23 23:24:05', 'admin', '2025-10-23 11:01:06', 'admin', '2025-10-23 23:24:05', NULL);
INSERT INTO `sys_user` VALUES (101, NULL, 'teacher-li', '李讲师', '00', '', '', '0', '', '$2a$10$Cc0DqtZLKdHUVPQ2js0Zmumz16sJxOrsyj9Qfshx62bH9evzOFFyG', '0', '0', '127.0.0.1', '2025-10-31 23:25:31', '2025-10-23 23:25:15', 'admin', '2025-10-23 11:01:49', 'admin', '2025-10-31 20:41:45', NULL);
INSERT INTO `sys_user` VALUES (102, NULL, 'student-xm', '小明', '00', '', '', '0', '', '$2a$10$zYt0Sz2YulzbsDsQGRiF/OGcGSXVLpc0TynPcAXdmjPnMqiGeFsdu', '0', '0', '127.0.0.1', '2025-10-31 23:06:28', '2025-10-23 23:26:11', 'admin', '2025-10-23 20:05:54', '', '2025-10-23 23:26:11', NULL);
INSERT INTO `sys_user` VALUES (103, NULL, 'teacher-zhang', '张教授', '00', '', '', '0', '', '$2a$10$xC6mwj5wUnEBakPJrMKpnO32PDAZHIJH8gus7c8cr3URr8MiC7A0m', '0', '0', '127.0.0.1', '2025-10-31 23:24:00', '2025-10-31 16:33:32', 'admin', '2025-10-23 21:17:34', '', '2025-10-31 16:33:32', NULL);
INSERT INTO `sys_user` VALUES (104, NULL, 'student-xh', '小红', '00', '', '', '0', '', '$2a$10$7JlwRROReo28xfDFi62aZuL7ivgSAXp3FgM1wHz3TXSHubQ5KQj7K', '0', '0', '127.0.0.1', '2025-10-31 23:05:21', '2025-10-23 23:25:35', 'admin', '2025-10-23 21:18:13', 'admin', '2025-10-23 23:25:35', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 100);
INSERT INTO `sys_user_role` VALUES (101, 102);
INSERT INTO `sys_user_role` VALUES (102, 101);
INSERT INTO `sys_user_role` VALUES (103, 102);
INSERT INTO `sys_user_role` VALUES (104, 101);

-- ----------------------------
-- Table structure for tb_course
-- ----------------------------
DROP TABLE IF EXISTS `tb_course`;
CREATE TABLE `tb_course`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID（主键）',
  `course_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程编码（如JSJ001）',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `teacher_id` bigint NOT NULL COMMENT '授课教师ID（关联tb_teacher.id）',
  `max_students` int NULL DEFAULT 50 COMMENT '最大选课人数',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态（0-正常，1-停用）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `course_code`(`course_code` ASC) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tb_teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程信息表（教务员管理+教师授课关联）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_course
-- ----------------------------
INSERT INTO `tb_course` VALUES (1, 'JSJ001', 'Java程序设计', 1, 30, 0);
INSERT INTO `tb_course` VALUES (2, 'JSJ002', 'Python基础', 1, 40, 0);
INSERT INTO `tb_course` VALUES (3, 'DB001', '数据库原理', 2, 25, 0);
INSERT INTO `tb_course` VALUES (9, 'JSJ003', '操作系统', 3, 1, 0);

-- ----------------------------
-- Table structure for tb_score
-- ----------------------------
DROP TABLE IF EXISTS `tb_score`;
CREATE TABLE `tb_score`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '成绩ID（主键）',
  `course_id` bigint NOT NULL COMMENT '课程ID（关联tb_course.id）',
  `student_id` bigint NOT NULL COMMENT '学生ID（关联tb_student.id）',
  `score` decimal(5, 2) NULL DEFAULT NULL COMMENT '成绩（如85.5，NULL表示未录入）',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注（如缺考/缓考）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_course_student`(`course_id` ASC, `student_id` ASC) USING BTREE,
  INDEX `student_id`(`student_id` ASC) USING BTREE,
  CONSTRAINT `tb_score_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `tb_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_score_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `tb_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生成绩表（教师录入/修改成绩）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_score
-- ----------------------------
INSERT INTO `tb_score` VALUES (1, 1, 1, 88.00, NULL);
INSERT INTO `tb_score` VALUES (2, 1, 2, 76.50, NULL);
INSERT INTO `tb_score` VALUES (3, 2, 1, 92.00, NULL);
INSERT INTO `tb_score` VALUES (4, 2, 3, 0.00, '缺考');
INSERT INTO `tb_score` VALUES (5, 3, 2, 85.00, NULL);
INSERT INTO `tb_score` VALUES (6, 3, 4, 79.00, NULL);
INSERT INTO `tb_score` VALUES (12, 9, 1, 67.00, NULL);

-- ----------------------------
-- Table structure for tb_selection_exception
-- ----------------------------
DROP TABLE IF EXISTS `tb_selection_exception`;
CREATE TABLE `tb_selection_exception`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '异常ID（主键）',
  `course_id` bigint NOT NULL COMMENT '课程ID（关联tb_course.id）',
  `student_id` bigint NOT NULL COMMENT '学生ID（关联tb_student.id）',
  `exception_type` tinyint NOT NULL COMMENT '异常类型（1-重复选课，2-超员选课）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE,
  INDEX `student_id`(`student_id` ASC) USING BTREE,
  CONSTRAINT `tb_selection_exception_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `tb_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_selection_exception_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `tb_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '选课异常记录表（教务员处理重复/超员选课）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_selection_exception
-- ----------------------------
INSERT INTO `tb_selection_exception` VALUES (8, 1, 1, 1, '2025-10-31 23:02:10');
INSERT INTO `tb_selection_exception` VALUES (9, 9, 2, 2, '2025-10-31 23:02:39');
INSERT INTO `tb_selection_exception` VALUES (10, 1, 1, 1, '2025-10-31 23:04:50');

-- ----------------------------
-- Table structure for tb_student
-- ----------------------------
DROP TABLE IF EXISTS `tb_student`;
CREATE TABLE `tb_student`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '学生ID（主键）',
  `student_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学号（如S2023001）',
  `student_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学生姓名',
  `user_id` bigint NULL DEFAULT NULL COMMENT '关联系统用户ID（对应sys_user.id）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `student_no`(`student_no` ASC) USING BTREE,
  UNIQUE INDEX `uk_student_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生信息表（学生个人信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_student
-- ----------------------------
INSERT INTO `tb_student` VALUES (1, 'S2023001', '小明', 102);
INSERT INTO `tb_student` VALUES (2, 'S2023002', '小红', 104);
INSERT INTO `tb_student` VALUES (3, 'S2023003', '小李', 105);
INSERT INTO `tb_student` VALUES (4, 'S2023004', '小张', 106);

-- ----------------------------
-- Table structure for tb_student_selection
-- ----------------------------
DROP TABLE IF EXISTS `tb_student_selection`;
CREATE TABLE `tb_student_selection`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '选课ID（主键）',
  `course_id` bigint NOT NULL COMMENT '课程ID（关联tb_course.id）',
  `student_id` bigint NOT NULL COMMENT '学生ID（关联tb_student.id）',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态（0-已选，1-已退）',
  `select_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '选课时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_course_student`(`course_id` ASC, `student_id` ASC) USING BTREE,
  INDEX `student_id`(`student_id` ASC) USING BTREE,
  CONSTRAINT `tb_student_selection_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `tb_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_student_selection_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `tb_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生选课表（学生选课/退课记录）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_student_selection
-- ----------------------------
INSERT INTO `tb_student_selection` VALUES (1, 1, 1, 0, '2024-09-01 08:30:00');
INSERT INTO `tb_student_selection` VALUES (2, 1, 2, 0, '2024-09-01 08:35:00');
INSERT INTO `tb_student_selection` VALUES (3, 2, 1, 0, '2024-09-01 09:00:00');
INSERT INTO `tb_student_selection` VALUES (4, 2, 3, 0, '2024-09-01 09:05:00');
INSERT INTO `tb_student_selection` VALUES (5, 3, 2, 0, '2024-09-01 09:10:00');
INSERT INTO `tb_student_selection` VALUES (6, 3, 4, 0, '2024-09-01 09:15:00');
INSERT INTO `tb_student_selection` VALUES (14, 9, 1, 0, '2025-10-31 00:00:00');

-- ----------------------------
-- Table structure for tb_teacher
-- ----------------------------
DROP TABLE IF EXISTS `tb_teacher`;
CREATE TABLE `tb_teacher`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '教师ID（主键）',
  `teacher_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教师工号（如T001）',
  `teacher_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教师姓名',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职称（如教授/讲师）',
  `user_id` bigint NULL DEFAULT NULL COMMENT '关联系统用户ID（对应sys_user.id）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `teacher_no`(`teacher_no` ASC) USING BTREE,
  UNIQUE INDEX `uk_teacher_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教师信息表（教师个人信息+关联课程）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_teacher
-- ----------------------------
INSERT INTO `tb_teacher` VALUES (1, 'T001', '张教授', '教授', 103);
INSERT INTO `tb_teacher` VALUES (2, 'T002', '李讲师', '讲师', 101);
INSERT INTO `tb_teacher` VALUES (3, 'T003', '王讲师', '讲师', NULL);

SET FOREIGN_KEY_CHECKS = 1;
