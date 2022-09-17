package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

type LatestVersionReq struct {
	g.Meta `path:"/:id" tags:"版本信息" method:"get" summary:"最新版本"`
	Id     string `p:"id"`
	Token  string `p:"token"`
}

type LatestVersionRes struct {
	g.Meta `mime:"application/json"`
	VersionRes
}

type VersionRes struct {
	VersionNumber string      `json:"versionNumber"`
	Link          string      `json:"link"`
	FileName      string      `json:"fileName"`
	Status        int         `json:"status"`
	UpdatedAt     *gtime.Time `json:"updatedAt"`
	Comment       string      `json:"comment"`
}
