<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flutter Core Framework</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
        }
        h1, h2, h3 {
            color: #333;
        }
        ul {
            margin: 10px 0;
            padding-left: 20px;
        }
        li {
            margin: 5px 0;
        }
        code {
            background-color: #f4f4f4;
            padding: 2px 4px;
            border-radius: 4px;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <h1>Flutter Core Framework</h1>
    <p>Flutter Core Framework 是一个轻量级、高扩展性且易维护的 Flutter 项目核心框架，专注于提高开发效率和代码的可维护性。该框架主要封装了常见功能模块和工具类，帮助开发者快速搭建高质量的 Flutter 应用。</p>
    
    <h2>目录结构说明</h2>

    <h3>1. config</h3>
    <p>用于存放项目的配置信息，例如环境变量、全局配置等。</p>

    <h3>2. initializer</h3>
    <p>包含项目初始化逻辑。例如：</p>
    <ul>
        <li><code>app_initializer.dart</code>: 初始化应用时加载的逻辑，包括日志系统、网络监听、用户状态等。</li>
    </ul>

    <h3>3. network</h3>
    <p>负责网络请求和网络状态管理的核心模块：</p>
    <ul>
        <li><code>api_endpoints.dart</code>: 定义所有的 API 接口路径，便于统一管理。</li>
        <li><code>api_exceptions.dart</code>: 处理网络异常和错误信息。</li>
        <li><code>api_interceptors.dart</code>: 定义请求、响应的拦截器逻辑，例如添加 Token。</li>
        <li><code>api_service.dart</code>: 封装的网络请求类，支持 GET、POST 等方法调用。</li>
        <li><code>network_monitor.dart</code>: 用于监听网络状态的工具类，并提供全局事件通知。</li>
    </ul>

    <h3>4. services</h3>
    <p>用于存放业务相关的服务类，例如：</p>
    <ul>
        <li><code>user_manager.dart</code>: 管理用户登录状态、权限校验等逻辑。</li>
    </ul>

    <h3>5. theme</h3>
    <p>负责全局主题管理：</p>
    <ul>
        <li><code>colors.dart</code>: 定义应用中使用的所有颜色。</li>
        <li><code>text_styles.dart</code>: 定义全局字体样式。</li>
        <li><code>theme.dart</code>: 配置应用的主题（浅色/深色模式）。</li>
    </ul>

    <h3>6. utils</h3>
    <p>封装了一些常用工具类：</p>
    <ul>
        <li><code>dateUtils.dart</code>: 提供日期时间相关操作的方法，例如获取当前日期、前一天日期等。</li>
        <li><code>eventManager.dart</code>: 基于事件驱动的管理工具，用于全局事件订阅与发布。</li>
        <li><code>logger.dart</code>: 日志系统，支持控制台输出与本地文件存储。</li>
        <li><code>permissionManager.dart</code>: 统一管理权限请求与校验逻辑。</li>
        <li><code>storage.dart</code>: 封装本地存储工具类。</li>
        <li><code>task_scheduler.dart</code>: 定时任务调度工具类，支持周期性任务与单次任务。</li>
    </ul>

    <h3>7. widgets</h3>
    <p>封装的基础 UI 组件，提升代码复用性与开发效率：</p>
    <ul>
        <li><code>base_app_bar_page.dart</code>: 定义基础页面布局与通用 AppBar。</li>
        <li><code>base_button.dart</code>: 自定义按钮组件。</li>
        <li><code>base_card.dart</code>: 通用卡片组件。</li>
        <li><code>base_dialog.dart</code>: 封装对话框组件。</li>
        <li><code>base_text_field.dart</code>: 封装的输入框组件，支持样式与校验。</li>
    </ul>
</body>
</html>
