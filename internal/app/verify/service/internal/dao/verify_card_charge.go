// =================================================================================
// This is auto-generated by GoFrame CLI tool only once. Fill this file as you wish.
// =================================================================================

package dao

import (
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao/internal"
)

// verifyCardChargeDao is the data access object for table verify_card_charge.
// You can define custom methods on it to extend its functionality as you wish.
type verifyCardChargeDao struct {
	*internal.VerifyCardChargeDao
}

var (
	// VerifyCardCharge is globally public accessible object for table verify_card_charge operations.
	VerifyCardCharge = verifyCardChargeDao{
		internal.NewVerifyCardChargeDao(),
	}
)

// Fill with you ideas below.