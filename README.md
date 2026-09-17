# 智慧课程管理系统

基于 **RuoYi-Vue v3.9.0**（若依前后端分离框架）二次开发的后台管理系统。

## 项目简介

- **后端**：Spring Boot + MyBatis + Druid + Redis + Quartz，模块化 Maven 工程
- **前端**：Vue 3 + Vite + Element Plus + Pinia + ECharts
- **功能**：用户管理、角色权限、菜单管理、部门管理、字典管理、系统监控、定时任务、文件上传等（基于若依内置模块二次开发）

## 目录结构

```
RuoYi/
├── backend/                  # 后端工程（Maven 多模块）
│   ├── ruoyi-admin/          # 启动模块（ruoyi-admin 启动类在这里）
│   ├── ruoyi-common/         # 通用工具模块
│   ├── ruoyi-framework/      # 框架核心模块
│   ├── ruoyi-generator/      # 代码生成模块
│   ├── ruoyi-manage/         # 管理模块
│   ├── ruoyi-quartz/         # 定时任务模块
│   ├── ruoyi-system/         # 系统业务模块
│   └── sql/                  # 数据库脚本（smart_course_management.sql 完整库、quartz.sql 定时任务）
└── frontend/                 # 前端工程（Vue3 + Vite）
```

## 环境要求

| 环境 | 版本要求 |
| --- | --- |
| JDK | 1.8 及以上 |
| Maven | 3.x |
| MySQL | 5.7 及以上（本项目建议 8.0） |
| Redis | 任意版本（本地默认无密码） |
| Node.js | 18 及以上 |

## 快速开始

### 1. 初始化数据库

1. 使用 Navicat 或其他工具新建数据库（如 `smart_course_management`），字符集选择 `utf8mb4`
2. 导入脚本：执行 `backend/sql/smart_course_management.sql`（完整库脚本，包含若依系统表 + 课程/学生/教师/成绩/选课等业务表，共 25 张表）；若需使用定时任务功能，再执行 `backend/sql/quartz.sql`

### 2. 配置并启动后端

1. 进入 `backend/ruoyi-admin/src/main/resources/`
2. 复制 `application-druid-example.yml`，重命名为 `application-druid.yml`，填写你自己的 MySQL 账号密码
3. 复制 `application-example.yml`，重命名为 `application.yml`，修改 `token.secret` 为你自己生成的随机密钥
   > 本地 Redis 无密码时，`spring.redis.password` 保持为空即可
4. 使用 IDEA 打开 `backend` 目录，等待 Maven 依赖下载完成
5. 运行启动类 `ruoyi-admin/src/main/java/com/ruoyi/RuoYiApplication.java`
6. 后端访问地址：http://localhost:8080

### 3. 配置并启动前端

```bash
cd frontend
npm install        # 安装依赖
npm run dev        # 启动开发环境
```

前端访问地址：http://localhost:8081

> 默认管理员账号：admin / admin123（首次登录后请尽快修改）

### 4. 生产构建（可选）

```bash
cd frontend
npm run build:prod    # 生产环境打包，产物在 frontend/dist/
```

## 隐私与安全说明（重要）

上传到 GitHub 前请务必了解以下设计，本项目已通过 `.gitignore` 做好了隐私保护：

| 文件 | 处理方式 | 原因 |
| --- | --- | --- |
| `backend/.../application.yml` | **不上传**，仅上传 `application-example.yml` 模板 | 含 token 密钥、本地路径等 |
| `backend/.../application-druid.yml` | **不上传**，仅上传 `application-druid-example.yml` 模板 | 含 MySQL 账号密码、Druid 监控台密码 |
| `frontend/node_modules/` | 不上传（约 222MB） | clone 后执行 `npm install` 自动安装 |
| `backend/**/target/` | 不上传 | Maven 编译产物，clone 后自动生成 |
| `frontend/dist/` | 不上传 | 打包产物 |
| `.idea/`、`*.iml` | 不上传 | IDE 本地配置，与代码无关 |
| 前端 `.env.development` 等 | 上传 | 仅含页面标题和接口前缀，无敏感信息 |

**为什么这样设计：**
- `.gitignore` 只影响 Git 上传行为，**不删除、不修改你本地的任何文件**，项目照常运行
- 别人 clone 代码后，按上面"快速开始"步骤复制模板并填写自己的配置即可运行
- 若你的前端 `.env` 文件中以后填写了真实服务器地址/密钥，请同样加入 `.gitignore` 后改为上传模板

## 常见问题

**Q：clone 后后端启动报数据库连接失败？**
A：确认已复制 `application-druid-example.yml` 为 `application-druid.yml`，并正确填写账号密码、确认 MySQL 已启动、数据库已导入脚本。

**Q：前端 `npm install` 很慢或失败？**
A：可切换 npm 镜像源：`npm config set registry https://registry.npmmirror.com`，然后重新执行 `npm install`。

**Q：修改了代码需要上传？**
A：本地正常 `git add`、`git commit`、`git push` 即可，被忽略的配置文件不会上传，历史提交也不会包含它们（前提是从一开始就使用本仓库的 `.gitignore`）。

## License

MIT License（基于若依开源框架二次开发，保留原框架 License 声明）
