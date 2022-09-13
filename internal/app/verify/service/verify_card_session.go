package service

import (
	"context"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
)

type sCardSession struct {
}

var insCardSession = sCardSession{}

func DeviceSession() *sCardSession {
	return &insCardSession
}

func (s *sCardSession) ListCardSession(ctx context.Context, req *v1.CardSessionListReq) (res *v1.CardSessionListRes, err error) {
	model := g.Model(dao.VerifyCardSession.Table()+" cs").LeftJoin("verify_card c", "cs.card_id = c.id")
	if req.CardCode != "" {
		model.WhereLike("card_code = ?", req.CardCode)
	}
	count, _ := model.Count()
	result, err := model.All()
	if err != nil {
		return nil, gerror.New("查询设备Session出现异常")
	}
	res = &v1.CardSessionListRes{
		Total: count,
	}
	if count <= 0 {
		return res, nil
	}
	list := make([]v1.CardSessionListItem, result.Len())

	err = result.Structs(&list)
	res.List = &list
	if err != nil {
		g.Log().Error(ctx, err)
		return nil, gerror.New("查询设备Session出现异常")
	}
	return res, err
}
