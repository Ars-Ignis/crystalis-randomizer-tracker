BADGE_IMAGE_PATH = "images/badges/"

function CreateKeyItem(name, code, category, imagePath, badges, default_code)
	local self = ScriptHost:CreateLuaItem()
	self.Name = name
	local imageBase = ImageReference:FromPackRelativePath(imagePath)
	self.ItemState = {
	["active"] = false,
	["imageBase"] = imageBase,
	["code"] = code,
	["badges"] = badges,
	["badgeNum"] = 0,
	["canUpdateIcon"] = false,
	["category"] = category,
	["default_code"] = default_code,
	["flag_wt"] = 0,
	["flag_wu"] = 0
	}
	self.Icon = imageBase	
	self.OnLeftClickFunc = KeyItem_onLeftClick
	self.OnRightClickFunc = KeyItem_onRightClick
	self.CanProvideCodeFunc = KeyItem_canProvideCode
	self.ProvidesCodeFunc = KeyItem_providesCode
	self.AdvanceToCodeFunc = KeyItem_advanceToCode
	self.SaveFunc = KeyItem_save
	self.LoadFunc = KeyItem_load
	self.PropertyChangedFunc = KeyItem_propertyChanged
	KeyItem_cacheAndUpdateFromFlags(self)
	self.ItemState["canUpdateIcon"] = true
	KeyItem_updateIcon(self)
end

function KeyItem_cacheAndUpdateFromFlags(self)
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if self.ItemState["flag_wt"] ~= flag_wt or self.ItemState["flag_wu"] ~= flag_wu then
		--print("caching")
		self.ItemState["flag_wt"] = flag_wt
		self.ItemState["flag_wu"] = flag_wu
		local badgeNum = self.ItemState["badgeNum"]
		local badge = self.ItemState["badges"][badgeNum]
		if not flag_wt and not flag_wu then
			self:Set("badgeNum", 0)
		elseif	badgeNum > 0 and
			((flag_wt and not flag_wu and badge["flag_wt"]) or
			(not flag_wt and flag_wu and badge["flag_wu"]) or
			(flag_wt and flag_wu and badge["both"])) then
				--no need to update
		else
			--print("right-clicking: " .. self.name)
			KeyItem_onRightClick(self)
		end
	end
end

function KeyItem_updateIcon(self)
	if self.ItemState["canUpdateIcon"] then
		local img_mod = ""
		if self.ItemState["badgeNum"] and self.ItemState["badgeNum"] > 0 then
			img_mod = "overlay|".. BADGE_IMAGE_PATH .. self.ItemState["badges"][self.ItemState["badgeNum"]]["code"] .. ".png"
		end
		if not self.ItemState["active"] then
			img_mod = img_mod .. ",@disabled"
		end
		self.Icon = ImageReference:FromImageReference(self.ItemState["imageBase"], img_mod)
	end
end

function KeyItem_onLeftClick(self)
	KeyItem_cacheAndUpdateFromFlags(self)
	self:Set("active", not self.ItemState["active"])
end

function KeyItem_onRightClick(self)
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	--print ("flag_wt: " .. (flag_wt and 'true' or 'false') .. " flag_wu: " .. (flag_wu and 'true' or 'false'))
	if not flag_wt and not flag_wu then
		self:Set("badgeNum", 0)
	else
		local badgeNum = self.ItemState["badgeNum"]
		local initialBadgeNum = badgeNum
		badgeNum = badgeNum + 1
		if badgeNum > #self.ItemState["badges"] then
			badgeNum = 1
		end
		while badgeNum ~= initialBadgeNum do
			local currentBadge = self.ItemState["badges"][badgeNum]
			if	(flag_wt and not flag_wu and currentBadge["flag_wt"]) or
				(not flag_wt and flag_wu and currentBadge["flag_wu"]) or
				(flag_wt and flag_wu and currentBadge["both"]) then
					break
			end
			badgeNum = badgeNum + 1
			if badgeNum > #self.ItemState["badges"] then
				if initialBadgeNum == 0 then
					break
				end
				badgeNum = 1
			end
		end
		if badgeNum == initialBadgeNum or badgeNum > #self.ItemState["badges"] then
			self:Set("badgeNum", 0)
		else
			self:Set("badgeNum", badgeNum)
		end
	end
end

function KeyItem_canProvideCode(self, code)
	if self.ItemState["code"] == code then
		return true
	end
	if self.ItemState["category"] == code then
		return true
	end
	for _, badge in ipairs(self.ItemState["badges"]) do
		if 	code == badge["code"] or
			code == "not" .. badge["code"] then
			return true
		end
	end
	return false
end

function KeyItem_providesCode(self, code)
	local badgeNum = self.ItemState["badgeNum"]
	if 	self.ItemState["active"] and 
		(code == self.ItemState["code"] or 
		code == self.ItemState["category"] or
		(badgeNum > 0 and code == self.ItemState["badges"][badgeNum]["code"])) then
			return 1
	end
	if 	not self.ItemState["active"] and
		(badgeNum > 0 and code == ("not" .. self.ItemState["badges"][badgeNum]["code"])) then
			return 1
	end
	return 0
end

function KeyItem_advanceToCode(self, code)
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if code ~= nil and code == self.ItemState["code"] then
		self:Set("active", true)
	else
		for badgeIndex, badge in ipairs(self.ItemState["badges"]) do
			if code == badge["code"] then
				if	(flag_wt and not flag_wu and badge["flag_wt"]) or
					(not flag_wt and flag_wu and badge["flag_wu"]) or
					(flag_wt and flag_wu and badge["both"]) then
						self:Set("badgeNum", badgeIndex)
						self:Set("active", true)
				end
				break
			end
		end
	end
end

function KeyItem_save(self)
	return self.ItemState
end

function KeyItem_load(self, data)
	self.ItemState = data
	KeyItem_updateIcon(self)
end

function KeyItem_propertyChanged(self, key, value)
	KeyItem_updateIcon(self)
end

function KeyItem_advanceToDefaultCode(self)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("Default code for item [%s]: %s", self.Name, self.ItemState["default_code"]))
	end
	KeyItem_advanceToCode(self, self.ItemState["default_code"])
end