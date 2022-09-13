/*
* @desc:后台路由
* @company:云南奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2022/2/18 17:34
 */

package router

import (
	"github.com/gogf/gf/v2/net/ghttp"
	commonService "github.com/y3512537/gf-verify-admin/internal/app/common/service"
	"github.com/y3512537/gf-verify-admin/internal/app/system/controller"
	"github.com/y3512537/gf-verify-admin/internal/app/system/service"
)

func BindController(group *ghttp.RouterGroup) {
	group.Group("/system", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		// 系统初始化
		group.Bind(
			controller.DbInit,
		)
		group.Bind(
			//登录
			controller.Login,
		)
		//登录验证拦截
		_ = service.GfToken().Middleware(group)
		//context拦截器
		group.Middleware(service.Middleware().Ctx, service.Middleware().Auth)
		group.Bind(
			controller.User,
			controller.Menu,
			controller.Role,
			controller.DictType,
			controller.DictData,
			controller.Config,
			controller.Monitor,
			controller.LoginLog,
		)
	})
}
