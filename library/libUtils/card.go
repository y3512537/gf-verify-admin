package libUtils

import (
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/os/gtime"
	"time"
)

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
