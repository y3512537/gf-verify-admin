// =================================================================================
// Code generated by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// VerifyCardCharge is the golang structure of table verify_card_charge for DAO operations like Where/Data.
type VerifyCardCharge struct {
	g.Meta           `orm:"table:verify_card_charge, do:true"`
	Id               interface{} // 充值记录ID
	CardCode         interface{} // 被充值卡密
	UseCardCode      interface{} // 使用的卡密
	ExpireTimeBefore *gtime.Time // 充值前到期日期
	ExpireTimeAfter  *gtime.Time // 充值后到期日期
	CreatedAt        *gtime.Time // 创建时间
	UpdatedAt        *gtime.Time // 修改时间
	DeletedAt        *gtime.Time // 删除时间
}
