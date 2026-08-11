function BraceletItemFunc_onLeftClick(self)
	self:Set("active", not self.ItemState["active"])
end

function BraceletItemFunc_onRightClick(self)
	self:Set("active", not self.ItemState["active"])
end

function BraceletItemFunc_canProvideCode(self, code)
	if code == self.ItemState["braceletCode"] then
		return true
	elseif code == "bracelet" then
		return true
	else
		return false
	end
end

function BraceletItemFunc_providesCode(self, code)
	if self.ItemState["active"] and (code == self.ItemState["braceletCode"] or code == "bracelet") then
		return 1
	end
	return 0
end

function BraceletItemFunc_advanceToCode(self, code)
	if code == nil or code == self.ItemState["braceletCode"] then
		self:Set("active", true)
	end
end

function BraceletItemFunc_save(self)
	return self.ItemState
end

function BraceletItemFunc_load(self, data)
	self.ItemState = data
end

function BraceletItemFunc_propertyChanged(self, key, value)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print("Property changed for LuaItem: " .. self.Name .. ". Key: " .. key .. " Value: " .. tostring(value))
	end
	if key == "active" and value == true and Tracker.ActiveVariantUID == "items_and_map_custom" and self.ItemState["allowResets"] then
		if negate("flag_nw") and Tracker:ProviderCountForCode(string.sub(self.ItemState["braceletCode"], 1, -9)) > 0 and (negate("flag_gc") or battleMagicCount() == 1) then
			resetTetrarchyBossTracking()
		end
	end
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
	
	self.OnLeftClickFunc = BraceletItemFunc_onLeftClick
	self.OnRightClickFunc = BraceletItemFunc_onRightClick
	self.CanProvideCodeFunc = BraceletItemFunc_canProvideCode
	self.ProvidesCodeFunc = BraceletItemFunc_providesCode
	self.AdvanceToCodeFunc = BraceletItemFunc_advanceToCode
	self.SaveFunc = BraceletItemFunc_save
	self.LoadFunc = BraceletItemFunc_load
	self.PropertyChangedFunc = BraceletItemFunc_propertyChanged
end