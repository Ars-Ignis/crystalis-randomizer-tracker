ITEM_MAPPING = {
    [1] = {"swordofwind", "toggle"},
    [2] = {"swordoffire", "toggle"},
    [3] = {"swordofwater", "toggle"},
    [4] = {"swordofthunder", "toggle"},
    [5] = {"orbofwind", "toggle"},
    [6] = {"windbracelet", "toggle"},
    [7] = {"orboffire", "toggle"},
    [8] = {"firebracelet", "toggle"},
    [9] = {"orbofwater", "toggle"},
    [10] = {"waterbracelet", "toggle"},
    [11] = {"orbofthunder", "toggle"},
    [12] = {"thunderbracelet", "toggle"},
    [26] = {"statueofonyx", "toggle"},
    [27] = {"opelstatue", "consumable"},
    [28] = {"insectflute", "toggle"},
    [29] = {"fluteoflime", "toggle"},
    [30] = {"gasmask", "toggle"},
    [31] = {"gasmask", "toggle"},
    [32] = {"powerring", "toggle"},
    [33] = {"warriorring", "toggle"},
    [34] = {"ironnecklace", "toggle"},
    [35] = {"deospendant", "toggle"},
    [36] = {"rabbitboots", "toggle"},
    [37] = {"speedboots", "toggle"},
    [38] = {"speedboots", "toggle"},
    [39] = {"shieldring", "toggle"},
    [40] = {"alarmflute", "toggle"},
    [41] = {"windmillkey", "toggle"},
    [42] = {"keytoprison", "toggle"},
    [43] = {"keytostxy", "toggle"},
    [44] = {"foglamp", "toggle"},
    [45] = {"shellflute", "toggle"},
    [46] = {"eyeglasses", "toggle"},
    [47] = {"brokenstatue", "toggle"},
    [48] = {"glowinglamp", "toggle"},
    [49] = {"statueofgold", "toggle"},
    [50] = {"lovependant", "toggle"},
    [51] = {"kirisaplant", "toggle"},
    [52] = {"ivorystatue", "toggle"},
    [53] = {"bowofmoon", "toggle"},
    [54] = {"bowofsun", "toggle"},
    [55] = {"bowoftruth", "toggle"},
    [56] = {"refresh", "toggle"},
    [57] = {"paralysis", "toggle"},
    [58] = {"telepathy", "toggle"},
    [59] = {"teleport", "toggle"},
    [60] = {"recover", "toggle"},
    [61] = {"barrier", "toggle"},
    [62] = {"change", "toggle"},
    [63] = {"flight", "toggle"},
}

COMPACT_ITEM_MAPPING = {
    [1] = {"compactwind", "enable"},
    [2] = {"compactfire", "enable"},
    [3] = {"compactwater", "enable"},
    [4] = {"compactthunder", "enable"},
    [5] = {"compactwind", "increment"},
    [6] = {"compactwind", "increment"},
    [7] = {"compactfire", "increment"},
    [8] = {"compactfire", "increment"},
    [9] = {"compactwater", "increment"},
    [10] = {"compactwater", "increment"},
    [11] = {"compactthunder", "increment"},
    [12] = {"compactthunder", "increment"},
    [53] = {"sunmoon", "left"},
    [54] = {"sunmoon", "right"},
    [55] = {"bowoftruth", "enable"},
    [63] = {"flight", "enable"},
}

KEY_ITEM_REVERSE_MAP = {
	["Windmill Key"] = 41,
	["Key to Prison"] = 42,
	["Key to Stxy"] = 43,
	["Alarm Flute"] = 40,
	["Insect Flute"] = 28,
	["Flute of Lime"] = 29,
	["Shell Flute"] = 45,
	["Fog Lamp"] = 44,
	["Glowing Lamp"] = 48,
	["Statue of Onyx"] = 26,
	["Broken Statue"] = 47,
	["Statue of Gold"] = 49,
	["Ivory Statue"] = 52,
	["Bow of Moon"] = 53,
	["Bow of Sun"] = 54,
	["Bow of Truth"] = 55,
	["Kirisa Plant"] = 51,
	["Love Pendant"] = 50,
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