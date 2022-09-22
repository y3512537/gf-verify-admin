local GF_Plugin = {}
GF_Plugin.cardCode = ""
GF_Plugin.host = ""
GF_Plugin.secretId = ""
GF_Plugin.secretKey = ""
GF_Plugin.token = ""
GF_Plugin.heartbeat = 60
GF_Plugin.failedCount = 0
GF_Plugin.exit = false
GF_Plugin.loginFailHandle = nil
GF_Plugin.heartbeatFailHandle = nil
local loginPath = "/api/v1/app-api/card/login"
local heartbeatPath = "/api/v1/app-api/card/heartbeat"
local serverTimePath = "/api/v1/app-api/card/server-time"
local versionPath = "/api/v1/app-api/version"
local unbindPath = "/api/v1/app-api/card/unbind"
local rechargePath = "/api/v1/app-api/card/recharge"

function GF_Plugin.Init(host,secretId,secretKey,loginFailHandle,heartbeatFailHandle)
	GF_Plugin.host = host
    GF_Plugin.secretId = secretId
    GF_Plugin.secretKey = secretKey
    if loginFailHandle == nil 	then
    	GF_Plugin.loginFailHandle = function ()
        	print("登录失败")
        	exitScript()
        end
    else
    	GF_Plugin.loginFailHandle = loginFailHandle
    end
    if heartbeatFailHandle == nil then
    	GF_Plugin.heartbeatFailHandle = function ()
        	print("心跳失败")
        	exitScript()
        end
    else
    	GF_Plugin.heartbeatFailHandle = heartbeatFailHandle
    end

end

-- 卡密心跳
function heartPacket()
    while true do
    	sleep((GF_Plugin.heartbeat/4) * 1000)
        print("心跳验证: ",os.date("%Y-%m-%d %H:%M:%S"))
        if GF_Plugin.exit == true or GF_Plugin.failedCount > 2 then
			if GF_Plugin.heartbeatFailHandle == nil  then
            	exitScript()
                return
            else
            	setTimer(GF_Plugin.heartbeatFailHandle,1000)
                return
            end
        end
        -- 进行心跳验证
        local cardCode = GF_Plugin.cardCode
        local host = GF_Plugin.host
        local secretId = GF_Plugin.secretId
        local nonce = systemTime()
        local timestamp = getServerTime()
        local params = "cardCode="..cardCode.."&nonce="..
            nonce.."&secretId="..secretId.."&timestamp="..timestamp.."&token="..GF_Plugin.token
        local unSign = host..heartbeatPath.."&method=POST&"..params
        local sign = MD5(unSign)
        local ret,httpCode = httpPost(host..heartbeatPath,params.."&sign="..sign)
        if httpCode ~= 200 then
        	GF_Plugin.failedCount = GF_Plugin.failedCount + 1
        	print("心跳验证失败",GF_Plugin.failedCount,"次,连接服务器失败")
            checkFailedcount()
        else
        	print("心跳返回结果",ret)
        	local retObject = jsonLib.decode(ret)
            if retObject["code"] ~= 0 then
            	GF_Plugin.failedCount = GF_Plugin.failedCount + 1
                checkFailedcount()
            end
        end
    end
end


-- 卡密登录，返回剩余时长
function GF_Plugin.Login(cardCode)
	if cardCode == nil or string.len(cardCode) < 1 then
    	return nil,false
    end
    GF_Plugin.cardCode = cardCode
    print("卡密方式登录，开始构建请求参数")
    local secretId = GF_Plugin.secretId
    local host = GF_Plugin.host
    local nonce = systemTime()
    local deviceCode,deviceName = getDeviceInfo()
    local params = "cardCode="..cardCode.."&deviceCode="..
    deviceCode.."&nonce="..nonce.."&secretId="..secretId
    local sign = MD5(host..loginPath.."&method=POST&"..params)
    local ret, httpCode = httpPost(host..loginPath,params.."&sign="..sign.."&deviceName="..deviceName)
    if httpCode ~= 200 then
    	GF_Plugin.loginFailHandle()
		return ret,false
    end
    local retObject = jsonLib.decode(ret)
    local code = retObject["code"]
    if code ~= 0 then
    	print(retObject["message"])
        GF_Plugin.loginFailHandle()
        return ret,false
    end
	GF_Plugin.token = retObject["data"]["token"]
    GF_Plugin.heartbeat = retObject["data"]["heartbeat"]
	local tId = beginThread(heartPacket,1)
    retObject["data"]["tId"] = tId
    return jsonLib.encode(retObject),true
end

-- 版本更新
function GF_Plugin.Update(ret)
	if ret == nil or string.len(ret) < 1 then
    	return nil,false
    end
   	local ob = jsonLib.decode(ret)
	local versionObject = ob["data"]["version"]
	if versionObject == nil or versionObject == "" then
		local msg = "版本信息为空，跳过更新"
		return msg,false
	end
	local latestVersionNumber = versionObject["latestVersionNumber"]
	if latestVersionNumber == nil or string.len(latestVersionNumber) < 1 then
		return nil,false
	end
    -- 获取当前版本
    local versionInfoPath = getSdPath().."/Download/versionInfo.txt"
    local currentVersion = ""
    if fileExist(versionInfoPath) then
    	local versionInfoString = readFile(versionInfoPath)
        local localVersionObj = jsonLib.decode(versionInfoString)
        currentVersion = localVersionObj["version"]
    end
	if latestVersionNumber == currentVersion then
		local msg = "已经是最新版本"
        toast(msg,0,0,12)
		return msg,false
	end
	-- 获取最新版本下载地址
	local id = versionObject["latestVersionId"]
	if id == nil then
		local msg = "不存在的版本信息"
		return msg,false
	end
	local host = GF_Plugin.host
	local url = host..versionPath.."/"..id.."?token="..GF_Plugin.token
	print(url)
	local versionRet,httpCode = httpGet(url)
	if httpCode ~= 200 then
		local msg = "连接服务器失败"
		return msg,false
	end
	print("返回的版本信息",versionRet)
	local versionInfo = jsonLib.decode(versionRet)
	local versionData = versionInfo["data"]
	if versionData == nil then
		local msg = "版本信息为空"
		return msg,false
	end
	local link = versionData["link"]
	if link == nil or string.len(link) < 1 then
		local msg = "下载地址错误"
		return msg,false
	end
	local updatePath = getSdPath().."/Download/"..versionData["fileName"]
	local downRet = downloadFile(link,updatePath,progress)
	if downRet ~= 0 then
		return false,"网络错误"
	end
	if fileExist(updatePath) == false then
		local msg = "写入文件失败"
		return msg,false
	end
	if fileSize(updatePath) <= 0 then
		local msg = "更新文件大小为0，跳过更新"
		return msg,false
	end
	installLrPkg(updatePath)
	toast("更新完成,正在重启脚本",0,0,18)
	delfile(updatePath)
    print("开始重启")
    -- 更新本地版本
	local versionInfo = {}
	versionInfo["version"] = latestVersionNumber
	versionInfo["date"] = os.date("%Y-%m-%d %H:%M:%S")
    delfile(versionInfoPath)
	writeFile(versionInfoPath,jsonLib.encode(versionInfo))
    return "更新完成",true
end

function progress(pos)
	toast("下载进度:"..pos.."%",0,0,16)
end

-- 设备解绑
function GF_Plugin.Unbind(cardCode)
	if cardCode == nil or string.len(cardCode) < 1 then
		return nil,false
	end
    local secretId = GF_Plugin.secretId
    local host = GF_Plugin.host
    local deviceCode = getDeviceInfo()
    local timestamp = systemTime()
    local params = "cardCode="..cardCode.."&deviceCode="..deviceCode.."&secretId="..secretId.."&timestamp="..timestamp
    local unSign = host..unbindPath.."&method=POST&"..params
    print("unbind unsign string",unSign)
    local sign = MD5(unSign)
    local ret,httpCode = httpPost(host..unbindPath,params.."&sign="..sign)
    if httpCode ~= 200 then
		return ret,false
	end
    local retObject = jsonLib.decode(ret)
    local code = retObject["code"]
    if code ~= 0 then
        return ret,false
    end
    print("解绑成功,返回信息",ret)
    return ret,false
end


--以卡充卡
function GF_Plugin.Recharge(cardCode,cardCode2)
	if cardCode == nil or string.len(cardCode) < 1 then
		return nil,false
	end
	if cardCode2 == nil or string.len(cardCode2) < 1 then
		return nil,false
	end
    local secretId = GF_Plugin.secretId
    local host = GF_Plugin.host
    local timestamp = systemTime()
    local params = "cardCode="..cardCode.."&cardCode2="..cardCode2.."&secretId="..secretId.."&timestamp="..timestamp
    local unSign = host..rechargePath.."&method=POST&"..params
    print("Recharge unsign string",unSign)
    local sign = MD5(unSign)
    local ret,httpCode = httpPost(host..rechargePath,params.."&sign="..sign)
    if httpCode ~= 200 then
		return ret,false
	end
    local retObject = jsonLib.decode(ret)
    local code = retObject["code"]
    if code ~= 0 then
        return ret,false
    end
    print("充值成功,返回信息",ret)
    return ret,false
end

-- 获取设备信息，返回编号和名称
function getDeviceInfo()
	local deviceCode = ""
    local deviceName = ""
    local b,e = pcall(function ()
    	deviceCode = getSubscriberId()
        if deviceCode == nil or string.len(deviceCode) < 1 then
        	deviceCode = getDeviceId()
            if deviceCode == nil or string.len(deviceCode) < 1 then
            	local idPath = getSdPath().."/Download/random"
            	if fileExist(idPath) then
                	deviceCode = readFile(idPath)
                else
                	deviceCode = MD5(GF_Plugin.secretId..systemTime())
                    writeFile(idPath,deviceCode,false)
                end
            end
        end
    end)
    if b == false then
    	print("无法获取设备唯一编号",e)
        return deviceCode,deviceName
    end
    local b,e = pcall(function ()
    	deviceName = getManufacturer()..getModel()
    end)
    if b == false then
    	print("无法获取设备名称",e)
        deviceName = ""
    end
    return deviceCode,deviceName
end
-- 获取服务器时间
function getServerTime()
	print("getServerTime",GF_Plugin.host..serverTimePath.."?token="..GF_Plugin.token)
	local ret,code = httpGet(GF_Plugin.host..serverTimePath.."?token="..GF_Plugin.token,10)
    if code ~= 200 then
    	print("获取服务器时间错误,http error,",ret,code)
        return getTime(1)
    end
    local retObject = jsonLib.decode(ret)
    if retObject["code"] ~= 0 then
    	print("获取服务器时间错误,internal error",retObject["message"])
        return getTime(1)
    end
    print("获取服务器时间成功",ret)
    return retObject["data"]["serverTime"],retObject["data"]["serverTimestamp"]
end

function getTime(r)
	if r == nil then
    	return os.time()
    end
	local ret,code = httpGet("http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp")
    if code == 200 then
    	-- {"api":"mtop.common.getTimestamp","v":"*","ret":["SUCCESS::接口调用成功"],"data":{"t":"1642581071440"}}
    	print("成功获取淘宝api北京时间,ret=",ret)
        local t2 = nil
		local b,e = pcall(function ()
			local object = XM.JsonDecode(ret)
			local t = object["data"]["t"]
			t2,_ = math.modf(tonumber(t)/1000)
        end)
        if t2 ~= 0 and b ~= false then
        	return t2
        end
        if b == false then
        	print("淘宝获取北京时间失败",e)
            return getNetWorkTimestamp()
        end
    else
    	print("获取北京时间失败，尝试k780获取,返回tet==",ret)
        for i=1,5 do
        	local ret,code = httpGet("http://api.k780.com/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
            if code == 200 then
            	print("成功获取k780api北京时间,ret=",ret)
				local b,e = pcall(function ()
					local object = XM.JsonDecode(ret)
					local t = object["result"]["timestamp"]
					return t
                end)
				if b == false then
					print("k780api获取北京时间失败")
					return getNetWorkTimestamp()
				end
            else
            	sleep(100)
            end
        end
    end
    return getNetWorkTimestamp()
end

function getNetWorkTimestamp()
	for i=1,10 do
		local t = getNetWorkTime()
        if t ~= nil and utf8.length(t) > 1 then
        	print("成功获取networktime,t==",t)
			local _, _, y, m, d, hour, min, sec = string.find(t, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
			local ta = {year=y,month=m,day=d,hour=hour,min=min,sec=sec}
			local ret = os.time(ta)
			return ret
        else
        	print("当前第"..i.."次获取网络时间失败")
        	sleep(200)
        end
    end
    return os.time()
end


function checkFailedcount()
	if GF_Plugin.failedCount > 2 then
    	GF_Plugin.exit = true
    end
end

return GF_Plugin

