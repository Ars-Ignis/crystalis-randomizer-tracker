function initCustomItems()
	ScriptHost:LoadScript("scripts/custom_items/SwordItem.lua")
	ScriptHost:LoadScript("scripts/custom_items/BallItem.lua")
	ScriptHost:LoadScript("scripts/custom_items/BraceletItem.lua")
	ScriptHost:LoadScript("scripts/custom_items/GoaFloorItem.lua")
	ScriptHost:LoadScript("scripts/custom_items/KeyItem.lua")
	CreateSwordItem("Sword of Wind", "wind", "images/items/swordofwind.png")
	CreateSwordItem("Sword of Fire", "fire", "images/items/swordoffire.png")
	CreateSwordItem("Sword of Water", "water", "images/items/swordofwater.png")
	CreateSwordItem("Sword of Thunder", "thunder", "images/items/thundernowarp.png")
	CreateOrbItem("Orb of Wind", "windorb", "images/items/ballofwind.png")
	CreateOrbItem("Orb of Fire", "fireorb", "images/items/balloffire.png")
	CreateOrbItem("Orb of Water", "waterorb", "images/items/ballofwater.png")
	CreateOrbItem("Orb of Thunder", "thunderorb", "images/items/ballofthunder.png")
	CreateBraceletItem("Tornado Bracelet", "windbracelet", "images/items/braceletofwind.png")
	CreateBraceletItem("Flame Bracelet", "firebracelet", "images/items/braceletoffire.png")
	CreateBraceletItem("Blizzard Bracelet", "waterbracelet", "images/items/braceletofwater.png")
	CreateBraceletItem("Storm Bracelet", "thunderbracelet", "images/items/braceletofthunder.png")
	CreateGoaFloorItem("1st", 0)
	CreateGoaFloorItem("2nd", 0)
	CreateGoaFloorItem("3rd", 0)
	CreateGoaFloorItem("4th", 0)

	local keyBadges =
	{
		{code = "unknownkey", flag_wt = false, flag_wu = true, both = true},
		{code = "windmill", flag_wt = false, flag_wu = true, both = true},
		{code = "prison", flag_wt = false, flag_wu = true, both = true},
		{code = "stxy", flag_wt = false, flag_wu = true, both = true}
	}
	CreateKeyItem("Windmill Key", "redkey", "key", "images/items/keywindmill.png", keyBadges, "windmill")
	CreateKeyItem("Key to Prison", "bluekey", "key", "images/items/keyprison.png", keyBadges, "prison")
	CreateKeyItem("Key to Styx", "greenkey", "key", "images/items/keystxy.png", keyBadges, "stxy")

	local fluteBadges = 
	{
		{code = "unknownflute", flag_wt = false, flag_wu = true, both = true},
		{code = "alarm", flag_wt = false, flag_wu = true, both = true},
		{code = "insect", flag_wt = false, flag_wu = true, both = true},
		{code = "lime", flag_wt = false, flag_wu = true, both = true},
		{code = "shell", flag_wt = false, flag_wu = true, both = true}
	}

	CreateKeyItem("Alarm Flute", "grayflute", "flute", "images/items/flutealarm.png", fluteBadges, "alarm")
	CreateKeyItem("Insect Flute", "greenflute", "flute", "images/items/fluteinsect.png", fluteBadges, "insect")
	CreateKeyItem("Flute of Lime", "blueflute", "flute", "images/items/flutelime.png", fluteBadges, "lime")
	CreateKeyItem("Shell Flute", "redflute", "flute", "images/items/fluteshell.png", fluteBadges, "shell")
	
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
	
	CreateKeyItem("Statue of Onyx", "redstatue", "tradestatue", "images/items/statueonyx.png", tradeStatueBadges, "tradeakahana")
	CreateKeyItem("Ivory Statue", "graystatue", "tradestatue", "images/items/statueivory.png", tradeStatueBadges, "tradeslime")
	
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
	
	CreateKeyItem("Statue of Gold", "bluestatue", "statue", "images/items/statuegold.png", nontradeStatueBadges, "whirlpool")
	CreateKeyItem("Broken Statue", "crackedstatue", "statue", "images/items/statuebroken.png", nontradeStatueBadges, "brokenstatue")
	
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
	
	CreateKeyItem("Fog Lamp", "bluelamp", "foglamp", "images/items/lampfog.png", fogLampBadges, "tradefisherman")
	
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
	
	CreateKeyItem("Glowing Lamp", "graylamp", "glowinglamp", "images/items/lampglowing.png", glowingLampBadges, "brokenlamp")
	
	local tradeBadges =
	{
		{code = "unknowntrade", flag_wt = true, flag_wu = false, both = true},
		{code = "tradeakahana", flag_wt = true, flag_wu = false, both = true},
		{code = "tradearyllis", flag_wt = true, flag_wu = false, both = true},
		{code = "tradefisherman", flag_wt = true, flag_wu = false, both = true},
		{code = "tradekensu", flag_wt = true, flag_wu = false, both = true},
		{code = "tradeslime", flag_wt = true, flag_wu = false, both = true},
	}
	
	CreateKeyItem("Kirisa Plant", "kirisa", "trade", "images/items/kirisaplant.png", tradeBadges, "tradearyllis")
	CreateKeyItem("Love Pendant", "love", "trade", "images/items/lovependant.png", tradeBadges, "tradekensu")
	
	local bowBadges = 
	{
		{code = "unknownbow", flag_wt = false, flag_wu = true, both = true},
		{code = "sun", flag_wt = false, flag_wu = true, both = true},
		{code = "moon", flag_wt = false, flag_wu = true, both = true},
		{code = "truth", flag_wt = false, flag_wu = true, both = true}
	}
	
	CreateKeyItem("Bow of Sun", "redbow", "bow", "images/items/bowofsun.png", bowBadges, "sun")
	CreateKeyItem("Bow of Moon", "graybow", "bow", "images/items/bowofmoon.png", bowBadges, "moon")
	CreateKeyItem("Bow of Truth", "bluebow", "bow", "images/items/bowoftruth.png", bowBadges, "truth")
	
end