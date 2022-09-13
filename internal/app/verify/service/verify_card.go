package service

import (
	"context"
	"fmt"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gfile"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"
	"github.com/rs/xid"
	"github.com/xuri/excelize/v2"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
	"github.com/y3512537/gf-verify-admin/library/libUtils"
	"strings"
)

type sCard struct {
}

var insCard = sCard{}

func Card() *sCard {
	return &insCard
}

func (s *sCard) ListCard(ctx context.Context, req *v1.CardListReq) (res *v1.CardListRes, err error) {
	cardModel := dao.VerifyCard.Ctx(ctx)
	if req.SoftwareId > 0 {
		cardModel = cardModel.Where("software_id = ?", req.SoftwareId)
	}
	if req.CardCode != "" {
		cardModel = cardModel.WhereLike("card_code", "%"+req.CardCode+"%")
	}
	if !req.BeginExpireTime.IsZero() && !req.EndExpireTime.IsZero() {
		cardModel.WhereBetween("expireTime", req.BeginExpireTime, req.EndExpireTime)
	}
	count, err := cardModel.CountColumn("id")
	if err != nil {
		g.Log().Error(ctx, "查询卡密信息异常 参数", req, err)
		return nil, gerror.New("查询失败，请联系管理员")
	}
	cardList := make([]v1.CardListResEntity, 0)
	res = &v1.CardListRes{
		Total: count,
		List:  &cardList,
	}
	if count < 1 {
		return res, nil
	}
	err = cardModel.Page(req.PageNum, req.PageSize).OrderDesc("updated_at").
		InnerJoin("verify_software", "verify_software.id = verify_card.software_id").
		Fields("verify_card.*,verify_software.software_name").Scan(&cardList)
	if err != nil {
		g.Log().Error(ctx, "查询卡密信息异常 参数", req, err)
		return nil, gerror.New("查询失败，请联系管理员")
	}
	return res, err
}

func (s *sCard) AddCard(ctx context.Context, req *v1.CardAddReq) (res *v1.CardAddRes, err error) {
	cardData := new(entity.VerifyCard)
	if req.Customize == 0 {
		one, err := dao.VerifySoftware.Ctx(ctx).One("id = ?", req.SoftwareId)
		if err != nil {
			g.Log().Error(ctx, "查询软件信息异常 id = ", req.SoftwareId, err)
			return nil, gerror.New("添加卡密失败，软件不存在")
		}
		var software entity.VerifySoftware
		err = one.Struct(&software)
		if err != nil {
			g.Log().Error(ctx, "软件转换异常", err)
			return nil, gerror.New("系统内部错误，请联系管理员")
		}
		cardData.KeyPrefix = software.KeyPrefix
		cardData.MultiOnline = software.MultiOnline
		cardData.IsReplace = software.IsReplace
	} else {
		cardData.KeyPrefix = req.KeyPrefix
		cardData.MultiOnline = req.MultiOnline
		cardData.IsReplace = req.IsReplace
	}
	genCount := req.GenCount
	cardList := make([]string, genCount)
	err = dao.VerifyCard.Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		for i := 0; i < genCount; i++ {
			cardData.SoftwareId = req.SoftwareId
			cardData.CardCode = cardData.KeyPrefix + strings.ToUpper(xid.New().String())
			cardData.CardType = req.CardType
			cardData.CardValue = req.CardValue
			cardData.CardStatus = 1
			cardData.UnbindCount = req.UnbindCount
			cardData.GenTime = gtime.Now()
			cardData.Customize = req.Customize
			_, err = dao.VerifyCard.Ctx(ctx).Insert(cardData)
			if err != nil {
				g.Log().Error(ctx, "添加卡密失败 id = ", req.SoftwareId, err)
				return err
			}
			cardList[i] = cardData.CardCode
		}
		return nil
	})
	if err != nil {
		g.Log().Debug(ctx, "生成卡密失败", err)
		return nil, gerror.New("系统内部错误，请联系管理员")
	}
	res = &v1.CardAddRes{
		List: &cardList,
	}
	return res, err
}

func (s *sCard) EditCard(ctx context.Context, req *v1.CardEditReq) (res *v1.CardAddRes, err error) {
	record, err := dao.VerifyCard.Ctx(ctx).One("id = ?", req.Id)
	if err != nil {
		return nil, gerror.New("查询卡密出现异常")
	}
	if record.IsEmpty() {
		return nil, gerror.New("卡密不存在")
	}
	card := entity.VerifyCard{}
	_ = record.Struct(&card)
	card.Customize = req.Customize
	card.MultiOnline = req.MultiOnline
	card.Comment = req.Comment
	card.ExpireTime = req.ExpireTime
	_, err = dao.VerifyCard.Ctx(ctx).Update(card, "id = ?", card.Id)
	if err != nil {
		return nil, err
	}
	return
}

func (s *sCard) QuickRechargeCard(ctx context.Context, req *v1.CardQuickRechargeReq) (res *v1.CardQuickRechargeRes, err error) {
	record, err := dao.VerifyCard.Ctx(ctx).One("id = ?", req.Id)
	if err != nil {
		return nil, gerror.New("查询卡密出现异常")
	}
	if record.IsEmpty() {
		return nil, gerror.New("卡密不存在")
	}
	card := entity.VerifyCard{}
	_ = record.Struct(&card)
	if card.ActivateTime.IsZero() {
		return nil, gerror.New("该卡密尚未激活")
	}
	expireTime, err := libUtils.SetExpireTime(card.ExpireTime, card.CardType, card.CardValue)
	if err != nil {
		g.Log().Error(ctx, "生成到期时间出现错误", err)
		return nil, gerror.New("生成到期时间出现错误")
	}
	card.ExpireTime = expireTime
	_, _ = dao.VerifyCard.Ctx(ctx).Update(card, "id = ?", card.Id)
	return
}

func (s *sCard) FreezeCard(ctx context.Context, req *v1.CardFreezeCardReq) (res *v1.CardFreezeCardRes, err error) {
	record, err := dao.VerifyCard.Ctx(ctx).One("id = ?", req.Id)
	if err != nil {
		return nil, gerror.New("查询卡密出现异常")
	}
	if record.IsEmpty() {
		return nil, gerror.New("卡密不存在")
	}
	card := entity.VerifyCard{}
	_ = record.Struct(&card)
	card.CardStatus = 0
	_, _ = dao.VerifyCard.Ctx(ctx).Update(card, "id = ?", card.Id)
	//下线所有设备

	return
}

func (s *sCard) UnbindCard(ctx context.Context, req *v1.CardUnbindReq) (res *v1.CardUnbindRes, err error) {
	record, err := dao.VerifyCard.Ctx(ctx).One("id = ?", req.Id)
	if err != nil {
		return nil, gerror.New("查询卡密出现异常")
	}
	if record.IsEmpty() {
		return nil, gerror.New("卡密不存在")
	}
	result, err := dao.VerifyDevice.Ctx(ctx).Delete("card_id = ?", req.Id)
	if err != nil {
		return nil, gerror.New("解绑出现异常")
	}
	card := entity.VerifyCard{}
	_ = record.Struct(&card)
	res = &v1.CardUnbindRes{}
	if card.ActivateTime.IsZero() {
		return res, nil
	}
	affected, _ := result.RowsAffected()
	res.Row = affected
	return res, nil
}

func (s *sCard) DelCard(ctx context.Context, req *v1.CardDelReq) (res *v1.CardDelRes, err error) {
	result, err := dao.VerifyCard.Ctx(ctx).Delete("id = ?", req.Id)
	if err != nil {
		return nil, gerror.New("删除卡密失败")
	}
	id, _ := result.RowsAffected()
	res = &v1.CardDelRes{
		Id: id,
	}
	return res, err
}

func (s *sCard) ImportCard(ctx context.Context, req *v1.CardImportReq) (res *v1.CardImportRes, err error) {
	data, err := g.Config().Get(ctx, "verify")
	configMap := data.MapStrStr()
	tempDir := configMap["tempDir"]
	file := req.File
	open, err := file.FileHeader.Open()
	_, err = file.Save(tempDir, true)
	excel, err := excelize.OpenReader(open)
	defer func() {
		if err := excel.Close(); err != nil {
			fmt.Println(err)
		}
		err2 := gfile.Remove(tempDir + file.Filename)
		if err2 != nil {
			fmt.Println(err)
		}
	}()
	rows, err := excel.GetRows("Sheet1")
	cards := make([]*entity.VerifyCard, len(rows)-1)
	for rowNumber, row := range rows {
		if rowNumber == 0 {
			continue
		}
		card := &entity.VerifyCard{}
		for index, colCell := range row {
			fmt.Print(colCell, "\t")
			if index == 0 {
				card.CardCode = colCell
			}
			if index == 1 {
				record, err := dao.VerifySoftware.Ctx(ctx).WhereLike("software_name", colCell).One()
				if err != nil {
					g.Log().Error(ctx, "查询软件异常", err)
					continue
				}
				if record.IsEmpty() {
					g.Log().Error(ctx, colCell+"查询软件为空", err)
					continue
				}
				software := entity.VerifySoftware{}
				_ = record.Struct(&software)
				card.SoftwareId = software.Id
			}
			if index == 2 {
				cardType := getCardTypeForImport(colCell)
				if cardType == 10 {
					card.CardType = 3
					card.CardValue = 10
				} else {
					card.CardValue = 1
					card.CardType = cardType
				}
			}
			if index == 3 {
				if colCell == "正常" {
					card.CardStatus = 1
				} else {
					card.CardStatus = 0
				}
			}
			if index == 4 {
				card.MultiOnline = gconv.Int(colCell)
			}
			if index == 5 {
				if colCell == "是" {
					card.IsReplace = 1
				} else {
					card.IsReplace = 0
				}
			}
			if index == 6 {
				card.GenTime = gtime.ParseTimeFromContent(colCell, "Y-m-d H:i:s")
			}
			if index == 7 {
				card.ExpireTime = gtime.ParseTimeFromContent(colCell, "Y-m-d H:i:s")
			}
			if index == 8 {
				card.ActivateTime = gtime.ParseTimeFromContent(colCell, "Y-m-d H:i:s")
			}
			cards[rowNumber-1] = card
		}
	}
	_, _ = dao.VerifyCard.Ctx(ctx).Insert(cards)
	return nil, nil
}

func getCardTypeForImport(cardTypeStr string) int {
	res := 1
	switch cardTypeStr {
	case "分钟卡":
		res = 1
	case "天卡":
		res = 3
	case "月卡":
		res = 4
	case "季卡":
		res = 5
	case "半年卡":
		res = 6
	case "年卡":
		res = 7
	default:
		res = 10
	}
	return res
}
