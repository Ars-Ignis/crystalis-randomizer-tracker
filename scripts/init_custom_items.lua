function initCustomItems()
	ScriptHost:LoadScript("scripts/custom_items/SwordItem.lua")
	ScriptHost:LoadScript("scripts/custom_items/BallItem.lua")
	ScriptHost:LoadScript("scripts/custom_items/BraceletItem.lua")
	local swordOfWind = CreateSwordItem("Sword of Wind", "wind", "images/items/swordofwind.png")
	local swordOfFire = CreateSwordItem("Sword of Fire", "fire", "images/items/swordoffire.png")
	local swordOfWater = CreateSwordItem("Sword of Water", "water", "images/items/swordofwater.png")
	local swordOfThunder = CreateSwordItem("Sword of Thunder", "thunder", "images/items/thundernowarp.png")
	local orbOfWind = CreateOrbItem("Orb of Wind", "windorb", "images/items/ballofwind.png")
	local orbOfFire = CreateOrbItem("Orb of Fire", "fireorb", "images/items/balloffire.png")
	local orbOfWater = CreateOrbItem("Orb of Water", "waterorb", "images/items/ballofwater.png")
	local orbOfThunder = CreateOrbItem("Orb of Thunder", "thunderorb", "images/items/ballofthunder.png")
	local windBracelet = CreateBraceletItem("Tornado Bracelet", "windbracelet", "images/items/braceletofwind.png")
	local fireBracelet = CreateBraceletItem("Flame Bracelet", "firebracelet", "images/items/braceletoffire.png")
	local waterBracelet = CreateBraceletItem("Blizzard Bracelet", "waterbracelet", "images/items/braceletofwater.png")
	local thunderBracelet = CreateBraceletItem("Storm Bracelet", "thunderbracelet", "images/items/braceletofthunder.png")
	--[[local goa1st = CreateGoaFloorItem("1st", 0)
	local goa2nd = CreateGoaFloorItem("2nd", 0)
	local goa3rd = CreateGoaFloorItem("3rd", 0)
	local goa4th = CreateGoaFloorItem("4th", 0)


	local keyBadges = 
	{
		{code = "unknownkey", flag_wt = false, flag_wu = true, both = true},
		{code = "windmill", flag_wt = false, flag_wu = true, both = true},
		{code = "prison", flag_wt = false, flag_wu = true, both = true},
		{code = "styx", flag_wt = false, flag_wu = true, both = true}
	}
	local redKey = KeyItem("Windmill Key", "redkey", "key", "images/items/keywindmill.png", keyBadges)
	local blueKey = KeyItem("Key to Prison", "bluekey", "key", "images/items/keyprison.png", keyBadges)
	local greenKey = KeyItem("Key to Styx", "greenkey", "key", "images/items/keystyx.png", keyBadges)

	local fluteBadges = 
	{
		{code = "unknownflute", flag_wt = false, flag_wu = true, both = true},
		{code = "alarm", flag_wt = false, flag_wu = true, both = true},
		{code = "insect", flag_wt = false, flag_wu = true, both = true},
		{code = "lime", flag_wt = false, flag_wu = true, both = true},
		{code = "shell", flag_wt = false, flag_wu = true, both = true}
	}

	local grayFlute = KeyItem("Alarm Flute", "grayflute", "flute", "images/items/flutealarm.png", fluteBadges)
	local blueFlute = KeyItem("Insect Flute", "greenflute", "flute", "images/items/fluteinsect.png", fluteBadges)
	local greenFlute = KeyItem("Flute of Lime", "blueflute", "flute", "images/items/flutelime.png", fluteBadges)
	local redFlute = KeyItem("Shell Flute", "redflute", "flute", "images/items/fluteshell.png", fluteBadges)
	
	local tradeStatueBadges = 
	{
		{code = "unknowntrade", flag_wt = true, flag_wu = false, both = false},
		{code = "unknownstatue", flag_wt = false, flag_wu = true, both = true},
		{code = "tradeakahana", flag_wt = true, flag_wu = true, both = true},
		{code = "tradearyllis", flag_wt = true, flag_wu = false, both = true},
		{code = "tradefisherman", flag_wt = true, flag_wu = false, both = true},
		{code = "tradekensu", flag_wt = true, flag_wu = false, both = true},
		{code = "tradeslime", flag_wt = true, flag_wu = true, both = true},
		{code = "brokenstatue", flag_wt = false, flag_wu = true, both = true},
		{code = "whirlpool", flag_wt = false, flag_wu = true, both = true}
	}
	
	local redStatue = KeyItem("Statue of Onyx", "redstatue", "tradestatue", "images/items/statueonyx.png", tradeStatueBadges)
	local grayStatue = KeyItem("Ivory Statue", "graystatue", "tradestatue", "images/items/statueivory.png", tradeStatueBadges)
	
	local nontradeStatueBadges =  
	{
		{code = "unknownstatue", flag_wt = false, flag_wu = true, both = true},
		{code = "tradeakahana", flag_wt = false, flag_wu = true, both = true},
		{code = "tradearyllis", flag_wt = false, flag_wu = false, both = true},
		{code = "tradefisherman", flag_wt = false, flag_wu = false, both = true},
		{code = "tradekensu", flag_wt = false, flag_wu = false, both = true},
		{code = "tradeslime", flag_wt = false, flag_wu = true, both = true},
		{code = "brokenstatue", flag_wt = false, flag_wu = true, both = true},
		{code = "whirlpool", flag_wt = false, flag_wu = true, both = true}
	}
	
	local blueStatue = KeyItem("Statue of Gold", "bluestatue", "statue", "images/items/statuegold.png", nontradeStatueBadges)
	local crackedStatue = KeyItem("Broken Statue", "crackedstatue", "statue", "images/items/statuebroken.png", nontradeStatueBadges)
	
	local fogLampBadges =
	{
		{code = "unknowntrade", flag_wt = true, flag_wu = false, both = false},
		{code = "unknownlamp", flag_wt = false, flag_wu = true, both = true},
		{code = "tradeakahana", flag_wt = true, flag_wu = false, both = true},
		{code = "tradearyllis", flag_wt = true, flag_wu = false, both = true},
		{code = "tradefisherman", flag_wt = true, flag_wu = true, both = true},
		{code = "tradekensu", flag_wt = true, flag_wu = false, both = true},
		{code = "tradeslime", flag_wt = true, flag_wu = false, both = true},
		{code = "brokenlamp", flag_wt = false, flag_wu = true, both = true},
	}
	
	local blueLamp = KeyItem("Fog Lamp", "bluelamp", "foglamp", "images/items/lampfog.png", fogLampBadges)
	
	local glowingLampBadges =
	{
		{code = "unknownlamp", flag_wt = false, flag_wu = true, both = true},
		{code = "tradeakahana", flag_wt = false, flag_wu = false, both = true},
		{code = "tradearyllis", flag_wt = false, flag_wu = false, both = true},
		{code = "tradefisherman", flag_wt = false, flag_wu = true, both = true},
		{code = "tradekensu", flag_wt = false, flag_wu = false, both = true},
		{code = "tradeslime", flag_wt = false, flag_wu = false, both = true},
		{code = "brokenlamp", flag_wt = false, flag_wu = true, both = true},
	}
	
	local grayLamp = KeyItem("Glowing Lamp", "graylamp", "glowinglamp", "images/items/lampglowing.png", glowingLampBadges)
	
	local tradeBadges =
	{
		{code = "unknowntrade", flag_wt = true, flag_wu = false, both = true},
		{code = "tradeakahana", flag_wt = true, flag_wu = false, both = true},
		{code = "tradearyllis", flag_wt = true, flag_wu = false, both = true},
		{code = "tradefisherman", flag_wt = true, flag_wu = false, both = true},
		{code = "tradekensu", flag_wt = true, flag_wu = false, both = true},
		{code = "tradeslime", flag_wt = true, flag_wu = false, both = true},
	}
	
	local kirisaPlant = KeyItem("Kirisa Plant", "kirisa", "trade", "images/items/kirisaplant.png", tradeBadges)
	local lovePendant = KeyItem("Love Pendant", "love", "trade", "images/items/lovependant.png", tradeBadges)
	
	local bowBadges = 
	{
		{code = "unknownbow", flag_wt = false, flag_wu = true, both = true},
		{code = "sun", flag_wt = false, flag_wu = true, both = true},
		{code = "moon", flag_wt = false, flag_wu = true, both = true},
		{code = "truth", flag_wt = false, flag_wu = true, both = true}
	}
	
	local redBow = KeyItem("Bow of Sun", "redbow", "bow", "images/items/bowofsun.png", bowBadges)
	local grayBow = KeyItem("Bow of Moon", "graybow", "bow", "images/items/bowofmoon.png", bowBadges)
	local blueBow = KeyItem("Bow of Truth", "bluebow", "bow", "images/items/bowoftruth.png", bowBadges)]]--
	
end