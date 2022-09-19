package controller

import (
	"context"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service"
)

var AppCard = hAppCard{}

type hAppCard struct{}

// CardHeartbeat 卡密心跳
func (h *hAppCard) CardHeartbeat(ctx context.Context, req *v1.CardHeartbeatReq) (res *v1.CardHeartbeatRes, err error) {
	return service.AppCard().CardHeartbeat(ctx, req)
}

// CardLogin 卡密登录
func (h *hAppCard) CardLogin(ctx context.Context, req *v1.CardLoginReq) (res *v1.CardLoginRes, err error) {
	return service.AppCard().CardLogin(ctx, req)
}

// CardUnbind 解绑当前设备
func (h *hAppCard) CardUnbind(ctx context.Context, req *v1.AppCardUnbindReq) (res *v1.AppCardUnbindRes, err error) {
	return service.AppCard().CardUnbind(ctx, req)
}

// CardRecharge 以卡冲卡
func (h *hAppCard) CardRecharge(ctx context.Context, req *v1.AppCardRechargeReq) (res *v1.AppCardRechargeRes, err error) {
	return service.AppCard().CardRecharge(ctx, req)
}

// ServerTime 获取服务器时间
func (h *hAppCard) ServerTime(ctx context.Context, req *v1.CardServerTimeReq) (res *v1.CardServerTimeRes, err error) {
	return service.AppCard().ServerTime(ctx, req)
}
