
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `gf_verify_admin`
--

-- --------------------------------------------------------

--
-- 表的结构 `casbin_rule`
--

CREATE TABLE `casbin_rule` (
  `ptype` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v0` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v1` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v2` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v3` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v4` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v5` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `casbin_rule`
--

INSERT INTO `casbin_rule` (`ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES
('p', '1', '10', 'All', '', '', ''),
('p', '1', '12', 'All', '', '', ''),
('p', '1', '13', 'All', '', '', ''),
('p', '1', '14', 'All', '', '', ''),
('g', '42', '1', '', '', '', ''),
('g', '42', '2', '', '', '', ''),
('g', '1', '1', '', '', '', ''),
('g', '1', '2', '', '', '', ''),
('g', '2', '3', '', '', '', ''),
('g', '2', '2', '', '', '', ''),
('g', '4', '2', '', '', '', ''),
('g', '5', '2', '', '', '', ''),
('g', '7', '2', '', '', '', ''),
('g', '8', '2', '', '', '', ''),
('g', '10', '2', '', '', '', ''),
('g', '14', '2', '', '', '', ''),
('g', '15', '2', '', '', '', ''),
('g', '16', '2', '', '', '', ''),
('p', '1', '1', 'All', '', '', ''),
('g', '6', '2', '', '', '', ''),
('g', '3', '2', '', '', '', ''),
('g', 'u_43', '9', '', '', '', ''),
('g', 'u_44', '9', '', '', '', ''),
('g', 'u_1', '1', '', '', '', ''),
('p', '1', '34', 'All', '', '', ''),
('p', '9', '34', 'All', '', '', ''),
('p', '9', '36', 'All', '', '', ''),
('p', '1', '36', 'All', '', '', ''),
('p', '1', '35', 'All', '', '', ''),
('p', '9', '35', 'All', '', '', ''),
('p', '1', '37', 'All', '', '', ''),
('p', '9', '37', 'All', '', '', ''),
('p', '1', '38', 'All', '', '', ''),
('p', '9', '38', 'All', '', '', ''),
('p', '1', '39', 'All', '', '', ''),
('p', '9', '39', 'All', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `sys_auth_rule`
--

CREATE TABLE `sys_auth_rule` (
  `id` int UNSIGNED NOT NULL,
  `pid` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `menu_type` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型 0目录 1菜单 2按钮',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `is_hide` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '显示状态',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `is_link` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否外链 1是 0否',
  `module_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所属模块',
  `model_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '模型ID',
  `is_iframe` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否内嵌iframe',
  `is_cached` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否缓存',
  `redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由重定向地址',
  `is_affix` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否固定',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '链接地址',
  `created_at` datetime DEFAULT NULL COMMENT '创建日期',
  `updated_at` datetime DEFAULT NULL COMMENT '修改日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单节点表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `sys_auth_rule`
--

INSERT INTO `sys_auth_rule` (`id`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `menu_type`, `weigh`, `is_hide`, `path`, `component`, `is_link`, `module_type`, `model_id`, `is_iframe`, `is_cached`, `redirect`, `is_affix`, `link_url`, `created_at`, `updated_at`) VALUES
(1, 0, 'api/v1/system/auth', '权限管理', 'ele-Stamp', '', '', 0, 30, 0, '/system/auth', 'layout/routerView/parent', 0, '', 0, 0, 1, '0', 0, '', '2022-03-24 15:03:37', '2022-04-14 16:29:19'),
(2, 1, 'api/v1/system/auth/menuList', '菜单管理', 'ele-Calendar', '', '', 1, 0, 0, '/system/auth/menuList', 'system/menu/index', 0, '', 0, 0, 1, '', 0, '', '2022-03-24 17:24:13', '2022-09-12 21:37:01'),
(3, 2, 'api/v1/system/menu/add', '添加菜单', '', '', '', 2, 0, 0, '', '', 0, '', 0, 0, 1, '', 0, '', '2022-03-29 16:48:43', '2022-03-29 17:05:19'),
(4, 2, 'api/v1/system/menu/update', '修改菜单', '', '', '', 2, 0, 0, '', '', 0, '', 0, 0, 1, '', 0, '', '2022-03-29 17:04:25', '2022-03-29 18:11:36'),
(10, 1, 'api/v1/system/role/list', '角色管理', 'iconfont icon-juxingkaobei', '', '', 1, 0, 0, '/system/auth/roleList', 'system/role/index', 0, '', 0, 0, 1, '', 0, '', '2022-03-29 18:15:03', '2022-03-30 10:25:34'),
(11, 2, 'api/v1/system/menu/delete', '删除菜单', '', '', '', 2, 0, 0, '', '', 0, '', 0, 0, 1, '', 0, '', '2022-04-06 14:49:10', '2022-04-06 14:49:17'),
(12, 10, 'api/v1/system/role/add', '添加角色', '', '', '', 2, 0, 0, '', '', 0, '', 0, 0, 1, '', 0, '', '2022-04-06 14:49:46', '2022-04-06 14:49:46'),
(13, 10, '/api/v1/system/role/edit', '修改角色', '', '', '', 2, 0, 0, '', '', 0, '', 0, 0, 1, '', 0, '', '2022-04-06 14:50:08', '2022-04-06 14:50:08'),
(14, 10, '/api/v1/system/role/delete', '删除角色', '', '', '', 2, 0, 0, '', '', 0, '', 0, 0, 1, '', 0, '', '2022-04-06 14:50:22', '2022-04-06 14:50:22'),
(26, 1, 'api/v1/system/user/list', '用户管理', 'ele-User', '', '', 1, 0, 0, '/system/auth/user/list', 'system/user/index', 0, '', 0, 0, 1, '', 0, '', '2022-04-09 14:19:10', '2022-04-09 14:19:58'),
(27, 0, 'api/v1/system/dict', '系统配置', 'iconfont icon-shuxingtu', '', '', 0, 40, 0, '/system/dict', 'layout/routerView/parent', 0, '', 0, 0, 1, '654', 0, '', '2022-04-14 16:28:51', '2022-04-18 14:40:56'),
(28, 27, 'api/v1/system/dict/type/list', '字典管理', 'iconfont icon-crew_feature', '', '', 1, 0, 0, '/system/dict/type/list', 'system/dict/index', 0, '', 0, 0, 1, '', 0, '', '2022-04-14 16:32:10', '2022-04-16 17:02:50'),
(29, 27, 'api/v1/system/dict/dataList', '字典数据管理', 'iconfont icon-putong', '', '', 1, 0, 1, '/system/dict/data/list/:dictType', 'system/dict/dataList', 0, '', 0, 0, 1, '', 0, '', '2022-04-18 12:04:17', '2022-09-17 15:56:16'),
(30, 27, 'api/v1/system/config/list', '参数管理', 'ele-Cherry', '', '', 1, 0, 0, '/system/config/list', 'system/config/index', 0, '', 0, 0, 1, '', 0, '', '2022-04-18 21:05:20', '2022-04-18 21:13:19'),
(31, 0, 'api/v1/system/monitor', '系统监控', 'iconfont icon-xuanzeqi', '', '', 0, 30, 0, '/system/monitor', 'layout/routerView/parent', 0, '', 0, 0, 1, '', 0, '', '2022-04-19 10:40:19', '2022-09-13 17:15:08'),
(32, 31, 'api/v1/system/monitor/server', '服务监控', 'iconfont icon-shuju', '', '', 1, 0, 0, '/system/monitor/server', 'system/monitor/server/index', 0, '', 0, 0, 1, '', 0, '', '2022-04-19 10:43:32', '2022-04-19 10:44:47'),
(33, 31, 'api/swagger', 'api文档', 'iconfont icon--chaifenlie', '', '', 1, 0, 0, '/system/swagger', 'layout/routerView/iframes', 1, '', 0, 1, 1, '', 0, 'http://localhost:8201/swagger', '2022-04-21 09:23:43', '2022-04-21 11:19:49'),
(34, 0, 'api/v1/verify/software', '软件管理', 'iconfont icon-juxingkaobei', '', '', 0, 4, 0, '/verify/software', 'layout/routerView/parent', 0, '', 0, 0, 1, '', 0, '', '2022-09-12 23:44:12', '2022-09-13 09:15:14'),
(35, 34, 'api/v1/verify/software/list', '软件列表', 'iconfont icon-ico', '', '', 1, 20, 0, '/verify/software/list', 'verify/software/index', 0, '', 0, 0, 1, '', 0, '', '2022-09-13 08:52:37', '2022-09-13 15:04:39'),
(36, 34, 'api/v1/verify/version/list', '版本列表', 'iconfont icon-jiliandongxuanzeqi', '', '', 1, 10, 0, '/verify/version/list', 'verify/version/index', 0, '', 0, 0, 1, '', 0, '', '2022-09-13 12:32:27', '2022-09-13 15:04:36'),
(37, 0, 'api/v1/verify/card', '卡密管理', 'fa fa-newspaper-o', '', '', 0, 3, 0, '/verify/card', 'layout/routerView/parent', 0, '', 0, 0, 1, '', 0, '', '2022-09-13 15:18:21', '2022-09-13 15:19:56'),
(38, 37, 'api/v1/verify/card/list', '卡密列表', 'fa fa-diamond', '', '', 1, 0, 0, '/verify/card/list', 'verify/card/index', 0, '', 0, 0, 1, '1', 0, '', '2022-09-13 15:20:13', '2022-09-13 15:38:58'),
(39, 37, '/api/v1/verify/card-session/list', '在线设备', 'iconfont icon-diannao1', '', '', 1, 0, 0, '/verify/card-session/list', 'verify/cardSession/index', 0, '', 0, 0, 1, '1', 0, '', '2022-09-13 15:22:08', '2022-09-13 16:18:05');

-- --------------------------------------------------------

--
-- 表的结构 `sys_config`
--

CREATE TABLE `sys_config` (
  `config_id` int UNSIGNED NOT NULL COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` tinyint(1) DEFAULT '0' COMMENT '系统内置（Y是 N否）',
  `create_by` int UNSIGNED DEFAULT '0' COMMENT '创建者',
  `update_by` int UNSIGNED DEFAULT '0' COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `sys_config`
--

INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`) VALUES
(1, '文件上传-文件大小', 'sys.uploadFile.fileSize', '50M', 1, 31, 31, '文件上传大小限制', NULL, '2021-07-06 14:57:35'),
(2, '文件上传-文件类型', 'sys.uploadFile.fileType', 'doc,docx,zip,xls,xlsx,rar,jpg,jpeg,gif,npm,png', 1, 31, 31, '文件上传后缀类型限制', NULL, NULL),
(3, '图片上传-图片类型', 'sys.uploadFile.imageType', 'jpg,jpeg,gif,npm,png', 1, 31, 0, '图片上传后缀类型限制', NULL, NULL),
(4, '图片上传-图片大小', 'sys.uploadFile.imageSize', '50M', 1, 31, 31, '图片上传大小限制', NULL, NULL),
(11, '静态资源', 'static.resource', '/', 1, 2, 0, '', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `sys_dict_data`
--

CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认（1是 0否）',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` bigint UNSIGNED DEFAULT '0' COMMENT '创建者',
  `update_by` bigint UNSIGNED DEFAULT '0' COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `sys_dict_data`
--

INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`) VALUES
(1, 0, '男', '1', 'sys_user_sex', '', 'warning', 0, 1, 31, 1, '备注信息', '2022-04-18 16:46:22', '2022-09-18 14:00:24'),
(2, 0, '女', '2', 'sys_user_sex', '', '', 0, 1, 31, 31, '备注信息', NULL, '2022-09-17 16:12:20'),
(3, 0, '保密', '0', 'sys_user_sex', '', '', 1, 1, 31, 31, '备注信息', NULL, '2022-09-17 16:12:20'),
(24, 0, '频道页', '1', 'cms_category_type', '', '', 0, 1, 31, 31, '作为频道页，不可作为栏目发布文章，可添加下级分类', NULL, '2021-07-21 10:54:22'),
(25, 0, '发布栏目', '2', 'cms_category_type', '', '', 0, 1, 31, 31, '作为发布栏目，可添加文章', NULL, '2021-07-21 10:54:22'),
(26, 0, '跳转栏目', '3', 'cms_category_type', '', '', 0, 1, 31, 31, '不直接发布内容，用于跳转页面', NULL, '2021-07-21 10:54:22'),
(27, 0, '单页栏目', '4', 'cms_category_type', '', '', 0, 1, 31, 31, '单页面模式，分类直接显示为文章', NULL, '2021-07-21 10:54:22'),
(28, 0, '正常', '0', 'sys_job_status', '', 'default', 1, 1, 31, 0, '', NULL, NULL),
(29, 0, '暂停', '1', 'sys_job_status', '', 'default', 0, 1, 31, 31, '', NULL, NULL),
(30, 0, '默认', 'DEFAULT', 'sys_job_group', '', 'default', 1, 1, 31, 0, '', NULL, NULL),
(31, 0, '系统', 'SYSTEM', 'sys_job_group', '', 'default', 0, 1, 31, 0, '', NULL, NULL),
(32, 0, '成功', '1', 'admin_login_status', '', 'default', 0, 1, 31, 31, '', NULL, NULL),
(33, 0, '失败', '0', 'admin_login_status', '', 'default', 0, 1, 31, 0, '', NULL, NULL),
(34, 0, '成功', '1', 'sys_oper_log_status', '', 'default', 0, 1, 31, 0, '', NULL, NULL),
(35, 0, '失败', '0', 'sys_oper_log_status', '', 'default', 0, 1, 31, 0, '', NULL, NULL),
(36, 0, '重复执行', '1', 'sys_job_policy', '', 'default', 1, 1, 31, 0, '', NULL, NULL),
(37, 0, '执行一次', '2', 'sys_job_policy', '', 'default', 1, 1, 31, 0, '', NULL, NULL),
(38, 0, '显示', '0', 'sys_show_hide', NULL, 'default', 1, 1, 31, 0, NULL, NULL, NULL),
(39, 0, '隐藏', '1', 'sys_show_hide', NULL, 'default', 0, 1, 31, 0, NULL, NULL, NULL),
(40, 0, '正常', '1', 'sys_normal_disable', '', 'default', 1, 1, 31, 0, '', NULL, NULL),
(41, 0, '停用', '0', 'sys_normal_disable', '', 'default', 0, 1, 31, 0, '', NULL, NULL),
(49, 1, '是', '1', 'sys_yes_no', '', 'success', 1, 1, 31, 1, '', NULL, '2022-09-18 15:04:59'),
(50, 0, '否', '0', 'sys_yes_no', '', 'warning', 0, 1, 31, 1, '', NULL, '2022-09-18 15:02:11'),
(51, 0, '已发布', '1', 'cms_article_pub_type', '', '', 1, 1, 31, 31, '', NULL, NULL),
(54, 0, '未发布', '0', 'cms_article_pub_type', '', '', 0, 1, 31, 0, '', NULL, NULL),
(55, 0, '置顶', '1', 'cms_article_attr', '', '', 0, 1, 31, 0, '', NULL, NULL),
(56, 0, '推荐', '2', 'cms_article_attr', '', '', 0, 1, 31, 0, '', NULL, NULL),
(57, 0, '普通文章', '0', 'cms_article_type', '', '', 0, 1, 31, 31, '', NULL, NULL),
(58, 0, '跳转链接', '1', 'cms_article_type', '', '', 0, 1, 31, 31, '', NULL, NULL),
(59, 0, 'cms模型', '6', 'cms_cate_models', '', '', 0, 1, 1, 1, '', NULL, NULL),
(61, 0, '政府工作目标', '1', 'gov_cate_models', '', '', 0, 1, 2, 0, '', NULL, NULL),
(62, 0, '系统后台', 'sys_admin', 'menu_module_type', '', '', 1, 1, 2, 0, '', NULL, NULL),
(63, 0, '政务工作', 'gov_work', 'menu_module_type', '', '', 0, 1, 2, 0, '', NULL, NULL),
(64, 0, '幻灯', '3', 'cms_article_attr', '', '', 0, 1, 31, 0, '', NULL, NULL),
(65, 0, '[work]测试业务表', 'wf_news', 'flow_type', '', '', 0, 1, 2, 2, '', NULL, NULL),
(66, 0, '回退修改', '-1', 'flow_status', '', '', 0, 1, 31, 0, '', NULL, NULL),
(67, 0, '保存中', '0', 'flow_status', '', '', 0, 1, 31, 0, '', NULL, NULL),
(68, 0, '流程中', '1', 'flow_status', '', '', 0, 1, 31, 0, '', NULL, NULL),
(69, 0, '审批通过', '2', 'flow_status', '', '', 0, 1, 31, 2, '', NULL, NULL),
(70, 2, '发布栏目', '2', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(71, 3, '跳转栏目', '3', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(72, 4, '单页栏目', '4', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(73, 2, '置顶', '1', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(74, 3, '幻灯', '2', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(75, 4, '推荐', '3', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(76, 1, '一般', '0', 'sys_log_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(77, 1, '频道页', '1', 'sys_blog_sign', '', '', 0, 1, 31, 31, '', NULL, NULL),
(78, 0, '普通', '0', 'flow_level', '', '', 0, 1, 31, 0, '', NULL, '2021-07-20 08:55:20'),
(79, 0, '加急', '1', 'flow_level', '', '', 0, 1, 31, 0, '', NULL, '2021-07-20 08:55:20'),
(80, 0, '紧急', '2', 'flow_level', '', '', 0, 1, 31, 0, '', NULL, '2021-07-20 08:55:20'),
(81, 0, '特急', '3', 'flow_level', '', '', 0, 1, 31, 31, '', NULL, '2021-07-20 08:55:25'),
(82, 0, '频道页', '1', 'sys_blog_type', '', '', 0, 1, 31, 0, '', NULL, NULL),
(83, 0, '发布栏目', '2', 'sys_blog_type', '', '', 0, 1, 31, 0, '', NULL, NULL),
(84, 0, '跳转栏目', '3', 'sys_blog_type', '', '', 0, 1, 31, 31, '', NULL, NULL),
(85, 0, '单页栏目', '4', 'sys_blog_type', '', '', 0, 1, 31, 0, '', NULL, NULL),
(87, 0, '[cms]文章表', 'cms_news', 'flow_type', '', '', 0, 1, 31, 0, '', NULL, NULL),
(91, 0, '测试一下', '666', 'cms_article_type', '', '', 0, 1, 31, 0, '', '2021-08-03 17:04:12', '2021-08-03 17:04:12'),
(92, 0, '缓存测试222', '33333', 'cms_article_type', '', '', 0, 1, 31, 31, '', '2021-08-03 17:16:45', '2021-08-03 17:19:41'),
(93, 0, '缓存测试222', '11111', 'cms_article_type', '', '', 0, 1, 31, 31, '', '2021-08-03 17:26:14', '2021-08-03 17:26:26'),
(94, 0, '1折', '10', 'plugin_store_discount', '', '', 0, 1, 31, 0, '', '2021-08-14 11:59:38', '2021-08-14 11:59:38'),
(95, 0, '5折', '50', 'plugin_store_discount', '', '', 0, 1, 31, 0, '', '2021-08-14 11:59:49', '2021-08-14 11:59:49'),
(96, 0, '8折', '80', 'plugin_store_discount', '', '', 0, 1, 31, 0, '', '2021-08-14 12:00:00', '2021-08-14 12:00:00'),
(97, 0, '9折', '90', 'plugin_store_discount', '', '', 0, 1, 31, 0, '', '2021-08-14 12:00:07', '2021-08-14 12:00:07'),
(98, 0, '无折扣', '100', 'plugin_store_discount', '', '', 0, 1, 31, 0, '', '2021-08-14 12:00:16', '2021-08-14 12:00:16'),
(99, 0, '不显示', 'none', 'cms_nav_position', '', '', 1, 1, 22, 0, '', '2021-08-31 15:37:35', '2021-08-31 15:37:35'),
(100, 0, '顶部导航', 'top', 'cms_nav_position', '', '', 0, 1, 22, 0, '', '2021-08-31 15:37:57', '2021-08-31 15:37:57'),
(101, 0, '底部导航', 'bottom', 'cms_nav_position', '', '', 0, 1, 22, 0, '', '2021-08-31 15:38:08', '2021-08-31 15:38:08'),
(102, 1, '数据库', '1', 'verify_version_store_type', '', 'info', 0, 1, 1, 1, '', '2022-09-13 13:31:32', '2022-09-18 15:01:12'),
(103, 2, '文件直连', '2', 'verify_version_store_type', '', 'success', 0, 1, 1, 1, '', '2022-09-13 13:31:40', '2022-09-18 15:01:17'),
(104, 3, '蓝奏云', '3', 'verify_version_store_type', '', 'warning', 0, 1, 1, 1, '', '2022-09-13 13:31:47', '2022-09-18 15:01:46'),
(105, 1, '分钟卡', '1', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:45:59', '2022-09-14 12:45:59'),
(106, 2, '小时卡', '2', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:46:09', '2022-09-14 12:46:09'),
(107, 3, '天卡', '3', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:46:15', '2022-09-14 12:46:15'),
(108, 4, '月卡', '4', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:46:22', '2022-09-14 12:46:22'),
(109, 5, '季卡', '5', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:46:30', '2022-09-14 12:46:30'),
(110, 6, '半年卡', '6', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:46:40', '2022-09-14 12:46:40'),
(111, 7, '年卡', '7', 'verify_card_value_type', '', '', 0, 1, 1, 0, '', '2022-09-14 12:46:50', '2022-09-14 12:46:50'),
(112, 1, '启用', '1', 'common_status', '', 'success', 0, 1, 1, 1, '', '2022-09-18 11:22:14', '2022-09-18 15:03:09'),
(113, 0, '禁用', '0', 'common_status', '', 'danger', 0, 1, 1, 1, '', '2022-09-18 11:22:24', '2022-09-18 15:03:04');

-- --------------------------------------------------------

--
-- 表的结构 `sys_dict_type`
--

CREATE TABLE `sys_dict_type` (
  `dict_id` bigint UNSIGNED NOT NULL COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` tinyint UNSIGNED DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` int UNSIGNED DEFAULT '0' COMMENT '创建者',
  `update_by` int UNSIGNED DEFAULT '0' COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建日期',
  `updated_at` datetime DEFAULT NULL COMMENT '修改日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `sys_dict_type`
--

INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `update_by`, `remark`, `created_at`, `updated_at`) VALUES
(1, '用户性别', 'sys_user_sex', 1, 31, 1, '用于选择用户性别', NULL, '2022-09-17 16:12:20'),
(2, '分类类型', 'cms_category_type', 1, 31, 3, '文章分类类型', NULL, '2021-07-21 10:54:22'),
(3, '任务状态', 'sys_job_status', 1, 31, 31, '任务状态列表', NULL, NULL),
(13, '任务分组', 'sys_job_group', 1, 31, 0, '', NULL, NULL),
(14, '管理员登录状态', 'admin_login_status', 1, 31, 0, '', NULL, NULL),
(15, '操作日志状态', 'sys_oper_log_status', 1, 31, 0, '', NULL, NULL),
(16, '任务策略', 'sys_job_policy', 1, 31, 0, '', NULL, NULL),
(17, '菜单状态', 'sys_show_hide', 1, 31, 0, '菜单状态', NULL, NULL),
(18, '系统开关', 'sys_normal_disable', 1, 31, 31, '系统开关', NULL, NULL),
(24, '系统内置', 'sys_yes_no', 1, 31, 0, '', NULL, NULL),
(25, '文章发布状态', 'cms_article_pub_type', 1, 31, 0, '', NULL, NULL),
(26, '文章附加状态', 'cms_article_attr', 1, 31, 0, '', NULL, NULL),
(27, '文章类型', 'cms_article_type', 1, 31, 0, '', NULL, NULL),
(28, '文章栏目模型分类', 'cms_cate_models', 1, 1, 0, '', NULL, NULL),
(29, '政务工作模型分类', 'gov_cate_models', 1, 2, 0, '', NULL, NULL),
(30, '菜单模块类型', 'menu_module_type', 1, 2, 0, '', NULL, NULL),
(31, '工作流程类型', 'flow_type', 1, 2, 0, '', NULL, NULL),
(32, '工作流程审批状态', 'flow_status', 1, 31, 0, '工作流程审批状态', NULL, NULL),
(33, '博客分类类型', 'sys_blog_type', 1, 31, 31, '博客分类中的标志', NULL, NULL),
(34, '博客日志标志', 'sys_log_sign', 1, 31, 0, '博客日志管理中的标志数据字典', NULL, NULL),
(35, '工作流紧急状态', 'flow_level', 1, 31, 31, '', NULL, '2021-07-20 08:55:20'),
(48, '插件商城折扣', 'plugin_store_discount', 1, 31, 0, '', '2021-08-14 11:59:26', '2021-08-14 11:59:26'),
(49, 'CMS栏目导航位置', 'cms_nav_position', 1, 22, 0, '', '2021-08-31 15:37:04', '2021-08-31 15:37:04'),
(50, '版本文件存储方式', 'verify_version_store_type', 1, 1, 1, '', '2022-09-13 13:31:15', '2022-09-18 14:43:54'),
(51, '卡密面值类型', 'verify_card_value_type', 1, 1, 0, '', '2022-09-14 12:45:33', '2022-09-14 12:45:33'),
(52, '公共状态', 'common_status', 1, 1, 0, '', '2022-09-18 11:21:54', '2022-09-18 11:21:54');

-- --------------------------------------------------------

--
-- 表的结构 `sys_login_log`
--

CREATE TABLE `sys_login_log` (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` tinyint DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `module` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录模块'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `sys_login_log`
--

INSERT INTO `sys_login_log` (`info_id`, `login_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`, `module`) VALUES
(449, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 12:14:56', '系统后台'),
(450, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 14:23:14', '系统后台'),
(451, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 14:23:21', '系统后台'),
(452, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 14:25:13', '系统后台'),
(453, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:30:17', '系统后台'),
(454, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:31:42', '系统后台'),
(455, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:32:30', '系统后台'),
(456, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:39:41', '系统后台'),
(457, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:39:45', '系统后台'),
(458, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:41:04', '系统后台'),
(459, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:42:08', '系统后台'),
(460, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:45:02', '系统后台'),
(461, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:45:13', '系统后台'),
(462, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:45:45', '系统后台'),
(463, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:45:46', '系统后台'),
(464, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:46:05', '系统后台'),
(465, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:46:06', '系统后台'),
(466, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:47:14', '系统后台'),
(467, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:47:42', '系统后台'),
(468, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 17:47:42', '系统后台'),
(469, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:02:21', '系统后台'),
(470, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:03:09', '系统后台'),
(471, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:04:29', '系统后台'),
(472, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:06:28', '系统后台'),
(473, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:08:37', '系统后台'),
(474, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:08:39', '系统后台'),
(475, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:10:19', '系统后台'),
(476, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:15:32', '系统后台'),
(477, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:18:00', '系统后台'),
(478, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:18:13', '系统后台'),
(479, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-08 18:24:46', '系统后台'),
(480, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 09:22:39', '系统后台'),
(481, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 11:04:08', '系统后台'),
(482, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 11:09:06', '系统后台'),
(483, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 15:50:29', '系统后台'),
(484, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 15:51:35', '系统后台'),
(485, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 15:52:24', '系统后台'),
(486, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 15:53:34', '系统后台'),
(487, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 16:54:59', '系统后台'),
(488, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 16:58:24', '系统后台'),
(489, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 16:59:12', '系统后台'),
(490, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 17:02:25', '系统后台'),
(491, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 17:03:27', '系统后台'),
(492, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-09 17:05:14', '系统后台'),
(493, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:21:43', '系统后台'),
(494, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:22:03', '系统后台'),
(495, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:22:05', '系统后台'),
(496, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:31:53', '系统后台'),
(497, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:32:18', '系统后台'),
(498, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:39:56', '系统后台'),
(499, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:55:59', '系统后台'),
(500, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:56:15', '系统后台'),
(501, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:58:30', '系统后台'),
(502, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:58:51', '系统后台'),
(503, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 10:59:58', '系统后台'),
(504, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 11:01:00', '系统后台'),
(505, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 11:01:24', '系统后台'),
(506, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:32:00', '系统后台'),
(507, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:34:53', '系统后台'),
(508, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:34:55', '系统后台'),
(509, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:35:06', '系统后台'),
(510, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:35:37', '系统后台'),
(511, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:36:21', '系统后台'),
(512, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:36:23', '系统后台'),
(513, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-11 16:37:24', '系统后台'),
(514, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 09:46:43', '系统后台'),
(515, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 09:51:58', '系统后台'),
(516, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 09:55:59', '系统后台'),
(517, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 10:57:45', '系统后台'),
(518, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 10:58:42', '系统后台'),
(519, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 11:39:08', '系统后台'),
(520, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 11:40:00', '系统后台'),
(521, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 11:40:40', '系统后台'),
(522, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:13:48', '系统后台'),
(523, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:13:57', '系统后台'),
(524, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:14:12', '系统后台'),
(525, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:14:14', '系统后台'),
(526, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:14:24', '系统后台'),
(527, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:24', '系统后台'),
(528, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:26', '系统后台'),
(529, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:28', '系统后台'),
(530, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:29', '系统后台'),
(531, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:30', '系统后台'),
(532, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:32', '系统后台'),
(533, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:32', '系统后台'),
(534, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:43', '系统后台'),
(535, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:15:44', '系统后台'),
(536, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:16:08', '系统后台'),
(537, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:16:17', '系统后台'),
(538, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:16:19', '系统后台'),
(539, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:16:20', '系统后台'),
(540, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-14 15:16:21', '系统后台'),
(541, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 09:18:00', '系统后台'),
(542, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 09:20:55', '系统后台'),
(543, 'asda', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:17:33', '系统后台'),
(544, 'asdasd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:19:02', '系统后台'),
(545, 'sadasd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:21:28', '系统后台'),
(546, 'sadasd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:21:30', '系统后台'),
(547, 'asd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:23:09', '系统后台'),
(548, 'asd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:23:12', '系统后台'),
(549, 'asd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:23:23', '系统后台'),
(550, 'asd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:25:09', '系统后台'),
(551, 'asd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:25:25', '系统后台'),
(552, 'sada', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:27:18', '系统后台'),
(553, 'asd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:28:18', '系统后台'),
(554, 'sadas', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:41:06', '系统后台'),
(555, 'sadas', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:41:08', '系统后台'),
(556, 'asdasd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:42:10', '系统后台'),
(557, 'asdasd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:42:13', '系统后台'),
(558, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:42:32', '系统后台'),
(559, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:42:42', '系统后台'),
(560, 'sda', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:43:46', '系统后台'),
(561, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:45:53', '系统后台'),
(562, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:45:58', '系统后台'),
(563, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:45:59', '系统后台'),
(564, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:46:01', '系统后台'),
(565, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:46:03', '系统后台'),
(566, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:46:04', '系统后台'),
(567, 'dema', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-15 14:46:05', '系统后台'),
(568, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:46:14', '系统后台'),
(569, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:46:16', '系统后台'),
(570, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:46:20', '系统后台'),
(571, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:46:46', '系统后台'),
(572, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:48:44', '系统后台'),
(573, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:49:26', '系统后台'),
(574, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:49:27', '系统后台'),
(575, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:49:27', '系统后台'),
(576, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:49:27', '系统后台'),
(577, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:59:52', '系统后台'),
(578, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 14:59:55', '系统后台'),
(579, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:02:02', '系统后台'),
(580, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:03:01', '系统后台'),
(581, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:04:25', '系统后台'),
(582, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:04:30', '系统后台'),
(583, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:04:34', '系统后台'),
(584, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:05:50', '系统后台'),
(585, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:06:36', '系统后台'),
(586, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:10:07', '系统后台'),
(587, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:11:17', '系统后台'),
(588, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:12:15', '系统后台'),
(589, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:13:30', '系统后台'),
(590, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:15:07', '系统后台'),
(591, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:16:02', '系统后台'),
(592, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:20:06', '系统后台'),
(593, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:21:18', '系统后台'),
(594, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:21:32', '系统后台'),
(595, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:21:56', '系统后台'),
(596, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:26:44', '系统后台'),
(597, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:49:34', '系统后台'),
(598, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:49:37', '系统后台'),
(599, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:57:07', '系统后台'),
(600, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 15:57:09', '系统后台'),
(601, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 16:00:52', '系统后台'),
(602, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 16:02:47', '系统后台'),
(603, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 16:02:58', '系统后台'),
(604, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 16:10:05', '系统后台'),
(605, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 16:30:13', '系统后台'),
(606, 'admin', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 16:31:16', '系统后台'),
(607, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 16:31:46', '系统后台'),
(608, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 16:33:18', '系统后台'),
(609, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 16:34:24', '系统后台'),
(610, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 17:55:46', '系统后台'),
(611, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 17:56:40', '系统后台'),
(612, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 17:57:46', '系统后台'),
(613, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 18:00:21', '系统后台'),
(614, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-15 18:01:42', '系统后台'),
(615, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 18:05:44', '系统后台'),
(616, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 18:21:44', '系统后台'),
(617, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 18:21:52', '系统后台'),
(618, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 18:22:23', '系统后台'),
(619, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-15 18:23:20', '系统后台'),
(620, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 09:30:54', '系统后台'),
(621, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 09:57:49', '系统后台'),
(622, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 09:58:17', '系统后台'),
(623, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 10:14:18', '系统后台'),
(624, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 10:20:26', '系统后台'),
(625, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 10:22:18', '系统后台'),
(626, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 10:22:23', '系统后台'),
(627, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 10:22:24', '系统后台'),
(628, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 10:22:28', '系统后台'),
(629, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 10:32:10', '系统后台'),
(630, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 10:32:49', '系统后台'),
(631, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 11:30:03', '系统后台'),
(632, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 12:03:09', '系统后台'),
(633, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 12:06:17', '系统后台'),
(634, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 14:14:50', '系统后台'),
(635, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 15:57:09', '系统后台'),
(636, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 16:43:46', '系统后台'),
(637, 'demosada', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:17:12', '系统后台'),
(638, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:17:30', '系统后台'),
(639, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:17:43', '系统后台'),
(640, 'demoasdasd', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:17:53', '系统后台'),
(641, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:18:23', '系统后台'),
(642, 'zsasda', '127.0.0.1', '内网IP', 'ApiPOST', '', 0, '账号密码错误', '2022-03-16 17:18:26', '系统后台'),
(643, 'zsa', '127.0.0.1', '内网IP', 'ApiPOST', '', 0, '账号密码错误', '2022-03-16 17:18:41', '系统后台'),
(644, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 0, '账号密码错误', '2022-03-16 17:18:48', '系统后台'),
(645, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 0, '账号密码错误', '2022-03-16 17:19:45', '系统后台'),
(646, 'demo55', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:21:06', '系统后台'),
(647, 'demo4564646', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:21:21', '系统后台'),
(648, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:21:56', '系统后台'),
(649, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:22:52', '系统后台'),
(650, 'demo2', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:24:11', '系统后台'),
(651, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:24:37', '系统后台'),
(652, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:25:12', '系统后台'),
(653, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:25:22', '系统后台'),
(654, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:25:27', '系统后台'),
(655, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 0, '账号密码错误', '2022-03-16 17:25:56', '系统后台'),
(656, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:26:03', '系统后台'),
(657, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:26:08', '系统后台'),
(658, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:27:17', '系统后台'),
(659, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:27:52', '系统后台'),
(660, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:28:07', '系统后台'),
(661, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:28:10', '系统后台'),
(662, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:28:31', '系统后台'),
(663, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:29:00', '系统后台'),
(664, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-16 17:30:28', '系统后台'),
(665, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:30:46', '系统后台'),
(666, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:31:12', '系统后台'),
(667, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:31:13', '系统后台'),
(668, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:32:00', '系统后台'),
(669, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:37:39', '系统后台'),
(670, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:42:16', '系统后台'),
(671, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:44:00', '系统后台'),
(672, 'zsss', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:45:23', '系统后台'),
(673, 'zsss', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:45:29', '系统后台'),
(674, 'zsss', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-16 17:45:34', '系统后台'),
(675, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 17:50:57', '系统后台'),
(676, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 18:05:59', '系统后台'),
(677, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 18:18:27', '系统后台'),
(678, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 18:22:40', '系统后台'),
(679, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 18:24:14', '系统后台'),
(680, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 18:24:43', '系统后台'),
(681, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-16 18:24:51', '系统后台'),
(682, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:00:59', '系统后台'),
(683, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:04:08', '系统后台'),
(684, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:05:28', '系统后台'),
(685, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:29:12', '系统后台'),
(686, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:35:19', '系统后台'),
(687, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:43:37', '系统后台'),
(688, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-17 10:45:05', '系统后台'),
(689, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:45:18', '系统后台'),
(690, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-17 10:45:37', '系统后台'),
(691, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 0, '账号密码错误', '2022-03-17 10:46:50', '系统后台'),
(692, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:47:21', '系统后台'),
(693, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:48:23', '系统后台'),
(694, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 10:51:19', '系统后台'),
(695, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:52:20', '系统后台'),
(696, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:55:42', '系统后台'),
(697, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:55:43', '系统后台'),
(698, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:55:44', '系统后台'),
(699, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:55:45', '系统后台'),
(700, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 10:57:36', '系统后台'),
(701, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:06:06', '系统后台'),
(702, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:09:07', '系统后台'),
(703, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:11:10', '系统后台'),
(704, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:26:31', '系统后台'),
(705, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:30:27', '系统后台'),
(706, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:36:21', '系统后台'),
(707, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:42:24', '系统后台'),
(708, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:45:25', '系统后台'),
(709, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 11:54:51', '系统后台'),
(710, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 14:41:42', '系统后台'),
(711, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 14:45:39', '系统后台'),
(712, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 14:55:57', '系统后台'),
(713, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:15:12', '系统后台'),
(714, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:20:43', '系统后台'),
(715, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:21:49', '系统后台'),
(716, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:24:28', '系统后台'),
(717, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:46:38', '系统后台'),
(718, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:48:02', '系统后台'),
(719, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:49:52', '系统后台'),
(720, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:50:36', '系统后台'),
(721, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:51:48', '系统后台'),
(722, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:54:50', '系统后台'),
(723, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:56:04', '系统后台'),
(724, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:57:18', '系统后台'),
(725, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 15:58:24', '系统后台'),
(726, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 16:04:05', '系统后台'),
(727, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:04:39', '系统后台'),
(728, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 16:10:20', '系统后台'),
(729, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:13:49', '系统后台'),
(730, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:16:06', '系统后台'),
(731, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:32:57', '系统后台'),
(732, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:39:26', '系统后台'),
(733, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:42:27', '系统后台'),
(734, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:44:38', '系统后台'),
(735, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:46:11', '系统后台'),
(736, 'zs', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:48:00', '系统后台'),
(737, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 16:54:33', '系统后台'),
(738, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-17 17:06:44', '系统后台'),
(739, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 17:55:46', '系统后台'),
(740, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-17 18:07:51', '系统后台'),
(741, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-18 09:44:38', '系统后台'),
(742, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-18 14:29:28', '系统后台'),
(743, 'zs', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-18 15:22:13', '系统后台'),
(744, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-18 15:22:29', '系统后台'),
(745, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 09:21:30', '系统后台'),
(746, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 14:14:54', '系统后台'),
(747, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 14:14:59', '系统后台'),
(748, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 14:15:44', '系统后台'),
(749, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 14:16:28', '系统后台'),
(750, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 14:38:30', '系统后台'),
(751, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 15:17:20', '系统后台'),
(752, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 15:29:55', '系统后台'),
(753, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 15:58:22', '系统后台'),
(754, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-21 18:06:31', '系统后台'),
(755, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-22 09:01:15', '系统后台'),
(756, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-22 09:11:55', '系统后台'),
(757, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 09:00:52', '系统后台'),
(758, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-24 09:59:09', '系统后台'),
(759, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 14:45:09', '系统后台'),
(760, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 14:47:54', '系统后台'),
(761, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 14:48:20', '系统后台'),
(762, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 14:52:37', '系统后台'),
(763, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 15:02:19', '系统后台'),
(764, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 15:02:36', '系统后台'),
(765, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-24 15:05:42', '系统后台'),
(766, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 17:06:28', '系统后台'),
(767, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-24 17:09:39', '系统后台'),
(768, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-25 15:08:31', '系统后台'),
(769, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-25 15:11:56', '系统后台'),
(770, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-25 15:12:13', '系统后台'),
(771, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-25 16:06:30', '系统后台'),
(772, 'demo2', '127.0.0.1', '内网IP', 'ApiPOST', '', 0, '账号密码错误', '2022-03-25 16:41:46', '系统后台'),
(773, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-28 10:24:28', '系统后台'),
(774, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-28 10:37:47', '系统后台'),
(775, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-28 14:27:08', '系统后台'),
(776, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-28 14:29:44', '系统后台'),
(777, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-28 16:27:11', '系统后台'),
(778, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-29 10:10:16', '系统后台'),
(779, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-29 10:49:47', '系统后台'),
(780, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 09:06:05', '系统后台'),
(781, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-30 09:58:27', '系统后台'),
(782, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 10:19:08', '系统后台'),
(783, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 10:20:01', '系统后台'),
(784, 'test', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 10:50:40', '系统后台'),
(785, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 10:51:30', '系统后台'),
(786, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 11:08:00', '系统后台'),
(787, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 11:09:44', '系统后台'),
(788, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 11:09:49', '系统后台'),
(789, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 11:23:08', '系统后台'),
(790, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-30 11:41:01', '系统后台'),
(791, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-03-30 11:44:36', '系统后台'),
(792, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-03-31 09:34:07', '系统后台'),
(793, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-01 10:09:45', '系统后台'),
(794, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-01 10:13:39', '系统后台'),
(795, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-01 10:16:04', '系统后台'),
(796, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-01 15:02:11', '系统后台'),
(797, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-02 09:15:20', '系统后台'),
(798, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-02 09:15:34', '系统后台'),
(799, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-02 09:59:08', '系统后台'),
(800, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-02 11:04:12', '系统后台'),
(801, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-06 09:51:48', '系统后台'),
(802, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-06 16:21:37', '系统后台'),
(803, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-06 17:40:57', '系统后台'),
(804, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-07 09:34:50', '系统后台'),
(805, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-07 15:17:03', '系统后台'),
(806, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-07 15:58:53', '系统后台'),
(807, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-07 22:13:22', '系统后台'),
(808, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-08 09:26:14', '系统后台'),
(809, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-08 12:03:47', '系统后台'),
(810, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-08 14:17:47', '系统后台'),
(811, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-08 14:24:23', '系统后台'),
(812, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-09 12:58:53', '系统后台'),
(813, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-11 09:01:47', '系统后台'),
(814, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-11 09:13:10', '系统后台'),
(815, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-11 09:36:58', '系统后台'),
(816, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-11 16:42:45', '系统后台'),
(817, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-12 08:59:10', '系统后台'),
(818, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-12 09:11:59', '系统后台'),
(819, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-12 14:20:39', '系统后台'),
(820, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-12 16:13:56', '系统后台'),
(821, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-13 09:30:32', '系统后台'),
(822, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-13 11:51:43', '系统后台'),
(823, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-13 15:00:37', '系统后台'),
(824, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-13 15:07:04', '系统后台'),
(825, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 11:38:33', '系统后台'),
(826, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:08:12', '系统后台'),
(827, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:09:03', '系统后台'),
(828, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:11:46', '系统后台'),
(829, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:40:42', '系统后台'),
(830, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:41:48', '系统后台'),
(831, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:46:52', '系统后台'),
(832, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 15:48:41', '系统后台'),
(833, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 17:50:00', '系统后台'),
(834, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 18:08:01', '系统后台'),
(835, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-14 21:10:21', '系统后台'),
(836, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-16 10:07:14', '系统后台'),
(837, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-16 10:48:15', '系统后台'),
(838, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 11:15:08', '系统后台'),
(839, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 11:15:16', '系统后台'),
(840, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 11:15:18', '系统后台'),
(841, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 11:15:20', '系统后台'),
(842, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 15:59:10', '系统后台'),
(843, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 15:59:12', '系统后台'),
(844, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 15:59:14', '系统后台'),
(845, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 15:59:15', '系统后台'),
(846, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 15:59:16', '系统后台'),
(847, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-16 15:59:17', '系统后台'),
(848, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-16 16:11:58', '系统后台'),
(849, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-16 17:01:43', '系统后台'),
(850, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-18 10:33:28', '系统后台'),
(851, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-18 10:45:05', '系统后台'),
(852, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-18 16:27:06', '系统后台'),
(853, 'demo', '::1', '安徽省 合肥市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-18 20:59:19', '系统后台'),
(854, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-18 22:18:35', '系统后台'),
(855, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 08:49:39', '系统后台'),
(856, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 08:55:49', '系统后台'),
(857, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 08:57:07', '系统后台'),
(858, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:50:28', '系统后台'),
(859, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:06', '系统后台'),
(860, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:07', '系统后台'),
(861, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:29', '系统后台'),
(862, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:30', '系统后台'),
(863, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:30', '系统后台'),
(864, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:31', '系统后台'),
(865, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:32', '系统后台'),
(866, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-19 09:51:32', '系统后台'),
(867, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 11:08:39', '系统后台'),
(868, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 11:50:30', '系统后台'),
(869, 'demo', '127.0.0.1', '内网IP', 'Firefox', 'Windows 10', 1, '登录成功', '2022-04-19 15:07:34', '系统后台'),
(870, 'admin', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 16:38:37', '系统后台'),
(871, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-19 17:29:59', '系统后台'),
(872, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 08:42:41', '系统后台'),
(873, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 09:51:36', '系统后台'),
(874, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 10:41:01', '系统后台'),
(875, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 10:50:15', '系统后台'),
(876, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 10:50:19', '系统后台'),
(877, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 10:50:59', '系统后台'),
(878, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 14:38:28', '系统后台'),
(879, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-20 16:26:04', '系统后台'),
(880, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-20 16:27:13', '系统后台'),
(881, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-21 08:31:03', '系统后台'),
(882, 'demo', '::1', '云南省 曲靖市', 'Chrome', 'Windows 10', 1, '登录成功', '2022-04-21 09:22:27', '系统后台'),
(883, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-21 17:17:35', '系统后台'),
(884, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-21 17:27:48', '系统后台'),
(885, 'demo', '127.0.0.1', '内网IP', 'ApiPOST', '', 1, '登录成功', '2022-04-21 17:28:09', '系统后台'),
(886, 'demo', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 20:26:17', '系统后台'),
(887, 'demo', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 20:26:22', '系统后台'),
(888, 'demo', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 20:27:14', '系统后台'),
(889, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 20:27:46', '系统后台'),
(890, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 21:17:00', '系统后台'),
(891, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 21:27:43', '系统后台'),
(892, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 21:31:51', '系统后台'),
(893, 'demo', '::1', '广东省 广州市', 'Edge', 'Windows 10', 0, '账号密码错误', '2022-09-12 21:33:06', '系统后台'),
(894, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 21:33:10', '系统后台'),
(895, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-12 21:34:37', '系统后台'),
(896, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-13 08:46:03', '系统后台'),
(897, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 0, '账号密码错误', '2022-09-13 08:48:14', '系统后台'),
(898, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-13 08:48:17', '系统后台'),
(899, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-13 18:55:19', '系统后台'),
(900, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-13 18:56:18', '系统后台'),
(901, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-13 18:57:05', '系统后台'),
(902, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-14 11:17:55', '系统后台'),
(903, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-14 21:45:30', '系统后台'),
(904, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-16 10:14:22', '系统后台'),
(905, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-16 21:14:53', '系统后台'),
(906, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-17 13:35:37', '系统后台'),
(907, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-17 22:34:45', '系统后台'),
(908, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-17 23:35:44', '系统后台'),
(909, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-18 10:42:34', '系统后台'),
(910, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-18 13:38:15', '系统后台'),
(911, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-19 11:37:21', '系统后台'),
(912, 'admin', '::1', '广东省 广州市', 'Edge', 'Windows 10', 1, '登录成功', '2022-09-19 14:15:45', '系统后台');

-- --------------------------------------------------------

--
-- 表的结构 `sys_oper_log`
--

CREATE TABLE `sys_oper_log` (
  `oper_id` bigint UNSIGNED NOT NULL COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '请求参数',
  `json_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `sys_role`
--

CREATE TABLE `sys_role` (
  `id` int UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `list_order` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `data_scope` tinyint UNSIGNED NOT NULL DEFAULT '3' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `sys_role`
--

INSERT INTO `sys_role` (`id`, `status`, `list_order`, `name`, `remark`, `data_scope`, `created_at`, `updated_at`) VALUES
(1, 1, 0, '超级管理员', '备注', 3, '2022-04-01 11:38:39', '2022-04-09 12:59:28'),
(9, 1, 1, '软件开发者', '', 3, '2022-09-12 21:19:53', '2022-09-12 21:19:53');

-- --------------------------------------------------------

--
-- 表的结构 `sys_user`
--

CREATE TABLE `sys_user` (
  `id` bigint UNSIGNED NOT NULL,
  `user_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `birthday` int NOT NULL DEFAULT '0' COMMENT '生日',
  `user_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_salt` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密盐',
  `user_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `sex` tinyint NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `is_admin` tinyint NOT NULL DEFAULT '1' COMMENT '是否后台管理员 1 是  0   否',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系地址',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT ' 描述信息',
  `last_login_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `sys_user`
--

INSERT INTO `sys_user` (`id`, `user_name`, `mobile`, `user_nickname`, `birthday`, `user_password`, `user_salt`, `user_status`, `user_email`, `sex`, `avatar`, `remark`, `is_admin`, `address`, `describe`, `last_login_ip`, `last_login_time`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', '13578342363', '超级管理员', 0, 'c567ae329f9929b518759d3bea13f492', 'f9aZTAa8yz', 1, 'yxh669@qq.com', 1, 'https://yxh-1301841944.cos.ap-chongqing.myqcloud.com/gfast/2021-07-19/ccwpeuqz1i2s769hua.jpeg', '', 1, 'asdasfdsaf大发放打发士大夫发按时', '描述信息', '::1', '2022-09-19 14:15:45', '2021-06-22 17:58:00', '2022-09-19 14:15:45', NULL),
(2, 'yixiaohu', '13699885599', '奈斯', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, 'yxh@qq.com', 1, 'pub_upload/2020-11-02/c6sntzg7r96c7p9gqf.jpeg', '备注', 1, '', '', '[::1]', '2022-02-14 18:10:40', '2021-06-22 17:58:00', '2022-04-13 11:20:03', '2022-09-12 20:28:55'),
(3, 'zs', '16399669855', '张三', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, 'zs@qq.com', 0, 'https://yxh-1301841944.cos.ap-chongqing.myqcloud.com/gfast/2021-08-02/cd8nif79egjg9kbkgk.jpeg', '', 1, '', '', '127.0.0.1', '2022-03-18 15:22:13', '2021-06-22 17:58:00', '2022-04-21 11:20:06', '2022-09-12 20:28:55'),
(4, 'qlgl', '13758596696', '测试c', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, 'qlgl@qq.com', 0, '', '', 1, '', '', '127.0.0.1', NULL, '2021-06-22 17:58:00', '2022-04-12 17:55:28', '2022-09-12 20:28:55'),
(5, 'test', '13845696696', '测试2', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '123@qq.com', 0, '', '', 0, '', '', '::1', '2022-03-30 10:50:39', '2021-06-22 17:58:00', '2022-04-12 17:55:31', '2022-09-12 20:28:55'),
(6, '18999998889', '13755866654', '刘大大', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '1223@qq.com', 0, '', '', 1, '', '', '[::1]', '2022-02-25 14:29:22', '2021-06-22 17:58:00', '2022-04-14 21:11:06', '2022-09-12 20:28:55'),
(7, 'zmm', '13788566696', '张明明', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '11123@qq.com', 0, '', '', 1, '', '', '127.0.0.1', NULL, '2021-06-22 17:58:00', '2022-04-12 17:55:42', '2022-09-12 20:28:55'),
(8, 'lxx', '13756566696', '李小小', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '123333@qq.com', 0, '', '', 1, '', '', '127.0.0.1', NULL, '2021-06-22 17:58:00', '2022-04-12 17:55:45', '2022-09-12 20:28:55'),
(10, 'xmm', '13588999969', '小秘密', 0, '2de2a8df703bfc634cfda2cb2f6a59be', 'Frz7LJY7SE', 1, '696@qq.com', 0, '', '', 1, '', '', '[::1]', '2021-07-22 17:08:53', '2021-06-22 17:58:00', '2022-04-12 17:55:50', '2022-09-12 20:28:55'),
(14, 'cd_19', '13699888899', '看金利科技', 0, '1169d5fe4119fd4277a95f02d7036171', '7paigEoedh', 1, '', 0, '', '', 1, '', '', '', NULL, '2021-06-22 17:58:00', '2022-04-12 18:13:22', '2022-09-12 20:28:55'),
(15, 'lmm', '13587754545', '刘敏敏', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, 'a@coc.com', 0, '', '', 1, '', '', '127.0.0.1', NULL, '2021-06-22 17:58:00', '2022-04-12 17:56:23', '2022-09-12 20:28:48'),
(16, 'ldn', '13899658874', '李大牛', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, 'a@ll.con', 0, '', '', 1, '', '', '127.0.0.1', NULL, '2021-06-22 17:58:00', '2022-04-12 17:56:27', '2022-09-12 20:28:45'),
(20, 'dbc', '13877555566', '大百词', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '', 0, '', '', 1, '', '', '', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:43'),
(22, 'yxfmlbb', '15969423326', '大数据部门测试', 0, '66f89b40ee4a10aabaf70c15756429ea', 'mvd2OtUe8f', 1, 'yxh6691@qq.com', 0, 'https://yxh-1301841944.cos.ap-chongqing.myqcloud.com/gfast/2021-09-29/cem20k3fdciosy7nwo.jpeg', '', 1, '2222233', '1222', '[::1]', '2021-10-28 11:36:07', '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:41'),
(23, 'wangming', '13699888855', '王明', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '', 0, '', '', 1, '', '', '', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:40'),
(24, 'zhk', '13699885591', '综合科', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '', 0, '', '', 1, '', '', '192.168.0.146', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:38'),
(28, 'demo3', '18699888855', '测试账号1', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '123132@qq.com', 0, '', '', 1, '', '', '192.168.0.229', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:37'),
(31, 'demo', '15334455789', '李四', 0, '39978de67915a11e94bfe9c879b2d9a1', 'gqwLs4n95E', 1, '223@qq.com', 2, 'https://yxh-1301841944.cos.ap-chongqing.myqcloud.com/gfast/2021-11-30/cg30rab8myj85vjzcf.jpeg', '', 1, '云南省曲靖市22223', '12345', '::1', '2022-09-12 20:27:14', '2021-06-22 17:58:00', '2022-09-12 20:27:14', '2022-09-12 20:28:35'),
(32, 'demo100', '18699888859', '测试账号1', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '', 0, '', '', 1, '', '', '[::1]', '2021-11-24 18:01:21', '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:34'),
(33, 'demo110', '18699888853', '测试账号1', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '', 0, '', '', 1, '', '', '', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:32'),
(34, 'yxfmlbb2', '15969423327', '研发部门测试', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '1111@qqq.com', 1, '', '', 0, '', '', '127.0.0.1', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:29'),
(35, 'wk666', '18888888888', 'wk', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '396861557@qq.com', 1, '', '', 1, '', '', '[::1]', '2021-12-09 14:52:37', '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:28'),
(36, 'zxd', '13699885565', '张晓东', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, 'zxk@qq.com', 1, '', '666', 1, '', '', '', NULL, '2021-06-22 17:58:00', '2021-06-22 17:58:00', '2022-09-12 20:28:26'),
(37, 'yxfmlbb3', '13513513511', '张三', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '111@qq.com', 0, '', '', 1, '', '', '[::1]', '2021-07-26 14:49:25', '2021-06-22 17:58:00', '2021-07-26 14:49:18', '2022-09-12 20:28:25'),
(38, 'test_user', '18888888880', 'test', 0, '542a6e44dbac171f260fc4a032cd5522', 'dlqVVBTADg', 1, '11@qq.com', 1, '', '111', 0, '', '', '', NULL, '2021-06-22 17:58:00', '2021-07-12 22:05:29', '2022-09-12 20:28:23'),
(39, 'asan', '18687460555', '阿三', 0, '2354837137115700e2adf870ac113dcf', 'drdDvbtYZW', 1, '456654@qq.com', 1, '', '666666', 1, '', '', '', NULL, '2021-07-12 17:21:43', '2021-07-12 21:13:31', '2021-07-12 22:00:44'),
(40, 'asi', '13655888888', '啊四', 0, 'fbb755b35d48759dad47bb1540249fd1', '9dfUstcxrz', 1, '5464@qq.com', 1, '', 'adsaasd', 1, '', '', '', '2021-07-12 17:21:43', '2021-07-12 17:46:27', '2021-07-12 21:29:41', '2021-07-12 22:00:44'),
(41, 'awu', '13578556546', '阿五', 0, '3b36a96afa0dfd66aa915e0816e0e9f6', '9gHRa9ho4U', 0, '132321@qq.com', 1, '', 'asdasdasd', 1, '', '', '', NULL, '2021-07-12 17:54:31', '2021-07-12 21:46:34', '2021-07-12 21:59:56'),
(42, 'demo01', '13699888556', '测试01222', 0, '048dc94116558fb40920f3553ecd5fe8', 'KiVrfzKJQx', 1, '456@qq.com', 2, '', '测试用户', 1, '', '', '', NULL, '2022-04-12 16:15:23', '2022-04-12 17:54:49', '2022-09-12 20:28:21'),
(44, 'card', '13800000001', 'card', 0, 'fedd18cc24980b13decf529cf80c3829', '6Jp5KFTEMO', 1, '32321@qq.ocm', 1, '', '1', 0, '', '', '', NULL, '2022-09-12 21:44:30', '2022-09-12 21:44:30', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `sys_user_online`
--

CREATE TABLE `sys_user_online` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT '用户标识',
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT '用户token',
  `create_time` datetime DEFAULT NULL COMMENT '登录时间',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `ip` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录ip',
  `explorer` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '浏览器',
  `os` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作系统'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户在线状态表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `verify_attachment`
--

CREATE TABLE `verify_attachment` (
  `id` bigint NOT NULL,
  `file_name` varchar(200) NOT NULL COMMENT '附件名',
  `md5` varchar(64) NOT NULL COMMENT 'MD5',
  `store_type` int NOT NULL COMMENT '1 二进制 2 直接 3 蓝奏云 4 百度网盘',
  `other_param` varchar(256) DEFAULT NULL COMMENT '其他参数，用于保存网盘密码等',
  `file_path` varchar(1024) NOT NULL COMMENT '附件存储路径',
  `file_size` bigint DEFAULT NULL COMMENT '附件大小 byte',
  `file_type` varchar(50) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='附件表';

-- --------------------------------------------------------

--
-- 表的结构 `verify_card`
--

CREATE TABLE `verify_card` (
  `id` bigint NOT NULL COMMENT '卡密ID',
  `software_id` bigint NOT NULL COMMENT '软件ID',
  `card_code` varchar(64) NOT NULL COMMENT '密钥',
  `card_value` int NOT NULL COMMENT '面值',
  `card_type` int NOT NULL COMMENT '1 分钟 2 小时 3 天 4 月 5 年',
  `card_status` tinyint NOT NULL DEFAULT '2' COMMENT '状态 1 正常 0 冻结',
  `unbind_count` int DEFAULT '5' COMMENT '允许解绑次数',
  `gen_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
  `activate_time` timestamp NULL DEFAULT NULL COMMENT '激活时间',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '到期时间',
  `customize` tinyint NOT NULL DEFAULT '0' COMMENT '自定义属性',
  `key_prefix` varchar(10) DEFAULT NULL COMMENT '卡密前缀',
  `multi_online` int DEFAULT NULL COMMENT '多开上限',
  `is_replace` tinyint DEFAULT NULL COMMENT '顶号登录 1 是 0 否',
  `comment` varchar(2000) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='激活码表';

-- --------------------------------------------------------

--
-- 表的结构 `verify_card_charge`
--

CREATE TABLE `verify_card_charge` (
  `id` bigint NOT NULL COMMENT '充值记录ID',
  `card_code` varchar(64) NOT NULL COMMENT '被充值卡密',
  `use_card_code` varchar(64) NOT NULL COMMENT '使用的卡密',
  `expire_time_before` datetime NOT NULL COMMENT '充值前到期日期',
  `expire_time_after` datetime NOT NULL COMMENT '充值后到期日期',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='充值记录表';

-- --------------------------------------------------------

--
-- 表的结构 `verify_card_session`
--

CREATE TABLE `verify_card_session` (
  `id` bigint NOT NULL COMMENT '编号',
  `card_id` bigint NOT NULL COMMENT '卡密Id',
  `session_timeout` datetime NOT NULL COMMENT '超时时间',
  `login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录IP',
  `device_id` bigint NOT NULL COMMENT '设备ID',
  `device_token` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设备在线Session';

-- --------------------------------------------------------

--
-- 表的结构 `verify_card_unbind`
--

CREATE TABLE `verify_card_unbind` (
  `id` bigint NOT NULL,
  `card_id` bigint NOT NULL COMMENT '卡密ID',
  `device_code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备编号',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='卡密解绑记录';

-- --------------------------------------------------------

--
-- 表的结构 `verify_device`
--

CREATE TABLE `verify_device` (
  `id` bigint NOT NULL COMMENT '设备ID',
  `card_id` bigint NOT NULL COMMENT '卡密',
  `device_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备编号',
  `device_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `device_status` tinyint NOT NULL DEFAULT '0' COMMENT '设备状态',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `login_ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '当前登录IP',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='卡密绑定记录表';

-- --------------------------------------------------------

--
-- 表的结构 `verify_software`
--

CREATE TABLE `verify_software` (
  `id` bigint NOT NULL COMMENT '软件id',
  `software_name` varchar(256) NOT NULL COMMENT '软件名称',
  `secret_id` varchar(100) NOT NULL COMMENT '软件唯一标识',
  `secret_key` varchar(100) NOT NULL COMMENT '软件密钥',
  `software_status` int DEFAULT '1' COMMENT '软件状态',
  `card_length` int DEFAULT '10' COMMENT '密钥长度',
  `encrypt_type` varchar(50) NOT NULL COMMENT '加密方式 AES RSA MD5',
  `key_prefix` varchar(10) DEFAULT NULL COMMENT '密钥前缀',
  `multi_online` int DEFAULT '1' COMMENT '设备上限',
  `is_replace` tinyint NOT NULL DEFAULT '1' COMMENT '是否顶号登录 1 是 0 否',
  `heartbeat` int DEFAULT NULL COMMENT '心跳间隔',
  `open_trial` tinyint DEFAULT '0' COMMENT '开启试用 1 是 0 否',
  `trial_count` int DEFAULT '1' COMMENT '试用次数',
  `trial_time` int DEFAULT NULL COMMENT '试用时间(分钟)',
  `trial_duration` int DEFAULT NULL COMMENT '每次试用间隔',
  `comment` varchar(2000) DEFAULT NULL COMMENT '软件备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='软件信息表';

-- --------------------------------------------------------

--
-- 表的结构 `verify_version`
--

CREATE TABLE `verify_version` (
  `id` bigint NOT NULL,
  `software_id` bigint NOT NULL COMMENT '软件Id',
  `version_number` varchar(32) DEFAULT NULL COMMENT '主版本号',
  `is_publish` int DEFAULT '1' COMMENT '是否发布',
  `att_id` bigint DEFAULT NULL COMMENT '附件Id',
  `comment` varchar(2000) DEFAULT NULL COMMENT '版本备注',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='版本表';

--
-- 转储表的索引
--

--
-- 表的索引 `sys_auth_rule`
--
ALTER TABLE `sys_auth_rule`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `name` (`name`) USING BTREE,
  ADD KEY `pid` (`pid`) USING BTREE,
  ADD KEY `weigh` (`weigh`) USING BTREE;

--
-- 表的索引 `sys_config`
--
ALTER TABLE `sys_config`
  ADD PRIMARY KEY (`config_id`) USING BTREE,
  ADD UNIQUE KEY `uni_config_key` (`config_key`) USING BTREE;

--
-- 表的索引 `sys_dict_data`
--
ALTER TABLE `sys_dict_data`
  ADD PRIMARY KEY (`dict_code`) USING BTREE;

--
-- 表的索引 `sys_dict_type`
--
ALTER TABLE `sys_dict_type`
  ADD PRIMARY KEY (`dict_id`) USING BTREE,
  ADD UNIQUE KEY `dict_type` (`dict_type`) USING BTREE;

--
-- 表的索引 `sys_login_log`
--
ALTER TABLE `sys_login_log`
  ADD PRIMARY KEY (`info_id`) USING BTREE;

--
-- 表的索引 `sys_oper_log`
--
ALTER TABLE `sys_oper_log`
  ADD PRIMARY KEY (`oper_id`) USING BTREE;

--
-- 表的索引 `sys_role`
--
ALTER TABLE `sys_role`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `status` (`status`) USING BTREE;

--
-- 表的索引 `sys_user`
--
ALTER TABLE `sys_user`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `user_login` (`user_name`,`deleted_at`) USING BTREE,
  ADD UNIQUE KEY `mobile` (`mobile`,`deleted_at`) USING BTREE,
  ADD KEY `user_nickname` (`user_nickname`) USING BTREE;

--
-- 表的索引 `sys_user_online`
--
ALTER TABLE `sys_user_online`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `uni_token` (`token`) USING BTREE;

--
-- 表的索引 `verify_attachment`
--
ALTER TABLE `verify_attachment`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `verify_card`
--
ALTER TABLE `verify_card`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_secret_secret_id_uindex` (`id`),
  ADD UNIQUE KEY `t_secret_secret_key_uindex` (`card_code`);

--
-- 表的索引 `verify_card_charge`
--
ALTER TABLE `verify_card_charge`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `verify_card_session`
--
ALTER TABLE `verify_card_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_card_session_card_id_IDX` (`card_id`),
  ADD KEY `verify_card_session_device_token_index` (`device_token`);

--
-- 表的索引 `verify_card_unbind`
--
ALTER TABLE `verify_card_unbind`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_card_unbind_log_card_id_index` (`card_id`);

--
-- 表的索引 `verify_device`
--
ALTER TABLE `verify_device`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_device_card_id_IDX` (`card_id`);

--
-- 表的索引 `verify_software`
--
ALTER TABLE `verify_software`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_application_software_id_uindex` (`id`),
  ADD UNIQUE KEY `t_software_secret_id_uindex` (`secret_id`),
  ADD UNIQUE KEY `t_software_secret_key_undex` (`secret_key`);

--
-- 表的索引 `verify_version`
--
ALTER TABLE `verify_version`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `sys_auth_rule`
--
ALTER TABLE `sys_auth_rule`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- 使用表AUTO_INCREMENT `sys_config`
--
ALTER TABLE `sys_config`
  MODIFY `config_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '参数主键', AUTO_INCREMENT=15;

--
-- 使用表AUTO_INCREMENT `sys_dict_data`
--
ALTER TABLE `sys_dict_data`
  MODIFY `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码', AUTO_INCREMENT=114;

--
-- 使用表AUTO_INCREMENT `sys_dict_type`
--
ALTER TABLE `sys_dict_type`
  MODIFY `dict_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '字典主键', AUTO_INCREMENT=53;

--
-- 使用表AUTO_INCREMENT `sys_login_log`
--
ALTER TABLE `sys_login_log`
  MODIFY `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID', AUTO_INCREMENT=913;

--
-- 使用表AUTO_INCREMENT `sys_oper_log`
--
ALTER TABLE `sys_oper_log`
  MODIFY `oper_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志主键';

--
-- 使用表AUTO_INCREMENT `sys_role`
--
ALTER TABLE `sys_role`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `sys_user`
--
ALTER TABLE `sys_user`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- 使用表AUTO_INCREMENT `sys_user_online`
--
ALTER TABLE `sys_user_online`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17387;

--
-- 使用表AUTO_INCREMENT `verify_attachment`
--
ALTER TABLE `verify_attachment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `verify_card`
--
ALTER TABLE `verify_card`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '卡密ID';

--
-- 使用表AUTO_INCREMENT `verify_card_charge`
--
ALTER TABLE `verify_card_charge`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '充值记录ID';

--
-- 使用表AUTO_INCREMENT `verify_card_session`
--
ALTER TABLE `verify_card_session`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号';

--
-- 使用表AUTO_INCREMENT `verify_card_unbind`
--
ALTER TABLE `verify_card_unbind`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `verify_device`
--
ALTER TABLE `verify_device`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID';

--
-- 使用表AUTO_INCREMENT `verify_software`
--
ALTER TABLE `verify_software`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT '软件id';

--
-- 使用表AUTO_INCREMENT `verify_version`
--
ALTER TABLE `verify_version`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
