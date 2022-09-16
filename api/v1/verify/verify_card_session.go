package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	commonApi "github.com/y3512537/gf-verify-admin/api/v1/common"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
)

type CardSessionListReq struct {
	g.Meta   `path:"/list" tags:"在线设备" method:"get" summary:"在线设备列表"`
	CardCode string `p:"cardCode"`
	commonApi.PageReq
}

type OfflineCardSessionReq struct {
	g.Meta `path:"/offline" tags:"在线设备" method:"post" summary:"强制设备下线"`
	Id     int64 `p:"id"`
}

type OfflineCardSessionRes struct {
	g.Meta `mime:"application/json"`
}

type CardSessionListRes struct {
	g.Meta `mime:"application/json"`
	Total  int                    `json:"total"`
	List   *[]CardSessionListItem `json:"list"`
}

type CardSessionListItem struct {
	entity.VerifyCardSession
	CardCode   string `json:"cardCode"`
	DeviceCode string `json:"deviceCode"`
}
