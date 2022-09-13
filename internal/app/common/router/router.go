/*
* @desc:后台路由
* @company:云南奇讯科技有限公司
* @Author: yixiaohu
* @Date:   2022/2/18 17:34
 */

package router

import (
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/y3512537/gf-verify-admin/internal/app/common/controller"
	commonService "github.com/y3512537/gf-verify-admin/internal/app/common/service"
)

func BindController(group *ghttp.RouterGroup) {
	group.Group("/pub", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		group.Group("/captcha", func(group *ghttp.RouterGroup) {
			group.Bind(
				controller.Captcha,
			)
		})

		// 文件上传
		group.Group("/upload", func(group *ghttp.RouterGroup) {
			group.Bind(
				controller.Upload,
			)
		})
	})
}
