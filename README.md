# 项目介绍

**Flutter Core Framework** 是一个轻量级、高扩展性且易维护的 Flutter 项目核心框架，专注于提高开发效率和代码的可维护性。该框架主要封装了常见功能模块和工具类，帮助开发者快速搭建高质量的 Flutter 应用。

## 目录结构说明

core/
├── config/                         # 配置相关
│   ├── env_preprod.dart            # 预生产环境配置
│   ├── env_prod.dart               # 生产环境配置
│   └── environment.dart            # 环境管理入口，动态配置当前环境
│
├── initializer/                    # 应用初始化相关
│   └── app_initializer.dart        # 应用初始化类，负责框架功能模块初始化（如日志、网络监听等）
│
├── network/                        # 网络模块
│   ├── api_endpoints.dart          # API接口路径管理
│   ├── api_exceptions.dart         # 网络异常处理
│   ├── api_interceptors.dart       # 拦截器，处理请求日志、错误逻辑及刷新Token等
│   ├── api_service.dart            # 网络请求核心类，封装通用请求逻辑
│   └── network_monitor.dart        # 网络状态监听工具
│
├── services/                       # 业务服务模块
│   ├── route_manager.dart          # 路由管理器，负责路由拦截、导航拦截等
│   └── user_manager.dart           # 用户管理器，处理用户相关状态（如Token、用户信息等）
│
├── theme/                          # 主题样式相关
│   ├── colors.dart                 # 定义全局颜色
│   ├── text_styles.dart            # 全局字体样式
│   └── theme.dart                  # 应用主题配置（如深色/浅色模式）
│
├── utils/                          # 工具类模块
│   ├── dateUtils.dart              # 日期时间工具类，提供日期相关操作
│   ├── eventManager.dart           # 全局事件管理，基于订阅发布模式
│   ├── logger.dart                 # 日志系统，支持日志等级和文件存储
│   ├── permissionManager.dart      # 权限管理工具
│   ├── storage.dart                # 本地存储工具（SharedPreferences封装）
│   └── task_scheduler.dart         # 定时任务调度工具
│
└── widgets/                        # 通用组件
├── base_app_bar_page.dart      # 基础页面框架组件，内含通用AppBar
├── base_button.dart            # 自定义按钮组件
├── base_card.dart              # 卡片组件
├── base_dialog.dart            # 通用对话框组件
└── base_text_field.dart        # 输入框组件，支持校验及样式配置
