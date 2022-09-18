/*
* @desc:字典数据
* @company:云南奇讯科技有限公司
* @Author: yixiaohu<yxh669@qq.com>
* @Date:   2022/3/18 11:56
 */

package model

type DictTypeRes struct {
	DictName string `json:"name"`
	Remark   string `json:"remark"`
}

// DictDataRes 字典数据
type DictDataRes struct {
	DictType  string `json:"dictType"`
	DictSort  string `json:"dictSort"`
	DictValue string `json:"dictValue"`
	DictLabel string `json:"dictLabel"`
	CssClass  string `json:"cssClass"`
	ListClass string `json:"listClass"`
	IsDefault int    `json:"isDefault"`
	Remark    string `json:"remark"`
}
