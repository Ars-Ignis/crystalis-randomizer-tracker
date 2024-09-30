--Goa Logic

function canEnterGoaFrontEntrance()
	--TODO: flag_wh logic
	return 	canReach("goa") and
			canBypassBarriers() and
			canBreakGoaEntranceWall()
end

function canMaybeEnterGoaFrontEntrance()
	--TODO: flag_wh logic
	return 	canMaybeReach("goa") and
			canBypassBarriers() and
			canMaybeBreakGoaEntranceWall()
end

function canEnterGoaBackEntrance()
	if Tracker:ProviderCountForCode("flag_wm") == 0 then
		return 	canReach("goa") and
				Tracker:ProviderCountForCode("flight") > 0
	else
		return	canReach("goa") and
				(Tracker:ProviderCountForCode("d_oasis1") > 0 or
				Tracker:ProviderCountForCode("flight") > 0)
	end
end

function canMaybeEnterGoaBackEntrance()
	if Tracker:ProviderCountForCode("flag_wm") == 0 then
		return 	canMaybeReach("goa") and
				Tracker:ProviderCountForCode("flight") > 0
	else
		return	canMaybeReach("goa") and
				(Tracker:ProviderCountForCode("d_oasis1_blocked") == 0 or
				Tracker:ProviderCountForCode("flight") > 0)
	end
end

function canCrossKelbesquesFloor()
	return	canKillKelbesque2()
end

function canMaybeCrossKelbesquesFloor()
	return	canMaybeKillKelbesque2()
end

function canCrossSaberasFloor()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		local canCross =	(canCrossRivers() and canBreakSaberaBossWall() and canBreakSaberaChestWall() and canKillSabera2()) or
							(Tracker:ProviderCountForCode("d_goasabera1") > 0 and Tracker:ProviderCountForCode("d_goasabera2") > 0 and canKillSabera2())
		return canCross
	else
		return	canCrossRivers() and
				canBreakSaberaBossWall() and
				canKillSabera2()
	end
end

function canMaybeCrossSaberasFloor()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		local canCross = (Tracker:ProviderCountForCode("d_goasabera1_blocked") == 0 and Tracker:ProviderCountForCode("d_goasabera2_blocked") == 0 and canMaybeKillSabera2())
		return canCross
	else
		return	canCrossRivers() and
				canMaybeBreakSaberaBossWall() and
				canMaybeKillSabera2()
	end
end

function canCrossMadosFloor()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		local canCross =	(Tracker:ProviderCountForCode("d_goamado1") > 0 and canKillMado2() and Tracker:ProviderCountForCode("d_goamado2") > 0) or
							(canKillMado2() and canCrossSpikes())
		return canCross
	else
		return	canKillMado2() and
				canCrossSpikes()
	end
end

function canMaybeCrossMadosFloor()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		local canCross = (Tracker:ProviderCountForCode("d_goamado1_blocked") == 0 and Tracker:ProviderCountForCode("d_goamado2_blocked") == 0 and canMaybeKillMado2())
		return canCross
	else
		return	canMaybeKillMado2() and
				canCrossSpikes()
	end
end

function canCrossKarminesFloor()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		local canCross =	(Tracker:ProviderCountForCode("d_goakarmine1") > 0 and Tracker:ProviderCountForCode("d_goakarmine2") > 0) or
							canBreakKarmineWall()
		return canCross
	else
		return	canBreakKarmineWall()
	end
end

function canMaybeCrossKarminesFloor()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		local canCross =	(Tracker:ProviderCountForCode("d_goakarmine1_blocked") == 0 and Tracker:ProviderCountForCode("d_goakarmine2_blocked") == 0) or
							canMaybeBreakKarmineWall()
		return canCross
	else
		return	canMaybeBreakKarmineWall()
	end
end

function canFullyCrossGoa()
	return	canCrossKelbesquesFloor() and
			canCrossSaberasFloor() and
			canCrossMadosFloor() and
			canCrossKarminesFloor()
end

function canMaybeFullyCrossGoa()
	return	canMaybeCrossKelbesquesFloor() and
			canMaybeCrossSaberasFloor() and
			canMaybeCrossMadosFloor() and
			canMaybeCrossKarminesFloor()
end

function canCrossGivenGoaFloor(boss)
	if boss == "kelbesque" then
		return canCrossKelbesquesFloor()
	elseif boss == "sabera" then
		return canCrossSaberasFloor()
	elseif boss == "mado" then
		return canCrossMadosFloor()
	elseif boss == "karmine" then
		return canCrossKarminesFloor()
	end
	print("Unrecognized boss: " .. boss)
	return false
end

function canMaybeCrossGivenGoaFloor(boss)
	if boss == "kelbesque" then
		return canMaybeCrossKelbesquesFloor()
	elseif boss == "sabera" then
		return canMaybeCrossSaberasFloor()
	elseif boss == "mado" then
		return canMaybeCrossMadosFloor()
	elseif boss == "karmine" then
		return canMaybeCrossKarminesFloor()
	end
	print("Unrecognized boss: " .. boss)
	return false
end

function getBossForFloor(floorNum)
	if negate("flag_wg") then
		if floorNum == 1 then
			return "kelbesque"
		elseif floorNum == 2 then
			return "sabera"
		elseif floorNum == 3 then
			return "mado"
		elseif floorNum == 4 then
			return "karmine"
		end
	elseif GOA_ORDER ~= nil then
		return GOA_ORDER[floorNum]["name"]
	else
		--if Tracker:ProviderCountForCode("goaknownfloor") < 3 then
			return "unknown"
		--[[elseif Tracker:ProviderCountForCode("goakelbesque") == 0 then
			return "kelbesque"
		elseif Tracker:ProviderCountForCode("goasabera") == 0 then
			return "sabera"
		elseif Tracker:ProviderCountForCode("goamado") == 0 then
			return "mado"
		elseif Tracker:ProviderCountForCode("goakarmine") == 0 then
			return "karmine"
		end]]--
	end
	return "unknown"
end

function getFloorForBoss(bossName)
	if negate("flag_wg") then
		if bossName == "kelbesque" then return "1st"
		elseif bossName == "sabera" then return "2nd"
		elseif bossName == "mado" then return "3rd"
		elseif bossName == "karmine" then return "4th"
		end
	elseif GOA_ORDER ~= nil then
		if GOA_ORDER[1]["name"] == bossName then
			return "1st"
		elseif GOA_ORDER[2]["name"] == bossName then
			return "2nd"
		elseif GOA_ORDER[3]["name"] == bossName then
			return "3rd"
		elseif GOA_ORDER[4]["name"] == bossName then
			return "4th"
		else
			return "unknown"
		end
	end
	return "unknown"
end

function isBossFloorReversed(bossName)
	if GOA_ORDER ~= nil then
		for _, floor_info in ipairs(GOA_ORDER) do
			if floor_info["name"] == bossName then
				return floor_info["is_flipped"]
			end
		end
	end
	return false
end

function canCrossGoa1stFloor()
	if negate("flag_wg") then
		return canCrossKelbesquesFloor()
	else
		local boss = getBossForFloor(1)
		if boss == "unknown" then
			return canFullyCrossGoa()
		else
			return canCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canMaybeCrossGoa1stFloor()
	if negate("flag_wg") then
		return canMaybeCrossKelbesquesFloor()
	else
		local boss = getBossForFloor(1)
		if boss == "unknown" then
			return 	(Tracker:ProviderCountForCode("goakelbesque") == 0 and canMaybeCrossKelbesquesFloor()) or
					(Tracker:ProviderCountForCode("goasabera") == 0 and canMaybeCrossSaberasFloor()) or
					(Tracker:ProviderCountForCode("goamado") == 0 and canMaybeCrossMadosFloor()) or
					(Tracker:ProviderCountForCode("goakarmine") == 0 and canMaybeCrossKarminesFloor())
		else
			return canMaybeCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canCrossGoa2ndFloor()
	if negate("flag_wg") then
		return canCrossSaberasFloor()
	else
		local boss = getBossForFloor(2)
		if boss == "unknown" then
			return canFullyCrossGoa()
		else
			return canCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canMaybeCrossGoa2ndFloor()
	if negate("flag_wg") then
		return canMaybeCrossSaberasFloor()
	else
		local boss = getBossForFloor(2)
		if boss == "unknown" then
			return 	(Tracker:ProviderCountForCode("goakelbesque") == 0 and canMaybeCrossKelbesquesFloor()) or
					(Tracker:ProviderCountForCode("goasabera") == 0 and canMaybeCrossSaberasFloor()) or
					(Tracker:ProviderCountForCode("goamado") == 0 and canMaybeCrossMadosFloor()) or
					(Tracker:ProviderCountForCode("goakarmine") == 0 and canMaybeCrossKarminesFloor())
		else
			return canMaybeCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canCrossGoa3rdFloor()
	if negate("flag_wg") then
		return canCrossMadosFloor()
	else
		local boss = getBossForFloor(3)
		if boss == "unknown" then
			return canFullyCrossGoa()
		else
			return canCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canMaybeCrossGoa3rdFloor()
	if negate("flag_wg") then
		return canMaybeCrossMadosFloor()
	else
		local boss = getBossForFloor(3)
		if boss == "unknown" then
			return 	(Tracker:ProviderCountForCode("goakelbesque") == 0 and canMaybeCrossKelbesquesFloor()) or
					(Tracker:ProviderCountForCode("goasabera") == 0 and canMaybeCrossSaberasFloor()) or
					(Tracker:ProviderCountForCode("goamado") == 0 and canMaybeCrossMadosFloor()) or
					(Tracker:ProviderCountForCode("goakarmine") == 0 and canMaybeCrossKarminesFloor())
		else
			return canMaybeCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canCrossGoa4thFloor()
	if negate("flag_wg") then
		return canCrossKarminesFloor()
	else
		local boss = getBossForFloor(4)
		if boss == "unknown" then
			return canFullyCrossGoa()
		else
			return canCrossGivenGoaFloor(boss)
		end
	end
	return false
end

function canMaybeCrossGoa4thFloor()
	if negate("flag_wg") then
		return canMaybeCrossKarminesFloor()
	else
		local boss = getBossForFloor(4)
		if boss == "unknown" then
			return 	(Tracker:ProviderCountForCode("goakelbesque") == 0 and canMaybeCrossKelbesquesFloor()) or
					(Tracker:ProviderCountForCode("goasabera") == 0 and canMaybeCrossSaberasFloor()) or
					(Tracker:ProviderCountForCode("goamado") == 0 and canMaybeCrossMadosFloor()) or
					(Tracker:ProviderCountForCode("goakarmine") == 0 and canMaybeCrossKarminesFloor())
		else
			return canMaybeCrossGivenGoaFloor(boss)
		end
	end
	return false
end

--------1st Floor Functions--------------

function canReachGoa1stFloorEntrance()
	return 	canEnterGoaFrontEntrance()
end

function canReachGoa1stFloorExit()
	return canEnterGoaBackEntrance() and canCrossGoa4thFloor() and canCrossGoa3rdFloor() and canCrossGoa2ndFloor()
end

function canReachGoa1stFloor()
	return 	canReachGoa1stFloorEntrance() or canReachGoa1stFloorExit()
end

function canMaybeReachGoa1stFloorEntrance()
	return 	canMaybeEnterGoaFrontEntrance()
end

function canMaybeReachGoa1stFloorExit()
	return canMaybeEnterGoaBackEntrance() and canMaybeCrossGoa4thFloor() and canMaybeCrossGoa3rdFloor() and canMaybeCrossGoa2ndFloor()
end

function canMaybeReachGoa1stFloor()
	return 	canMaybeReachGoa1stFloorEntrance() or canMaybeReachGoa1stFloorExit()
end

--------2nd Floor Functions--------------

function canReachGoa2ndFloorEntrance()
	return 	canEnterGoaFrontEntrance() and canCrossGoa1stFloor()
end

function canReachGoa2ndFloorExit()
	return canEnterGoaBackEntrance() and canCrossGoa4thFloor() and canCrossGoa3rdFloor()
end

function canReachGoa2ndFloor()
	return 	canReachGoa2ndFloorEntrance() or canReachGoa2ndFloorExit()
end

function canMaybeReachGoa2ndFloorEntrance()
	return 	canMaybeEnterGoaFrontEntrance() and canMaybeCrossGoa1stFloor()
end

function canMaybeReachGoa2ndFloorExit()
	return canMaybeEnterGoaBackEntrance() and canMaybeCrossGoa4thFloor() and canMaybeCrossGoa3rdFloor()
end

function canMaybeReachGoa2ndFloor()
	return 	canMaybeReachGoa2ndFloorEntrance() or canMaybeReachGoa2ndFloorExit()
end

--------3rd Floor Functions--------------

function canReachGoa3rdFloorEntrance()
	return canEnterGoaFrontEntrance() and canCrossGoa1stFloor() and canCrossGoa2ndFloor()
end

function canReachGoa3rdFloorExit()
	return canEnterGoaBackEntrance() and canCrossGoa4thFloor()
end

function canReachGoa3rdFloor()
	return canReachGoa3rdFloorEntrance() or canReachGoa3rdFloorExit()
end

function canMaybeReachGoa3rdFloorEntrance()
	return canMaybeEnterGoaFrontEntrance() and canMaybeCrossGoa1stFloor() and canMaybeCrossGoa2ndFloor()
end

function canMaybeReachGoa3rdFloorExit()
	return canMaybeEnterGoaBackEntrance() and canMaybeCrossGoa4thFloor()
end

function canMaybeReachGoa3rdFloor()
	return canMaybeReachGoa3rdFloorEntrance() or canMaybeReachGoa3rdFloorExit()
end

--------4th Floor Functions--------------

function canReachGoa4thFloorEntrance()
	return canEnterGoaFrontEntrance() and canCrossGoa1stFloor() and canCrossGoa2ndFloor() and canCrossGoa3rdFloor()
end

function canReachGoa4thFloorExit()
	return canEnterGoaBackEntrance()
end

function canReachGoa4thFloor()
	return canReachGoa4thFloorEntrance() or canReachGoa4thFloorExit()
end

function canMaybeReachGoa4thFloorEntrance()
	return canMaybeEnterGoaFrontEntrance() and canMaybeCrossGoa1stFloor() and canMaybeCrossGoa2ndFloor() and canMaybeCrossGoa3rdFloor()
end

function canMaybeReachGoa4thFloorExit()
	return canMaybeEnterGoaBackEntrance()
end

function canMaybeReachGoa4thFloor()
	return canMaybeReachGoa4thFloorEntrance() or canMaybeReachGoa4thFloorExit()
end

--------Kelbesque Functions--------------

function canReachKelbesquesFloor()
	local floorName = getFloorForBoss("kelbesque")
	--print("kelbesque: " .. floorName)
	if floorName == "1st" then
		return canReachGoa1stFloor()
	elseif floorName == "2nd" then
		return canReachGoa2ndFloor()
	elseif floorName == "3rd" then
		return canReachGoa3rdFloor()
	elseif floorName == "4th" then
		return canReachGoa4thFloor()
	else
		local crossCount = 0
		if canCrossSaberasFloor() then crossCount = crossCount + 1 end
		if canCrossMadosFloor() then crossCount = crossCount + 1 end
		if canCrossKarminesFloor() then crossCount = crossCount + 1 end
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		return	crossCount >= 4
	end
end

function canMaybeReachKelbesquesFloor()
	local floorName = getFloorForBoss("kelbesque")
	if floorName == "1st" then
		return canMaybeReachGoa1stFloor()
	elseif floorName == "2nd" then
		return canMaybeReachGoa2ndFloor()
	elseif floorName == "3rd" then
		return canMaybeReachGoa3rdFloor()
	elseif floorName == "4th" then
		return canMaybeReachGoa4thFloor()
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
end

--------Sabera Functions--------------

function canReachSaberasFloorEntrance()
	local floorName = getFloorForBoss("sabera")
	local reversed = isBossFloorReversed("sabera")
	if floorName == "1st" then
		if not reversed then
			return canReachGoa1stFloorEntrance()
		else
			return canReachGoa1stFloorExit()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canReachGoa2ndFloorEntrance()
		else
			return canReachGoa2ndFloorExit()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canReachGoa3rdFloorEntrance()
		else
			return canReachGoa3rdFloorExit()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canReachGoa4thFloorEntrance()
		else
			return canReachGoa4thFloorExit()
		end
	else
		local crossCount = 0
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		if canCrossSaberasFloor() then crossCount = crossCount + 1 end
		return crossCount >= 2 and canCrossKarminesFloor() and canCrossMadosFloor() and canCrossKelbesquesFloor()
	end
end

function canMaybeReachSaberasFloorEntrance()
	local floorName = getFloorForBoss("sabera")
	local reversed = isBossFloorReversed("sabera")
	if floorName == "1st" then
		if not reversed then
			return canMaybeReachGoa1stFloorEntrance()
		else
			return canMaybeReachGoa1stFloorExit()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canMaybeReachGoa2ndFloorEntrance()
		else
			return canMaybeReachGoa2ndFloorExit()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canMaybeReachGoa3rdFloorEntrance()
		else
			return canMaybeReachGoa3rdFloorExit()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canMaybeReachGoa4thFloorEntrance()
		else
			return canMaybeReachGoa4thFloorExit()
		end
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
end

function canReachSaberasFloorExit()
	local floorName = getFloorForBoss("sabera")
	local reversed = isBossFloorReversed("sabera")
	if floorName == "1st" then
		if not reversed then
			return canReachGoa1stFloorExit()
		else
			return canReachGoa1stFloorEntrance()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canReachGoa2ndFloorExit()
		else
			return canReachGoa2ndFloorEntrance()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canReachGoa3rdFloorExit()
		else
			return canReachGoa3rdFloorEntrance()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canReachGoa4thFloorExit()
		else
			return canReachGoa4thFloorEntrance()
		end
	else
		local crossCount = 0
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		if canCrossSaberasFloor() then crossCount = crossCount + 1 end
		return crossCount >= 2 and canCrossKarminesFloor() and canCrossMadosFloor() and canCrossKelbesquesFloor()
	end
end

function canMaybeReachSaberasFloorExit()
	local floorName = getFloorForBoss("sabera")
	local reversed = isBossFloorReversed("sabera")
	if floorName == "1st" then
		if not reversed then
			return canMaybeReachGoa1stFloorExit()
		else
			return canMaybeReachGoa1stFloorEntrance()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canMaybeReachGoa2ndFloorExit()
		else
			return canMaybeReachGoa2ndFloorEntrance()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canMaybeReachGoa3rdFloorExit()
		else
			return canMaybeReachGoa3rdFloorEntrance()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canMaybeReachGoa4thFloorExit()
		else
			return canMaybeReachGoa4thFloorEntrance()
		end
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
end

---------------Mado Functions-------------------------

function canReachMadosFloorEntrance()
	local floorName = getFloorForBoss("mado")
	local reversed = isBossFloorReversed("mado")
	if floorName == "1st" then
		if not reversed then
			return canReachGoa1stFloorEntrance()
		else
			return canReachGoa1stFloorExit()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canReachGoa2ndFloorEntrance()
		else
			return canReachGoa2ndFloorExit()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canReachGoa3rdFloorEntrance()
		else
			return canReachGoa3rdFloorExit()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canReachGoa4thFloorEntrance()
		else
			return canReachGoa4thFloorExit()
		end
	else
		local crossCount = 0
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		if canCrossMadosFloor() then crossCount = crossCount + 1 end
		return crossCount >= 2 and canCrossKarminesFloor() and canCrossSaberasFloor() and canCrossKelbesquesFloor()
	end
end

function canMaybeReachMadosFloorEntrance()
	local floorName = getFloorForBoss("mado")
	local reversed = isBossFloorReversed("mado")
	if floorName == "1st" then
		if not reversed then
			return canMaybeReachGoa1stFloorEntrance()
		else
			return canMaybeReachGoa1stFloorExit()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canMaybeReachGoa2ndFloorEntrance()
		else
			return canMaybeReachGoa2ndFloorExit()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canMaybeReachGoa3rdFloorEntrance()
		else
			return canMaybeReachGoa3rdFloorExit()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canMaybeReachGoa4thFloorEntrance()
		else
			return canMaybeReachGoa4thFloorExit()
		end
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
	return(canCross)
end

function canReachMadosFloorExit()
	local floorName = getFloorForBoss("mado")
	local reversed = isBossFloorReversed("mado")
	if floorName == "1st" then
		if not reversed then
			return canReachGoa1stFloorExit()
		else
			return canReachGoa1stFloorEntrance()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canReachGoa2ndFloorExit()
		else
			return canReachGoa2ndFloorEntrance()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canReachGoa3rdFloorExit()
		else
			return canReachGoa3rdFloorEntrance()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canReachGoa4thFloorExit()
		else
			return canReachGoa4thFloorEntrance()
		end
	else
		local crossCount = 0
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		if canCrossMadosFloor() then crossCount = crossCount + 1 end
		return crossCount >= 2 and canCrossKarminesFloor() and canCrossSaberasFloor() and canCrossKelbesquesFloor()
	end
end

function canMaybeReachMadosFloorExit()
	local floorName = getFloorForBoss("mado")
	local reversed = isBossFloorReversed("mado")
	if floorName == "1st" then
		if not reversed then
			return canMaybeReachGoa1stFloorExit()
		else
			return canMaybeReachGoa1stFloorEntrance()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canMaybeReachGoa2ndFloorExit()
		else
			return canMaybeReachGoa2ndFloorEntrance()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canMaybeReachGoa3rdFloorExit()
		else
			return canMaybeReachGoa3rdFloorEntrance()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canMaybeReachGoa4thFloorExit()
		else
			return canMaybeReachGoa4thFloorEntrance()
		end
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
end

---------------Karmine Functions-------------------------

function canReachKarminesFloorEntrance()
	local floorName = getFloorForBoss("karmine")
	local reversed = isBossFloorReversed("karmine")
	if floorName == "1st" then
		if not reversed then
			return canReachGoa1stFloorEntrance()
		else
			return canReachGoa1stFloorExit()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canReachGoa2ndFloorEntrance()
		else
			return canReachGoa2ndFloorExit()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canReachGoa3rdFloorEntrance()
		else
			return canReachGoa3rdFloorExit()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canReachGoa4thFloorEntrance()
		else
			return canReachGoa4thFloorExit()
		end
	else
		local crossCount = 0
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		if canCrossKarminesFloor() then crossCount = crossCount + 1 end
		return crossCount >= 2 and canCrossMadosFloor() and canCrossSaberasFloor() and canCrossKelbesquesFloor()
	end
end

function canMaybeReachKarminesFloorEntrance()
	local floorName = getFloorForBoss("karmine")
	local reversed = isBossFloorReversed("karmine")
	if floorName == "1st" then
		if not reversed then
			return canMaybeReachGoa1stFloorEntrance()
		else
			return canMaybeReachGoa1stFloorExit()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canMaybeReachGoa2ndFloorEntrance()
		else
			return canMaybeReachGoa2ndFloorExit()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canMaybeReachGoa3rdFloorEntrance()
		else
			return canMaybeReachGoa3rdFloorExit()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canMaybeReachGoa4thFloorEntrance()
		else
			return canMaybeReachGoa4thFloorExit()
		end
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
end

function canReachKarminesFloorExit()
	local floorName = getFloorForBoss("karmine")
	local reversed = isBossFloorReversed("karmine")
	if floorName == "1st" then
		if not reversed then
			return canReachGoa1stFloorExit()
		else
			return canReachGoa1stFloorEntrance()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canReachGoa2ndFloorExit()
		else
			return canReachGoa2ndFloorEntrance()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canReachGoa3rdFloorExit()
		else
			return canReachGoa3rdFloorEntrance()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canReachGoa4thFloorExit()
		else
			return canReachGoa4thFloorEntrance()
		end
	else
		local crossCount = 0
		if canEnterGoaFrontEntrance() then crossCount = crossCount + 1 end
		if canEnterGoaBackEntrance() then crossCount = crossCount + 1 end
		if canCrossKarminesFloor() then crossCount = crossCount + 1 end
		return crossCount >= 2 and canCrossMadosFloor() and canCrossSaberasFloor() and canCrossKelbesquesFloor()
	end
end

function canMaybeReachKarminesFloorExit()
	local floorName = getFloorForBoss("karmine")
	local reversed = isBossFloorReversed("karmine")
	if floorName == "1st" then
		if not reversed then
			return canMaybeReachGoa1stFloorExit()
		else
			return canMaybeReachGoa1stFloorEntrance()
		end
	elseif floorName == "2nd" then
		if not reversed then
			return canMaybeReachGoa2ndFloorExit()
		else
			return canMaybeReachGoa2ndFloorEntrance()
		end
	elseif floorName == "3rd" then
		if not reversed then
			return canMaybeReachGoa3rdFloorExit()
		else
			return canMaybeReachGoa3rdFloorEntrance()
		end
	elseif floorName == "4th" then
		if not reversed then
			return canMaybeReachGoa4thFloorExit()
		else
			return canMaybeReachGoa4thFloorEntrance()
		end
	else
		return	(canMaybeReachGoa1stFloor() and Tracker:ProviderCountForCode("goa1stunknown") > 0) or
				(canMaybeReachGoa2ndFloor() and Tracker:ProviderCountForCode("goa2ndunknown") > 0) or
				(canMaybeReachGoa3rdFloor() and Tracker:ProviderCountForCode("goa3rdunknown") > 0) or
				(canMaybeReachGoa4thFloor() and Tracker:ProviderCountForCode("goa4thunknown") > 0)
	end
end