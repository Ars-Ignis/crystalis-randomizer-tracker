function OrbItem_onLeftClick(self)
	self:Set("active", not self.ItemState["active"])
end

function OrbItem_onRightClick(self)
	self:Set("active", not self.ItemState["active"])
end

function OrbItem_canProvideCode(self, code)
	if code == self.ItemState["orbCode"] then
		return true
	elseif code == "orb" then
		return true
	elseif code == string.gsub(self.ItemState["orbCode"], "orb", "upgrade") then
		return true
	else
		return false
	end
end

function OrbItem_providesCode(self, code)
	if self.ItemState["active"] and (code == self.ItemState["orbCode"] or code == "orb" or code == string.gsub(self.ItemState["orbCode"], "orb", "upgrade")) then
		return 1
	end
	return 0
end

function OrbItem_advanceToCode(self, code)
	if code == nil or code == self.ItemState["orbCode"] then
		self:Set("active", true)
	end
end

function OrbItem_save(self)
	return self.ItemState
end

function OrbItem_load(self, data)
	self.ItemState = data
	OrbItem_updateIcon(self)
end

function OrbItem_propertyChanged(self, key, value)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print("Property changed for LuaItem: " .. self.Name .. ". Key: " .. key .. " Value: " .. tostring(value))
	end
	if key == "active" and value == true and Tracker.ActiveVariantUID == "items_and_map_custom" and self.ItemState["allowResets"] then
		if negate("flag_ro") and Tracker:ProviderCountForCode(string.sub(self.ItemState["orbCode"], 1, -4)) > 0 and (negate("flag_gc") or levelTwoCount() == 1) then
			resetWallTracking()
		end
		if negate("flag_nw") and Tracker:ProviderCountForCode(string.sub(self.ItemState["orbCode"], 1, -4)) > 0 and (negate("flag_gc") or levelTwoCount() == 1) then
			resetKarmineTracking()
		end
	end
	OrbItem_updateIcon(self)
end

function OrbItem_updateIcon(self)
	if self.ItemState["active"] then
		self.Icon = self.ItemState["activeImage"]
	else
		self.Icon = self.ItemState["disabledImage"]
	end
end

function CreateOrbItem(name, code, imagePath)
	local self = ScriptHost:CreateLuaItem()
	self.Name = name
	local activeImage = ImageReference:FromPackRelativePath(imagePath)
	local disabledImage = ImageReference:FromImageReference(activeImage, "@disabled")
	self.ItemState = {
	["active"] = false,
	["activeImage"] = activeImage,
	["disabledImage"] = disabledImage,
	["orbCode"] = code,
	["allowResets"] = true,
	}
	self.Icon = disabledImage
	
	self.OnLeftClickFunc = OrbItem_onLeftClick
	self.OnRightClickFunc = OrbItem_onRightClick
	self.CanProvideCodeFunc = OrbItem_canProvideCode
	self.ProvidesCodeFunc = OrbItem_providesCode
	self.AdvanceToCodeFunc = OrbItem_advanceToCode
	self.SaveFunc = OrbItem_save
	self.LoadFunc = OrbItem_load
	self.PropertyChangedFunc = OrbItem_propertyChanged
end