package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

type CardLoginReq struct {
	g.Meta     `path:"/login" tags:"卡密验证" method:"post" summary:"卡密登录"`
	SecretId   string      `p:"secretId"  v:"required#参数错误，secretId不能为空"`
	CardCode   string      `p:"cardCode"  v:"required#参数错误，卡密不能为空"`
	DeviceCode string      `p:"deviceCode" v:"required#参数错误，设备ID不能为空"`
	DeviceName string      `p:"deviceName"`
	Nonce      string      `p:"nonce"  v:"required#参数错误，Nonce不能为空"`
	Timestamp  *gtime.Time `p:"timestamp" v:"required#参数错误，timestamp不能为空"`
	Sign       string      `p:"sign"  v:"required#参数错误，签名不能为空"`
}

type CardLoginRes struct {
	g.Meta          `mime:"application/json"`
	CardType        string      `json:"cardType"`
	Expires         *gtime.Time `json:"expires"`
	ExpiresTs       int64       `json:"expiresTs"`
	Remark          string      `json:"remark"`
	ServerTimestamp string      `json:"serverTimestamp"`
	Token           string      `json:"token"`
	Version         VersionRes  `json:"version"`
}

type CardHeartbeatReq struct {
	g.Meta    `path:"/heartbeat" tags:"卡密验证" method:"post" summary:"心跳验证"`
	CardCode  string      `p:"cardCode"`
	SecretId  string      `p:"secretId"`
	Nonce     string      `p:"nonce"`
	Timestamp *gtime.Time `p:"timestamp"`
	Token     string      `p:"token"`
	Sign      string      `p:"sign"`
}

type CardHeartbeatRes struct {
	Expires         string `json:"expires"`
	ExpiresTs       int64  `json:"expiresTs"`
	ServerTimestamp int64  `json:"serverTimestamp"`
	Nonce           string `json:"nonce"`
	Sign            string `json:"sign"`
}

type VersionRes struct {
	VersionNumber string      `json:"versionNumber"`
	Link          string      `json:"link"`
	FileName      string      `json:"fileName"`
	Status        int         `json:"status"`
	UpdatedAt     *gtime.Time `json:"updatedAt"`
	Comment       string      `json:"comment"`
}
