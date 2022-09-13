/*
* @desc:部门model
* @company:云南奇讯科技有限公司
* @Author: yixiaohu<yxh669@qq.com>
* @Date:   2022/4/11 9:07
 */

package model

import "github.com/y3512537/gf-verify-admin/internal/app/system/model/entity"

type SysDeptTreeRes struct {
	*entity.SysDept
	Children []*SysDeptTreeRes `json:"children"`
}
