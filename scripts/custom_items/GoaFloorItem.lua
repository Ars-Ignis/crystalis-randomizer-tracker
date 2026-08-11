BOSSNAMES =
{
	"unknown",
	"kelbesque",
	"sabera",
	"mado",
	"karmine"
}

function CreateGoaFloorItem(floor, defaultState)
	local self = ScriptHost:CreateLuaItem()
	self.Name = "Goa " .. floor .. " Floor"
	self.ItemState = {
		["floor"] = floor,
		["active"] = false,
		["activeImage"] = activeImage,
		["disabledImage"] = disabledImage,
		["state"] = defaultState,
		["reversed"] = false,
		["enableIconUpdates"] = true
	}
	self.Icon = disabledImage

	self.OnLeftClickFunc = GoaFloorItem_onLeftClick
	self.OnRightClickFunc = GoaFloorItem_onRightClick
	self.CanProvideCodeFunc = GoaFloorItem_canProvideCode
	self.ProvidesCodeFunc = GoaFloorItem_providesCode
	self.AdvanceToCodeFunc = GoaFloorItem_advanceToCode
	self.SaveFunc = GoaFloorItem_save
	self.LoadFunc = GoaFloorItem_load
	self.PropertyChangedFunc = GoaFloorItem_propertyChanged
	
	self.ItemState["enableIconUpdates"] = false
	self:Set("state", defaultState)
	self:Set("reversed", false)
	self.ItemState["enableIconUpdates"] = true
	GoaFloorItem_updateIcon(self)
end

function GoaFloorItem_updateIcon(self)
	if self.ItemState["enableIconUpdates"] then
		local filename = "images/goa floors/" .. self.ItemState["floor"] .. "_"
		local state = self.ItemState["state"]
		if state == 0 then
			filename = filename .. "badge"
		elseif state == 1 then
			filename = filename .. "kelbesque"
		elseif state == 2 then
			filename = filename .. "sabera"
		elseif state == 3 then
			filename = filename .. "mado"
		elseif state == 4 then
			filename = filename .. "karmine"
		end
		if self.ItemState["reversed"] and state ~= 0 then
			filename = filename .. "_r"
		end
		filename = filename .. ".png"
		self.Icon = ImageReference:FromPackRelativePath(filename)
	end
end

function GoaFloorItem_onLeftClick(self)
	local state = self.ItemState["state"]
	state = state + 1
	if state == 5 then
		state = 0
	end
	self:Set("state", state)
end

function GoaFloorItem_onRightClick(self)
	self:Set("reversed",  not self.ItemState["reversed"])
end

function GoaFloorItem_canProvideCode(self, code)
	if code == "goaknownfloor" then return true end
	if code == "goa" .. self.ItemState["floor"] then return true end
	for index, bossName in ipairs(BOSSNAMES) do
		if	code == "goa" .. bossName or
			code == "goa" .. bossName .. "_r" or
			code == "goa" .. self.ItemState["floor"] .. bossName then
				return true
		end
	end
end

function GoaFloorItem_providesCode(self, code)
	if code == "goa" .. self.ItemState["floor"] then return 1 end
	local state = self.ItemState["state"]
	if code == "goaknownfloor" and state > 0 then return 1 end
	local bossName = BOSSNAMES[state + 1]
	if	code == "goa" .. bossName or
		code == "goa" .. self.ItemState["floor"] .. bossName then
			return 1
	end
	if self.ItemState["reversed"] and code == "goa" .. bossName .. "_r" then
		return 1
	end
	return 0
end

function GoaFloorItem_advanceToCode(self, code)
	self.ItemState["enableIconUpdates"] = false
	if string.find(code, "unknown") ~= nil then
		self:Set("state", 0)
	elseif string.find(code, "kelbesque") ~= nil then
		self:Set("state", 1)
	elseif string.find(code, "sabera") ~= nil then
		self:Set("state", 2)
	elseif string.find(code, "mado") ~= nil then
		self:Set("state", 3)
	elseif string.find(code, "karmine") ~= nil then
		self:Set("state", 4)
	end
	if string.find(code, "_r") ~= nil then
		self:Set("reversed", true)
	else
		self:Set("reversed", false)
	end
	self.ItemState["enableIconUpdates"] = true
	GoaFloorItem_updateIcon(self)
end

function GoaFloorItem_save(self)
	return self.ItemState
end

function GoaFloorItem_load(self, data)
	self.ItemState["enableIconUpdates"] = false
	self.ItemState = data
	self.ItemState["enableIconUpdates"] = true
	GoaFloorItem_updateIcon(self)
	return true
end

function GoaFloorItem_propertyChanged(self, key, value)
	GoaFloorItem_updateIcon(self)
end