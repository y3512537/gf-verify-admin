package controller

import (
	"context"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service"
)

var Version = hVersion{}

type hVersion struct {
}

func (h *hVersion) ListVersion(ctx context.Context, req *v1.VersionListReq) (res *v1.VersionListRes, err error) {
	return service.Version().ListVersion(ctx, req)
}

func (h *hVersion) AddVersion(ctx context.Context, req *v1.VersionAddReq) (res *v1.VersionAddRes, err error) {
	return service.Version().AddVersion(ctx, req)
}

func (h *hVersion) UpdateVersion(ctx context.Context, req *v1.VersionEditReq) (res *v1.VersionEditRes, err error) {
	return service.Version().EditVersion(ctx, req)
}

func (h *hVersion) DeleteVersion(ctx context.Context, req *v1.VersionDelReq) (res *v1.VersionDelRes, err error) {
	return service.Version().DelVersion(ctx, req)
}

func (h *hVersion) ReleaseVersion(ctx context.Context, req *v1.VersionReleaseReq) (res *v1.VersionReleaseRes, err error) {
	return service.Version().ReleaseVersion(ctx, req)
}
