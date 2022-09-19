package libUtils

import (
	"context"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/grand"
	"math/rand"
	"time"
)

// 定义5套随机编码规则，去掉有歧义的O0 L1

var LETTERS_RULES = [...]string{lettersRule1, lettersRule2, lettersRule3, lettersRule4, lettersRule5}

var lettersRule1 = "QYSFNDRKWXUCEH5GZP467JMA28VTB9L3"
var lettersRule2 = "A8769SPYM4LEUXWQKHZT2VJFRG5DN3BC"
var lettersRule3 = "XRY7NZGJ56892EMLDFSAHWU4VBCPT3KQ"
var lettersRule4 = "FZ28H69S4TDCRALUJVNMKE5G7PQXBWY3"
var lettersRule5 = "W859ECFBX6N2JVPLUYK34TH7RSQMGZAD"

func SetExpireTime(activeTime *gtime.Time, cardType int, value int) (expireTime *gtime.Time, err error) {
	switch cardType {
	case 1:
		return activeTime.Add(time.Duration(value) * time.Minute), nil
	case 2:
		return activeTime.Add(time.Duration(value) * time.Hour), nil
	case 3:
		return activeTime.Add(time.Duration(value) * time.Hour), nil
	case 4:
		return activeTime.AddDate(0, value, 0), nil
	case 5:
		return activeTime.AddDate(0, value*3, 0), nil
	case 6:
		return activeTime.AddDate(0, value*6, 0), nil
	case 7:
		return activeTime.AddDate(value, 0, 0), nil
	case 8:
		return activeTime.AddDate(100, 0, 0), nil
	default:
		return nil, gerror.NewCode(gcode.New(11, "未知时间类型", nil))
	}
}

// GenCardCode 生成卡号
// 简单粗暴的生成方式，根据输入的长度，遍历模板
// TODO
func GenCardCode(ctx context.Context, cardLen int, secretKey string) (cardCode string) {
	b := make([]byte, cardLen)
	for i := range b {
		b[i] = LETTERS_RULES[1][rand.Intn(len(lettersRule1))]
	}
	cardCode = string(b)
	return
}

// TODO
func ParseCardCode(prefix string, secretKey string) {

}

// GenSecret 生成指定长度字符串
func GenSecret(length int) (secret string) {
	return grand.Str(lettersRule1, length)
}
