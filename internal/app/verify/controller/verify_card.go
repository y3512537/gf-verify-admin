package controller

import (
	"context"
	"github.com/gogf/gf/v2/frame/g"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service"
)

var Card = hCard{}

type hCard struct{}

// AddCard 新增卡密
func (h *hCard) AddCard(ctx context.Context, req *v1.CardAddReq) (res *v1.CardAddRes, err error) {
	return service.Card().AddCard(ctx, req)
}

// ListCard 查询卡密列表
func (h *hCard) ListCard(ctx context.Context, req *v1.CardListReq) (res *v1.CardListRes, err error) {
	g.Log().Debug(ctx, "进来拉ListCard,参数==", req)
	return service.Card().ListCard(ctx, req)
}

// EditCard 编辑卡密
func (h *hCard) EditCard(ctx context.Context, req *v1.CardEditReq) (res *v1.CardAddRes, err error) {
	return service.Card().EditCard(ctx, req)
}

// QuickRechargeCard 快速续费
func (h *hCard) QuickRechargeCard(ctx context.Context, req *v1.CardQuickRechargeReq) (res *v1.CardQuickRechargeRes, err error) {
	return service.Card().QuickRechargeCard(ctx, req)
}

// FreezeCard 快速冻结
func (h *hCard) FreezeCard(ctx context.Context, req *v1.CardFreezeCardReq) (res *v1.CardFreezeCardRes, err error) {
	return service.Card().FreezeCard(ctx, req)
}

// UnbindCard 卡密解绑
func (h *hCard) UnbindCard(ctx context.Context, req *v1.CardUnbindReq) (res *v1.CardUnbindRes, err error) {
	return service.Card().UnbindCard(ctx, req)
}

// DelCard 删除卡密
func (h *hCard) DelCard(ctx context.Context, req *v1.CardDelReq) (res *v1.CardDelRes, err error) {
	return service.Card().DelCard(ctx, req)
}

// ImportCard 导入卡密
func (h *hCard) ImportCard(ctx context.Context, req *v1.CardImportReq) (res *v1.CardImportRes, err error) {
	return service.Card().ImportCard(ctx, req)
}
