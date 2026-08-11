function OrbItemFunc_onLeftClick(self)
	self:Set("active", not self.ItemState["active"])
end

function OrbItemFunc_onRightClick(self)
	self:Set("active", not self.ItemState["active"])
end

function OrbItemFunc_canProvideCode(self, code)
	if code == self.ItemState["orbCode"] then
		return true
	elseif code == "orb" then
		return true
	else
		return false
	end
end

function OrbItemFunc_providesCode(self, code)
	if self.ItemState["active"] and (code == self.ItemState["orbCode"] or code == "orb") then
		return 1
	end
	return 0
end

function OrbItemFunc_advanceToCode(self, code)
	if code == nil or code == self.ItemState["orbCode"] then
		self:Set("active", true)
	end
end

function OrbItemFunc_save(self)
	return self.ItemState
end

function OrbItemFunc_load(self, data)
	self.ItemState = data
end

function OrbItemFunc_propertyChanged(self, key, value)
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
	
	self.OnLeftClickFunc = OrbItemFunc_onLeftClick
	self.OnRightClickFunc = OrbItemFunc_onRightClick
	self.CanProvideCodeFunc = OrbItemFunc_canProvideCode
	self.ProvidesCodeFunc = OrbItemFunc_providesCode
	self.AdvanceToCodeFunc = OrbItemFunc_advanceToCode
	self.SaveFunc = OrbItemFunc_save
	self.LoadFunc = OrbItemFunc_load
	self.PropertyChangedFunc = OrbItemFunc_propertyChanged
end