ScriptHost:LoadScript("scripts/archipelago/item_mapping.lua")
ScriptHost:LoadScript("scripts/archipelago/location_mapping.lua")
ScriptHost:LoadScript("scripts/archipelago/map_switching.lua")

CUR_INDEX = -1
SLOT_DATA = nil
KEY_ITEM_MAP = nil
HOSTED = {}

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
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    if SLOT_DATA ~= nil then
        for k, v in pairs(SLOT_DATA) do
            if OPTION_NAME_TO_FLAG_ITEM_MAP[k] ~= nil then
                local flag_obj = Tracker:FindObjectForCode(OPTION_NAME_TO_FLAG_ITEM_MAP[k])
                flag_obj.Active = (v ~= 0)
            end
        end
        local vm_value = SLOT_DATA["vanilla_maps"]
        local vm_obj = Tracker:FindObjectForCode("flag_vm")
        if vm_value == 0 then
            vm_obj.CurrentStage = 0
            vm_obj.Active = false
        elseif vm_value == 1 then
            vm_obj.CurrentStage = 2
            vm_obj.Active = true
        elseif vm_value == 2 then
            vm_obj.CurrentStage = 1
            vm_obj.Active = true
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
    elseif SLOT_DATA["unidentified_key_items"] ~= 0 then
        local forward_map = SLOT_DATA["shuffle_data"]["key_item_names"]
        KEY_ITEM_MAP = {}
        for k, v in pairs(forward_map) do
            KEY_ITEM_MAP[v] = k
        end
            
    else
        KEY_ITEM_MAP = nil
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
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
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
