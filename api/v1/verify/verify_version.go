package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	commonApi "github.com/y3512537/gf-verify-admin/api/v1/common"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
)

type VersionListReq struct {
	g.Meta        `path:"/list" tags:"版本管理" method:"get" summary:"版本列表"`
	SoftwareId    int64  `p:"softwareId"`
	VersionNumber string `p:"versionNumber"`
	StoreType     int    `p:"storeType"`
	commonApi.PageReq
}

type VersionAddReq struct {
	g.Meta        `path:"/add" tags:"版本管理" method:"post" summary:"添加版本"`
	SoftwareId    int64  `p:"softwareId"  v:"required#参数错误，软件ID不能为空"`
	IsPublish     int    `p:"isPublish"`
	VersionNumber string `p:"versionNumber"  v:"required#参数错误，版本号不能为空"`
	StoreType     int    `p:"storeType" v:"required#参数错误，存储类型不能为空"`
	Link          string `p:"link" v:"required#参数错误，下载链接不能为空"`
	Password      string `p:"password"`
	Comment       string `p:"comment"`
}

type VersionEditReq struct {
	g.Meta        `path:"/edit" tags:"版本管理" method:"put" summary:"编辑版本"`
	Id            int64  `p:"idd"  v:"required#参数错误，版本ID不能为空"`
	IsPublish     int    `p:"isPublish"`
	VersionNumber string `p:"versionNumber"  v:"required#参数错误，版本号不能为空"`
	StoreType     int    `p:"storeType" v:"required#参数错误，存储类型不能为空"`
	Link          string `p:"link" v:"required#参数错误，下载链接不能为空"`
	Password      string `p:"password"`
	Comment       string `p:"comment"`
}

type VersionDelReq struct {
	g.Meta `path:"/del" tags:"版本管理" method:"delete" summary:"删除版本"`
	Id     int64 `p:"id"  v:"required#参数错误，版本ID不能为空"`
}

type VersionReleaseReq struct {
	g.Meta    `path:"/release" tags:"版本管理" method:"put" summary:"发布版本"`
	Id        int64 `p:"id"  v:"required#参数错误，版本ID不能为空"`
	IsPublish int   `p:"isPublish"   v:"required#参数错误"`
}

type VersionListEntity struct {
	Ver      *entity.VerifyVersion
	Att      *entity.VerifyAttachment
	Software *entity.VerifySoftware
}

type VersionListRes struct {
	g.Meta `mime:"application/json"`
	Total  int                       `json:"total"`
	List   *[]map[string]interface{} `json:"list"`
}

type VersionAddRes struct {
	g.Meta `mime:"application/json"`
	AttId  int64 `json:"attId"`
}

type VersionEditRes struct {
	g.Meta `mime:"application/json"`
}

type VersionDelRes struct {
	g.Meta `mime:"application/json"`
}
type VersionReleaseRes struct {
	g.Meta `mime:"application/json"`
}
