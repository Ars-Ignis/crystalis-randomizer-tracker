--Wall breaking logic

function canBreakStoneWalls()
	if Tracker:ProviderCountForCode("wind") == 0 then
		return false
	else
		return	Tracker:ProviderCountForCode("windorb") > 0 or 
				Tracker:ProviderCountForCode("windbracelet") > 0 or 
				Tracker:ProviderCountForCode("flag_ro") > 0 or
				(Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo())
	end
end

function canBreakIceWalls()
	if Tracker:ProviderCountForCode("fire") == 0 then
		return false
	else
		return	Tracker:ProviderCountForCode("fireorb") > 0 or 
				Tracker:ProviderCountForCode("firebracelet") > 0 or 
				Tracker:ProviderCountForCode("flag_ro") > 0 or
				(Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo())
	end
end

function canBreakEmberWalls()
	if Tracker:ProviderCountForCode("water") == 0 then
		return false
	else
		return	Tracker:ProviderCountForCode("waterorb") > 0 or 
				Tracker:ProviderCountForCode("waterbracelet") > 0 or 
				Tracker:ProviderCountForCode("flag_ro") > 0 or
				(Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo())
	end
end

function canBreakIronWalls()
	if Tracker:ProviderCountForCode("thunder") == 0 then
		return false
	else
		return	Tracker:ProviderCountForCode("thunderorb") > 0 or 
				Tracker:ProviderCountForCode("thunderbracelet") > 0 or 
				Tracker:ProviderCountForCode("flag_ro") > 0 or
				(Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo())
	end
end

function canBreakAllWalls()
	return hasAllSwords() and (Tracker:ProviderCountForCode("flag_ro") > 0 or hasAllLevelTwo())
end

function canBreakAnyWall()
	return hasAnySword() and (Tracker:ProviderCountForCode("flag_ro") > 0 or hasAnyLevelTwo())
end

function canBreakWallWithCode(code)
	return	canBreakAllWalls() or
			(Tracker:ProviderCountForCode(code .. "_wind") > 0 and canBreakStoneWalls()) or
			(Tracker:ProviderCountForCode(code .. "_fire") > 0 and canBreakIceWalls()) or
			(Tracker:ProviderCountForCode(code .. "_water") > 0 and canBreakEmberWalls()) or
			(Tracker:ProviderCountForCode(code .. "_thunder") > 0 and canBreakIronWalls())
end

function canMaybeBreakWallWithCode(code)
	return (canBreakAnyWall() and Tracker:ProviderCountForCode(code) <= 0) or canBreakWallWithCode(code)
end

function canBreakEastCaveWall()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canBreakWallWithCode("ecw")
	end
end

function canMaybeBreakEastCaveWall()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canMaybeBreakWallWithCode("ecw")
	end
end

function canBreakSealedCaveWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canBreakWallWithCode("scw")
	end
end

function canMaybeBreakSealedCaveWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canMaybeBreakWallWithCode("scw")
	end
end

function canBreakZebusCaveWall()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canBreakWallWithCode("zcw")
	end
end

function canMaybeBreakZebusCaveWall()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canMaybeBreakWallWithCode("zcw")
	end
end

function canBreakSabreWestWalls()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canBreakWallWithCode("msww")
	end
end

function canMaybeBreakSabreWestWalls()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canMaybeBreakWallWithCode("msww")
	end
end

function canBreakSabreNorthWalls()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canBreakWallWithCode("msnw")
	end
end

function canMaybeBreakSabreNorthWalls()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canMaybeBreakWallWithCode("msnw")
	end
end

function canBreakWaterfallCaveWalls()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canBreakWallWithCode("wcw")
	end
end

function canMaybeBreakWaterfallCaveWalls()
	if negate("flag_we") then
		return canBreakIceWalls()
	else
		return canMaybeBreakWallWithCode("wcw")
	end
end

function canBreakFogLampCaveWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canBreakWallWithCode("flcw")
	end
end

function canMaybeBreakFogLampCaveWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canMaybeBreakWallWithCode("flcw")
	end
end

function canBreakKirisaPlantCaveWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canBreakWallWithCode("kpcw")
	end
end

function canMaybeBreakKirisaPlantCaveWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canMaybeBreakWallWithCode("kpcw")
	end
end

function canBreakEvilSpiritIslandWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canBreakWallWithCode("esiw")
	end
end

function canMaybeBreakEvilSpiritIslandWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canMaybeBreakWallWithCode("esiw")
	end
end

function canBreakHydraWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canBreakWallWithCode("mhw")
	end
end

function canMaybeBreakHydraWalls()
	if negate("flag_we") then
		return canBreakStoneWalls()
	else
		return canMaybeBreakWallWithCode("mhw")
	end
end

function canBreakGoaEntranceWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return canBreakAllWalls() or Tracker:ProviderCountForCode("goa_entrance_wall_cleared") > 0
	end
end

function canMaybeBreakGoaEntranceWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return (canBreakAnyWall() and Tracker:ProviderCountForCode("goa_entrance_wall_tested") == 0) or canBreakGoaEntranceWall()
	end
end

function canBreakSaberaChestWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return canBreakAllWalls() or Tracker:ProviderCountForCode("goa_sabera_item_wall_cleared") > 0
	end
end

function canMaybeBreakSaberaChestWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return (canBreakAnyWall() and Tracker:ProviderCountForCode("goa_sabera_item_wall_tested") == 0) or canBreakSaberaChestWall()
	end
end

function canBreakSaberaBossWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return canBreakAllWalls() or Tracker:ProviderCountForCode("goa_sabera_boss_wall_cleared") > 0
	end
end

function canMaybeBreakSaberaBossWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return (canBreakAnyWall() and Tracker:ProviderCountForCode("goa_sabera_boss_wall_tested") == 0) or canBreakSaberaBossWall()
	end
end

function canBreakMadoWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return canBreakAllWalls() or Tracker:ProviderCountForCode("goa_mado_wall_cleared") > 0
	end
end

function canMaybeBreakMadoWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return (canBreakAnyWall() and Tracker:ProviderCountForCode("goa_mado_wall_tested") == 0) or canBreakMadoWall()
	end
end

function canBreakKarmineWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return canBreakAllWalls() or Tracker:ProviderCountForCode("goa_karmine_wall_cleared") > 0
	end
end

function canMaybeBreakKarmineWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return (canBreakAnyWall() and Tracker:ProviderCountForCode("goa_karmine_wall_tested") == 0) or canBreakKarmineWall()
	end
end

function canBreakPowerRingWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return canBreakAllWalls() or Tracker:ProviderCountForCode("goa_basement_wall_cleared") > 0
	end
end

function canMaybeBreakPowerRingWall()
	if negate("flag_we") then
		return canBreakIronWalls()
	else
		return (canBreakAnyWall() and Tracker:ProviderCountForCode("goa_basement_wall_tested") == 0) or canBreakPowerRingWall()
	end
end

function resetWallTracking()
	--print("Resetting tested walls...")
	local scw = Tracker:FindObjectForCode("scw")
	if scw.CurrentStage == 5 then
		scw.CurrentStage = 0
	end
	local zcw = Tracker:FindObjectForCode("zcw")
	if zcw.CurrentStage == 5 then
		zcw.CurrentStage = 0
	end
	local msww = Tracker:FindObjectForCode("msww")
	if msww.CurrentStage == 5 then
		msww.CurrentStage = 0
	end
	local msnw = Tracker:FindObjectForCode("msnw")
	if msnw.CurrentStage == 5 then
		msnw.CurrentStage = 0
	end
	local wcw = Tracker:FindObjectForCode("wcw")
	if wcw.CurrentStage == 5 then
		wcw.CurrentStage = 0
	end
	local flcw = Tracker:FindObjectForCode("flcw")
	if flcw.CurrentStage == 5 then
		flcw.CurrentStage = 0
	end
	local kpcw = Tracker:FindObjectForCode("kpcw")
	if kpcw.CurrentStage == 5 then
		kpcw.CurrentStage = 0
	end
	local esiw = Tracker:FindObjectForCode("esiw")
	if esiw.CurrentStage == 5 then
		esiw.CurrentStage = 0
	end
	local mhw = Tracker:FindObjectForCode("mhw")
	if mhw.CurrentStage == 5 then
		mhw.CurrentStage = 0
	end
	local gew = Tracker:FindObjectForCode("goa_entrance_wall_tested")
	if gew.CurrentStage == 2 then
		gew.CurrentStage = 0
	end
	local gsbw = Tracker:FindObjectForCode("goa_sabera_boss_wall_tested")
	if gsbw.CurrentStage == 2 then
		gsbw.CurrentStage = 0
	end
	local gsiw = Tracker:FindObjectForCode("goa_sabera_item_wall_tested")
	if gsiw.CurrentStage == 2 then
		gsiw.CurrentStage = 0
	end
	local gmw = Tracker:FindObjectForCode("goa_mado_wall_tested")
	if gmw.CurrentStage == 2 then
		gmw.CurrentStage = 0
	end
	local gkw = Tracker:FindObjectForCode("goa_karmine_wall_tested")
	if gkw.CurrentStage == 2 then
		gkw.CurrentStage = 0
	end
	local gbw = Tracker:FindObjectForCode("goa_basement_wall_tested")
	if gbw.CurrentStage == 2 then
		gbw.CurrentStage = 0
	end
end