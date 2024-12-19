项目介绍

Flutter Core Framework 是一个轻量级、高扩展性且易维护的 Flutter 项目核心框架，专注于提高开发效率和代码的可维护性。该框架主要封装了常见功能模块和工具类，帮助开发者快速搭建高质量的 Flutter 应用。

目录结构说明

1. config

用于存放项目的配置信息，例如环境变量、全局配置等。

2. initializer

包含项目初始化逻辑。例如：
	•	app_initializer.dart: 初始化应用时加载的逻辑，包括日志系统、网络监听、用户状态等。

3. network

负责网络请求和网络状态管理的核心模块：
	•	api_endpoints.dart: 定义所有的 API 接口路径，便于统一管理。
	•	api_exceptions.dart: 处理网络异常和错误信息。
	•	api_interceptors.dart: 定义请求、响应的拦截器逻辑，例如添加 Token。
	•	api_service.dart: 封装的网络请求类，支持 GET、POST 等方法调用。
	•	network_monitor.dart: 用于监听网络状态的工具类，并提供全局事件通知。

4. services

用于存放业务相关的服务类，例如：
	•	user_manager.dart: 管理用户登录状态、权限校验等逻辑。

5. theme

负责全局主题管理：
	•	colors.dart: 定义应用中使用的所有颜色。
	•	text_styles.dart: 定义全局字体样式。
	•	theme.dart: 配置应用的主题（浅色/深色模式）。

6. utils

封装了一些常用工具类：
	•	dateUtils.dart: 提供日期时间相关操作的方法，例如获取当前日期、前一天日期等。
	•	eventManager.dart: 基于事件驱动的管理工具，用于全局事件订阅与发布。
	•	logger.dart: 日志系统，支持控制台输出与本地文件存储。
	•	permissionManager.dart: 统一管理权限请求与校验逻辑。
	•	storage.dart: 封装本地存储工具类。
	•	task_scheduler.dart: 定时任务调度工具类，支持周期性任务与单次任务。

7. widgets

封装的基础 UI 组件，提升代码复用性与开发效率：
	•	base_app_bar_page.dart: 定义基础页面布局与通用 AppBar。
	•	base_button.dart: 自定义按钮组件。
	•	base_card.dart: 通用卡片组件。
	•	base_dialog.dart: 封装对话框组件。
	•	base_text_field.dart: 封装的输入框组件，支持样式与校验。
