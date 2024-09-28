ITEM_MAPPING = {
    [2241000] = {"swordofwind", "toggle"},
    [2241001] = {"swordoffire", "toggle"},
    [2241002] = {"swordofwater", "toggle"},
    [2241003] = {"swordofthunder", "toggle"},
    [2241004] = {"orbofwind", "toggle"},
    [2241005] = {"windbracelet", "toggle"},
    [2241006] = {"orboffire", "toggle"},
    [2241007] = {"firebracelet", "toggle"},
    [2241008] = {"orbofwater", "toggle"},
    [2241009] = {"waterbracelet", "toggle"},
    [2241010] = {"orbofthunder", "toggle"},
    [2241011] = {"thunderbracelet", "toggle"},
    [2241025] = {"statueofonyx", "toggle"},
    [2241026] = {"opelstatue", "consumable"},
    [2241027] = {"insectflute", "toggle"},
    [2241028] = {"fluteoflime", "toggle"},
    [2241029] = {"gasmask", "toggle"},
    [2241030] = {"gasmask", "toggle"},
    [2241031] = {"powerring", "toggle"},
    [2241032] = {"warriorring", "toggle"},
    [2241033] = {"ironnecklace", "toggle"},
    [2241034] = {"deospendant", "toggle"},
    [2241035] = {"rabbitboots", "toggle"},
    [2241036] = {"speedboots", "toggle"},
    [2241037] = {"speedboots", "toggle"},
    [2241038] = {"shieldring", "toggle"},
    [2241039] = {"alarmflute", "toggle"},
    [2241040] = {"windmillkey", "toggle"},
    [2241041] = {"keytoprison", "toggle"},
    [2241042] = {"keytostxy", "toggle"},
    [2241043] = {"foglamp", "toggle"},
    [2241044] = {"shellflute", "toggle"},
    [2241045] = {"eyeglasses", "toggle"},
    [2241046] = {"brokenstatue", "toggle"},
    [2241047] = {"glowinglamp", "toggle"},
    [2241048] = {"statueofgold", "toggle"},
    [2241049] = {"lovependant", "toggle"},
    [2241050] = {"kirisaplant", "toggle"},
    [2241051] = {"ivorystatue", "toggle"},
    [2241052] = {"bowofmoon", "toggle"},
    [2241053] = {"bowofsun", "toggle"},
    [2241054] = {"bowoftruth", "toggle"},
    [2241055] = {"refresh", "toggle"},
    [2241056] = {"paralysis", "toggle"},
    [2241057] = {"telepathy", "toggle"},
    [2241058] = {"teleport", "toggle"},
    [2241059] = {"recover", "toggle"},
    [2241060] = {"barrier", "toggle"},
    [2241061] = {"change", "toggle"},
    [2241062] = {"flight", "toggle"},
}

KEY_ITEM_REVERSE_MAP = {
	["Windmill Key"] = 2241040,
	["Key to Prison"] = 2241041,
	["Key to Stxy"] = 2241042,
	["Alarm Flute"] = 2241039,
	["Insect Flute"] = 2241027,
	["Flute of Lime"] = 2241028,
	["Shell Flute"] = 2241044,
	["Fog Lamp"] = 2241043,
	["Glowing Lamp"] = 2241047,
	["Statue of Onyx"] = 2241025,
	["Broken Statue"] = 2241046,
	["Statue of Gold"] = 2241048,
	["Ivory Statue"] = 2241051,
	["Bow of Moon"] = 2241052,
	["Bow of Sun"] = 2241053,
	["Bow of Truth"] = 2241054,
	["Kirisa Plant"] = 2241050,
	["Love Pendant"] = 2241049,
}

OPTION_NAME_TO_FLAG_ITEM_MAP = {
	["randomize_maps"] = "flag_wm",
	["shuffle_houses"] = "flag_wh",
	["randomize_tradeins"] = "flag_wt",
	["unidentified_key_items"] = "flag_wu",
	["randomize_wall_elements"] = "flag_we",
	["shuffle_goa"] = "flag_wg",
	["orbs_not_required"] = "flag_ro",
	["vanilla_dolphin"] = "flag_rd",
	["fake_flight"] = "flag_gf",
	["randomize_monster_weaknesses"] = "flag_me",
	["oops_all_mimics"] = "flag_mg",
	["dont_shuffle_mimics"] = "flag_et",
	["keep_unique_items_and_consumables_separate"] = "flag_eu",
	["guarantee_refresh"] = "flag_er",
	["battle_magic_not_guaranteed"] = "flag_nw",
	["tink_mode"] = "flag_ns",
	["barrier_not_guaranteed"] = "flag_nb",
	["gas_mask_not_guaranteed"] = "flag_ng",
	["dont_buff_bonus_items"] = "flag_vb",
	["vanilla_wild_warp"] = "flag_vw"
}

GLITCH_OPTION_TO_FLAG_ITEM_MAP = {
	["statue_glitch"] = "flag_gs",
	["mt_sabre_skip"] = "flag_gn",
	["statue_gauntlet_skip"] = "flag_gg",
	["sword_charge_glitch"] = "flag_gc",
	["trigger_skip"] = "flag_gt",
	["rage_skip"] = "flag_gr"
}

--These settings need special handling
--****["vanilla_maps"] = "flag_",
--****["thunder_warp"] = "flag_",

THUNDER_CODE_TO_INDEX = {
	["thunder"] = 0,
	["thundershyron"] = 1,
	["thunderleaf"] = 2,
	["thunderbrynmaer"] = 3,
	["thunderoak"] = 4,
	["thundernadares"] = 5,
	["thunderportoa"] = 6,
	["thunderamazones"] = 7,
	["thunderjoel"] = 8,
	["thunderzombie"] = 9,
	["thunderswan"] = 10,
	["thundergoa"] = 11,
	["thundersahara"] = 12
}

REGION_TO_ROCK_WALL_CODE = {
	["Zebu Cave"] = "zcw",
	["East Cave"] = "ecw",
	["Sealed Cave"] = "scw",
	["Mt Sabre West"] = "msww",
	["Mt Sabre North"] = "msnw",
	["Waterfall Cave"] = "wcw",
	["Fog Lamp Cave"] = "flcw",
	["Kirisa Plant Cave"] = "kpcw",
	["Evil Spirit Island"] = "esiw",
	["Mt Hydra"] = "mhw"
}

REGION_TO_IRON_WALL_CODE = {
	["Goa Fortress - Entrance"] = "goa_entrance_wall_cleared",
	["Goa Fortress Basement"] = "goa_basement_wall_cleared",
	["Goa Fortress - Sabera Item"] = "goa_sabera_item_wall_cleared",
	["Goa Fortress - Sabera Boss"] = "goa_sabera_boss_wall_cleared",
	["Goa Fortress - Mado 2"] = "goa_mado_wall_cleared",
	["Goa Fortress - Karmine 5"] = "goa_karmine_wall_cleared"
}

REGION_TO_GBC_EXIT_STAGE = {
	["Cordel Plains - Main"] = 1,
	["Lime Valley"] = 2,
	["Goa Valley"] = 3,
	["Desert 2"] = 4
}