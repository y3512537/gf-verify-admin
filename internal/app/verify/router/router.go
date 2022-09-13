package router

import (
	"github.com/gogf/gf/v2/net/ghttp"
	commonService "github.com/y3512537/gf-verify-admin/internal/app/common/service"
	"github.com/y3512537/gf-verify-admin/internal/app/system/service"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/controller"
)

func BindController(group *ghttp.RouterGroup) {
	group.Group("/software", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		group.Bind(
			controller.Software,
		)
		_ = service.GfToken().Middleware(group)
		group.Middleware(service.Middleware().Ctx, service.Middleware().Auth)
	})
	group.Group("/version", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		group.Bind(
			controller.Version,
		)
		_ = service.GfToken().Middleware(group)
		group.Middleware(service.Middleware().Ctx, service.Middleware().Auth)
	})
	group.Group("/card", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		group.Bind(
			controller.Card,
		)
		_ = service.GfToken().Middleware(group)
		group.Middleware(service.Middleware().Ctx, service.Middleware().Auth)
	})
	group.Group("/card-session", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		group.Bind(
			controller.CardSession,
		)
		_ = service.GfToken().Middleware(group)
		group.Middleware(service.Middleware().Ctx, service.Middleware().Auth)
	})
	group.Group("/app-api/card", func(group *ghttp.RouterGroup) {
		group.Middleware(commonService.Middleware().MiddlewareCORS)
		group.Bind(
			controller.AppCard,
		)
		group.Middleware(service.Middleware().Ctx, service.Middleware().Auth)
	})
}
