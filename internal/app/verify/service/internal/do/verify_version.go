// =================================================================================
// Code generated by GoFrame CLI tool. DO NOT EDIT. 
// =================================================================================

package do

import(
"github.com/gogf/gf/v2/frame/g"
"github.com/gogf/gf/v2/os/gtime"
)

// VerifyVersion is the golang structure of table verify_version for DAO operations like Where/Data.
type VerifyVersion struct {
g.Meta `orm:"table:verify_version, do:true"`
    Id interface{} //           
    SoftwareId interface{} // 软件Id    
    VersionNumber interface{} // 主版本号  
    IsPublish interface{} // 是否发布  
    AttId interface{} // 附件Id    
    Comment interface{} // 版本备注  
    CreatedAt     *gtime.Time // 创建时间  
    UpdatedAt     *gtime.Time // 修改时间  
    DeletedAt     *gtime.Time // 删除时间  
}