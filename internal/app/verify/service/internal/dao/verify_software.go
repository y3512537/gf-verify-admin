// =================================================================================
// This is auto-generated by GoFrame CLI tool only once. Fill this file as you wish.
// =================================================================================

package dao

import (
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao/internal"
)

// verifySoftwareDao is the data access object for table verify_software.
// You can define custom methods on it to extend its functionality as you wish.
type verifySoftwareDao struct {
	*internal.VerifySoftwareDao
}

var (
	// VerifySoftware is globally public accessible object for table verify_software operations.
	VerifySoftware = verifySoftwareDao{
		internal.NewVerifySoftwareDao(),
	}
)

// Fill with you ideas below.
