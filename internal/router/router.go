/*
* @desc:路由绑定
* @company:云南奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2022/2/18 16:23
 */

package router

import (
	"github.com/gogf/gf/v2/net/ghttp"
	commonRouter "github.com/y3512537/gf-verify-admin/internal/app/common/router"
	systemRouter "github.com/y3512537/gf-verify-admin/internal/app/system/router"
	verifyRouter "github.com/y3512537/gf-verify-admin/internal/app/verify/router"
)

func BindController(group *ghttp.RouterGroup) {
	group.Group("/api/v1", func(group *ghttp.RouterGroup) {
		group.Middleware(ghttp.MiddlewareHandlerResponse)
		// 绑定后台路由
		systemRouter.BindController(group)
		// 绑定公共路由
		commonRouter.BindController(group)
		// 验证模块路由
		verifyRouter.BindController(group)
	})

}
