// =================================================================================
// Code generated by GoFrame CLI tool. DO NOT EDIT. 
// =================================================================================

package do

import(
"github.com/gogf/gf/v2/frame/g"
"github.com/gogf/gf/v2/os/gtime"
)

// VerifyCard is the golang structure of table verify_card for DAO operations like Where/Data.
type VerifyCard struct {
g.Meta `orm:"table:verify_card, do:true"`
    Id interface{} // 卡密ID                        
    SoftwareId interface{} // 软件ID                        
    CardCode interface{} // 密钥                          
    CardValue interface{} // 面值                          
    CardType interface{} // 1 分钟 2 小时 3 天 4 月 5 年  
    CardStatus interface{} // 状态 1 正常 0 冻结            
    UnbindCount interface{} // 允许解绑次数                  
    GenTime      *gtime.Time // 生成时间                      
    ActivateTime *gtime.Time // 激活时间                      
    ExpireTime   *gtime.Time // 到期时间                      
    Customize interface{} // 自定义属性                    
    KeyPrefix interface{} // 卡密前缀                      
    MultiOnline interface{} // 多开上限                      
    IsReplace interface{} // 顶号登录 1 是 0 否            
    Comment interface{} // 备注                          
    CreatedAt    *gtime.Time // 创建时间                      
    UpdatedAt    *gtime.Time // 修改时间                      
    DeletedAt    *gtime.Time // 删除时间                      
}