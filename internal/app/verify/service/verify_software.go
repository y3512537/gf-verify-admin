package service

import (
	"context"
	"fmt"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/text/gstr"
	"github.com/gogf/gf/v2/util/gconv"
	"github.com/gogf/gf/v2/util/guid"
	verify "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
	"github.com/y3512537/gf-verify-admin/library/libUtils"
)

type sSoftware struct {
}

var insSoftware = sSoftware{}

func Software() *sSoftware {
	return &insSoftware
}

// AddSoftware 保存软件
func (s *sSoftware) AddSoftware(ctx context.Context, req *verify.SoftwareAddReq) (res *verify.SoftwareAddRes, err error) {
	record, err := dao.VerifySoftware.Ctx(ctx).Where(dao.VerifySoftware.Columns().SoftwareName, req.SoftwareName).One()
	if err != nil {
		return nil, gerror.New("数据库链接失败")
	}
	if !record.IsEmpty() {
		return nil, gerror.New("软件名称《" + req.SoftwareName + "》已存在")
	}
	if req.CardLength < 8 {
		return nil, gerror.New("卡号最小长度是8位")
	}
	m := gconv.Map(req)
	// secretId 固定24位，aes加密和des加密 要求长度
	secretId := libUtils.GenSecret(24)
	// secretKey 固定32位
	secretKey := guid.S()
	m["secret_id"] = gstr.ToLower(secretId)
	m["secret_key"] = secretKey
	_, err = dao.VerifySoftware.Ctx(ctx).Save(m)
	if err != nil {
		return nil, gerror.New("保存软件失败")
	}
	return res, nil
}

// EditSoftware 更新软件
func (s *sSoftware) EditSoftware(ctx context.Context, req *verify.SoftwareEditReq) (res *verify.SoftwareEditRes, err error) {
	record, err := dao.VerifySoftware.Ctx(ctx).WherePri(req.Id).One()
	if err != nil {
		return res, gerror.New("数据查询失败")
	}
	if record.IsEmpty() {
		return res, gerror.New("软件不存在或已删除")
	}
	m := gconv.Map(req)
	err = dao.VerifySoftware.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		_, err = dao.VerifySoftware.Ctx(ctx).WherePri(req.Id).Update(m)
		if err != nil {
			g.Log("EditSoftware").Error(ctx, "软件更新出现错误", err)
			return err
		}
		return nil
	})
	if err != nil {
		return res, gerror.New("数据更新失败")
	}
	return
}

func (s *sSoftware) DelSoftware(ctx context.Context, req *verify.SoftwareDelReq) (res *verify.SoftwareDelRes, err error) {
	err = dao.VerifySoftware.Ctx(ctx).Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		result, err := dao.VerifySoftware.Ctx(ctx).WherePri(req.SoftwareId).Delete()
		if err != nil {
			g.Log().Error(ctx, "删除失败", err)
			return err
		}
		//删除卡密
		cr, err := dao.VerifyCard.Ctx(ctx).Delete(dao.VerifyCard.Columns().SoftwareId, req.SoftwareId)
		if err != nil {
			return err
		}
		rowsAffected, err := cr.RowsAffected()
		if err != nil {
			return err
		}
		msg := fmt.Sprint("删除了 d%", rowsAffected, " 张卡密")
		//删除版本
		ver, err := dao.VerifyVersion.Ctx(ctx).Delete(dao.VerifyVersion.Columns().SoftwareId, req.SoftwareId)
		if err != nil {
			return err
		}
		i, err := ver.RowsAffected()
		if err != nil {
			return err
		}
		msg = fmt.Sprint("，d%", i, " 个版本号")
		affected, err := result.RowsAffected()
		if affected > 0 {
			res = &verify.SoftwareDelRes{Result: msg}
		}
		return nil
	})
	return res, err
}

func (s *sSoftware) GetSoftware(ctx context.Context, req *verify.SoftwareGetReq) (res *verify.SoftwareGetRes, err error) {
	record, err := dao.VerifySoftware.Ctx(ctx).WherePri(req.Id).One()
	if err != nil {
		g.Log().Error(ctx, "查询数据失败", err)
		return res, gerror.New("查询失败")
	}
	if record.IsEmpty() {
		return res, gerror.New("查询数据为空")
	}
	_ = record.Struct(&res)
	return res, err

}
func (s *sSoftware) ListSoftware(ctx context.Context, req *verify.SoftwareListReq) (res *verify.SoftwareListRes, err error) {
	desc := dao.VerifySoftware.Ctx(ctx).OrderDesc(dao.VerifySoftware.Columns().UpdatedAt)
	count, err := desc.Count()
	if err != nil {
		g.Log().Error(ctx, "查询数据失败", err)
		return res, gerror.New("查询失败")
	}
	res = &verify.SoftwareListRes{
		Total: count,
	}
	if count < 1 {
		return res, err
	}
	softwareModel := dao.VerifySoftware.Ctx(ctx)
	if req.SoftwareName != "" {
		softwareModel = softwareModel.WhereLike(dao.VerifySoftware.Columns().SoftwareName, "%"+req.SoftwareName+"%")
	}
	result, err := softwareModel.Page(req.PageNum, req.PageSize).OrderDesc(dao.VerifySoftware.Columns().UpdatedAt).All()
	if err != nil {
		g.Log().Error(ctx, "查询数据失败", err)
		return res, gerror.New("查询失败")
	}
	err = result.Structs(&res.List)
	if err != nil {
		return nil, err
	}
	return res, err
}
