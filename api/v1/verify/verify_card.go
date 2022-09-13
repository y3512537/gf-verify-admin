package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gtime"
	commonApi "github.com/y3512537/gf-verify-admin/api/v1/common"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
)

type CardAddReq struct {
	g.Meta      `path:"/add" tags:"卡密管理" method:"post" summary:"添加卡密"`
	SoftwareId  int64  `p:"softwareId"  v:"required#参数错误，软件ID不能为空"`
	CardType    int    `p:"cardType"  v:"required#参数错误，请选择卡密类型"`
	CardValue   int    `p:"cardValue"  v:"required#参数错误，请输入卡密面值"`
	UnbindCount int    `p:"unbindCount"  d:"5"`
	GenCount    int    `p:"genCount"  d:"1"`
	Comment     string `p:"comment"`
	Customize   int    `p:"customize"`
	KeyPrefix   string `p:"keyPrefix" v:"regex:[a-zA-Z]#卡密前缀只能是字母"`
	MultiOnline int    `p:"multiOnline"`
	IsReplace   int    `p:"isReplace"`
}

type CardListReq struct {
	g.Meta          `path:"/list" tags:"卡密管理" method:"get" summary:"卡密列表"`
	SoftwareId      int64       `p:"softwareId"`
	CardCode        string      `p:"cardCode"`
	BeginExpireTime *gtime.Time `p:"beginExpireTime"`
	EndExpireTime   *gtime.Time `p:"endExpireTime"`
	commonApi.PageReq
}

type CardEditReq struct {
	g.Meta      `path:"/edit" tags:"卡密管理" method:"put" summary:"编辑卡密"`
	Id          int64       `p:"id"  v:"required#参数错误，卡密ID不能为空"`
	Customize   int         `p:"customize"`
	MultiOnline int         `p:"multiOnline"`
	IsReplace   int         `p:"isReplace"`
	ExpireTime  *gtime.Time `p:"expireTime"`
	Comment     string      `p:"comment"`
}

type CardQuickRechargeReq struct {
	g.Meta `path:"/quick/recharge" tags:"卡密管理" method:"put" summary:"卡密充值"`
	Id     int64 `p:"id"  v:"required#参数错误，卡密ID不能为空"`
}

type CardQuickRechargeRes struct {
	g.Meta `mime:"application/json"`
}

type CardFreezeCardReq struct {
	g.Meta `path:"/freeze" tags:"卡密管理" method:"put" summary:"冻结卡密"`
	Id     int64 `p:"id"  v:"required#参数错误，卡密ID不能为空"`
}
type CardFreezeCardRes struct {
	g.Meta `mime:"application/json"`
}
type CardUnbindReq struct {
	g.Meta `path:"/unbind" tags:"卡密管理" method:"put" summary:"卡密解绑"`
	Id     int64 `p:"id"  v:"required#参数错误，卡密ID不能为空"`
}

type CardImportReq struct {
	g.Meta `path:"/import" tags:"卡密管理" method:"post" summary:"导入卡密" mime:"multipart/form-data"`
	File   *ghttp.UploadFile `p:"file"  v:"required#文件不能为空" type:"file"`
}

type CardImportRes struct {
	g.Meta `mime:"application/json"`
	Row    int64 `json:"row"`
}

type CardUnbindRes struct {
	g.Meta `mime:"application/json"`
	Row    int64 `json:"row"`
}

type CardDelReq struct {
	g.Meta `path:"/del" tags:"卡密管理" method:"delete" summary:"删除卡密"`
	Id     int64 `p:"id"  v:"required#参数错误，ID不能为空"`
}

type CardDelRes struct {
	g.Meta `mime:"application/json"`
	Id     int64 `json:"id"`
}

type CardAddRes struct {
	g.Meta `mime:"application/json"`
	List   *[]string `json:"list"`
}

type CardEditRes struct {
	g.Meta `mime:"application/json"`
}

type CardListRes struct {
	g.Meta `mime:"application/json"`
	Total  int                  `json:"total"`
	List   *[]CardListResEntity `json:"list"`
}

type CardListResEntity struct {
	entity.VerifyCard
	SoftwareName string `json:"softwareName"`
}
