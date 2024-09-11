-- Boss Functions
function canKillInsect()
	if negate("flag_me") then
		return
			Tracker:ProviderCountForCode("fire") > 0 or
			Tracker:ProviderCountForCode("water") > 0 or
			Tracker:ProviderCountForCode("thunder") > 0
	else
		local swordCount = Tracker:ProviderCountForCode("sword")
		return Tracker:ProviderCountForCode("giantinsect_cleared") > 0 or swordCount > 1 or (Tracker:ProviderCountForCode("flag_ns") > 0 and swordCount > 0)
	end
end

function canMaybeKillInsect()
	if negate("flag_me") then
		return canKillInsect()
	elseif Tracker:ProviderCountForCode("giantinsect_tested") > 0 then
		return Tracker:ProviderCountForCode("sword") > 1
	else
		return hasAnySword() or canKillInsect()
	end
end

function canKillVampire2()
	if negate("flag_me") then
		return
			Tracker:ProviderCountForCode("wind") > 0 or
			Tracker:ProviderCountForCode("water") > 0 or
			Tracker:ProviderCountForCode("thunder") > 0
	else
		return Tracker:ProviderCountForCode("vampire_cleared") > 0 or Tracker:ProviderCountForCode("sword") > 1 or Tracker:ProviderCountForCode("flag_ns") > 0
	end
end

function canMaybeKillVampire2()
	if negate("flag_me") then
		return canKillVampire2()
	elseif Tracker:ProviderCountForCode("vampire_tested") > 0 then
		return Tracker:ProviderCountForCode("sword") > 1
	else
		return hasAnySword() or canKillVampire2()
	end
end

function canKillTetrarchyMember()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	return hasAllSwords() and 
	(hasAllBattleMagic() or Tracker:ProviderCountForCode("flag_nw") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and
	(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
end

function canMaybeKillTetrarchyMember()
	return hasAnySword() and 
	(Tracker:ProviderCountForCode("flag_nw") > 0 or hasAnyBattleMagic()) and
	(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
end

function canMaybeKillKelbesque1()
	if negate("flag_me") then
		return canKillKelbesque1()
	elseif Tracker:ProviderCountForCode("kelbesque1_tested") > 0 then
		return canKillTetrarchyMember()
	else
		return canMaybeKillTetrarchyMember() or canKillKelbesque1()
	end
end

function canKillKelbesque1()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("wind") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("windbracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return Tracker:ProviderCountForCode("kelbesque1_cleared") > 0 or canKillTetrarchyMember()
	end
end

function canMaybeKillKelbesque2()
	if negate("flag_me") then
		return canKillKelbesque2()
	elseif Tracker:ProviderCountForCode("kelbesque2_tested") > 0 then
		return canKillTetrarchyMember()
	else
		return canMaybeKillTetrarchyMember() or canKillKelbesque2()
	end
end

function canKillKelbesque2()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("wind") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("windbracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return Tracker:ProviderCountForCode("kelbesque2_cleared") > 0 or canKillTetrarchyMember()
	end
end

function canMaybeKillSabera1()
	if negate("flag_me") then
		return canKillSabera1()
	elseif Tracker:ProviderCountForCode("sabera1_tested") > 0 then
		return canKillTetrarchyMember()
	else
		return canMaybeKillTetrarchyMember() or canKillSabera1()
	end
end

function canKillSabera1()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("fire") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("firebracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return Tracker:ProviderCountForCode("sabera1_cleared") > 0 or canKillTetrarchyMember()
	end
end

function canMaybeKillSabera2()
	if negate("flag_me") then
		return canKillSabera2()
	elseif Tracker:ProviderCountForCode("sabera2_tested") > 0 then
		return canKillTetrarchyMember()
	else
		return canMaybeKillTetrarchyMember() or canKillSabera2()
	end
end

function canKillSabera2()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("fire") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("firebracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return Tracker:ProviderCountForCode("sabera2_cleared") > 0 or canKillTetrarchyMember()
	end
end

function canMaybeKillMado1()
	if negate("flag_me") then
		return canKillMado1()
	elseif Tracker:ProviderCountForCode("mado1_tested") > 0 then
		return canKillTetrarchyMember()
	else
		return canMaybeKillTetrarchyMember() or canKillMado1()
	end
end

function canKillMado1()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("water") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("waterbracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return Tracker:ProviderCountForCode("mado1_cleared") > 0 or canKillTetrarchyMember()
	end
end

function canMaybeKillMado2()
	if negate("flag_me") then
		return canKillMado2()
	elseif Tracker:ProviderCountForCode("mado2_tested") > 0 then
		return canKillTetrarchyMember()
	else
		return canMaybeKillTetrarchyMember() or canKillMado2()
	end
end

function canKillMado2()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return canMaybeKillTetrarchyMember()
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("water") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("waterbracelet") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyBattleMagic())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return Tracker:ProviderCountForCode("mado2_cleared") > 0 or canKillTetrarchyMember()
	end
end

-- Karmine needs special handling, because his fight only requires level 2 charge logically.
function canMaybeKillKarmine()
	if negate("flag_me") then
		return canKillKarmine()
	elseif Tracker:ProviderCountForCode("karmine_tested") > 0 then
		return 	hasAllSwords() and
				(hasAllLevelTwo() or Tracker:ProviderCountForCode("flag_nw") > 0) and
				(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return 	(hasAnySword() and
				(hasAnyLevelTwo() or Tracker:ProviderCountForCode("flag_nw") > 0) and
				(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)) or
				canKillKarmine()
	end
end

function canKillKarmine()
	if Tracker:ProviderCountForCode("flag_ns") > 0 then
		return 	(hasAnySword() and
				(hasAnyLevelTwo() or Tracker:ProviderCountForCode("flag_nw") > 0) and
				(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0))
	end
	if negate("flag_me") then
		return Tracker:ProviderCountForCode("thunder") > 0 and 
		(Tracker:ProviderCountForCode("flag_nw") > 0 or Tracker:ProviderCountForCode("thunderorb") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo())) and 
		(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0)
	else
		return 	Tracker:ProviderCountForCode("karmine_cleared") > 0 or 
				(hasAllSwords() and
				(hasAllLevelTwo() or Tracker:ProviderCountForCode("flag_nw") > 0 or (Tracker:ProviderCountForCode("flag_gc") > 0 and hasAnyLevelTwo())) and
				(negate("flag_er") or Tracker:ProviderCountForCode("refresh") > 0))
	end
end

function resetTetrarchyBossTracking()
	--print("Resetting tested bosses...")
	local kelbesque1 = Tracker:FindObjectForCode("kelbesque1")
	if kelbesque1.CurrentStage == 2 then
		kelbesque1.CurrentStage = 0
	end
	local kelbesque2 = Tracker:FindObjectForCode("kelbesque2")
	if kelbesque2.CurrentStage == 2 then
		kelbesque2.CurrentStage = 0
	end
	local sabera1 = Tracker:FindObjectForCode("sabera1")
	if sabera1.CurrentStage == 2 then
		sabera1.CurrentStage = 0
	end
	local sabera2 = Tracker:FindObjectForCode("sabera2")
	if sabera2.CurrentStage == 2 then
		sabera2.CurrentStage = 0
	end
	local mado1 = Tracker:FindObjectForCode("mado1")
	if mado1.CurrentStage == 2 then
		mado1.CurrentStage = 0
	end
	local mado2 = Tracker:FindObjectForCode("mado2")
	if mado2.CurrentStage == 2 then
		mado2.CurrentStage = 0
	end
end

function resetKarmineTracking()
	local karmine = Tracker:FindObjectForCode("karmine")
	if karmine.CurrentStage == 2 then
		karmine.CurrentStage = 0
	end
end

function resetMinorBossTracking()
	local giantinsect = Tracker:FindObjectForCode("giantinsect")
	if giantinsect.CurrentStage == 2 then
		giantinsect.CurrentStage = 0
	end
	local vampire = Tracker:FindObjectForCode("vampire")
	if vampire.CurrentStage == 2 then
		vampire.CurrentStage = 0
	end
end
