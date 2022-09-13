// =================================================================================
// Code generated by GoFrame CLI tool. DO NOT EDIT. 
// =================================================================================

package do

import(
"github.com/gogf/gf/v2/frame/g"
"github.com/gogf/gf/v2/os/gtime"
)

// VerifyCardSession is the golang structure of table verify_card_session for DAO operations like Where/Data.
type VerifyCardSession struct {
g.Meta `orm:"table:verify_card_session, do:true"`
    Id interface{} // 编号      
    CardId interface{} // 卡密Id    
    SessionTimeout *gtime.Time // 超时时间  
    LoginIp interface{} // 登录IP    
    DeviceId interface{} // 设备ID    
    CreatedAt      *gtime.Time // 创建时间  
    UpdatedAt      *gtime.Time // 修改时间  
    DeletedAt      *gtime.Time // 删除时间  
}