--Wt and Wu logic functions

function hasWindmillKey()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("redkey") > 0
	else
		return	Tracker:ProviderCountForCode("windmill") > 0 or
				Tracker:ProviderCountForCode("key") >= 3
	end
end

function maybeHasWindmillKey()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("redkey") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownkey") > 0 and Tracker:ProviderCountForCode("notwindmill") == 0) or hasWindmillKey()
	end
end

function hasKeyToPrison()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("bluekey") > 0
	else
		return	Tracker:ProviderCountForCode("prison") > 0 or
				Tracker:ProviderCountForCode("key") >= 3
	end
end

function maybeHasKeyToPrison()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("bluekey") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownkey") > 0 and Tracker:ProviderCountForCode("notprison") == 0) or hasKeyToPrison()
	end
end

function hasKeyToStxy()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("greenkey") > 0
	else
		return	Tracker:ProviderCountForCode("stxy") > 0 or
				Tracker:ProviderCountForCode("key") >= 3
	end
end

function maybeHasKeyToStxy()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("greenkey") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownkey") > 0 and Tracker:ProviderCountForCode("notstxy") == 0) or hasKeyToStxy()
	end
end

function hasAlarmFlute()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("grayflute") > 0
	else
		return	Tracker:ProviderCountForCode("alarm") > 0 or
				Tracker:ProviderCountForCode("flute") >= 4
	end
end

function maybeHasAlarmFlute()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("grayflute") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownflute") > 0 and Tracker:ProviderCountForCode("notalarm") == 0) or hasAlarmFlute()
	end
end

function hasInsectFlute()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("greenflute") > 0
	else
		return	Tracker:ProviderCountForCode("insect") > 0 or
				Tracker:ProviderCountForCode("flute") >= 4
	end
end

function maybeHasInsectFlute()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("greenflute") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownflute") > 0 and Tracker:ProviderCountForCode("notinsect") == 0) or hasInsectFlute()
	end
end

function hasFluteOfLime()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("blueflute") > 0
	else
		return	Tracker:ProviderCountForCode("lime") > 0 or
				Tracker:ProviderCountForCode("flute") >= 4
	end
end

function maybeHasFluteOfLime()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("blueflute") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownflute") > 0 and Tracker:ProviderCountForCode("notlime") == 0) or hasFluteOfLime()
	end
end

function hasShellFlute()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("redflute") > 0
	else
		return	Tracker:ProviderCountForCode("shell") > 0 or
				Tracker:ProviderCountForCode("flute") >= 4
	end
end

function maybeHasShellFlute()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("redflute") > 0
	else
		return	(Tracker:ProviderCountForCode("unknownflute") > 0 and Tracker:ProviderCountForCode("notshell") == 0) or hasShellFlute()
	end
end

function hasAllTrades()
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if flag_wu then
		return	Tracker:ProviderCountForCode("trade") >= 2 and
				hasAllStatues() and
				hasBothLamps()
	else
		return	Tracker:ProviderCountForCode("tradestatue") >= 2 and
				Tracker:ProviderCountForCode("foglamp") >= 1 and
				Tracker:ProviderCountForCode("trade") >= 2
	end
end

function hasAllStatues()
	return	Tracker:ProviderCountForCode("tradestatue") >= 2 and
			Tracker:ProviderCountForCode("statue") >= 2
end

function hasBothLamps()
	return	Tracker:ProviderCountForCode("foglamp") >= 1 and
			Tracker:ProviderCountForCode("glowinglamp") >= 1
end

function hasAkahanaTrade()
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local akahana_trade_item = SLOT_DATA["shuffle_data"]["trade_in_map"]["Akahana"]
		if flag_wu then
			local akahana_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[KEY_ITEM_MAP[akahana_trade_item]]][1]
			return Tracker:ProviderCountForCode(akahana_trade_code) > 0
		else
			local akahana_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[akahana_trade_item]][1]
			return Tracker:ProviderCountForCode(akahana_trade_code) > 0
		end
	end
	if not flag_wt and not flag_wu then
		return Tracker:ProviderCountForCode("redstatue") > 0
	elseif not flag_wt and flag_wu then
		return	Tracker:ProviderCountForCode("tradeakahana") > 0 or
				hasAllStatues()
	else
		return	Tracker:ProviderCountForCode("tradeakahana") > 0 or
				hasAllTrades()
	end
end

function maybeHasAkahanaTrade()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasAkahanaTrade()
	end
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if not flag_wt and not flag_wu then
		return Tracker:ProviderCountForCode("redstatue") > 0
	elseif not flag_wt and flag_wu then
		return	Tracker:ProviderCountForCode("tradeakahana") > 0 or
				(Tracker:ProviderCountForCode("unknownstatue") > 0 and Tracker:ProviderCountForCode("nottradeakahana") == 0)
	elseif flag_wt and not flag_wu then
		return	Tracker:ProviderCountForCode("tradeakahana") > 0 or
				(Tracker:ProviderCountForCode("unknowntrade") > 0 and Tracker:ProviderCountForCode("nottradeakahana") == 0)
	else
		return	Tracker:ProviderCountForCode("tradeakahana") > 0 or
				((Tracker:ProviderCountForCode("unknowntrade") > 0 or
				Tracker:ProviderCountForCode("unknownstatue") > 0 or
				Tracker:ProviderCountForCode("unknownlamp") > 0) and Tracker:ProviderCountForCode("nottradeakahana") == 0)
	end
end

function hasSlimeTrade()
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local slime_trade_item = SLOT_DATA["shuffle_data"]["trade_in_map"]["Slimed Kensu"]
		if flag_wu then
			local slime_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[KEY_ITEM_MAP[slime_trade_item]]][1]
			return Tracker:ProviderCountForCode(slime_trade_code) > 0
		else
			local slime_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[slime_trade_item]][1]
			return Tracker:ProviderCountForCode(slime_trade_code) > 0
		end
	end
	if not flag_wt and not flag_wu then
		return Tracker:ProviderCountForCode("graystatue") > 0
	elseif not flag_wt and flag_wu then
		return	Tracker:ProviderCountForCode("tradeslime") > 0 or
				hasAllStatues()
	else
		return	Tracker:ProviderCountForCode("tradeslime") > 0 or
				hasAllTrades()
	end
end

function maybeHasSlimeTrade()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasSlimeTrade()
	end
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if not flag_wt and not flag_wu then
		return Tracker:ProviderCountForCode("graystatue") > 0
	elseif not flag_wt and flag_wu then
		return	Tracker:ProviderCountForCode("tradeslime") > 0 or
				(Tracker:ProviderCountForCode("unknownstatue") > 0 and Tracker:ProviderCountForCode("nottradeslime") == 0)
	elseif flag_wt and not flag_wu then
		return	Tracker:ProviderCountForCode("tradeslime") > 0 or
				(Tracker:ProviderCountForCode("unknowntrade") > 0 and Tracker:ProviderCountForCode("nottradeslime") == 0)
	else
		return	Tracker:ProviderCountForCode("tradeslime") > 0 or
				((Tracker:ProviderCountForCode("unknowntrade") > 0 or
				Tracker:ProviderCountForCode("unknownstatue") > 0 or
				Tracker:ProviderCountForCode("unknownlamp") > 0) and Tracker:ProviderCountForCode("nottradeslime") == 0)
	end
end

function hasAryllisTrade()
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local aryllis_trade_item = SLOT_DATA["shuffle_data"]["trade_in_map"]["Aryllis"]
		if flag_wu then
			local aryllis_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[KEY_ITEM_MAP[aryllis_trade_item]]][1]
			return Tracker:ProviderCountForCode(aryllis_trade_code) > 0
		else
			local aryllis_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[aryllis_trade_item]][1]
			return Tracker:ProviderCountForCode(aryllis_trade_code) > 0
		end
	end
	if negate("flag_wt") then
		return Tracker:ProviderCountForCode("kirisa") > 0
	else
		return	Tracker:ProviderCountForCode("tradearyllis") > 0 or
				hasAllTrades()
	end
end

function maybeHasAryllisTrade()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasAryllisTrade()
	end
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if not flag_wt then
		return Tracker:ProviderCountForCode("kirisa") > 0
	else
		if not flag_wu then
			return	Tracker:ProviderCountForCode("tradearyllis") > 0 or
					(Tracker:ProviderCountForCode("unknowntrade") > 0 and Tracker:ProviderCountForCode("nottradearyllis") == 0)
		else
			return	Tracker:ProviderCountForCode("tradearyllis") > 0 or
					((Tracker:ProviderCountForCode("unknowntrade") > 0 or
					Tracker:ProviderCountForCode("unknownstatue") > 0 or
					Tracker:ProviderCountForCode("unknownlamp") > 0) and Tracker:ProviderCountForCode("nottradearyllis") == 0)
		end
	end
end

function hasKensuTrade()
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local kensu_trade_item = SLOT_DATA["shuffle_data"]["trade_in_map"]["Kensu"]
		if flag_wu then
			local kensu_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[KEY_ITEM_MAP[kensu_trade_item]]][1]
			return Tracker:ProviderCountForCode(kensu_trade_code) > 0
		else
			local kensu_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[kensu_trade_item]][1]
			return Tracker:ProviderCountForCode(kensu_trade_code) > 0
		end
	end
	if negate("flag_wt") then
		return Tracker:ProviderCountForCode("love") > 0
	else
		return	Tracker:ProviderCountForCode("tradekensu") > 0 or
				hasAllTrades()
	end
end

function maybeHasKensuTrade()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasKensuTrade()
	end
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if not flag_wt then
		return Tracker:ProviderCountForCode("love") > 0
	else
		if not flag_wu then
			return	Tracker:ProviderCountForCode("tradekensu") > 0 or
					(Tracker:ProviderCountForCode("unknowntrade") > 0 and Tracker:ProviderCountForCode("nottradekensu") == 0)
		else
			return	Tracker:ProviderCountForCode("tradekensu") > 0 or
					((Tracker:ProviderCountForCode("unknowntrade") > 0 or
					Tracker:ProviderCountForCode("unknownstatue") > 0 or
					Tracker:ProviderCountForCode("unknownlamp") > 0) and Tracker:ProviderCountForCode("nottradekensu") == 0)
		end
	end
end

function hasFishermanTrade()
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local fisherman_trade_item = SLOT_DATA["shuffle_data"]["trade_in_map"]["Fisherman"]
		if flag_wu then
			local fisherman_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[KEY_ITEM_MAP[fisherman_trade_item]]][1]
			return Tracker:ProviderCountForCode(fisherman_trade_code) > 0
		else
			local fisherman_trade_code = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[fisherman_trade_item]][1]
			return Tracker:ProviderCountForCode(fisherman_trade_code) > 0
		end
	end
	if not flag_wt and not flag_wu then
		return Tracker:ProviderCountForCode("bluelamp") > 0
	elseif not flag_wt and flag_wu then
		return	Tracker:ProviderCountForCode("tradefisherman") > 0 or
				hasBothLamps()
	else
		return	Tracker:ProviderCountForCode("tradefisherman") > 0 or
				hasAllTrades()
	end
end

function maybeHasFishermanTrade()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasFishermanTrade()
	end
	local flag_wt = Tracker:ProviderCountForCode("flag_wt") > 0
	local flag_wu = Tracker:ProviderCountForCode("flag_wu") > 0
	if not flag_wt and not flag_wu then
		return Tracker:ProviderCountForCode("bluelamp") > 0
	elseif not flag_wt and flag_wu then
		return	Tracker:ProviderCountForCode("tradefisherman") > 0 or
				(Tracker:ProviderCountForCode("unknownlamp") > 0 and Tracker:ProviderCountForCode("nottradefisherman") == 0)
	elseif flag_wt and not flag_wu then
		return	Tracker:ProviderCountForCode("tradefisherman") > 0 or
				(Tracker:ProviderCountForCode("unknowntrade") > 0 and Tracker:ProviderCountForCode("nottradefisherman") == 0)
	else
		return	Tracker:ProviderCountForCode("tradefisherman") > 0 or
				((Tracker:ProviderCountForCode("unknowntrade") > 0 or
				Tracker:ProviderCountForCode("unknownstatue") > 0 or
				Tracker:ProviderCountForCode("unknownlamp") > 0) and Tracker:ProviderCountForCode("nottradefisherman") == 0)
	end
end

function hasRepairLamp()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("graylamp") > 0
	else
		return	Tracker:ProviderCountForCode("brokenlamp") > 0 or
				hasBothLamps()
	end
end

function maybeHasRepairLamp()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("graylamp") > 0
	else
		return	Tracker:ProviderCountForCode("brokenlamp") > 0 or
				(Tracker:ProviderCountForCode("unknownlamp") > 0 and Tracker:ProviderCountForCode("notbrokenlamp") == 0)
	end
end

function hasBrokenStatue()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("crackedstatue") > 0
	else
		return	Tracker:ProviderCountForCode("brokenstatue") > 0 or
				hasAllStatues()
	end
end

function maybeHasBrokenStatue()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("crackedstatue") > 0
	else
		return	Tracker:ProviderCountForCode("brokenstatue") > 0 or
				(Tracker:ProviderCountForCode("unknownstatue") > 0 and Tracker:ProviderCountForCode("notbrokenstatue") == 0)
	end
end

function hasWhirlpoolStatue()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("bluestatue") > 0
	else
		return	Tracker:ProviderCountForCode("whirlpool") > 0 or
				hasAllStatues()
	end
end

function maybeHasWhirlpoolStatue()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("bluestatue") > 0
	else
		return	Tracker:ProviderCountForCode("whirlpool") > 0 or
				(Tracker:ProviderCountForCode("unknownstatue") > 0 and Tracker:ProviderCountForCode("notwhirlpool") == 0)
	end
end

function hasTornelBracelet()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local tornelement = string.lower(SLOT_DATA["shuffle_data"]["trade_in_map"]["Tornel"])
		return Tracker:ProviderCountForCode(tornelement .. "upgrade") > 1
	end
	if negate("flag_wt") then
		return Tracker:ProviderCountForCode("windupgrade") > 1
	else
		return 	hasAllBattleMagic() or
				(Tracker:ProviderCountForCode("tornelwind") > 0 and Tracker:ProviderCountForCode("windupgrade") > 1) or
				(Tracker:ProviderCountForCode("tornelfire") > 0 and Tracker:ProviderCountForCode("fireupgrade") > 1) or
				(Tracker:ProviderCountForCode("tornelwater") > 0 and Tracker:ProviderCountForCode("waterupgrade") > 1) or
				(Tracker:ProviderCountForCode("tornelthunder") > 0 and Tracker:ProviderCountForCode("thunderupgrade") > 1) 
	end
end

function maybeHasTornelBracelet()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasTornelBracelet()
	end
	if negate("flag_wt") then
		return Tracker:ProviderCountForCode("windupgrade") > 1
	else
		return (hasAnyBattleMagic() and Tracker:ProviderCountForCode("tornel") == 0) or hasTornelBracelet()
	end
end

function hasRageSword()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		local ragesword = string.gsub(string.lower(SLOT_DATA["shuffle_data"]["trade_in_map"]["Rage"]), " ", "")
		return Tracker:ProviderCountForCode(ragesword) > 0
	end
	if negate("flag_wt") then
		return Tracker:ProviderCountForCode("water") > 0
	else
		return 	hasAllSwords() or
				(Tracker:ProviderCountForCode("ragewind") > 0 and Tracker:ProviderCountForCode("wind") > 0) or
				(Tracker:ProviderCountForCode("ragefire") > 0 and Tracker:ProviderCountForCode("fire") > 0) or
				(Tracker:ProviderCountForCode("ragewater") > 0 and Tracker:ProviderCountForCode("water") > 0) or
				(Tracker:ProviderCountForCode("ragethunder") > 0 and Tracker:ProviderCountForCode("thunder") > 0) 
	end
end

function maybeHasRageSword()
	if SLOT_DATA ~= nil and KEY_ITEM_MAP ~= nil then
		return hasRageSword()
	end
	if negate("flag_wt") then
		return Tracker:ProviderCountForCode("water") > 0
	else
		return (hasAnySword() and Tracker:ProviderCountForCode("rage") == 0) or hasRageSword()
	end
end

function resetRageTracking()
	local rage = Tracker:FindObjectForCode("rage")
	if rage.CurrentStage == 5 then
		rage.CurrentStage = 0
	end
end

function hasCryptAccess()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("graybow") > 0 and Tracker:ProviderCountForCode("redbow") > 0
	else
		return	(Tracker:ProviderCountForCode("sun") > 0 and Tracker:ProviderCountForCode("moon") > 0) or
				Tracker:ProviderCountForCode("bow") >= 3
	end
end

function maybeHasCryptAccess()
	if negate("flag_wu") then
		return Tracker:ProviderCountForCode("graybow") > 0 and Tracker:ProviderCountForCode("redbow") > 0
	else
		return	(Tracker:ProviderCountForCode("bow") >= 2 and Tracker:ProviderCountForCode("notsun") == 0 and Tracker:ProviderCountForCode("notmoon") == 0) or hasCryptAccess()	end
end

