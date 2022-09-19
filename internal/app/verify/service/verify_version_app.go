package service

import (
	"context"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
	"github.com/y3512537/gf-verify-admin/library/libUtils"
)

type sAppVersion struct {
}

var insAppVersion = sAppVersion{}

func AppVersion() *sAppVersion {
	return &insAppVersion
}

func (s *sAppVersion) LastVersion(ctx context.Context, req *v1.LatestVersionReq) (res *v1.LatestVersionRes, err error) {
	token := req.Token
	tokenRecord, err := g.Redis().Do(ctx, "GET", token)
	if err != nil {
		return nil, gerror.New("获取版本失败，服务器异常")
	}
	if tokenRecord.IsEmpty() {
		return nil, gerror.New("获取版本失败，token已过期")
	}
	versionRecord, err := dao.VerifyVersion.Ctx(ctx).WherePri(req.Id).One()
	if err != nil {
		return nil, gerror.New("获取版本失败，查询不到版本号")
	}
	if !versionRecord.IsEmpty() {
		res = &v1.LatestVersionRes{}
		versionEntity := entity.VerifyVersion{}
		_ = versionRecord.Struct(&versionEntity)
		//查询链接
		attachmentRecord, err := dao.VerifyAttachment.Ctx(ctx).WherePri(versionEntity.AttId).One()
		if err != nil {
			g.Log().Error(ctx, "查询版本附件异常", err)
			code := gcode.New(10, "登录失败，请联系管理员", err)
			return res, gerror.NewCode(code)
		}
		attachment := entity.VerifyAttachment{}
		_ = attachmentRecord.Struct(&attachment)
		if attachment.StoreType == 3 {
			link, fileName, err := libUtils.LanZouCloud().GetLanZouCloudRealLink(ctx, attachment.FilePath, attachment.OtherParam)
			if err != nil {
				res.Status = 10
			} else {
				res.Status = 0
				res.FileName = fileName
			}
			res.Link = link
		} else {
			res.Link = attachment.FilePath
		}
		res.VersionNumber = versionEntity.VersionNumber
		res.UpdatedAt = versionEntity.UpdatedAt
		res.Comment = versionEntity.Comment
	}
	return res, err
}
