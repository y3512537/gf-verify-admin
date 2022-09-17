package controller

import (
	"context"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service"
)

var AppVersion = hAppVersion{}

type hAppVersion struct{}

func (h *hAppVersion) LastVersion(ctx context.Context, req *v1.LatestVersionReq) (res *v1.LatestVersionRes, err error) {
	return service.AppVersion().LastVersion(ctx, req)
}
