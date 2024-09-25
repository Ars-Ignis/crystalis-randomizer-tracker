-- Check to see if a relevant flag is set to "off"
function negate(code)
	return Tracker:ProviderCountForCode(code) == 0
end

function hasAnySword()
	return Tracker:ProviderCountForCode("sword") > 0
end

function hasAllSwords()
	return Tracker:ProviderCountForCode("sword") >= 4
end

function hasAnyOrb()
	return Tracker:ProviderCountForCode("orb") > 0
end

function hasAllOrbs()
	return Tracker:ProviderCountForCode("orb") >= 4
end

function hasAnyBracelet()
	return Tracker:ProviderCountForCode("bracelet") > 0
end

function hasAllBracelets()
	return Tracker:ProviderCountForCode("bracelet") >= 4
end

function levelTwoCount()
	local count = 0
	if Tracker:ProviderCountForCode("windupgrade") > 0 and Tracker:ProviderCountForCode("wind") > 0 then
		count = count + 1
	end
	if Tracker:ProviderCountForCode("fireupgrade") > 0 and Tracker:ProviderCountForCode("fire") > 0 then
		count = count + 1
	end
	if Tracker:ProviderCountForCode("waterupgrade") > 0 and Tracker:ProviderCountForCode("water") > 0 then
		count = count + 1
	end
	if Tracker:ProviderCountForCode("thunderupgrade") > 0 and Tracker:ProviderCountForCode("thunder") > 0 then
		count = count + 1
	end
	return count
end

function hasAnyLevelTwo()
	return levelTwoCount() > 0
end

function hasAllLevelTwo()
	return levelTwoCount() == 4
end

function battleMagicCount()
	local count = 0
	if Tracker:ProviderCountForCode("windupgrade") > 1 and Tracker:ProviderCountForCode("wind") > 0 then
		count = count + 1
	end
	if Tracker:ProviderCountForCode("fireupgrade") > 1 and Tracker:ProviderCountForCode("fire") > 0 then
		count = count + 1
	end
	if Tracker:ProviderCountForCode("waterupgrade") > 1 and Tracker:ProviderCountForCode("water") > 0 then
		count = count + 1
	end
	if Tracker:ProviderCountForCode("thunderupgrade") > 1 and Tracker:ProviderCountForCode("thunder") > 0 then
		count = count + 1
	end
	return count
end

function hasAnyBattleMagic()
	return battleMagicCount() > 0
end

function hasAllBattleMagic()
	return battleMagicCount() == 4
end

function canOpenChest()
	return Tracker:ProviderCountForCode("flag_mg") == 0 or hasAnySword()
end

function canCrossRivers()
	return Tracker:ProviderCountForCode("flight") > 0 or canBreakEmberWalls()
end

function canTriggerSkip()
	return 	Tracker:ProviderCountForCode("flag_gt") > 0 
end

function canClimbSlope()
	return
		Tracker:ProviderCountForCode("rabbit") > 0 or
		(Tracker:ProviderCountForCode("speed") > 0 and negate("flag_vb")) or
		Tracker:ProviderCountForCode("flight") > 0 or
		canTriggerSkip()
end

function canBypassBarriers()
	return
		Tracker:ProviderCountForCode("barrier") > 0 or
		(Tracker:ProviderCountForCode("refresh") > 0 and Tracker:ProviderCountForCode("shield") > 0) or
		Tracker:ProviderCountForCode("flag_nb") > 0 or
		(Tracker:ProviderCountForCode("flag_gg") > 0 and Tracker:ProviderCountForCode("flight") > 0)
end

function canMaybeTriggerMesia()
	return (maybeHasRageSword() or Tracker:ProviderCountForCode("flag_gr") > 0) and canCrossRivers()
end

function canTriggerMesia()
	return (hasRageSword() or Tracker:ProviderCountForCode("flag_gr") > 0) and canCrossRivers()
end

function canMaybeUseShellFlute()
	if maybeHasShellFlute() then
		return negate("flag_rd") or (canMaybeTriggerMesia() and canCrossRivers() and (maybeHasFishermanTrade() or Tracker:ProviderCountForCode("flag_vw") > 0))
	else
		return false
	end
end

function canUseShellFlute()
	if hasShellFlute() then
		return negate("flag_rd") or (canTriggerMesia() and canCrossRivers() and (hasFishermanTrade() or Tracker:ProviderCountForCode("flag_vw") > 0))
	else
		return false
	end
end

function canCrossSpikes()
	return	(Tracker:ProviderCountForCode("gas") > 0 and negate("flag_vb")) or
			Tracker:ProviderCountForCode("flight") > 0 or
			Tracker:ProviderCountForCode("rabbit") > 0 or
			Tracker:ProviderCountForCode("flag_ng") > 0 or
			(Tracker:ProviderCountForCode("speed") > 0 and Tracker:ProviderCountForCode("flag_vb") > 0) or
			canTriggerSkip()
end

pyramidCached = nil

function pryamidFrontIsCleared()
	if pyramidCached == nil then
		local draygon1 = Tracker:FindObjectForCode("@Pyramid/Draygon 1")
		local azteca = Tracker:FindObjectForCode("@Pyramid/Azteca In Pyramid")
		local magicRing = Tracker:FindObjectForCode("@Pyramid/Pyramid Chest")
		if Tracker:ProviderCountForCode("flag_eu") > 0 then
			pyramidCached = draygon1.AvailableChestCount == 0 and azteca.AvailableChestCount == 0
		else
			pyramidCached = draygon1.AvailableChestCount == 0 and azteca.AvailableChestCount == 0 and magicRing.AvailableChestCount == 0
		end
	end
	return pyramidCached
end