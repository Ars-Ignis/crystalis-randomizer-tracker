function initCustomItemsAuto()
	local thunderCodes = {"nowarp", "shyron", "leaf", "brynmaer", 
				"oak", "nadares", "portoa", "amazones", 
				"joel", "zombie", "swan", "goa", "sahara"}

	local swordOfWind = SwordItem("Sword of Wind", "wind", "images/items/swordofwind.png")
	local swordOfFire = SwordItem("Sword of Fire", "fire", "images/items/swordoffire.png")
	local swordOfWater = SwordItem("Sword of Water", "water", "images/items/swordofwater.png")
	local swordOfThunder = ThunderSwordItem("Sword of Thunder", "thunder", thunderCodes)
	local ballOfWind = BallItem("Ball of Wind", "windball", "images/items/ballofwind.png")
	local ballOfFire = BallItem("Ball of Fire", "fireball", "images/items/balloffire.png")
	local ballOfWater = BallItem("Ball of Water", "waterball", "images/items/ballofwater.png")
	local ballOfThunder = BallItem("Ball of Thunder", "thunderball", "images/items/ballofthunder.png")
	local windBracelet = BraceletItem("Tornado Bracelet", "windbracelet", "images/items/braceletofwind.png")
	local fireBracelet = BraceletItem("Flame Bracelet", "firebracelet", "images/items/braceletoffire.png")
	local waterBracelet = BraceletItem("Blizzard Bracelet", "waterbracelet", "images/items/braceletofwater.png")
	local thunderBracelet = BraceletItem("Storm Bracelet", "thunderbracelet", "images/items/braceletofthunder.png")
	local goa1st = GoaFloorItem("1st", 0)
	local goa2nd = GoaFloorItem("2nd", 0)
	local goa3rd = GoaFloorItem("3rd", 0)
	local goa4th = GoaFloorItem("4th", 0)

	
	
end