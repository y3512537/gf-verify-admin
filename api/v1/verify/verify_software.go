package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	commonApi "github.com/y3512537/gf-verify-admin/api/v1/common"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
)

type SoftwareReq struct {
	SoftwareName   string `p:"softwareName" v:"bail|required|length:1,30#|请输入软件名称|软件名称长度应该在 1 到 30 之间"` // 软件名称
	SoftwareStatus int    `p:"softwareStatus" d:"1"`                                                    // 软件状态
	CardLength     int    `p:"cardLength" v:"bail|required|min:8#|请输入密钥长度|密钥长度最少为8位" d:"10"`            // 密钥长度
	EncryptType    string `p:"encryptType"  d:"AES"`                                                    // 加密方式 AES RSA MD5
	KeyPrefix      string `p:"keyPrefix" v:"bail|length:1,5|regex:[a-zA-Z]#|密钥前缀长度不能超过5位|密钥前缀只能为大小写字母"` // 密钥前缀
	MultiOnline    int    `p:"multiOnline" d:"20"`                                                      // 设备上限
	IsReplace      int    `p:"isReplace" d:"0"`                                                         // 是否顶号登录 1 是 0 否
	Heartbeat      int    `p:"heartbeat" v:"bail|required#|心跳间隔不能为空" d:"5"`                             // 心跳间隔
	OpenTrial      int    `p:"openTrial" d:"0"`                                                         // 开启试用 1 是 0 否
	TrialCount     int    `p:"trialCount" d:"0"`                                                        // 试用次数
	TrialTime      int    `p:"trialTime" d:"0"`                                                         // 试用时间(分钟)
	TrialDuration  int    `p:"trialDuration" d:"0"`                                                     // 每次试用间隔
	Comment        string `p:"comment"`                                                                 // 软件备注
}

type SoftwareAddReq struct {
	g.Meta `path:"/add" tags:"软件管理" method:"post" summary:"添加软件"`
	*SoftwareReq
}

type SoftwareEditReq struct {
	g.Meta `path:"/edit" tags:"软件管理" method:"put" summary:"编辑软件"`
	Id     int64 `p:"id" v:"required#参数错误，id不能为空"`
	*SoftwareReq
}

type SoftwareListReq struct {
	g.Meta       `path:"/list" tags:"软件管理" method:"get" summary:"软件列表"`
	SoftwareName string `p:"softwareName"`
	commonApi.PageReq
}

type SoftwareDelReq struct {
	g.Meta     `path:"/del" tags:"软件管理" method:"delete" summary:"删除软件"`
	SoftwareId int64 `p:"softwareId" v:"required#参数错误，id不能为空"`
}

type SoftwareGetReq struct {
	g.Meta `path:"/{id}" tags:"软件管理" method:"get" summary:"查询软件"`
	Id     string `p:"id"`
}

type SoftwareAddRes struct {
	g.Meta `mime:"application/json"`
}

type SoftwareEditRes struct {
	g.Meta `mime:"application/json"`
	Id     string `json:"id"`
}
type SoftwareListRes struct {
	g.Meta `mime:"application/json" example:"string"`
	Total  int        `json:"total"`
	List   []Software `json:"list"`
}

type Software struct {
	entity.VerifySoftware
}

type SoftwareDelRes struct {
	Result string `json:"result"`
}
type SoftwareGetRes struct {
	*entity.VerifySoftware
}
