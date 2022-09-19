package service

import (
	"context"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
)

type sVersion struct {
}

var insVersion = sVersion{}

func Version() *sVersion {
	return &insVersion
}

// ListVersion 查询版本列表
func (s *sVersion) ListVersion(ctx context.Context, req *v1.VersionListReq) (res *v1.VersionListRes, err error) {
	verModel := dao.VerifyVersion.Ctx(ctx)
	if req.SoftwareId > 0 {
		verModel = verModel.Where(dao.VerifyVersion.Columns().SoftwareId, req.SoftwareId)
	}
	if req.VersionNumber != "" {
		verModel = verModel.WhereLike(dao.VerifyVersion.Columns().VersionNumber, "%"+req.VersionNumber+"%")
	}
	if req.StoreType > 0 {
		verModel = verModel.LeftJoin("verify_attachment", "verify_attachment.att_id = verify_version.att_id").Where("store_type = ?", req.StoreType)
	}
	count, err := verModel.CountColumn(dao.VerifyVersion.Columns().SoftwareId)
	if err != nil {
		g.Log().Debug(ctx, "查询版本列表数量错误", err)
		return nil, err
	}
	list := make([]map[string]interface{}, count)
	res = &v1.VersionListRes{
		Total: count,
		List:  &list,
	}
	if count < 1 {
		g.Log().Debug(ctx, "版本列表为空", err)
		return res, nil
	}
	var verList []v1.VersionListEntity
	err = verModel.Page(req.PageNum, req.PageSize).Fields("verify_version.*").
		ScanList(&verList, "Ver")
	if err != nil {
		g.Log().Debug(ctx, "查询版本列表错误错误", err)
	}
	err = dao.VerifyAttachment.Ctx(ctx).
		Where("id", gdb.ListItemValuesUnique(verList, "Ver", "AttId")).
		ScanList(&verList, "Att", "Ver", "id:AttId")
	if err != nil {
		return nil, err
	}
	err = dao.VerifySoftware.Ctx(ctx).
		Where("id", gdb.ListItemValuesUnique(verList, "Ver", "SoftwareId")).
		ScanList(&verList, "Software", "Ver", "id:SoftwareId")
	mapList := make([]map[string]interface{}, len(verList))
	for i := range verList {
		ver := verList[i]
		mapList[i] = make(map[string]interface{})
		mapList[i]["id"] = ver.Ver.Id
		mapList[i]["softwareId"] = ver.Software.Id
		mapList[i]["softwareName"] = ver.Software.SoftwareName
		mapList[i]["versionNumber"] = ver.Ver.VersionNumber
		mapList[i]["isPublish"] = ver.Ver.IsPublish
		mapList[i]["link"] = ver.Att.FilePath
		mapList[i]["storeType"] = ver.Att.StoreType
		mapList[i]["password"] = ver.Att.OtherParam
		mapList[i]["comment"] = ver.Ver.Comment
		mapList[i]["attId"] = ver.Att.Id
		mapList[i]["updatedAt"] = ver.Ver.UpdatedAt
	}
	res.List = &mapList
	return res, err
}

func (s *sVersion) AddVersion(ctx context.Context, req *v1.VersionAddReq) (res *v1.VersionAddRes, err error) {
	if req.StoreType == 1 {
		return nil, gerror.New("数据存放还没做")
	}
	all, err := dao.VerifyVersion.Ctx(ctx).Where(dao.VerifyVersion.Columns().SoftwareId, req.SoftwareId).
		Where(dao.VerifyVersion.Columns().VersionNumber, req.VersionNumber).All()
	if err != nil {
		g.Log().Error(ctx, "查询版本数据错误", err)
		return res, err
	}
	if !all.IsEmpty() {
		return nil, gerror.New("软件版本《" + req.VersionNumber + "》已存在")
	}
	attachment := entity.VerifyAttachment{
		StoreType:  req.StoreType,
		FilePath:   req.Link,
		OtherParam: req.Password,
	}
	result, err := dao.VerifyAttachment.Ctx(ctx).Save(attachment)
	if err != nil {
		g.Log().Error(ctx, "保存附件错误", err)
		return res, err
	}
	attId, _ := result.LastInsertId()
	version := entity.VerifyVersion{
		SoftwareId:    req.SoftwareId,
		VersionNumber: req.VersionNumber,
		IsPublish:     req.IsPublish,
		AttId:         attId,
		Comment:       req.Comment,
	}
	result, err = dao.VerifyVersion.Ctx(ctx).Save(version)
	if err != nil {
		g.Log().Error(ctx, "保存版本信息错误", err)
		return res, err
	}
	res = &v1.VersionAddRes{
		AttId: attId,
	}
	return res, err
}

func (s *sVersion) EditVersion(ctx context.Context, req *v1.VersionEditReq) (res *v1.VersionEditRes, err error) {
	if req.StoreType == 1 {
		return nil, gerror.New("数据存放还没做")
	}
	version, err := dao.VerifyVersion.Ctx(ctx).WherePri(req.Id).One()
	if err != nil {
		g.Log().Error(ctx, "查询版本信息错误", err)
		return nil, err
	}
	if version.IsEmpty() {
		g.Log().Error(ctx, "查询版本信息错误,数据为空", err)
		return nil, err
	}
	m := version.Map()
	m["version_number"] = req.VersionNumber
	m["comment"] = req.Comment
	m["is_publish"] = req.IsPublish
	tx, err := dao.VerifyVersion.DB().Begin(ctx)
	_, err = tx.Update(dao.VerifyVersion.Table(), m, "id = ?", req.Id)
	if err != nil {
		g.Log().Error(ctx, "更新版本错误", err)
		return nil, err
	}
	record, err := dao.VerifyAttachment.Ctx(ctx).One("id = ?", m["att_id"])
	if err != nil {
		g.Log().Error(ctx, "查询附件错误", err)
		return nil, err
	}
	attMap := record.Map()
	attMap["store_type"] = req.StoreType
	attMap["other_param"] = req.Password
	attMap["file_path"] = req.Link
	_, err = tx.Update("verify_attachment", attMap, "id = ?", m["att_id"])
	if err != nil {
		g.Log().Error(ctx, "更新附件错误", err)
		return nil, err
	}
	defer func(tx *gdb.TX) {
		err := tx.Commit()
		if err != nil {
			g.Log().Error(ctx, "保存版本提交事务出错", err)
		}
	}(tx)
	return res, nil
}

func (s *sVersion) DelVersion(ctx context.Context, req *v1.VersionDelReq) (res *v1.VersionDelRes, err error) {
	one, err := dao.VerifyVersion.Ctx(ctx).WherePri(req.Id).One()
	if err != nil {
		return nil, err
	}
	if one.IsEmpty() {
		g.Log().Error(ctx, "无法删除版本，版本数据不存在", err)
		return nil, err
	}
	var version entity.VerifyVersion
	_ = one.Struct(&version)
	_, err = dao.VerifyAttachment.Ctx(ctx).WherePri(version.AttId).Delete()
	if err != nil {
		g.Log().Error(ctx, "无法删除版本，文件数据不存在", err)
		return nil, err
	}
	_, err = dao.VerifyVersion.Ctx(ctx).Delete(dao.VerifyVersion.Columns().Id, req.Id)
	if err != nil {
		g.Log().Error(ctx, "无法删除版本，版本数据不存在", err)
		return nil, err
	}
	return res, nil
}

func (s *sVersion) ReleaseVersion(ctx context.Context, req *v1.VersionReleaseReq) (res *v1.VersionReleaseRes, err error) {
	one, err := dao.VerifyVersion.Ctx(ctx).WherePri(req.Id).One()
	if err != nil || one.IsEmpty() {
		return nil, gerror.New("软件版本不存在")
	}
	verMap := one.Map()
	if verMap["is_publish"] == req.IsPublish {
		return res, nil
	}
	verMap["is_publish"] = req.IsPublish
	_, err = dao.VerifyVersion.Ctx(ctx).WherePri(req.Id).Update(verMap)
	if err != nil {
		return nil, gerror.NewSkip(30, "发布失败，请联系管理员")
	}
	return res, nil
}
