# 部署说明

## 一、环境准备

| 组件 | 版本 | 说明 |
| --- | --- | --- |
| Ubuntu | 20.04 / 22.04 | 阿里云 ECS，2 核 4G 起 |
| JDK | 1.8 | `apt install openjdk-8-jdk` |
| MySQL | 8.0 | 建库 `smart_course_management`，字符集 utf8mb4 |
| Redis | 6.x | `apt install redis-server`，默认 6379 无密码 |
| Nginx | 1.18+ | 反向代理前端静态资源与 API |

## 二、数据库初始化

```bash
mysql -uroot -p -e "CREATE DATABASE smart_course_management DEFAULT CHARACTER SET utf8mb4;"
mysql -uroot -p smart_course_management < backend/sql/smart_course_management.sql
# 需要定时任务时再执行
mysql -uroot -p smart_course_management < backend/sql/quartz.sql
```

## 三、后端部署

```bash
# 1. 本地或服务器打包
cd backend
mvn clean package -DskipTests

# 2. 上传 jar
scp ruoyi-admin/target/ruoyi-admin.jar root@<服务器IP>:/opt/app/

# 3. 服务器上配置（注意不要把 application.yml 提交到仓库）
cd /opt/app
vi application.yml         # 数据库、Redis、token.secret
vi application-druid.yml   # 数据库连接池

# 4. 后台运行
nohup java -jar ruoyi-admin.jar --spring.profiles.active=druid \
  > /opt/app/logs/app.log 2>&1 &

# 5. 查看日志
tail -f /opt/app/logs/app.log
```

## 四、前端部署

```bash
cd frontend
npm install
npm run build:prod          # 产物在 dist/
scp -r dist/* root@<服务器IP>:/opt/web/
```

## 五、Nginx 配置

```nginx
server {
    listen 80;
    server_name _;

    # 前端静态资源
    location / {
        root /opt/web;
        index index.html;
        try_files $uri $uri/ /index.html;
    }

    # 后端接口（前端环境变量 VITE_APP_BASE_API=/prod-api）
    location /prod-api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_read_timeout 300s;
    }
}
```

```bash
nginx -t && nginx -s reload
```

> 反向代理同时解决了前端跨域问题，后端无需额外配置 CORS。

## 六、安全组 / 防火墙

| 端口 | 用途 | 是否对公网开放 |
| --- | --- | --- |
| 80 | HTTP 访问前端与接口 | ✅ |
| 22 | SSH 运维 | 建议限制来源 IP |
| 3306 / 6379 / 8080 | 数据库 / 缓存 / 后端 | ❌ 仅内网 |

## 七、备份

```bash
# 每日备份数据库
mysqldump -uroot -p smart_course_management > /opt/backup/db_$(date +%F).sql
```

## 八、常见问题

| 现象 | 原因 | 处理 |
| --- | --- | --- |
| 启动报 `Unable to connect to Redis` | Redis 未启动 | `systemctl start redis-server` |
| 启动报 `Access denied for user` | 数据库账号密码错误 | 检查 `application-druid.yml` |
| 页面 404 / 空白 | `dist` 未放到 Nginx 目录或路由未回退 | 检查 `try_files` |
| 接口 401 | token 过期或未携带请求头 | 重新登录换取 token |
