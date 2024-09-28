-- Lua Scripts for calculating general overworld traversal
WA_HACK = false

reachable = {}
maybeReachable = {}
reachableCacheValid = false
maybeReachableCacheValid = false

function invalidateCache()
	local success = true
	--print("Invalidating cache!")
	if not reachableCacheValid or not maybeReachableCacheValid then
		--print("Cache already invalid!")
		success = false
	end
	reachable = {}
	maybeReachable = {}
	reachableCacheValid = false
	maybeReachableCacheValid = false
	pyramidFrontCached = nil
	return success
end
		

--Returns a list of the possible starting points for overworld traversal
function getStartingPoints()
	local starts = {"leaf"}
	if Tracker:ProviderCountForCode("flag_vw") > 0 then
		table.insert(starts, "brynmaer")
		table.insert(starts, "portoa")
		table.insert(starts, "swan")
		table.insert(starts, "goa")
		table.insert(starts, "sahara")
		table.insert(starts, "ESI")
	end
	if Tracker:ProviderCountForCode("thundershyron") > 0 then
		table.insert(starts, "shyron")
	end
	if Tracker:ProviderCountForCode("thunderbrynmaer") > 0 then
		table.insert(starts, "brynmaer")
	end
	if Tracker:ProviderCountForCode("thunderoak") > 0 then
		table.insert(starts, "oak")
	end
	if Tracker:ProviderCountForCode("thundernadares") > 0 then
		table.insert(starts, "nadares")
	end
	if Tracker:ProviderCountForCode("thunderportoa") > 0 then
		table.insert(starts, "portoa")
	end
	if Tracker:ProviderCountForCode("thunderamazones") > 0 then
		table.insert(starts, "amazones")
	end
	if Tracker:ProviderCountForCode("thunderjoel") > 0 then
		table.insert(starts, "joel")
	end
	if Tracker:ProviderCountForCode("thunderzombie") > 0 then
		table.insert(starts, "zombie")
	end
	if Tracker:ProviderCountForCode("thunderswan") > 0 then
		table.insert(starts, "swan")
	end
	if Tracker:ProviderCountForCode("thundergoa") > 0 then
		table.insert(starts, "goa")
	end
	if Tracker:ProviderCountForCode("thundersahara") > 0 then
		table.insert(starts, "sahara")
	end
	return starts
end

--Edge functions for traversal graph
--These functions are all one-directional, and only care about direct paths from the source to the destination
--The traversal function will put together these edges to determine which warp points are reachable.
function canReachBrynmaerFromLeaf()
	--TODO: flag_wh support
	--Passage through East Cave
	if negate("flag_vm") and negate("flag_vbangm") then
		if 	Tracker:ProviderCountForCode("eastfreebrynmaer") > 0 or
			(Tracker:ProviderCountForCode("eastwallbrynmaer") > 0 and canBreakEastCaveWall()) then
				return true
		end
	end
	--Passage through Zebu's cave
	if canBreakZebusCaveWall() then
		return true
	elseif Tracker:ProviderCountForCode("flag_wm") > 0 and Tracker:ProviderCountForCode("d_zebu") > 0 then
		return true
	end
	--Passage through Windmill Cave (needs flag_wh support)
	return hasWindmillKey() and canBreakSealedCaveWalls()
end

function canReachPortoaFromLeaf()
	if negate("flag_vm") and negate("flag_vbangm") then
		if 	Tracker:ProviderCountForCode("eastfreeportoa") > 0 or
			(Tracker:ProviderCountForCode("eastwallportoa") > 0 and canBreakEastCaveWall()) then
				return true
		end
	end
	return Tracker:ProviderCountForCode("flag_vbangm") > 0
end

function canReachGoaFromLeaf()
	return	negate("flag_vm") and
			negate("flag_vbangm") and
			(Tracker:ProviderCountForCode("eastfreegoa") > 0 or (Tracker:ProviderCountForCode("eastwallgoa") > 0 and canBreakEastCaveWall()))
end

function canReachSaharaFromLeaf()
	return	negate("flag_vm") and
			negate("flag_vbangm") and
			(Tracker:ProviderCountForCode("eastfreesahara") > 0 or (Tracker:ProviderCountForCode("eastwallsahara") > 0 and canBreakEastCaveWall()))
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canReachLeafFromBrynmaer()
	print("How did we get here?")
	if negate("flag_vm") and negate("flag_vbangm") then
		if 	Tracker:ProviderCountForCode("eastfreebrynmaer") > 0 or
			(Tracker:ProviderCountForCode("eastwallbrynmaer") > 0 and canBreakEastCaveWall()) then
				return true
		end
	end
	--Passage through Zebu's cave
	if canBreakZebusCaveWall() then
		return true
	elseif Tracker:ProviderCountForCode("flag_wm") > 0 and Tracker:ProviderCountForCode("d_zebu") > 0 then
		return true
	end
	return false
end

function canReachAmazonesFromBrynmaer()
	return canCrossRivers()
end

function canReachOakFromBrynmaer()
	return Tracker:ProviderCountForCode("flag_ng") > 0 or Tracker:ProviderCountForCode("gas") > 0
end

function canReachNadaresFromBrynmaer()
	return  (Tracker:ProviderCountForCode("telepathy") > 0 and Tracker:ProviderCountForCode("teleport") > 0) or 
			(Tracker:ProviderCountForCode("flag_gn") > 0 and (Tracker:ProviderCountForCode("flight") > 0 or Tracker:ProviderCountForCode("teleport") > 0)) or 
			canTriggerSkip()
end

function canReachBrynmaerFromOak()
	return Tracker:ProviderCountForCode("flag_ng") > 0 or Tracker:ProviderCountForCode("gas") > 0
end

function canReachBrynmaerFromNadares()
	return true
end

function canReachPortoaFromNadares()
	--TODO: flag_wm support
	return canKillKelbesque1() and hasKeyToPrison() and canBreakSabreNorthWalls()
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canReachLeafFromPortoa()
	print("How did we get here?")
	if negate("flag_vm") and negate("flag_vbangm") then
		if 	Tracker:ProviderCountForCode("eastfreeportoa") > 0 or
			(Tracker:ProviderCountForCode("eastwallportoa") > 0 and canBreakEastCaveWall()) then
				return true
		end
	end
	return Tracker:ProviderCountForCode("flag_vbangm") > 0
end

function canReachNadaresFromPortoa()
	return canKillKelbesque1() and hasKeyToPrison() and canBreakSabreNorthWalls() and (Tracker:ProviderCountForCode("flight") > 0 or canTriggerSkip())
end

function canReachJoelFromPortoa()
	--TODO: flag_wh support
	local canCrossOcean = (canUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0)
	local canReachWaterFromFisherman = ((hasFishermanTrade() and (negate("flag_rd") or (canTriggerMesia() and canCrossRivers()))) or Tracker:ProviderCountForCode("flag_vw") > 0)
	local canReachWaterFromWaterway = (canTriggerMesia() or Tracker:ProviderCountForCode("flag_gs") > 0 or canTriggerSkip() or Tracker:ProviderCountForCode("paralysis") > 0)
	return 	canCrossOcean and (canReachWaterFromFisherman or canReachWaterFromWaterway)
end

function canReachBrynmaerFromAmazones()
	return canCrossRivers()
end

function canReachPortoaFromJoel()
	--TODO: flag_wh support
	return canUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0
end

function canReachZombieFromJoel()
	return	canUseShellFlute() and 
			((canCrossRivers() and canBreakEvilSpiritIslandWalls()) or
			(Tracker:ProviderCountForCode("flag_wm") > 0 and Tracker:ProviderCountForCode("d_evilspirit2") > 0 and Tracker:ProviderCountForCode("d_evilspirit4") > 0))
end

function canReachSwanFromJoel()
	return Tracker:ProviderCountForCode("flight") > 0 or (canUseShellFlute() and (hasWhirlpoolStatue() or (Tracker:ProviderCountForCode("flag_gf") > 0 and Tracker:ProviderCountForCode("rabbit") > 0)))
end

function canReachJoelFromZombie()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		return	((Tracker:ProviderCountForCode("d_evilspirit2") > 0 and
				Tracker:ProviderCountForCode("d_evilspirit1") > 0) or
				(canCrossRivers() and canBreakEvilSpiritIslandWalls())) and
				(canUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0)
	else
		return canCrossRivers() and (canUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0)
	end
end

function canReachJoelFromSwan()
	return canUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0
end

function canReachGoaFromSwan()
	return Tracker:ProviderCountForCode("change") > 0
end

function canReachGoaFromShyron()
	return canCrossRivers()
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canReachLeafFromGoa()
	print("How did we get here?")
	return	negate("flag_vm") and
			negate("flag_vbangm") and
			(Tracker:ProviderCountForCode("eastfreegoa") > 0 or (Tracker:ProviderCountForCode("eastwallgoa") > 0 and canBreakEastCaveWall()))
end

function canReachShyronFromGoa()
	return canCrossRivers() and (Tracker:ProviderCountForCode("change") > 0 or Tracker:ProviderCountForCode("flag_gs") > 0)
end

function canReachSwanFromGoa()
	return Tracker:ProviderCountForCode("change") > 0
end

function canReachSaharaFromGoa()
	return Tracker:ProviderCountForCode("flight") > 0
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canReachLeafFromSahara()
	print("How did we get here?")
	return	negate("flag_vm") and
			negate("flag_vbangm") and
			(Tracker:ProviderCountForCode("eastfreesahara") > 0 or (Tracker:ProviderCountForCode("eastwallsahara") > 0 and canBreakEastCaveWall()))
end

function canReachGoaFromSahara()
	return Tracker:ProviderCountForCode("flight") > 0
end

function canReachJoelFromESI()
	return Tracker:ProviderCountForCode("flight") > 0 or canUseShellFlute()
end

function canReachZombieFromESI()
	return (canCrossRivers() and canBreakEvilSpiritIslandWalls()) or
		   (Tracker:ProviderCountForCode("d_evilspirit2") > 0 and Tracker:ProviderCountForCode("d_evilspirit4") > 0)
end

local traversalGraph = {
	leaf = {brynmaer = canReachBrynmaerFromLeaf, portoa = canReachPortoaFromLeaf, goa = canReachGoaFromLeaf, sahara = canReachSaharaFromLeaf},
	brynmaer = {leaf = canReachLeafFromBrynmaer, amazones = canReachAmazonesFromBrynmaer, oak = canReachOakFromBrynmaer, nadares = canReachNadaresFromBrynmaer},
	oak = {brynmaer = canReachBrynmaerFromOak},
	nadares = {brynmaer = canReachBrynmaerFromNadares, portoa = canReachPortoaFromNadares},
	portoa = {leaf = canReachLeafFromPortoa, nadares = canReachNadaresFromPortoa, joel = canReachJoelFromPortoa},
	amazones = {brynmaer = canReachBrynmaerFromAmazones},
	joel = {portoa = canReachPortoaFromJoel, zombie = canReachZombieFromJoel, swan = canReachSwanFromJoel},
	zombie = {joel = canReachJoelFromZombie},
	swan = {joel = canReachJoelFromSwan, goa = canReachGoaFromSwan},
	shyron = {goa = canReachGoaFromShyron},
	goa = {leaf = canReachLeafFromGoa, shyron = canReachShyronFromGoa, swan = canReachSwanFromGoa, sahara = canReachSaharaFromGoa},
	sahara = {leaf = canReachLeafFromSahara, goa = canReachGoaFromSahara},
	ESI = {joel = canReachJoelFromESI, zombie = canReachZombieFromESI}
}

function canReach(location)
	if WA_HACK then
		return true
	end
	--print("Trying to reach: ", location)
	if not reachableCacheValid then
		reachable = getStartingPoints()
		reachableCacheValid = true
	end
	local hasReached = {}
	for index, currentLocation in ipairs(reachable) do
		--print(currentLocation)
		if location == currentLocation then
			--print("Location in starting points")
			--print(currentLocation)
			return true
		end
		hasReached[currentLocation] = true
	end
	local index = 1
	while index <= #reachable do
		local currentLocation = reachable[index]
		--print("current location: ", currentLocation)
		for destination, test in pairs(traversalGraph[currentLocation]) do
			if hasReached[destination] then
				--do nothing
			elseif test() then
				if destination == location then
					--print("Location found after traversal")
					--print(destination)
					return true
				end
				hasReached[destination] = true
				table.insert(reachable, destination)
				--print(destination)
			end
		end
		index = index + 1
	end
	--print("Failed to reach ", location)
	return false
end

-- Maybe Traversal
function canMaybeReachBrynmaerFromLeaf()
	--TODO: flag_wh support
	if canReachBrynmaerFromLeaf() then
		return true
	end
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallbrynmaer") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		end
	end
	if canMaybeBreakZebusCaveWall() then
		return true
	else
		return maybeHasWindmillKey() and canMaybeBreakSealedCaveWalls()
	end
end

function canMaybeReachPortoaFromLeaf()
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallportoa") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		end
	end
	return canReachPortoaFromLeaf()
end

function canMaybeReachGoaFromLeaf()
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallgoa") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		else
			return canReachGoaFromLeaf()
		end
	end
	return false
end

function canMaybeReachSaharaFromLeaf()
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallsahara") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		else
			return canReachSaharaFromLeaf()
		end
	end
	return false
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canMaybeReachLeafFromBrynmaer()
	print("How did we get here?")
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallbrynmaer") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		end
	end
	if canMaybeBreakZebusCaveWall() then
		return true
	else
		return canReachLeafFromBrynmaer()
	end
end

function canMaybeReachAmazonesFromBrynmaer()
	--No uncertainty
	return canReachAmazonesFromBrynmaer()
end

function canMaybeReachOakFromBrynmaer()
	--No uncertainty
	return canReachOakFromBrynmaer()
end

function canMaybeReachNadaresFromBrynmaer()
	--No uncertainty
	return canReachNadaresFromBrynmaer()
end

function canMaybeReachBrynmaerFromOak()
	--No uncertainty
	return canReachBrynmaerFromOak()
end

function canMaybeReachBrynmaerFromNadares()
	--No uncertainty
	return true
end

function canMaybeReachPortoaFromNadares()
	--TODO: flag_wm support
	return canMaybeKillKelbesque1() and maybeHasKeyToPrison() and canMaybeBreakSabreNorthWalls()
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canMaybeReachLeafFromPortoa()
	print("How did we get here?")
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallportoa") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		end
	else
		return canReachPortoaFromLeaf()
	end
end

function canMaybeReachNadaresFromPortoa()
	return (canMaybeKillKelbesque1() and maybeHasKeyToPrison() and canMaybeBreakSabreNorthWalls() and (Tracker:ProviderCountForCode("flight") > 0 or canTriggerSkip())) or canReachNadaresFromPortoa()
end

function canMaybeReachJoelFromPortoa()
	--TODO: flag_wh support
	local canMaybeCrossOcean = (canMaybeUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0)
	local canMaybeReachWaterFromFisherman = ((maybeHasFishermanTrade() and (negate("flag_rd") or (canMaybeTriggerMesia() and canCrossRivers()))) or Tracker:ProviderCountForCode("flag_vw") > 0)
	local canReachWaterFromWaterway = (canMaybeTriggerMesia() or Tracker:ProviderCountForCode("flag_gs") > 0 or canTriggerSkip() or Tracker:ProviderCountForCode("paralysis") > 0)
	return canMaybeCrossOcean and (canMaybeReachWaterFromFisherman or canReachWaterFromWaterway)
end

function canMaybeReachBrynmaerFromAmazones()
	--No uncertainty
	return canReachBrynmaerFromAmazones()
end

function canMaybeReachPortoaFromJoel()
	--TODO: flag_wh support
	return canMaybeUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0
end

function canMaybeReachZombieFromJoel()
	return	canMaybeUseShellFlute() and 
			((canCrossRivers() and canMaybeBreakEvilSpiritIslandWalls()) or
			(Tracker:ProviderCountForCode("flag_wm") > 0 and
			Tracker:ProviderCountForCode("d_evilspirit2_blocked") == 0 and
			Tracker:ProviderCountForCode("d_evilspirit4_blocked") == 0))
end

function canMaybeReachSwanFromJoel()
	return Tracker:ProviderCountForCode("flight") > 0 or (canMaybeUseShellFlute() and (maybeHasWhirlpoolStatue() or (Tracker:ProviderCountForCode("flag_gf") > 0 and Tracker:ProviderCountForCode("rabbit") > 0)))
end

function canMaybeReachJoelFromZombie()
	if Tracker:ProviderCountForCode("flag_wm") > 0 then
		return	((Tracker:ProviderCountForCode("d_evilspirit2_blocked") == 0 and
				Tracker:ProviderCountForCode("d_evilspirit1_blocked") == 0) or
				(canCrossRivers() and canMaybeBreakEvilSpiritIslandWalls())) and
				(canMaybeUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0)
	else
		return canCrossRivers() and (canMaybeUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0)
	end
end

function canMaybeReachJoelFromSwan()
	return canMaybeUseShellFlute() or Tracker:ProviderCountForCode("flight") > 0
end

function canMaybeReachGoaFromSwan()
	--No uncertainty
	return canReachGoaFromSwan()
end

function canMaybeReachGoaFromShyron()
	--No uncertainty
	return canReachGoaFromShyron()
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canMaybeReachLeafFromGoa()
	print("How did we get here?")
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallgoa") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		else
			return canReachGoaFromLeaf()
		end
	end
	return false
end

function canMaybeReachShyronFromGoa()
	--No uncertainty
	return canReachShyronFromGoa()
end

function canMaybeReachSwanFromGoa()
	--No uncertainty
	return canReachSwanFromGoa()
end

function canMaybeReachSaharaFromGoa()
	--No uncertainty
	return canReachSaharaFromGoa()
end

-- This function is technically pointless, since you can always reach Leaf, but included for the sake of completeness and in case something is changed later to randomize your starting point.
function canMaybeReachLeafFromSahara()
	print("How did we get here?")
	if negate("flag_vm") and negate("flag_vbangm") then
		if (Tracker:ProviderCountForCode("eastwallsahara") > 0 and canMaybeBreakEastCaveWall()) then
			return true
		else
			return canReachSaharaFromLeaf()
		end
	end
	return false
end

function canMaybeReachGoaFromSahara()
	--No uncertainty
	return canReachGoaFromSahara()
end

function canMaybeReachJoelFromESI()
	return Tracker:ProviderCountForCode("flight") > 0 or canMaybeUseShellFlute()
end

function canMaybeReachZombieFromESI()
	return (canCrossRivers() and canMaybeBreakEvilSpiritIslandWalls()) or
		   (Tracker:ProviderCountForCode("flag_wm") > 0 and
			Tracker:ProviderCountForCode("d_evilspirit2_blocked") == 0 and
			Tracker:ProviderCountForCode("d_evilspirit4_blocked") == 0)
end

local maybeTraversalGraph = {
	leaf = {brynmaer = canMaybeReachBrynmaerFromLeaf, portoa = canMaybeReachPortoaFromLeaf, goa = canMaybeReachGoaFromLeaf, sahara = canMaybeReachSaharaFromLeaf},
	brynmaer = {leaf = canMaybeReachLeafFromBrynmaer, amazones = canMaybeReachAmazonesFromBrynmaer, oak = canMaybeReachOakFromBrynmaer, nadares = canMaybeReachNadaresFromBrynmaer},
	oak = {brynmaer = canMaybeReachBrynmaerFromOak},
	nadares = {brynmaer = canMaybeReachBrynmaerFromNadares, portoa = canMaybeReachPortoaFromNadares},
	portoa = {leaf = canMaybeReachLeafFromPortoa, nadares = canMaybeReachNadaresFromPortoa, joel = canMaybeReachJoelFromPortoa},
	amazones = {brynmaer = canMaybeReachBrynmaerFromAmazones},
	joel = {portoa = canMaybeReachPortoaFromJoel, zombie = canMaybeReachZombieFromJoel, swan = canMaybeReachSwanFromJoel},
	zombie = {joel = canMaybeReachJoelFromZombie},
	swan = {joel = canMaybeReachJoelFromSwan, goa = canMaybeReachGoaFromSwan},
	shyron = {goa = canMaybeReachGoaFromShyron},
	goa = {leaf = canMaybeReachLeafFromGoa, shyron = canMaybeReachShyronFromGoa, swan = canMaybeReachSwanFromGoa, sahara = canMaybeReachSaharaFromGoa},
	sahara = {leaf = canMaybeReachLeafFromSahara, goa = canMaybeReachGoaFromSahara},
	ESI = {joel = canMaybeReachJoelFromESI, zombie = canMaybeReachZombieFromESI}
}

function canMaybeReach(location)
	if WA_HACK then
		return true
	end
	--print("Trying to maybe reach: ", location)
	if not maybeReachableCacheValid then
		maybeReachable = getStartingPoints()
		maybeReachableCacheValid = true
	end
	local hasReached = {}
	for index, currentLocation in ipairs(maybeReachable) do
		--print(currentLocation)
		if location == currentLocation then
			--print("Location in starting points")
			--print(currentLocation)
			return true
		end
		hasReached[currentLocation] = true
	end
	local index = 1
	while index <= #maybeReachable do
		local currentLocation = maybeReachable[index]
		for destination, test in pairs(maybeTraversalGraph[currentLocation]) do
			if hasReached[destination] then
				--do nothing
			elseif test() then
				if destination == location then
					--print("Location found after traversal")
					--print(destination)
					return true
				end
				hasReached[destination] = true
				table.insert(maybeReachable, destination)
				--print(destination)
			end
		end
		index = index + 1
	end
	--print("Failed to maybe reach ", location)
	return false
end

--bonus Mt Sabre North functions, because it's complicated:
function canMaybeAccessSabreNorth()
	return canMaybeAccessSabreNorthFront() or canMaybeAccessSabreNorthBack()
end

function canAccessSabreNorth()
	return canAccessSabreNorthFront() or canAccessSabreNorthBack()
end

function canMaybeAccessSabreNorthFront()
	return canMaybeReach("nadares")
end

function canAccessSabreNorthFront()
	return canReach("nadares")
end

function canMaybeAccessSabreNorthBack()
	return maybeHasKeyToPrison() and (Tracker:ProviderCountForCode("flight") > 0 or canTriggerSkip()) and canMaybeReach("portoa") and canMaybeBreakSabreNorthWalls()
end

function canAccessSabreNorthBack()
	return hasKeyToPrison() and (Tracker:ProviderCountForCode("flight") > 0 or canTriggerSkip()) and canReach("portoa") and canBreakSabreNorthWalls()
end