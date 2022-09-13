package controller

import (
	"context"
	verify "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service"
)

var Software = hSoftware{}

type hSoftware struct{}

func (h *hSoftware) AddSoftware(ctx context.Context, req *verify.SoftwareAddReq) (res *verify.SoftwareAddRes, err error) {
	res, err = service.Software().AddSoftware(ctx, req)
	return res, err
}

func (h *hSoftware) EditSoftware(ctx context.Context, req *verify.SoftwareEditReq) (res *verify.SoftwareEditRes, err error) {
	return service.Software().EditSoftware(ctx, req)
}

func (h *hSoftware) DelSoftware(ctx context.Context, req *verify.SoftwareDelReq) (res *verify.SoftwareDelRes, err error) {
	return service.Software().DelSoftware(ctx, req)
}

func (h *hSoftware) ListSoftware(ctx context.Context, req *verify.SoftwareListReq) (res *verify.SoftwareListRes, err error) {
	return service.Software().ListSoftware(ctx, req)
}

func (h *hSoftware) GetSoftware(ctx context.Context, req *verify.SoftwareGetReq) (res *verify.SoftwareGetRes, err error) {
	return service.Software().GetSoftware(ctx, req)
}
