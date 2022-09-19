package main

import (
	"github.com/y3512537/gf-verify-admin/internal/cmd"
	//_ "github.com/y3512537/gf-verify-admin/packed"
	_ "github.com/y3512537/gf-verify-admin/internal/config"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gctx"
	"github.com/gogf/gf/v2/os/glog"
	"github.com/y3512537/gf-verify-admin/internal/app/system/service"
)

func init() {
	ctx := gctx.New()
	if service.SysInitConfig["autoInit"].Bool() && service.SysInit().IsCreateConfigFile() {
		// 加载配置文件
		err := service.SysInit().LoadConfigFile()
		if err != nil {
			g.Log().Panic(ctx, err)
		}
	}
}

func main() {
	g.Log().SetFlags(glog.F_ASYNC | glog.F_TIME_DATE | glog.F_TIME_TIME | glog.F_FILE_LONG)
	cmd.Main.Run(gctx.New())
}
