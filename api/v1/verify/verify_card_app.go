package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

type CardLoginReq struct {
	g.Meta     `path:"/login" tags:"卡密验证" method:"post" summary:"卡密登录"`
	SecretId   string `p:"secretId"  v:"required#参数错误，secretId不能为空"`
	CardCode   string `p:"cardCode"  v:"required#参数错误，卡密不能为空"`
	DeviceCode string `p:"deviceCode" v:"required#参数错误，设备ID不能为空"`
	DeviceName string `p:"deviceName"`
	Nonce      string `p:"nonce"  v:"required#参数错误，Nonce不能为空"`
	Sign       string `p:"sign"  v:"required#参数错误，签名不能为空"`
}

type CardLoginRes struct {
	g.Meta          `mime:"application/json"`
	CardType        string      `json:"cardType"`
	Expires         *gtime.Time `json:"expires"`
	ExpiresTs       int64       `json:"expiresTs"`
	Heartbeat       int         `json:"heartbeat"`
	Remark          string      `json:"remark"`
	ServerTimestamp string      `json:"serverTimestamp"`
	Token           string      `json:"token"`
	Version         VersionInfo `json:"version"`
}

type VersionInfo struct {
	LatestVersionId     int64       `json:"latestVersionId"`
	LatestVersionNumber string      `json:"latestVersionNumber"`
	UpdatedAt           *gtime.Time `json:"updatedAt"`
	Comment             string      `json:"comment"`
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

type AppCardUnbindReq struct {
	g.Meta     `path:"/unbind" tags:"卡密管理" method:"post" summary:"卡密解绑"`
	CardCode   string `p:"cardCode"  v:"required#参数错误，卡密ID不能为空"`
	DeviceCode string `p:"deviceCode"  v:"required#参数错误，设备编号不能为空"`
	Timestamp  int64  `p:"timestamp" v:"required#参数错误，时间不能为空"`
	Sign       string `p:"sign"   v:"required#参数签名错误"`
}

type AppCardUnbindRes struct {
	g.Meta `mime:"application/json"`
	Row    int64 `json:"row"`
}
type AppCardRechargeReq struct {
	g.Meta    `path:"/recharge" tags:"卡密管理" method:"post" summary:"以卡充卡"`
	CardCode  string `p:"cardCode"  v:"required#卡号不能为空"`
	CardCode2 string `p:"cardCode2"  v:"required#卡号不能为空"` // card2的时间加到card1上
	Timestamp int64  `p:"timestamp" v:"required#参数错误，时间不能为空"`
	Sign      string `p:"sign"   v:"required#参数签名错误"`
}

type AppCardRechargeRes struct {
	g.Meta    `mime:"application/json"`
	Expires   *gtime.Time `json:"expires"`
	ExpiresTs int64       `json:"expiresTs"`
}

type CardServerTimeReq struct {
	g.Meta `path:"/server-time" tags:"卡密验证" method:"get" summary:"服务器时间"`
	Token  string `json:"token"`
}

type CardServerTimeRes struct {
	ServerTime      string `json:"serverTime"`
	ServerTimestamp int64  `json:"serverTimestamp"`
}
