# gf-verify-admin

## 项目介绍
- 一个简单的卡密验证系统，目前只具备基础功能
- 项目框架：Go Frame 2.0 + Vue3 + Element Plus
- 本项目修改自 [gfastv3](https://gitee.com/tiger1103/gfast.git), 简化了部分功能
- 前端地址 [gf-verify-ui](https://github.com/y3512537/gf-verify-ui.git)
## 系统功能

| 功能   | 描述          | 状态  |
|------|-------------|-----|
| 卡密管理 | 卡密CRUD      | 已完成 |
| 版本管理 | 版本CRUD，目前支持蓝奏云和直连 | 已完成 |
| 卡密验证 | 卡密登录、心跳验证   | 已完成 |
| 在线设备 | 在线设备列表      | 未完成 |
| 远程变量 |             | 待开发 |
| 云控功能 |             | 待开发 |
| 卡密直销 |             | 待开发 |

## 部署教程
### 本地开发

首先确保你本地已安装golang version >= 1.16
- 安装gf-tools 安装教程: [gf-tools](https://goframe.org/pages/viewpage.action?pageId=1115782)
    ```
    gf run main.go
    ```

### 线上部署
- 首先修改 manifest/config/config-prod.yaml，修改数据库等信息
- 打包资源文件
  ```
  gf pack manifest/config,resource packed/data.go
- 打开 `main.go` 里面的第一行注释
- 执行打包命令(需要先安装gf tool)
  ```
  gf build
  ```
  - docker 部署(推荐)
    - 进入dockerFile文件目录
      ```
      docker build -t gf-verify-admin:latest .
      docker run --rm --name gf-verify-admin -p 8022:8022 -e GF_GCFG_FILE=config-prod.yaml gf-verify-admin:latest
      ```
  - 直接部署
    复制 `./build` 目录下对应的系统执行文件服务器,然后进入所在目录
    ```
    $ chmod +x ./gf-verify-admin
    $ ./gf-verify-admin --gf.gcfg.file=config-prod.yaml
    ```
## 感谢(排名不分先后)
- GFast: https://gitee.com/tiger1103/gfast.git

- gf框架: https://github.com/gogf/gf

- vue-next-admin https://gitee.com/lyt-top/vue-next-admin

- swaggo https://github.com/swaggo/swag

- gtoken https://github.com/goflyfox/gtoken

- casbin https://github.com/casbin/casbin


## 免责声明
```
 1. 本项目仅限自己学习使用，请勿将本项目用于非法目的。
 2. 所有与使用相关的资源直接风险均由用户承担
```
