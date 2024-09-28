ScriptHost:LoadScript("scripts/archipelago/item_mapping.lua")
ScriptHost:LoadScript("scripts/archipelago/location_mapping.lua")
ScriptHost:LoadScript("scripts/archipelago/map_switching.lua")

CUR_INDEX = -1
SLOT_DATA = nil
KEY_ITEM_MAP = nil
HOSTED = {}
IRON_WALL_ELEMENTS = nil
BOSS_ELEMENTS = nil

--AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = true

function onSetReply(key, value, _)
    local slot_team = tostring(Archipelago.TeamNumber)
    local slot_player = tostring(Archipelago.PlayerNumber)
    if key ==  "current_location_".. slot_team .. "_" .. slot_player then
        if true then --Tracker:FindObjectForCode("auto_tab").CurrentStage == 1 then
            if TABS_MAPPING[value] then
                CURRENT_ROOM = TABS_MAPPING[value]
            else
                CURRENT_ROOM = CURRENT_ROOM_ADDRESS
            end
            print("CURRENT_ROOM: " .. tostring(CURRENT_ROOM))
            for _, tab in ipairs(CURRENT_ROOM) do
                Tracker:UiHint("ActivateTab", tab)
            end
        end
    end
end

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print("called onClear, slot_data:\n")
        if slot_data ~= nil then
            for k, v in pairs(slot_data) do
                print(string.format("%s: %s", k, v))
            end
        else
            print("nil\n")
        end
    end
    IRON_WALL_ELEMENTS = {}
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    if SLOT_DATA ~= nil then
        for k, v in pairs(SLOT_DATA) do
            if OPTION_NAME_TO_FLAG_ITEM_MAP[k] ~= nil then
                local flag_obj = Tracker:FindObjectForCode(OPTION_NAME_TO_FLAG_ITEM_MAP[k])
                flag_obj.Active = (v ~= 0)
            elseif GLITCH_OPTION_TO_FLAG_ITEM_MAP[k] ~= nil then
                local flag_obj = Tracker:FindObjectForCode(GLITCH_OPTION_TO_FLAG_ITEM_MAP[k])
                flag_obj.Active = (v == 2)
            end
        end
        local vm_value = SLOT_DATA["vanilla_maps"]
        local vm_obj = Tracker:FindObjectForCode("flag_vm")
        local free_obj = Tracker:FindObjectForCode("eastfree")
        local blocked_obj = Tracker:FindObjectForCode("eastwall")
        if vm_value == 0 then
            vm_obj.CurrentStage = 0
            vm_obj.Active = false
            local gbc_exits = SLOT_DATA["shuffle_data"]["gbc_cave_exits"]
            local free_exit = gbc_exits[1]
            free_obj.Active = true
            free_obj.CurrentStage = REGION_TO_GBC_EXIT_STAGE[free_exit]
            local blocked_exit = gbc_exit[2]
            blocked_obj.Active = true
            blocked_obj.CurrentStage = REGION_TO_GBC_EXIT_STAGE[blocked_exit]
        elseif vm_value == 1 then
            vm_obj.CurrentStage = 2
            vm_obj.Active = true
            free_obj.Active = false
            free_obj.CurrentStage = 0
            blocked_obj.Active = false
            blocked_obj.CurrentStage = 0
        elseif vm_value == 2 then
            vm_obj.CurrentStage = 1
            vm_obj.Active = true
            free_obj.Active = false
            free_obj.CurrentStage = 0
            blocked_obj.Active = false
            blocked_obj.CurrentStage = 0
        end
        local thunder_warp = SLOT_DATA["shuffle_data"]["thunder_warp"]
        if thunder_warp == "Nadare's" then
            thunder_warp = "nadares"
        elseif thunder_warp == "Zombie Town" then
            thunder_warp = "zombie"
        else
            thunder_warp = string.lower(thunder_warp)
        end
        local thunder_code = "thunder" .. thunder_warp
        local thunder_obj = Tracker:FindObjectForCode("thunder")
        thunder_obj.CurrentStage = THUNDER_CODE_TO_INDEX[thunder_code]
        for wall_region, wall_element in pairs(SLOT_DATA["shuffle_data"]["wall_map"]) do
            local wall_code = REGION_TO_ROCK_WALL_CODE[wall_region]
            if wall_code ~= nil then
                local wall_obj = Tracker:FindObjectForCode(wall_code)
                wall_obj.Active = true
                if wall_element == "Wind" then
                    wall_obj.CurrentStage = 1
                elseif wall_element == "Fire" then
                    wall_obj.CurrentStage = 2
                elseif wall_element == "Water" then
                    wall_obj.CurrentStage = 3
                elseif wall_element == "Thunder" then
                    wall_obj.CurrentStage = 4
                else
                    wall_obj.Active = false
                end
            else
                wall_code = REGION_TO_IRON_WALL_CODE[wall_region]
                IRON_WALL_ELEMENTS[wall_code] = string.lower(wall_element)
            end
        end
        BOSS_ELEMENTS = SLOT_DATA["shuffle_data"]["boss_reqs"]
    end
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset hosted items
    for k, _ in pairs(HOSTED) do
        Tracker:FindObjectForCode(k).Active = false
    end

    if SLOT_DATA == nil then
        KEY_ITEM_MAP = nil
        return
    else
        local forward_map = SLOT_DATA["shuffle_data"]["key_item_names"]
        KEY_ITEM_MAP = {}
        for k, v in pairs(forward_map) do
            KEY_ITEM_MAP[v] = k
        end
        KEY_ITEM_MAP["Love Pendant"] = "Love Pendant"
        KEY_ITEM_MAP["Kirisa Plant"] = "Kirisa Plant"
    end

    --Tracker:FindObjectForCode("auto_tab").CurrentStage = 1
    local slot_team = tostring(Archipelago.TeamNumber)
    local slot_player = tostring(Archipelago.PlayerNumber)
    local data_storage_list = ({"current_location_".. slot_team .. "_" .. slot_player})

    Archipelago:SetNotify(data_storage_list)
    Archipelago:Get(data_storage_list)
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then
        return
    end
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        local found = false
        if KEY_ITEM_MAP ~= nil then
            v = ITEM_MAPPING[KEY_ITEM_REVERSE_MAP[KEY_ITEM_MAP[item_name]]]
            if v then
                found = true
            end
        end
        if not found then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onItem: could not find item mapping for id %s", item_id))
            end
            return
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local item_code = v[1]
    local item_type = v[2]
    local obj = Tracker:FindObjectForCode(item_code)
    if obj then
        if item_type == "toggle" then
            obj.Active = true
        elseif item_type == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif item_type == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", item_type, item_code))
        end
        if string.sub(item_code, 1, 7) == "swordof" then
            local sword_element = string.sub(item_code, 8)
            if Tracker:ProviderCountForCode("flag_ro") > 0 or Tracker:ProviderCountForCode(sword_element .. "upgrade") > 0 then
                for wall_code, wall_element in pairs(IRON_WALL_ELEMENTS) do
                    if wall_element == sword_element then
                        local wall_obj = Tracker:FindObjectForCode(wall_code)
                        wall_obj.Active = true
                        wall_obj.CurrentStage = 1
                    end
                end
            end
            for boss_name, boss_element in pairs(BOSS_ELEMENTS) do
                if boss_name == "Vampire 2" or boss_name == "Giant Insect" then
                    local boss_code = string.lower(string.gsub(string.gsub(boss_name, " ", ""), "2", ""))
                    local boss_obj = Tracker:FindObjectForCode(boss_code)
                    if item_code ~= "swordof" .. string.lower(boss_element) or Tracker:ProviderCountForCode("sword") > 2 then
                        boss_obj.Active = true
                        boss_obj.CurrentStage = 1
                    else
                        boss_obj.Active = true
                        boss_obj.CurrentStage = 2
                    end
                else
                    local boss_code = string.lower(string.gsub(boss_name, " ", ""))
                    local boss_obj = Tracker:FindObjectForCode(boss_code)
                    if item_code == "swordof" .. string.lower(boss_element) then
                        boss_obj.Active = true
                        boss_obj.CurrentStage = 1
                    elseif boss_obj.Active == false then
                        boss_obj.Active = true
                        boss_obj.CurrentStage = 2
                    end
                end
            end
            local rage_obj = Tracker:FindObjectForCode("rage")
            if item_code == string.lower(string.gsub(SLOT_DATA["shuffle_data"]["trade_in_map"]["Rage"], " ", "")) then
                rage_obj.Active = true
                if item_code == "swordofwind" then
                    rage_obj.CurrentStage = 1
                elseif item_code == "swordoffire" then
                    rage_obj.CurrentStage = 2
                elseif item_code == "swordofwater" then
                    rage_obj.CurrentStage = 3
                elseif item_code == "swordofthunder" then
                    rage_obj.CurrentStage = 4
                end
            elseif rage_obj.Active == false then
                rage_obj.Active = true
                rage_obj.CurrentStage = 5
            end
        end
        local upgrade_element = nil
        if string.sub(item_code, 1, 5) == "orbof" then
            upgrade_element = string.sub(item_code, 6)
        elseif string.sub(item_code, -8) == "bracelet" then
            upgrade_element = string.sub(item_code, 1, -9)
        end
        if upgrade_element ~= nil then
            if upgrade_element == string.lower(SLOT_DATA["shuffle_data"]["trade_in_map"]["Tornel"]) then
                upgrade_code = upgrade_element .. "upgrade"
                local tornel_obj = Tracker:FindObjectForCode("tornel")
                if Tracker:ProviderCountForCode(upgrade_code) > 1 then
                    tornel_obj.Active = true
                    if upgrade_code == "wind" then
                        tornel_obj.CurrentStage = 1
                    elseif upgrade_code == "fire" then
                        tornel_obj.CurrentStage = 2
                    elseif upgrade_code == "water" then
                        tornel_obj.CurrentStage = 3
                    elseif upgrade_code == "thunder" then
                        tornel_obj.CurrentStage = 4
                    end
                else
                    tornel_obj.Active = false
                    tornel_obj.CurrentStage = 0
                end
            end
            if Tracker:ProviderCountForCode("flag_ro") == 0 and 
               Tracker:ProviderCountForCode("swordof" .. upgrade_element) > 0 and 
               Tracker:ProviderCountForCode(upgrade_element .. "upgrade") == 1 then
                for wall_code, wall_element in pairs(IRON_WALL_ELEMENTS) do
                    if wall_element == upgrade_element then
                        local wall_obj = Tracker:FindObjectForCode(wall_code)
                        wall_obj.Active = true
                        wall_obj.CurrentStage = 1
                    end
                end
            end
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
end

--called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    local codes = LOCATION_MAPPING[location_id]
    if not codes and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
    for _, code in pairs(codes) do
        if not code then
            return
        end
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            if code:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onLocation: could not find object for code %s", code))
        end
    end
end

-- called when a locations is scouted
function onScout(location_id, location_name, item_id, item_name, item_player)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name,
            item_player))
    end
end

-- called when a bounce message is received 
function onBounce(json)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onBounce: %s", json))
    end
end

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("set reply handler", onSetReply)
-- Archipelago:AddScoutHandler("scout handler", onScout)
-- Archipelago:AddBouncedHandler("bounce handler", onBounce)
-- Archipelago:AddRetrievedHandler("retrieved", retrieved)
