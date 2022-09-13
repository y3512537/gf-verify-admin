package controller

import (
	"context"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service"
)

var CardSession = hCardSession{}

type hCardSession struct{}

// ListCardSession 在线设备列表
func (h *hCardSession) ListCardSession(ctx context.Context, req *v1.CardSessionListReq) (res *v1.CardSessionListRes, err error) {
	return service.DeviceSession().ListCardSession(ctx, req)
}
