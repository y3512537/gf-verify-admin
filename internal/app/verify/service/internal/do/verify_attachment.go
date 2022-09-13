// =================================================================================
// Code generated by GoFrame CLI tool. DO NOT EDIT. 
// =================================================================================

package do

import(
"github.com/gogf/gf/v2/frame/g"
"github.com/gogf/gf/v2/os/gtime"
)

// VerifyAttachment is the golang structure of table verify_attachment for DAO operations like Where/Data.
type VerifyAttachment struct {
g.Meta `orm:"table:verify_attachment, do:true"`
    Id interface{} //                                      
    FileName interface{} // 附件名                               
    Md5 interface{} // MD5                                  
    StoreType interface{} // 1 二进制 2 直接 3 蓝奏云 4 百度网盘  
    OtherParam interface{} // 其他参数，用于保存网盘密码等         
    FilePath interface{} // 附件存储路径                         
    FileSize interface{} // 附件大小 byte                        
    FileType interface{} //                                      
    Remark interface{} // 备注                                 
    CreatedAt  *gtime.Time // 创建时间                             
    UpdatedAt  *gtime.Time // 修改时间                             
    DeletedAt  *gtime.Time // 删除时间                             
}