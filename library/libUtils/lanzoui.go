package libUtils

import (
	"context"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"
	"strings"
)

type sLanZouCloud struct {
}

var insLanZouCloud = sLanZouCloud{}

func LanZouCloud() *sLanZouCloud {
	return &insLanZouCloud
}

func (s *sLanZouCloud) GetLanZouCloudRealLink(ctx context.Context, sourceLink string, password string) (link string, fileName string, err error) {
	signResponse, err := g.Client().Get(ctx, sourceLink)
	if err != nil {
		g.Log().Error(ctx, "获取蓝奏云下载地址失败", err)
		return link, fileName, err
	}
	htmlRes := signResponse.ReadAllString()
	split := strings.Split(htmlRes, "&sign=")
	if len(split) < 1 {
		return link, fileName, gerror.New("获取蓝奏云签名失败")
	}
	after := split[1]
	signSplit := strings.Split(after, "&p")
	if len(signSplit) < 1 {
		return link, fileName, gerror.New("获取蓝奏云签名失败")
	}
	sign := signSplit[0]
	lanZouApi := "https://www.lanzoub.com/ajaxm.php"
	headerMap := make(map[string]string)
	headerMap["authority"] = "www.lanzoub.com"
	headerMap["method"] = "POST"
	headerMap["path"] = "/ajaxm.php"
	headerMap["scheme"] = "https"
	headerMap["accept"] = "application/json, text/javascript, */*"
	headerMap["accept-encoding"] = "gzip, deflate, br"
	headerMap["accept-language"] = "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
	headerMap["content-type"] = "application/x-www-form-urlencoded"
	headerMap["origin"] = "https://www.lanzoub.com"
	headerMap["referer"] = sourceLink
	headerMap["x-requested-with"] = "XMLHttpRequest"
	headerMap["Connection"] = "Keep-Alive"
	formMap := make(map[string]string)
	formMap["action"] = "downprocess"
	formMap["sign"] = sign
	formMap["p"] = password
	cookieMap := make(map[string]string)
	cookieMap["ntime"] = gtime.Now().TimestampStr()
	response, err := g.Client().Header(headerMap).Cookie(cookieMap).Post(ctx, lanZouApi, formMap)
	if err != nil {
		g.Log().Error(ctx, "获取蓝奏云下载地址失败", err)
		return link, fileName, err
	}
	status := response.Status
	resBody := response.ReadAllString()
	g.Log().Debug(ctx, "获取蓝奏云下载地址 status", status, "res body =>", resBody)
	m := gconv.MapStrStr(resBody)
	info := m["inf"]
	zt := m["zt"]
	if gconv.Int(zt) == 0 {
		return link, fileName, gerror.New("蓝奏云地址解析失败：" + info)
	}
	domain := m["dom"]
	url := m["url"]
	g.Log().Debug(ctx, "info ", info)
	return domain + "/file/" + url, info, nil
}
