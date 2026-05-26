/*
 Navicat Premium Dump SQL

 Source Server         : MyDatabase
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : exam_system

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 26/05/2026 23:07:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration_minutes` int NOT NULL COMMENT '考试时长（分钟）',
  `total_score` decimal(6, 2) NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `is_random` tinyint(1) NULL DEFAULT 0 COMMENT '是否随机抽题',
  `question_ids` json NULL COMMENT '固定试卷的题目ID列表',
  `rules` json NULL COMMENT '随机抽题规则',
  `status` enum('draft','published','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'draft',
  `created_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`exam_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES (1, 'Python基础测试', 60, 100.00, '2025-06-01 09:00:00', '2025-06-30 18:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (2, 'Python期中考试', 90, 100.00, '2025-05-20 14:00:00', '2025-05-20 16:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (3, 'Python期末考试', 120, 100.00, '2025-06-20 09:00:00', '2025-06-20 11:00:00', 1, NULL, '{\"fill\": 5, \"essay\": 5, \"judge\": 10, \"single\": 20, \"multiple\": 10}', 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (4, 'Java基础入门', 60, 100.00, '2025-06-10 10:00:00', '2025-06-10 11:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (5, 'Java面向对象', 90, 100.00, '2025-06-15 14:00:00', '2025-06-15 15:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (6, '数据库原理', 90, 100.00, '2025-06-12 09:00:00', '2025-06-12 10:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (7, 'SQL进阶练习', 60, 100.00, '2025-06-18 14:00:00', '2025-06-18 15:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (8, 'Web前端基础', 60, 100.00, '2025-06-22 09:00:00', '2025-06-22 10:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (9, 'JavaScript高级', 90, 100.00, '2025-06-25 14:00:00', '2025-06-25 15:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]', NULL, 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (10, 'Vue框架实战', 120, 100.00, '2025-07-01 09:00:00', '2025-07-01 11:00:00', 1, NULL, '{\"fill\": 5, \"essay\": 5, \"judge\": 5, \"single\": 25, \"multiple\": 10}', 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (11, '数据结构', 90, 100.00, '2025-05-25 10:00:00', '2025-05-25 11:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (12, '算法设计', 120, 100.00, '2025-07-05 14:00:00', '2025-07-05 16:00:00', 1, NULL, '{\"fill\": 5, \"essay\": 10, \"judge\": 5, \"single\": 20, \"multiple\": 5}', 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (13, '操作系统', 90, 100.00, '2025-05-28 09:00:00', '2025-05-28 10:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (14, '计算机网络', 90, 100.00, '2025-06-08 14:00:00', '2025-06-08 15:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (15, '软件工程', 60, 100.00, '2025-07-10 09:00:00', '2025-07-10 10:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', NULL, 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (16, '项目管理', 60, 100.00, '2025-07-12 14:00:00', '2025-07-12 15:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', NULL, 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (17, 'Python爬虫技术', 90, 100.00, '2025-06-28 09:00:00', '2025-06-28 10:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (18, '数据分析入门', 60, 100.00, '2025-07-08 14:00:00', '2025-07-08 15:00:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', NULL, 'published', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (19, '机器学习基础', 120, 100.00, '2025-07-15 09:00:00', '2025-07-15 11:00:00', 1, NULL, '{\"fill\": 5, \"judge\": 5, \"single\": 30, \"multiple\": 10}', 'draft', 1, '2026-05-26 22:06:25');
INSERT INTO `exam` VALUES (20, '毕业设计指导', 90, 100.00, '2025-07-20 14:00:00', '2025-07-20 15:30:00', 0, '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]', NULL, 'draft', 1, '2026-05-26 22:06:25');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `type` enum('single','multiple','judge','fill','essay') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题干',
  `options` json NULL COMMENT '选项（JSON数组）',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参考答案',
  `analysis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '解析',
  `difficulty` tinyint NULL DEFAULT 1 COMMENT '1-5',
  `score` decimal(5, 2) NOT NULL,
  `tags` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '知识点标签',
  `created_by` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`question_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, 'single', 'Python中用于输出内容到控制台的函数是？', '{\"A\": \"print()\", \"B\": \"input()\", \"C\": \"len()\", \"D\": \"range()\"}', 'A', 'print()是Python中用于输出的内置函数', 1, 5.00, NULL, NULL, '2026-05-26 20:49:33');
INSERT INTO `question` VALUES (2, 'multiple', '下列哪些是Python的数据类型？', '{\"A\": \"int\", \"B\": \"str\", \"C\": \"float\", \"D\": \"char\"}', 'A,B,C', 'Python中int、str、float都是基本数据类型，char不存在', 2, 5.00, NULL, NULL, '2026-05-26 20:49:33');
INSERT INTO `question` VALUES (3, 'judge', 'Python是编译型语言。', NULL, 'False', 'Python是解释型语言，不是编译型语言', 1, 3.00, NULL, NULL, '2026-05-26 20:49:33');
INSERT INTO `question` VALUES (4, 'fill', 'Python中定义函数的关键字是______。', NULL, 'def', 'def是Python中定义函数的关键字', 1, 4.00, NULL, NULL, '2026-05-26 20:49:33');
INSERT INTO `question` VALUES (5, 'essay', '简述面向对象编程的三个主要特性。', NULL, '封装、继承、多态', '封装：隐藏内部实现细节；继承：子类复用父类属性和方法；多态：同一接口不同实现', 3, 10.00, NULL, NULL, '2026-05-26 20:49:33');
INSERT INTO `question` VALUES (6, 'single', 'Python中用于输出内容到控制台的函数是？', '{\"A\": \"print()\", \"B\": \"input()\", \"C\": \"len()\", \"D\": \"range()\"}', 'A', 'print()是Python中用于输出的内置函数', 1, 5.00, NULL, NULL, '2026-05-26 20:57:57');
INSERT INTO `question` VALUES (7, 'multiple', '下列哪些是Python的数据类型？', '{\"A\": \"int\", \"B\": \"str\", \"C\": \"float\", \"D\": \"char\"}', 'A,B,C', 'Python中int、str、float都是基本数据类型，char不存在', 2, 5.00, NULL, NULL, '2026-05-26 20:57:57');
INSERT INTO `question` VALUES (8, 'judge', 'Python是编译型语言。', NULL, 'False', 'Python是解释型语言，不是编译型语言', 1, 3.00, NULL, NULL, '2026-05-26 20:57:57');
INSERT INTO `question` VALUES (9, 'fill', 'Python中定义函数的关键字是______。', NULL, 'def', 'def是Python中定义函数的关键字', 1, 4.00, NULL, NULL, '2026-05-26 20:57:57');
INSERT INTO `question` VALUES (10, 'essay', '简述面向对象编程的三个主要特性。', NULL, '封装、继承、多态', '封装：隐藏内部实现细节；继承：子类复用父类属性和方法；多态：同一接口不同实现', 3, 10.00, NULL, NULL, '2026-05-26 20:57:57');
INSERT INTO `question` VALUES (11, 'single', 'Python中用于输出内容到控制台的函数是？', '{\"A\": \"print()\", \"B\": \"input()\", \"C\": \"len()\", \"D\": \"range()\"}', 'A', 'print()是Python中用于输出的内置函数', 1, 5.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (12, 'multiple', '下列哪些是Python的数据类型？', '{\"A\": \"int\", \"B\": \"str\", \"C\": \"float\", \"D\": \"char\"}', 'A,B,C', 'Python中int、str、float都是基本数据类型，char不存在', 2, 5.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (13, 'judge', 'Python是编译型语言。', NULL, 'False', 'Python是解释型语言，不是编译型语言', 1, 3.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (14, 'fill', 'Python中定义函数的关键字是______。', NULL, 'def', 'def是Python中定义函数的关键字', 1, 4.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (15, 'essay', '简述面向对象编程的三个主要特性。', NULL, '封装、继承、多态', '封装：隐藏内部实现细节；继承：子类复用父类属性和方法；多态：同一接口不同实现', 3, 10.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (16, 'single', 'Python中用于输出内容到控制台的函数是？', '{\"A\": \"print()\", \"B\": \"input()\", \"C\": \"len()\", \"D\": \"range()\"}', 'A', 'print()是Python中用于输出的内置函数', 1, 5.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (17, 'multiple', '下列哪些是Python的数据类型？', '{\"A\": \"int\", \"B\": \"str\", \"C\": \"float\", \"D\": \"char\"}', 'A,B,C', 'Python中int、str、float都是基本数据类型，char不存在', 2, 5.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (18, 'judge', 'Python是编译型语言。', NULL, 'False', 'Python是解释型语言，不是编译型语言', 1, 3.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (19, 'fill', 'Python中定义函数的关键字是______。', NULL, 'def', 'def是Python中定义函数的关键字', 1, 4.00, NULL, NULL, '2026-05-26 20:57:58');
INSERT INTO `question` VALUES (20, 'essay', '简述面向对象编程的三个主要特性。', NULL, '封装、继承、多态', '封装：隐藏内部实现细节；继承：子类复用父类属性和方法；多态：同一接口不同实现', 3, 10.00, NULL, NULL, '2026-05-26 20:57:58');

-- ----------------------------
-- Table structure for submission
-- ----------------------------
DROP TABLE IF EXISTS `submission`;
CREATE TABLE `submission`  (
  `submission_id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int NOT NULL,
  `user_id` int NOT NULL,
  `answers` json NULL COMMENT '答案（题目ID->答案）',
  `score` decimal(6, 2) NULL DEFAULT NULL,
  `detail` json NULL COMMENT '每道题的得分详情',
  `start_time` datetime NULL DEFAULT NULL,
  `submit_time` datetime NULL DEFAULT NULL,
  `status` enum('in_progress','submitted','auto_saved') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'in_progress',
  PRIMARY KEY (`submission_id`) USING BTREE,
  INDEX `idx_exam_user`(`exam_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of submission
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学号/工号',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_type` enum('student','teacher','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'student',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'active',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uk_account`(`account` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '20240001', '张三', '$2b$12$...', 'student', NULL, NULL, 'active', '2026-05-26 15:14:18');
INSERT INTO `user` VALUES (2, 'teacher01', '李老师', '$2b$12$...', 'teacher', NULL, NULL, 'active', '2026-05-26 15:14:18');
INSERT INTO `user` VALUES (3, '20250001', '测试学生', '$2b$12$xvD4Y4ZEgmKJg2cUaV7zAexIsJBB6/BjI2baNjsBpy6cys1Nx.Q5y', 'student', '13912345678', 'test@example.com', 'active', '2026-05-26 15:54:38');

SET FOREIGN_KEY_CHECKS = 1;
