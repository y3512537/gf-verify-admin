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

// LoginCard 卡密登录
func (h *hAppCard) LoginCard(ctx context.Context, req *v1.CardLoginReq) (res *v1.CardLoginRes, err error) {
	return service.AppCard().LoginCard(ctx, req)
}
