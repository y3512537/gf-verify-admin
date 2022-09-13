package service

import (
	"context"
	"github.com/bwmarrin/snowflake"
	"github.com/gogf/gf/v2/crypto/gmd5"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"
	"github.com/golang-jwt/jwt"
	"github.com/rs/xid"
	v1 "github.com/y3512537/gf-verify-admin/api/v1/verify"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/model/entity"
	"github.com/y3512537/gf-verify-admin/internal/app/verify/service/internal/dao"
	"github.com/y3512537/gf-verify-admin/library/libUtils"
	"strings"
	"time"
)

type sAppCard struct {
}

var insAppCard = sAppCard{}

func AppCard() *sAppCard {
	return &insAppCard
}

func (s *sAppCard) CardHeartbeat(ctx context.Context, req *v1.CardHeartbeatReq) (res *v1.CardHeartbeatRes, err error) {
	//校验参数签名
	data, _ := g.Config("config").Get(ctx, "verify")
	configMap := data.MapStrStr()
	g.Log().Debug(ctx, configMap)
	path := configMap["host"] + configMap["heartbeatPath"]
	url := path + "&method=POST"
	signString := url + "&cardCode=" + req.CardCode + "&nonce=" +
		req.Nonce + "&secretId=" + req.SecretId +
		"&timestamp=" + req.Timestamp.TimestampStr() +
		"&token=" + req.Token
	g.Log().Debug(ctx, "sign string = >", signString)
	sign, err := gmd5.Encrypt(signString)
	if sign != req.Sign {
		code := gcode.New(60, "签名验证失败", err)
		return nil, gerror.NewCode(code)
	}
	// 先从缓存拿出token
	tokenRecord, err := g.Redis().Do(ctx, "GET", req.Token)
	if err != nil {
		return nil, gerror.New("心跳失败，卡密不存在")
	}
	if tokenRecord.IsEmpty() {
		code := gcode.New(100, "验证失败，Token已过期", nil)
		return nil, gerror.NewCode(code)
	}
	softwareRecord, _ := dao.VerifySoftware.Ctx(ctx).One("secret_id = ?", req.SecretId)
	if err != nil {
		g.Log().Error(ctx, "查询卡密信息异常 参数", req, err)
		return nil, gerror.New("心跳失败，软件不存在")
	}
	software := entity.VerifySoftware{}
	err = softwareRecord.Struct(&software)
	if err != nil {
		g.Log().Error(ctx, "查询卡密信息异常 参数", req, err)
		return nil, gerror.New("心跳失败，软件不存在")
	}
	//验证心跳间隔
	heartbeat := software.Heartbeat
	// 解密token
	token := tokenRecord.String()
	g.Log().Debug(ctx, "token,", token, heartbeat)
	claim, err := jwt.Parse(token, func(token *jwt.Token) (interface{}, error) {
		return []byte(software.SecretKey), nil
	})
	if err != nil {
		g.Log().Error(ctx, "jwt token 解密失败 参数", req, err)
		return nil, gerror.New("心跳失败，非法的Token")
	}
	g.Log().Debug(ctx, "token 验证返回值==", claim)
	card := entity.VerifyCard{}
	cardRecord, err := dao.VerifyCard.Ctx(ctx).One("card_code = ?", req.CardCode)
	if err != nil || cardRecord.IsEmpty() {
		g.Log().Error(ctx, "查询卡密信息异常 参数", req, err)
		return nil, gerror.New("心跳失败，卡密不存在")
	}
	err = cardRecord.Struct(&card)
	if err != nil {
		g.Log().Error(ctx, "查询卡密信息异常 参数", req, err)
		return nil, gerror.New("心跳失败，请联系管理员")
	}
	if card.CardStatus == 0 {
		return nil, gerror.New("验证失败，该卡已被冻结")
	}
	if card.ExpireTime.Before(gtime.Now()) {
		return nil, gerror.New("验证失败，卡密已过期")
	}
	now := gtime.Now()
	resParam := path + "&expires=" + card.ExpireTime.String() + "&expiresTs=" + card.ExpireTime.TimestampStr() +
		"&serverTimestamp=" + now.TimestampStr() + "&nonce=" + ""
	sign, err = gmd5.Encrypt(resParam)
	if err != nil {
		g.Log().Error(ctx, "md5加密数据错误", err)
		return nil, gerror.New("心跳失败，请联系管理员")
	}
	node, _ := snowflake.NewNode(1)
	res = &v1.CardHeartbeatRes{
		Expires:         card.ExpireTime.String(),
		ExpiresTs:       card.ExpireTime.Timestamp(),
		ServerTimestamp: gtime.Timestamp(),
		Nonce:           node.Generate().String(),
		Sign:            sign,
	}
	record, err := dao.VerifyCardSession.Ctx(ctx).One("card_id = ?", card.Id)
	if err != nil || record.IsEmpty() {
		return nil, gerror.New("Session查询异常")
	}
	cardSession := entity.VerifyCardSession{}
	_ = record.Struct(&cardSession)
	if cardSession.SessionTimeout.Before(gtime.Now()) {
		g.Log().Debug(ctx, "当前Session Time：{}", cardSession.SessionTimeout, "续签Token")
		err = dao.VerifyCardSession.Ctx(ctx).Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
			cardSession.SessionTimeout = gtime.Now().Add(time.Duration(heartbeat) * time.Minute)
			_, err := dao.VerifyCardSession.Ctx(ctx).Update(cardSession, "id = ?", cardSession.Id)
			if err != nil {
				return err
			}
			//续签Token
			_, err = g.Redis().Do(ctx, "SETEX", req.Token, software.Heartbeat*90, token)
			do, err := g.Redis().Do(ctx, "TTL", req.Token)
			if err != nil {
				g.Log().Error(ctx, "查询Token ttl 异常", err)
				return err
			}
			ttl := do.Int64()
			g.Log().Debug(ctx, "续签后的Session Time：{}", cardSession.SessionTimeout, ",剩余时间TTl = ", ttl)
			return err
		})
	} else {
		do, err := g.Redis().Do(ctx, "TTL", req.Token)
		if err != nil {
			g.Log().Error(ctx, "查询Token ttl 异常", err)
			return nil, err
		}
		ttl := do.Int64()
		g.Log().Debug(ctx, "当前Session Time：{}", cardSession.SessionTimeout, ",剩余时间TTl = ", ttl, "暂时不续签")
	}

	if err != nil {
		return nil, gerror.New("Token续签异常")
	}
	return res, nil
}

func (s *sAppCard) LoginCard(ctx context.Context, req *v1.CardLoginReq) (res *v1.CardLoginRes, err error) {
	// 根据secretId查询软件并判断软件状态
	data, err := g.Config("config").Get(ctx, "verify")
	software := entity.VerifySoftware{}
	softwareRecord, err := dao.VerifySoftware.Ctx(ctx).One("secret_id = ?", req.SecretId)
	if err != nil {
		g.Log().Error(ctx, "卡号登录查询软件异常, cardCode", req.SecretId, err)
		code := gcode.New(10, "登录失败，请联系管理员", err)
		return nil, gerror.NewCode(code)
	}
	if softwareRecord.IsEmpty() {
		g.Log().Error(ctx, "通过secretId 查询软件为空: secretId:", req.SecretId)
		code := gcode.New(10, "登录失败，secretId不存在", err)
		return nil, gerror.NewCode(code)
	}
	err = softwareRecord.Struct(&software)
	if err != nil {
		g.Log().Error(ctx, "softwareRecord.Struct(&software) error,secretId", req.SecretId)
		code := gcode.New(10, "登录失败，请联系管理员", err)
		return nil, gerror.NewCode(code)
	}
	if software.SoftwareStatus == 0 {
		code := gcode.New(10, "登录失败，软件已禁用", err)
		return nil, gerror.NewCode(code)
	}
	//校验参数签名
	configMap := data.MapStrStr()
	g.Log().Debug(ctx, configMap)
	path := configMap["host"] + configMap["loginPath"]
	url := path + "&method=POST"
	signString := url + "&cardCode=" + req.CardCode + "&deviceCode=" + req.DeviceCode + "&nonce=" +
		req.Nonce + "&secretId=" + req.SecretId + "&timestamp=" + req.Timestamp.TimestampStr()
	g.Log().Debug(ctx, "sign string = >", signString)
	sign, err := gmd5.Encrypt(signString)
	if err != nil {
		g.Log().Error(ctx, "卡密登录md5签名失败", err)
		code := gcode.New(10, "登录失败，参数签名错误", err)
		return nil, gerror.NewCode(code)
	}
	if sign != req.Sign {
		code := gcode.New(10, "登录失败，参数签名错误", err)
		return nil, gerror.NewCode(code)
	}
	//查询卡密信息
	cardCode := strings.TrimSpace(req.CardCode)
	card := entity.VerifyCard{}
	record, err := dao.VerifyCard.Ctx(ctx).One("card_code = ?", cardCode)
	if err != nil {
		g.Log().Error(ctx, "使用卡号查询卡密表异常, cardCode", cardCode, err)
		code := gcode.New(10, "登录失败，请联系管理员", err)
		return nil, gerror.NewCode(code)
	}
	if record.IsEmpty() {
		code := gcode.New(10, "登录失败，卡密不存在", err)
		return nil, gerror.NewCode(code)
	}
	err = record.Struct(&card)
	if err != nil {
		code := gcode.New(10, "登录失败，请联系管理员", err)
		return nil, gerror.NewCode(code)
	}
	//卡密冻结直接返回
	if card.CardStatus == 0 {
		code := gcode.New(10, "该卡已被冻结", err)
		return nil, gerror.NewCode(code)
	}
	err = dao.VerifyCard.Ctx(ctx).Transaction(ctx, func(ctx context.Context, tx *gdb.TX) error {
		//如果卡密的激活时间是0，开始设置激活时间和到期时间
		if card.ActivateTime.IsZero() {
			g.Log().Info(ctx, "卡未激活，更新激活时间", card)
			now := gtime.Now()
			card.ActivateTime = now
			expireTime, err := setExpireTime(card.ActivateTime, card.CardType, card.CardValue)
			if err != nil {
				g.Log().Error(ctx, "卡号登录设置超时时间异常, cardCode", card, err)
				code := gcode.New(10, "登录失败，请联系管理员", err)
				return gerror.NewCode(code)
			}
			card.ExpireTime = expireTime
			g.Log().Info(ctx, "未激活卡密开始激活，激活时间", now, "卡面值为", card.CardValue, "卡类型为", card.CardType, "激活后到期时间为", expireTime)
			_, err = dao.VerifyCard.Ctx(ctx).TX(tx).Update(card, "id = ?", card.Id)
			if err != nil {
				code := gcode.New(10, "登录失败，请联系管理员", err)
				return gerror.NewCode(code)
			}
		}
		if card.ExpireTime.Before(gtime.Now()) {
			code := gcode.New(10, "卡密已过期", err)
			return gerror.NewCode(code)
		}
		//查询是否已经绑定设备
		deviceMap := make(map[string]entity.VerifyDevice)
		device := entity.VerifyDevice{}
		deviceRecord, err := dao.VerifyDevice.Ctx(ctx).All("card_id = ?", card.Id)
		if err != nil {
			code := gcode.New(10, "登录失败，请联系管理员", err)
			return gerror.NewCode(code)
		}
		// 如果没有绑定设备，则插入一条设备记录表
		if deviceRecord.IsEmpty() {
			g.Log().Debug(ctx, "卡号第一登录，插入登录记录")
			device = entity.VerifyDevice{
				CardId:        card.Id,
				DeviceCode:    req.DeviceCode,
				DeviceStatus:  1,
				DeviceName:    "",
				LastLoginTime: gtime.Now(),
			}
			_, err = dao.VerifyDevice.Ctx(ctx).TX(tx).Insert(device)
			if err != nil {
				code := gcode.New(10, "登录失败，请联系管理员", err)
				return gerror.NewCode(code)
			}
			deviceMap[device.DeviceCode] = device
		} else {
			//否则查询卡对应的设备
			var cardLogs []entity.VerifyDevice
			err = deviceRecord.Structs(&cardLogs)
			if err != nil {
				g.Log().Error(ctx, "device 转换数组失败", err)
				code := gcode.New(10, "登录失败，请联系管理员", err)
				return gerror.NewCode(code)
			}
			//将设备列表转换为map
			for i := range cardLogs {
				deviceMap[cardLogs[i].DeviceCode] = cardLogs[i]
			}
		}
		isReplace := card.IsReplace
		multiOnline := card.MultiOnline
		if card.Customize == 0 {
			isReplace = software.IsReplace
			multiOnline = software.MultiOnline
		}
		//超过多开上限时，判断是否有当前卡密
		if len(deviceMap) > multiOnline {
			//如果没有当前卡密，挤掉最先登录那个
			if _, ok := deviceMap[req.DeviceCode]; !ok {
				if isReplace == 1 {
					cardLogList := make([]entity.VerifyDevice, len(deviceMap))
					for s2 := range deviceMap {
						cardLogList = append(cardLogList, deviceMap[s2])
					}
					firstLogin := cardLogList[0]
					for i := range cardLogList {
						if i > 0 && cardLogList[i].LastLoginTime.Before(firstLogin.LastLoginTime) {
							firstLogin = cardLogList[i]
						}
					}
					delete(deviceMap, firstLogin.DeviceCode)
					deviceMap[req.DeviceCode] = device
				} else {
					code := gcode.New(10, "该卡密已达到多开上线", err)
					return gerror.NewCode(code)
				}
			}
		} else {
			deviceMap[req.DeviceCode] = device
		}
		claims := gconv.Map(card)
		token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims(claims))
		signedString, err := token.SignedString([]byte(software.SecretKey))
		if err != nil {
			g.Log().Error(ctx, "使用 secretKye: ", software.SecretKey, "进行签名异常", err)
			code := gcode.New(10, "登录失败，请联系管理员", err)
			return gerror.NewCode(code)
		}
		defer g.Log().Debug(ctx, "signedString", signedString)
		// 设置token缓存
		setKey := xid.New().String()
		//设置token过期时间
		heartbeat := software.Heartbeat
		_, err = g.Redis().Do(ctx, "SETEX", setKey, heartbeat*90, signedString)
		if err != nil {
			g.Log().Error(ctx, "登录后设置token异常", err)
			code := gcode.New(10, "登录失败，请联系管理员", err)
			return gerror.NewCode(code)
		}
		sessSionRecord, _ := dao.VerifyCardSession.Ctx(ctx).One("card_id = ?", card.Id)
		cardSession := &entity.VerifyCardSession{}
		if sessSionRecord.IsEmpty() {
			// 记录设备session
			cardSession = &entity.VerifyCardSession{
				CardId:         card.Id,
				SessionTimeout: gtime.Now().Add(time.Duration(heartbeat) * time.Minute),
				LoginIp:        "",
				DeviceId:       req.DeviceCode,
			}
			_, err = dao.VerifyCardSession.Ctx(ctx).Insert(cardSession)
			if err != nil {
				g.Log().Error(ctx, "插入card session 异常", err)
				code := gcode.New(10, "登录失败，请联系管理员", err)
				return gerror.NewCode(code)
			}
		} else {
			_ = sessSionRecord.Struct(cardSession)
			cardSession.SessionTimeout = gtime.Now().Add(time.Duration(heartbeat) * time.Minute)
			_, _ = dao.VerifyCardSession.Ctx(ctx).Update(cardSession, "id = ?", cardSession.Id)
		}

		//获取版本信息
		versionRecord, err := dao.VerifyVersion.Ctx(ctx).Where("software_id = ? and is_publish = 1", software.Id).OrderDesc("updated_at").
			Limit(0, 1).One()
		if err != nil {
			g.Log().Error(ctx, "查询版本异常", software.Id, err)
			code := gcode.New(10, "登录失败，请联系管理员", err)
			return gerror.NewCode(code)
		}
		res = &v1.CardLoginRes{
			CardType:  getCardType(card.CardType),
			Expires:   card.ExpireTime,
			ExpiresTs: card.ExpireTime.Timestamp(),
			Token:     setKey,
		}
		if !versionRecord.IsEmpty() {
			version := v1.VersionRes{}
			versionEntity := entity.VerifyVersion{}
			_ = versionRecord.Struct(&versionEntity)
			//查询链接
			attachmentRecord, err := dao.VerifyAttachment.Ctx(ctx).One("id = ?", versionEntity.AttId)
			if err != nil {
				g.Log().Error(ctx, "查询版本附件异常", err)
				code := gcode.New(10, "登录失败，请联系管理员", err)
				return gerror.NewCode(code)
			}
			attachment := entity.VerifyAttachment{}
			_ = attachmentRecord.Struct(&attachment)
			if attachment.StoreType == 3 {
				link, fileName, err := libUtils.LanZouCloud().GetLanZouCloudRealLink(ctx, attachment.FilePath, attachment.OtherParam)
				if err != nil {
					version.Status = 10
				} else {
					version.Status = 0
					version.FileName = fileName
				}
				version.Link = link
			} else {
				version.Link = attachment.FilePath
			}
			version.VersionNumber = versionEntity.VersionNumber
			version.UpdatedAt = versionEntity.UpdatedAt
			version.Comment = versionEntity.Comment
			res.Version = version
		}
		return err
	})
	return res, err
}

func getCardType(cardType int) (typeString string) {
	switch cardType {
	case 1:
		return "分钟卡"
	case 2:
		return "小时卡"
	case 3:
		return "天卡"
	case 4:
		return "月卡"
	case 5:
		return "季卡"
	case 6:
		return "半年卡"
	case 7:
		return "年卡"
	case 8:
		return "永久卡"
	default:
		return "未知卡密"
	}
}

func setExpireTime(activeTime *gtime.Time, cardType int, value int) (expireTime *gtime.Time, err error) {
	switch cardType {
	case 1:
		return activeTime.Add(time.Duration(value) * time.Minute), nil
	case 2:
		return activeTime.Add(time.Duration(value) * time.Hour), nil
	case 3:
		return activeTime.Add(time.Duration(value) * time.Hour), nil
	case 4:
		return activeTime.AddDate(0, value, 0), nil
	case 5:
		return activeTime.AddDate(0, value*3, 0), nil
	case 6:
		return activeTime.AddDate(0, value*6, 0), nil
	case 7:
		return activeTime.AddDate(value, 0, 0), nil
	case 8:
		return activeTime.AddDate(100, 0, 0), nil
	default:
		return nil, gerror.NewCode(gcode.New(11, "未知时间类型", nil))
	}
}
