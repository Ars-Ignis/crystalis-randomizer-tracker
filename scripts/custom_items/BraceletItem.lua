function BraceletItem_onLeftClick(self)
	self:Set("active", not self.ItemState["active"])
end

function BraceletItem_onRightClick(self)
	self:Set("active", not self.ItemState["active"])
end

function BraceletItem_canProvideCode(self, code)
	if code == self.ItemState["braceletCode"] then
		return true
	elseif code == "bracelet" then
		return true
	elseif code == string.gsub(self.ItemState["braceletCode"], "bracelet", "upgrade") then
		return true
	else
		return false
	end
end

function BraceletItem_providesCode(self, code)
	if self.ItemState["active"] and (code == self.ItemState["braceletCode"] or code == "bracelet" or code == string.gsub(self.ItemState["braceletCode"], "bracelet", "upgrade")) then
		return 1
	end
	return 0
end

function BraceletItem_advanceToCode(self, code)
	if code == nil or code == self.ItemState["braceletCode"] then
		self:Set("active", true)
	end
end

function BraceletItem_save(self)
	return self.ItemState
end

function BraceletItem_load(self, data)
	self.ItemState = data
	BraceletItem_updateIcon(self)
end

function BraceletItem_propertyChanged(self, key, value)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print("Property changed for LuaItem: " .. self.Name .. ". Key: " .. key .. " Value: " .. tostring(value))
	end
	if key == "active" and value == true and Tracker.ActiveVariantUID == "items_and_map_custom" and self.ItemState["allowResets"] then
		if negate("flag_nw") and Tracker:ProviderCountForCode(string.sub(self.ItemState["braceletCode"], 1, -9)) > 0 and (negate("flag_gc") or battleMagicCount() == 1) then
			resetTetrarchyBossTracking()
		end
	end
	BraceletItem_updateIcon(self)
end

function BraceletItem_updateIcon(self)
	if self.ItemState["active"] then
		self.Icon = self.ItemState["activeImage"]
	else
		self.Icon = self.ItemState["disabledImage"]
	end
end

function CreateBraceletItem(name, code, imagePath)
	local self = ScriptHost:CreateLuaItem()
	self.Name = name
	local activeImage = ImageReference:FromPackRelativePath(imagePath)
	local disabledImage = ImageReference:FromImageReference(activeImage, "@disabled")
	self.ItemState = {
	["active"] = false,
	["activeImage"] = activeImage,
	["disabledImage"] = disabledImage,
	["braceletCode"] = code,
	["allowResets"] = true,
	}
	self.Icon = disabledImage
	
	self.OnLeftClickFunc = BraceletItem_onLeftClick
	self.OnRightClickFunc = BraceletItem_onRightClick
	self.CanProvideCodeFunc = BraceletItem_canProvideCode
	self.ProvidesCodeFunc = BraceletItem_providesCode
	self.AdvanceToCodeFunc = BraceletItem_advanceToCode
	self.SaveFunc = BraceletItem_save
	self.LoadFunc = BraceletItem_load
	self.PropertyChangedFunc = BraceletItem_propertyChanged
end