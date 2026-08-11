function SwordItemFunc_onLeftClick(self)
	self:Set("active", not self.ItemState["active"])
end

function SwordItemFunc_onRightClick(self)
	self:Set("active", not self.ItemState["active"])
end

function SwordItemFunc_canProvideCode(self, code)
	if code == self.ItemState["swordCode"] then
		return true
	elseif code == "sword" then
		return true
	elseif code == "swordof"..self.ItemState["swordCode"]then
		return true
	else
		return false
	end
end

function SwordItemFunc_providesCode(self, code)
	if self.ItemState["active"] and (code == self.ItemState["swordCode"] or code == "sword") then
		return 1
	end
	return 0
end

function SwordItemFunc_advanceToCode(self, code)
	if code == nil or code == self.ItemState["swordCode"] then
		self:Set("active", true)
	end
end

function SwordItemFunc_save(self)
	return self.ItemState
end

function SwordItemFunc_load(self, data)
	self.ItemState = data
end

function SwordItemFunc_propertyChanged(self, key, value)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print("Property changed for LuaItem: " .. self.Name .. ". Key: " .. key .. " Value: " .. tostring(value))
	end
	if key == "active" and value == true and Tracker.ActiveVariantUID == "items_and_map_custom" and self.ItemState["allowResets"] then
		resetMinorBossTracking()
		resetRageTracking()
		if Tracker:ProviderCountForCode("flag_ro") > 0 or Tracker:ProviderCountForCode(self.ItemState["swordCode"] .. "orb") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo()) then
			resetWallTracking()
			resetKarmineTracking()
		end
		if Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode(self.ItemState["swordCode"] .. "bracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic()) then
			resetTetrarchyBossTracking()
		end
	end
	if self.ItemState["active"] then
		self.Icon = self.ItemState["activeImage"]
	else
		self.Icon = self.ItemState["disabledImage"]
	end
end

function CreateSwordItem(name, code, imagePath)
	local self = ScriptHost:CreateLuaItem()
	self.Name = name
	local activeImage = ImageReference:FromPackRelativePath(imagePath)
	local disabledImage = ImageReference:FromImageReference(activeImage, "@disabled")
	self.ItemState = {
	["active"] = false,
	["activeImage"] = activeImage,
	["disabledImage"] = disabledImage,
	["swordCode"] = code,
	["allowResets"] = true,
	}
	self.Icon = disabledImage
	
	self.OnLeftClickFunc = SwordItemFunc_onLeftClick
	self.OnRightClickFunc = SwordItemFunc_onRightClick
	self.CanProvideCodeFunc = SwordItemFunc_canProvideCode
	self.ProvidesCodeFunc = SwordItemFunc_providesCode
	self.AdvanceToCodeFunc = SwordItemFunc_advanceToCode
	self.SaveFunc = SwordItemFunc_save
	self.LoadFunc = SwordItemFunc_load
	self.PropertyChangedFunc = SwordItemFunc_propertyChanged
end