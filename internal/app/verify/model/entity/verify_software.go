// =================================================================================
// Code generated by GoFrame CLI tool. DO NOT EDIT. 
// =================================================================================

package entity

import(
"github.com/gogf/gf/v2/os/gtime"
)

// VerifySoftware is the golang structure for table verify_software.
type VerifySoftware struct {
    Id             int64       `json:"id"             description:"软件id"`                  
    SoftwareName   string      `json:"softwareName"   description:"软件名称"`                
    SecretId       string      `json:"secretId"       description:"软件唯一标识"`            
    SecretKey      string      `json:"secretKey"      description:"软件密钥"`                
    SoftwareStatus int         `json:"softwareStatus" description:"软件状态"`                
    CardLength     int         `json:"cardLength"     description:"密钥长度"`                
    EncryptType    string      `json:"encryptType"    description:"加密方式 AES RSA MD5"`    
    KeyPrefix      string      `json:"keyPrefix"      description:"密钥前缀"`                
    MultiOnline    int         `json:"multiOnline"    description:"设备上限"`                
    IsReplace      int         `json:"isReplace"      description:"是否顶号登录 1 是 0 否"`  
    Heartbeat      int         `json:"heartbeat"      description:"心跳间隔"`                
    OpenTrial      int         `json:"openTrial"      description:"开启试用 1 是 0 否"`      
    TrialCount     int         `json:"trialCount"     description:"试用次数"`                
    TrialTime      int         `json:"trialTime"      description:"试用时间(分钟)"`          
    TrialDuration  int         `json:"trialDuration"  description:"每次试用间隔"`            
    Comment        string      `json:"comment"        description:"软件备注"`                
    CreatedAt      *gtime.Time `json:"createdAt"      description:"创建时间"`                
    UpdatedAt      *gtime.Time `json:"updatedAt"      description:"修改时间"`                
    DeletedAt      *gtime.Time `json:"deletedAt"      description:"删除时间"`                
}