package service

import (
	"context"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
)

type sCardSession struct {
}

var insCardSession = sCardSession{}

func CardSession() *sCardSession {
	return &insCardSession
}

func (s *sCardSession) ListCardSession(ctx context.Context, req *v1.CardSessionListReq) (res *v1.CardSessionListRes, err error) {
	model := g.Model(dao.VerifyCardSession.Table()+" cs").LeftJoin("verify_card c", "cs.card_id = c.id").
		LeftJoin(dao.VerifyDevice.Table()+" d", "d.id = cs.device_id")
	if req.CardCode != "" {
		model.WhereLike("card_code", req.CardCode+"%")
	}
	count, _ := model.Count()
	result, err := model.Fields("cs.id", "cs.card_id", "session_timeout",
		"cs.login_ip", "device_id", "cs.created_at", "cs.updated_at", "card_code as cardCode", "d.device_code as deviceCode").Page(req.PageNum, req.PageSize).All()
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

func (s *sCardSession) OffLineCardSession(ctx context.Context, req *v1.OfflineCardSessionReq) (res *v1.OfflineCardSessionRes, err error) {
	cardSession := &entity.VerifyCardSession{}
	err = dao.VerifyCardSession.Ctx(ctx).WherePri(req.Id).Scan(cardSession)
	if err != nil {
		return nil, gerror.NewCode(gcode.New(50, "设备不存在", err))
	}
	token := cardSession.DeviceToken
	_, err = g.Redis().Do(ctx, "DEL", token)
	if err != nil {
		return nil, gerror.NewCode(gcode.New(51, "设备下线异常", err))
	}
	return
}
