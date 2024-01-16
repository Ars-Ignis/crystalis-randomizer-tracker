-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", "true")
end
print("---------------------------------------------------------------------")
print("")

U8_READ_CACHE = 0
U8_READ_CACHE_ADDRESS = 0

function autotracker_started()
    print("Started Tracking")
end

function InvalidateReadCaches()
    U8_READ_CACHE_ADDRESS = 0
end

function ReadU8(segment, address)
    if U8_READ_CACHE_ADDRESS ~= address then
        U8_READ_CACHE = segment:ReadUInt8(address)
        U8_READ_CACHE_ADDRESS = address
    end
    return U8_READ_CACHE
end

function isInGame()
  return true -- Need to eventually fix this.
end

--NEW CODE STARTS HERE
function updateToggleItemFromByteAndFlag(segment, code, address, flag)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(item.Name, code, flag)
        end

        local flagTest = value & flag

        if flagTest ~= 0 then
            item.Active = true
        else
            item.Active = false
        end
    end
end

function updateProgessiveItemFromByteAndFlag(segment, code, address, flag, currentStage)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(item.Name, code, flag)
        end

        local flagTest = value & flag

        if flagTest ~= 0 and currentStage == 0 then
            item.CurrentStage = 1
            currentStage = 1
        elseif currentStage == 1 then
            item.CurrentStage = 0
        end
    end
end 

function updateSectionChestCountFromByteAndFlag(segment, locationRef, address, flag, callback)
    local location = Tracker:FindObjectForCode(locationRef)
    if location then
        -- Do not auto-track this the user has manually modified it
        if location.Owner.ModifiedByUser then 
            return
        end

        local value = ReadU8(segment, address)
        
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(locationRef, value)
        end
  
        if (value & flag) ~= 0 then
            location.AvailableChestCount = 0
            if callback then
                callback(true)
            end
        else
            location.AvailableChestCount = location.ChestCount
            if callback then
                callback(false)
            end
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Couldn't find location", locationRef)
    end
end


-- CODE STOPS






function updateProgressiveItemFromBytes(segment, code, address, quantity)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = 0
        for i = 0, quantity-1, 1 do
            if ReadU8(segment, address+i) > 0 then
                value = value + 1
            end
        end
        if item.CurrentStage ~= value then
            print(item.Name .. ": " .. value)
            item.CurrentStage = value
        end
    end
end

function updateProgressiveItemFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if item.ItemState.stage ~= value then
            print(item.Name .. ": " .. value)
            item.CurrentStage = value
        end
    end
end

function update2ItemLocation(segment, locationRef, item1Address, item1Flag, item2Address, item2Flag)
	local location = Tracker:FindObjectForCode(locationRef)
  
	if location then
		  -- Do not auto-track this the user has manually modified it
		  if location.Owner.ModifiedByUser then
			  return
		  end
  
		  local item1Value = ReadU8(segment, item1Address)
		  local item2Value = ReadU8(segment, item2Address)
		  local item1Retrieved = (item1Value & item1Flag) ~= 0
		  local item2Retrieved = (item2Value & item2Flag) ~= 0
  
		  if item1Retrieved and item2Retrieved then
			  location.AvailableChestCount = 0
		  elseif item1Retrieved or item2Retrieved then
			  location.AvailableChestCount = 1
		  else
			  location.AvailableChestCount = 2
		  end
	  elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
		  print("Couldn't find locationRef ", locationRef)
	  end
  end


function updateWindSword(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 0 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateWindBall(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 5 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateWindBraclet(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 6 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateFireBall(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 7 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateFireBraclet(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 8 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateWaterBall(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 9 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateWaterBraclet(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 10 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateThunderBall(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 11 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateThunderBraclet(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value == 12 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateRefresh(segment, code)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	    local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	    local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	    local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)

	if item  then    
         
        	if SPELL1 == 0x41 
		or SPELL2 == 0x41 
		or SPELL3 == 0x41 
		or SPELL4 == 0x41 
		or SPELL5 == 0x41 
		or SPELL6 == 0x41 
		or SPELL7 == 0x41
		or SPELL8 == 0x41 then
            		if item.Active == false then
                	print(item.Name .. " obtained")
                	item .Active = true
            	end
        		else
            		item.Active = false
        		end        	
    	end
end

function updateParalysis(segment, code)
    	local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x42 
		or SPELL2 == 0x42 
		or SPELL3 == 0x42 
		or SPELL4 == 0x42 
		or SPELL5 == 0x42 
		or SPELL6 == 0x42 
		or SPELL7 == 0x42
		or SPELL8 == 0x42 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateTelepathy(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x43 
		or SPELL2 == 0x43 
		or SPELL3 == 0x43 
		or SPELL4 == 0x43 
		or SPELL5 == 0x43 
		or SPELL6 == 0x43 
		or SPELL7 == 0x43
		or SPELL8 == 0x43 then
            		if item.Active == false then
                		print(item .Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateTeleport(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x44
		or SPELL2 == 0x44 
		or SPELL3 == 0x44 
		or SPELL4 == 0x44 
		or SPELL5 == 0x44 
		or SPELL6 == 0x44 
		or SPELL7 == 0x44
		or SPELL8 == 0x44 then
            		if item.Active == false then
                		print(item .Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateRecover(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x45 
		or SPELL2 == 0x45 
		or SPELL3 == 0x45 
		or SPELL4 == 0x45 
		or SPELL5 == 0x45 
		or SPELL6 == 0x45 
		or SPELL7 == 0x45
		or SPELL8 == 0x45 then
            		if item.Active == false then
                		print(item .Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateBarrier(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x46 
		or SPELL2 == 0x46 
		or SPELL3 == 0x46 
		or SPELL4 == 0x46 
		or SPELL5 == 0x46 
		or SPELL6 == 0x46 
		or SPELL7 == 0x46
		or SPELL8 == 0x46 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateChange(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x47 
		or SPELL2 == 0x47 
		or SPELL3 == 0x47 
		or SPELL4 == 0x47 
		or SPELL5 == 0x47 
		or SPELL6 == 0x47 
		or SPELL7 == 0x47
		or SPELL8 == 0x47 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateFlight(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local SPELL1 = ReadU8(segment, 0x6458) 
    	local SPELL2 = ReadU8(segment, 0x6459)
	local SPELL3 = ReadU8(segment, 0x645A) 
    	local SPELL4 = ReadU8(segment, 0x645B)
	local SPELL5 = ReadU8(segment, 0x645C) 
    	local SPELL6 = ReadU8(segment, 0x645D)
	local SPELL7 = ReadU8(segment, 0x645E) 
    	local SPELL8 = ReadU8(segment, 0x645F)
	
	if item  then    
               	if SPELL1 == 0x48 
		or SPELL2 == 0x48 
		or SPELL3 == 0x48 
		or SPELL4 == 0x48 
		or SPELL5 == 0x48 
		or SPELL6 == 0x48 
		or SPELL7 == 0x48
		or SPELL8 == 0x48 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateGasMask(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x29 
		    or WEAR2 == 0x29
		    or WEAR3 == 0x29 
		    or WEAR4 == 0x29 
		    or WEAR5 == 0x29 
		    or WEAR6 == 0x29 
		    or WEAR7 == 0x29
		    or WEAR8 == 0x29 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updatePowerRing(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x2A 
		    or WEAR2 == 0x2A 
		    or WEAR3 == 0x2A 
		    or WEAR4 == 0x2A 
		    or WEAR5 == 0x2A 
		    or WEAR6 == 0x2A 
		    or WEAR7 == 0x2A
		    or WEAR8 == 0x2A then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateWarriorRing(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x2B 
		    or WEAR2 == 0x2B 
		    or WEAR3 == 0x2B 
		    or WEAR4 == 0x2B 
		    or WEAR5 == 0x2B 
		    or WEAR6 == 0x2B 
		    or WEAR7 == 0x2B
		    or WEAR8 == 0x2B then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateIronNecklace(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x2C 
		    or WEAR2 == 0x2C 
		    or WEAR3 == 0x2C 
		    or WEAR4 == 0x2C 
		    or WEAR5 == 0x2C 
		    or WEAR6 == 0x2C 
		    or WEAR7 == 0x2C
		    or WEAR8 == 0x2C then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateDeosPendant(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x2D 
		    or WEAR2 == 0x2D 
		    or WEAR3 == 0x2D 
		    or WEAR4 == 0x2D 
		    or WEAR5 == 0x2D 
		    or WEAR6 == 0x2D 
		    or WEAR7 == 0x2D
		    or WEAR8 == 0x2D then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateRabbitBoots(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x2E 
		    or WEAR2 == 0x2E
		    or WEAR3 == 0x2E 
		    or WEAR4 == 0x2E 
		    or WEAR5 == 0x2E 
		    or WEAR6 == 0x2E 
		    or WEAR7 == 0x2E
		    or WEAR8 == 0x2E then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateSpeedBoots(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x2F 
		    or WEAR2 == 0x2F
		    or WEAR3 == 0x2F 
		    or WEAR4 == 0x2F 
		    or WEAR5 == 0x2F 
		    or WEAR6 == 0x2F 
		    or WEAR7 == 0x2F
		    or WEAR8 == 0x2F then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateShieldRing(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local WEAR1 = ReadU8(segment, 0x6448) 
    	local WEAR2 = ReadU8(segment, 0x6449)
        local WEAR3 = ReadU8(segment, 0x644A) 
    	local WEAR4 = ReadU8(segment, 0x644B)
	    local WEAR5 = ReadU8(segment, 0x644C) 
    	local WEAR6 = ReadU8(segment, 0x644D)
	    local WEAR7 = ReadU8(segment, 0x644E) 
    	local WEAR8 = ReadU8(segment, 0x644F)
	
	if item  then    
               	if WEAR1 == 0x30 
		    or WEAR2 == 0x30
		    or WEAR3 == 0x30 
		    or WEAR4 == 0x30 
		    or WEAR5 == 0x30 
		    or WEAR6 == 0x30 
		    or WEAR7 == 0x30
		    or WEAR8 == 0x30 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item .Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateMoonBow(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	--if item  then    
               	if KEYITEM1 == 0x3E 
		    or KEYITEM2 == 0x3E
		    or KEYITEM3 == 0x3E 
		    or KEYITEM4 == 0x3E 
		    or KEYITEM5 == 0x3E 
		    or KEYITEM6 == 0x3E 
		    or KEYITEM7 == 0x3E
		    or KEYITEM8 == 0x3E
            or KEYITEM9 == 0x3E
		    or KEYITEM10 == 0x3E 
		    or KEYITEM11 == 0x3E 
		    or KEYITEM12 == 0x3E 
		    or KEYITEM13 == 0x3E 
		    or KEYITEM14 == 0x3E
		    or KEYITEM15 == 0x3E 
            or KEYITEM16 == 0x3E then
            		if item.Active == true then
                		--print(item.Name .. " obtained")
                		--item.Active = true
            		--end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateSunBow(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	--if item  then    
               	if KEYITEM1 == 0x3F 
		    or KEYITEM2 == 0x3F
		    or KEYITEM3 == 0x3F 
		    or KEYITEM4 == 0x3F 
		    or KEYITEM5 == 0x3F 
		    or KEYITEM6 == 0x3F 
		    or KEYITEM7 == 0x3F
		    or KEYITEM8 == 0x3F 
            or KEYITEM9 == 0x3F
		    or KEYITEM10 == 0x3F 
		    or KEYITEM11 == 0x3F 
		    or KEYITEM12 == 0x3F 
		    or KEYITEM13 == 0x3F 
		    or KEYITEM14 == 0x3F
		    or KEYITEM15 == 0x3F 
            or KEYITEM16 == 0x3F then
            		if item.Active == true then
                		--print(item.Name .. " obtained")
                		--item.Active = true
            		--end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateTruthBow(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	--if item  then    
               	if KEYITEM1 == 0x40 
		    or KEYITEM2 == 0x40
		    or KEYITEM3 == 0x40 
		    or KEYITEM4 == 0x40 
		    or KEYITEM5 == 0x40 
		    or KEYITEM6 == 0x40 
		    or KEYITEM7 == 0x40
		    or KEYITEM8 == 0x40 
            or KEYITEM9 == 0x40
		    or KEYITEM10 == 0x40 
		    or KEYITEM11 == 0x40 
		    or KEYITEM12 == 0x40 
		    or KEYITEM13 == 0x40 
		    or KEYITEM14 == 0x40
		    or KEYITEM15 == 0x40 
            or KEYITEM16 == 0x40 then
            		if item.Active == true then
                		--print(item.Name .. " obtained")
                		--item.Active = true
            		--end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateWindKey(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end
		
    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	--if item  then    
        if KEYITEM1 == 0x32 
		    or KEYITEM2 == 0x32
		    or KEYITEM3 == 0x32 
		    or KEYITEM4 == 0x32 
		    or KEYITEM5 == 0x32 
		    or KEYITEM6 == 0x32 
		    or KEYITEM7 == 0x32
		    or KEYITEM8 == 0x32 
            or KEYITEM9 == 0x32
		    or KEYITEM10 == 0x32 
		    or KEYITEM11 == 0x32 
		    or KEYITEM12 == 0x32 
		    or KEYITEM13 == 0x32 
		    or KEYITEM14 == 0x32
		    or KEYITEM15 == 0x32 
            or KEYITEM16 == 0x32 then
            		 item.Active = true 
                		--print(item.Name .. " obtained")
                		--item.Active = false
            		--end
        			else
            			item.Active = false
        		end        	
			end
	
end

function updatePrisonKey(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	--if item  then    
        if KEYITEM1 == 0x33 
		    or KEYITEM2 == 0x33
		    or KEYITEM3 == 0x33 
		    or KEYITEM4 == 0x33 
		    or KEYITEM5 == 0x33 
		    or KEYITEM6 == 0x33 
		    or KEYITEM7 == 0x33
		    or KEYITEM8 == 0x33 
            or KEYITEM9 == 0x33
		    or KEYITEM10 == 0x33 
		    or KEYITEM11 == 0x33 
		    or KEYITEM12 == 0x33 
		    or KEYITEM13 == 0x33 
		    or KEYITEM14 == 0x33
		    or KEYITEM15 == 0x33 
            or KEYITEM16 == 0x33 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateStyxKey(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	   
        	if KEYITEM1 == 0x34 
		    or KEYITEM2 == 0x34
		    or KEYITEM3 == 0x34 
		    or KEYITEM4 == 0x34 
		    or KEYITEM5 == 0x34 
		    or KEYITEM6 == 0x34 
		    or KEYITEM7 == 0x34
		    or KEYITEM8 == 0x34 
            or KEYITEM9 == 0x34
		    or KEYITEM10 == 0x34 
		    or KEYITEM11 == 0x34 
		    or KEYITEM12 == 0x34 
		    or KEYITEM13 == 0x34 
		    or KEYITEM14 == 0x34
		    or KEYITEM15 == 0x34 
            or KEYITEM16 == 0x34 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateGlowLamp(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	   
        	if KEYITEM1 == 0x39 
		    or KEYITEM2 == 0x39
		    or KEYITEM3 == 0x39 
		    or KEYITEM4 == 0x39 
		    or KEYITEM5 == 0x39 
		    or KEYITEM6 == 0x39 
		    or KEYITEM7 == 0x39
		    or KEYITEM8 == 0x39 
            or KEYITEM9 == 0x39
		    or KEYITEM10 == 0x39 
		    or KEYITEM11 == 0x39 
		    or KEYITEM12 == 0x39 
		    or KEYITEM13 == 0x39 
		    or KEYITEM14 == 0x39
		    or KEYITEM15 == 0x39 
            or KEYITEM16 == 0x39 then
            		 item.Active = true
        			else
            			item.Active = false
        			end        	
    	end
end

function updateFogLamp(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	  
        	if KEYITEM1 == 0x35
		    or KEYITEM2 == 0x35
		    or KEYITEM3 == 0x35 
		    or KEYITEM4 == 0x35 
		    or KEYITEM5 == 0x35 
		    or KEYITEM6 == 0x35 
		    or KEYITEM7 == 0x35
		    or KEYITEM8 == 0x35 
            or KEYITEM9 == 0x35
		    or KEYITEM10 == 0x35 
		    or KEYITEM11 == 0x35 
		    or KEYITEM12 == 0x35 
		    or KEYITEM13 == 0x35 
		    or KEYITEM14 == 0x35
		    or KEYITEM15 == 0x35 
            or KEYITEM16 == 0x35 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateAlarmFlute(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	   
               	if KEYITEM1 == 0x31
		    or KEYITEM2 == 0x31
		    or KEYITEM3 == 0x31 
		    or KEYITEM4 == 0x31 
		    or KEYITEM5 == 0x31 
		    or KEYITEM6 == 0x31 
		    or KEYITEM7 == 0x31
		    or KEYITEM8 == 0x31 
            or KEYITEM9 == 0x31
		    or KEYITEM10 == 0x31 
		    or KEYITEM11 == 0x31 
		    or KEYITEM12 == 0x31 
		    or KEYITEM13 == 0x31 
		    or KEYITEM14 == 0x31
		    or KEYITEM15 == 0x31 
            or KEYITEM16 == 0x31 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateShellFlute(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	
         	if KEYITEM1 == 0x36
		    or KEYITEM2 == 0x36
		    or KEYITEM3 == 0x36 
		    or KEYITEM4 == 0x36 
		    or KEYITEM5 == 0x36 
		    or KEYITEM6 == 0x36 
		    or KEYITEM7 == 0x36
		    or KEYITEM8 == 0x36 
            or KEYITEM9 == 0x36
		    or KEYITEM10 == 0x36 
		    or KEYITEM11 == 0x36 
		    or KEYITEM12 == 0x36 
		    or KEYITEM13 == 0x36 
		    or KEYITEM14 == 0x36
		    or KEYITEM15 == 0x36 
            or KEYITEM16 == 0x36 then
            		 item.Active = true
        			else
            			item.Active = false
        			end        	
    	end
end

function updateBugFlute(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	  
         	if KEYITEM1 == 0x27
		    or KEYITEM2 == 0x27
		    or KEYITEM3 == 0x27 
		    or KEYITEM4 == 0x27 
		    or KEYITEM5 == 0x27 
		    or KEYITEM6 == 0x27 
		    or KEYITEM7 == 0x27
		    or KEYITEM8 == 0x27  
            or KEYITEM9 == 0x27
		    or KEYITEM10 == 0x27 
		    or KEYITEM11 == 0x27 
		    or KEYITEM12 == 0x27 
		    or KEYITEM13 == 0x27 
		    or KEYITEM14 == 0x27
		    or KEYITEM15 == 0x27 
            or KEYITEM16 == 0x27 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateLimeFlute(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	
               	if KEYITEM1 == 0x28
		    or KEYITEM2 == 0x28
		    or KEYITEM3 == 0x28 
		    or KEYITEM4 == 0x28 
		    or KEYITEM5 == 0x28 
		    or KEYITEM6 == 0x28 
		    or KEYITEM7 == 0x28
		    or KEYITEM8 == 0x28 
            or KEYITEM9 == 0x28
		    or KEYITEM10 == 0x28 
		    or KEYITEM11 == 0x28 
		    or KEYITEM12 == 0x28 
		    or KEYITEM13 == 0x28 
		    or KEYITEM14 == 0x28
		    or KEYITEM15 == 0x28 
            or KEYITEM16 == 0x28 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateOnyxStatue(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	  
               	if KEYITEM1 == 0x25
		    or KEYITEM2 == 0x25
		    or KEYITEM3 == 0x25 
		    or KEYITEM4 == 0x25 
		    or KEYITEM5 == 0x25 
		    or KEYITEM6 == 0x25 
		    or KEYITEM7 == 0x25
		    or KEYITEM8 == 0x25 
            or KEYITEM9 == 0x25
		    or KEYITEM10 == 0x25 
		    or KEYITEM11 == 0x25 
		    or KEYITEM12 == 0x25 
		    or KEYITEM13 == 0x25 
		    or KEYITEM14 == 0x25
		    or KEYITEM15 == 0x25 
            or KEYITEM16 == 0x25 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateGoldStatue(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	 
          	if KEYITEM1 == 0x3A
		    or KEYITEM2 == 0x3A
		    or KEYITEM3 == 0x3A 
		    or KEYITEM4 == 0x3A 
		    or KEYITEM5 == 0x3A 
		    or KEYITEM6 == 0x3A 
		    or KEYITEM7 == 0x3A
		    or KEYITEM8 == 0x3A 
            or KEYITEM9 == 0x3A
		    or KEYITEM10 == 0x3A 
		    or KEYITEM11 == 0x3A 
		    or KEYITEM12 == 0x3A 
		    or KEYITEM13 == 0x3A 
		    or KEYITEM14 == 0x3A
		    or KEYITEM15 == 0x3A 
            or KEYITEM16 == 0x3A then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateIvoryStatue(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	    
        	if KEYITEM1 == 0x3D
		    or KEYITEM2 == 0x3D
		    or KEYITEM3 == 0x3D 
		    or KEYITEM4 == 0x3D 
		    or KEYITEM5 == 0x3D 
		    or KEYITEM6 == 0x3D 
		    or KEYITEM7 == 0x3D
		    or KEYITEM8 == 0x3D 
            or KEYITEM9 == 0x3D
		    or KEYITEM10 == 0x3D 
		    or KEYITEM11 == 0x3D 
		    or KEYITEM12 == 0x3D 
		    or KEYITEM13 == 0x3D 
		    or KEYITEM14 == 0x3D
		    or KEYITEM15 == 0x3D 
            or KEYITEM16 == 0x3D then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateBrokenStatue(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	  
               	if KEYITEM1 == 0x38
		    or KEYITEM2 == 0x38
		    or KEYITEM3 == 0x38 
		    or KEYITEM4 == 0x38 
		    or KEYITEM5 == 0x38 
		    or KEYITEM6 == 0x38 
		    or KEYITEM7 == 0x38
		    or KEYITEM8 == 0x38  
            or KEYITEM9 == 0x38
		    or KEYITEM10 == 0x38 
		    or KEYITEM11 == 0x38 
		    or KEYITEM12 == 0x38 
		    or KEYITEM13 == 0x38 
		    or KEYITEM14 == 0x38
		    or KEYITEM15 == 0x38 
            or KEYITEM16 == 0x38 then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateOpelStatue(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6440) 
    	local KEYITEM2 = ReadU8(segment, 0x6441)
        local KEYITEM3 = ReadU8(segment, 0x6442) 
    	local KEYITEM4 = ReadU8(segment, 0x6443)
	    local KEYITEM5 = ReadU8(segment, 0x6444) 
    	local KEYITEM6 = ReadU8(segment, 0x6445)
	    local KEYITEM7 = ReadU8(segment, 0x6446) 
    	local KEYITEM8 = ReadU8(segment, 0x6447)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	if item  then    
               	if KEYITEM1 == 0x26
		    or KEYITEM2 == 0x26
		    or KEYITEM3 == 0x26 
		    or KEYITEM4 == 0x26 
		    or KEYITEM5 == 0x26 
		    or KEYITEM6 == 0x26 
		    or KEYITEM7 == 0x26
		    or KEYITEM8 == 0x26 
            or KEYITEM9 == 0x26
		    or KEYITEM10 == 0x26 
		    or KEYITEM11 == 0x26 
		    or KEYITEM12 == 0x26 
		    or KEYITEM13 == 0x26 
		    or KEYITEM14 == 0x26
		    or KEYITEM15 == 0x26 
            or KEYITEM16 == 0x26 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item.Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateFruitofRepun(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6440) 
    	local KEYITEM2 = ReadU8(segment, 0x6441)
        local KEYITEM3 = ReadU8(segment, 0x6442) 
    	local KEYITEM4 = ReadU8(segment, 0x6443)
	    local KEYITEM5 = ReadU8(segment, 0x6444) 
    	local KEYITEM6 = ReadU8(segment, 0x6445)
	    local KEYITEM7 = ReadU8(segment, 0x6446) 
    	local KEYITEM8 = ReadU8(segment, 0x6447)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	if item  then    
               	if KEYITEM1 == 0x23
		    or KEYITEM2 == 0x23
		    or KEYITEM3 == 0x23 
		    or KEYITEM4 == 0x23 
		    or KEYITEM5 == 0x23 
		    or KEYITEM6 == 0x23 
		    or KEYITEM7 == 0x23
		    or KEYITEM8 == 0x23 
            or KEYITEM9 == 0x23
		    or KEYITEM10 == 0x23 
		    or KEYITEM11 == 0x23 
		    or KEYITEM12 == 0x23 
		    or KEYITEM13 == 0x23 
		    or KEYITEM14 == 0x23
		    or KEYITEM15 == 0x23 
            or KEYITEM16 == 0x23 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item.Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateKarissaPlant(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	 
               	if KEYITEM1 == 0x3C
		    or KEYITEM2 == 0x3C
		    or KEYITEM3 == 0x3C 
		    or KEYITEM4 == 0x3C 
		    or KEYITEM5 == 0x3C 
		    or KEYITEM6 == 0x3C 
		    or KEYITEM7 == 0x3C
		    or KEYITEM8 == 0x3C 
            or KEYITEM9 == 0x3C
		    or KEYITEM10 == 0x3C 
		    or KEYITEM11 == 0x3C 
		    or KEYITEM12 == 0x3C 
		    or KEYITEM13 == 0x3C 
		    or KEYITEM14 == 0x3C
		    or KEYITEM15 == 0x3C 
            or KEYITEM16 == 0x3C then
            		 item.Active = true 
        			else
            			item.Active = false
        			end        	
    	end
end

function updateXrayGlasses(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end


    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	 
               	if KEYITEM1 == 0x37
		    or KEYITEM2 == 0x37
		    or KEYITEM3 == 0x37 
		    or KEYITEM4 == 0x37 
		    or KEYITEM5 == 0x37 
		    or KEYITEM6 == 0x37 
		    or KEYITEM7 == 0x37
		    or KEYITEM8 == 0x37 
            or KEYITEM9 == 0x37
		    or KEYITEM10 == 0x37 
		    or KEYITEM11 == 0x37 
		    or KEYITEM12 == 0x37 
		    or KEYITEM13 == 0x37 
		    or KEYITEM14 == 0x37
		    or KEYITEM15 == 0x37 
            or KEYITEM16 == 0x37 then
            		 item.Active = true
        			else
            			item.Active = false
        			end        	
    	end
end

function updateLovePendant(segment, code, address)
    local item = Tracker:FindObjectForCode(code)

	if item then
		-- Do not auto-track this the user has manually modified it
		if item.Active then
		  return
		end

    	local KEYITEM1 = ReadU8(segment, 0x6450) 
    	local KEYITEM2 = ReadU8(segment, 0x6451)
        local KEYITEM3 = ReadU8(segment, 0x6452) 
    	local KEYITEM4 = ReadU8(segment, 0x6453)
	    local KEYITEM5 = ReadU8(segment, 0x6454) 
    	local KEYITEM6 = ReadU8(segment, 0x6455)
	    local KEYITEM7 = ReadU8(segment, 0x6456) 
    	local KEYITEM8 = ReadU8(segment, 0x6457)
        local KEYITEM9 = ReadU8(segment, 0x64B8) 
    	local KEYITEM10 = ReadU8(segment, 0x64B9)
        local KEYITEM11 = ReadU8(segment, 0x64BA) 
    	local KEYITEM12 = ReadU8(segment, 0x64BB)
	    local KEYITEM13 = ReadU8(segment, 0x64BC) 
    	local KEYITEM14 = ReadU8(segment, 0x64BD)
	    local KEYITEM15 = ReadU8(segment, 0x64BE) 
    	local KEYITEM16 = ReadU8(segment, 0x64BF)
	
	 
         	if KEYITEM1 == 0X3B
		    or KEYITEM2 == 0x3B
		    or KEYITEM3 == 0x3B 
		    or KEYITEM4 == 0x3B 
		    or KEYITEM5 == 0x3B 
		    or KEYITEM6 == 0x3B 
		    or KEYITEM7 == 0x3B
		    or KEYITEM8 == 0x3B 
            or KEYITEM9 == 0x3B
		    or KEYITEM10 == 0x3B 
		    or KEYITEM11 == 0x3B 
		    or KEYITEM12 == 0x3B 
		    or KEYITEM13 == 0x3B 
		    or KEYITEM14 == 0x3B
		    or KEYITEM15 == 0x3B 
            or KEYITEM16 == 0x3B then
            		 item.Active = true
        			else
            			item.Active = false
        			end        	
    	end
end

function updatePsychoArmor(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6434) 
    	local KEYITEM2 = ReadU8(segment, 0x6435)
        local KEYITEM3 = ReadU8(segment, 0x6436) 
    	local KEYITEM4 = ReadU8(segment, 0x6437)
	
	if item  then    
               	if KEYITEM1 == 0x1C
		    or KEYITEM2 == 0x1C
		    or KEYITEM3 == 0x1C 
		    or KEYITEM4 == 0x1C then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item.Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateSacredShield(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    	local KEYITEM1 = ReadU8(segment, 0x6438) 
    	local KEYITEM2 = ReadU8(segment, 0x6439)
        local KEYITEM3 = ReadU8(segment, 0x643A) 
    	local KEYITEM4 = ReadU8(segment, 0x643B)
	
	if item  then    
               	if KEYITEM1 == 0x12
		    or KEYITEM2 == 0x12
		    or KEYITEM3 == 0x12 
		    or KEYITEM4 == 0x12 then
            		if item.Active == false then
                		print(item.Name .. " obtained")
                		item.Active = true
            		end
        			else
            			item.Active = false
        			end        	
    	end
end

function updateToggleItemFromByte(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value > 0 and value < 254 then
            if item.Active == false then
                print(item.Name .. " obtained")
                item.Active = true
            end
        else
            item.Active = false
        end
    end
end

function updateToggleItemFromByteAndFlag(segment, code, address, flag)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(item.Name, code, flag, value)
        end

        local flagTest = value & flag

        if flagTest ~= FF then
            item.Active = true
        elseif AUTOTRACKER_ENABLE_SETTING_LOCATIONS_TO_FALSE then
            item.Active = false
        end
    end
end

function updateProgressiveItemFromByteAndFlags(segment, code, address, flag1, flag2)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)
        if value & flag1 ~= 0 and value & flag2 ~= 0 then
            if item.CurrentStage ~= 3 then
                print(item.Name .. " obtained")
                item.CurrentStage = 3
            end
        elseif value & flag2 ~= 0 then
            if item.CurrentStage ~= 2 then
                print(item.Name .. " obtained")
                item.CurrentStage = 2
            end
        elseif value & flag1 ~= 0 then
            if item.CurrentStage ~= 1 then
                print(item.Name .. " obtained")
                item.CurrentStage = 1
            end
        else
            item.CurrentStage = 0
        end
    end
end

function updateChestsFromMemorySegmentCorridor(segment)
    if not isInGame() then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        updateSectionChestCountFromByteAndFlag(segment, "@Leaf Village: Elder/Leaf Elder", 0x64A0, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Save the child or kill the boss/Oak Elder", 0x64A0, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Waterfall Cave: Sword of Water/Sword of Water", 0x64A0, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Styx: Sword of Thunder/Sword of Thunder", 0x64A0, 0x08)
        --Crystalis updateSectionChestCountFromByteAndFlag(segment, "@Crystalis", 0x64A0, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Sealed Cave: Ball of Wind/Ball of Wind", 0x64A0, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre West: Tornado Bracelet/Tornado Bracelet", 0x64A0, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Insect Boss/Use Insect Flute", 0x64A0, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre North: Kelbesque1/Kelbesque 1 Reward", 0x64A1, 0x01)  --Kelby 1
        updateSectionChestCountFromByteAndFlag(segment, "@Lime Tree/Rage", 0x64A1, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Amazones Basement/Storage Room", 0x64A1, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Mado 1/Trigger Massacre first", 0x64A1, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Karmine Reward 2/Karmine Reward 2", 0x64A1, 0x10)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A1, 0x20) Not used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A1, 0x40) Not used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A1, 0x80) Not used
		
        updateSectionChestCountFromByteAndFlag(segment, "@Waterfall Cave: Flute of Lime/Flute of Lime", 0x64A2, 0x01)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A2, 0x02) Not used
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Mado's Floor: Mado2/Mado 2 Reward", 0x64A2, 0x04)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A2, 0x08) Not used
        updateSectionChestCountFromByteAndFlag(segment, "@Styx: Psycho Shield/Psycho Shield", 0x64A2, 0x10)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A2, 0x20) Not used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A2, 0x40) Not used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A2, 0x80) Not used
		
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A3, 0x01) Not used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A3, 0x02) Not used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A3, 0x04) Not used
        updateSectionChestCountFromByteAndFlag(segment, "@Oasis Cave: Battle Armor/Battle Armor", 0x64A3, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Pyramid Front: BoT/Bow of Truth", 0x64A3, 0x10)
		--update2ItemLocation(segment, "@Pyramid Front: BoT and Psycho Armor/Bow of Truth + Psycho Armor", 0x64A3, 0x10, 0x64A8, 0x01)  --Note need to fix this is two items
        updateSectionChestCountFromByteAndFlag(segment, "@Sealed Cave: Medical Herb 2/Medical Herb 2", 0x64A3, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Sealed Cave: Antidote/Antidote", 0x64A3, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Fog Lamp Cave: Lysis/Lysis Plant", 0x64A3, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Hydra: Fruit of Lime/Fruit of Lime", 0x64A4, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Sabera's Fortress: Fruit of Power/Fruit of Power", 0x64A4, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Evil Spirit Island: Magic Ring/Magic Ring", 0x64A4, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Sabera's Floor: Sabera 2/Sabera 2 Reward", 0x64A4, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Sealed Cave: Warp Boots/Warp Boots", 0x64A4, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Item in grass/Walk on bridge first", 0x64A4, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Kelbesque's Floor/Kelbesque 2", 0x64A4, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Save the child or kill the boss/Mom", 0x64A4, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Queen 1/Queen 1", 0x64A5, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Akahana Trade-In/Give him item", 0x64A5, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Oasis Cave: Power Ring/Power Ring", 0x64A5, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Brokahana/Change into Akahana", 0x64A5, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Evil Spirit Island: Iron Necklace/Iron Necklace", 0x64A5, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Meadow/Console the Bunny", 0x64A5, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Sealed Cave: Vampire/Vampire Reward", 0x64A5, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Oasis Cave: Leather Boots/Leather Boots", 0x64A5, 0x80)
		
        updateSectionChestCountFromByteAndFlag(segment, "@Waterfall Cave: Akahana/Rescue Akahana", 0x64A6, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Leaf Village: Student/Student", 0x64A6, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Windmill Guard/Wake him up", 0x64A6, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre North: Prison Key/Key to Prison", 0x64A6, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Shyron/Zebu in the Temple", 0x64A6, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Fog Lamp Cave: Fog Lamp/Fog Lamp", 0x64A6, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Dolphin/Heal them", 0x64A6, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Clark/Kill Sabera first", 0x64A6, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Sabera's Fortress: Sabera1/Sabera Reward", 0x64A7, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Lighthouse/Wake Up Kensu", 0x64A7, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Combine the Items/Combine them!", 0x64A7, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Portoa Waterway/Underwater Item", 0x64A7, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Kirisa Plant Cave: Kirisa/Kirisa Plant", 0x64A7, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Karmine Reward 1/Karmine Reward 1", 0x64A7, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Amazones/Trade In Kirisa Plant", 0x64A7, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Hydra: Bow of Sun/Bow of Sun", 0x64A7, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Pyramid Front: Psycho Armor/Psycho Armor", 0x64A8, 0x01)
		updateSectionChestCountFromByteAndFlag(segment, "@Windmill Reward/Activate Windmill", 0x64A8, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre North: Prison Break Reward/Prison Break Reward", 0x64A8, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Stom Fight/Visit Oak first", 0x64A8, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre West: Tornel Reward/Tornel - Show him Tornado Bracelet", 0x64A8, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Queen 2/Queen 2 (Talk to Mesia first)", 0x64A8, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Altar/Calm the Sea", 0x64A8, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Kensu Tag/Turn-in Love Pendant", 0x64A8, 0x80)
		
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Slimed Kensu/Slimed Kensu", 0x64A9, 0x01)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x02) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x04) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x08) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x10) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x20) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x40) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64A9, 0x80) Not Used
		
        updateSectionChestCountFromByteAndFlag(segment, "@Sealed Cave: Medical Herb 1/Medical Herb 1", 0x64AA, 0x01)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64AA, 0x02) Not Used
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre West: Medical Herb/Medical Herb", 0x64AA, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre North: Medical Herb/Medical Herb", 0x64AA, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Mado's Floor: Magic Ring 3/Magic Ring 3", 0x64AA, 0x10) --NEW MADO CHEST
        updateSectionChestCountFromByteAndFlag(segment, "@Sabera's Fortress: Medical Herb/Medical Herb", 0x64AA, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Hydra: Medical Herb/Medical Herb", 0x64AA, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Styx: Medical Herb/Medical Herb", 0x64AA, 0x80)
		
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Magic Ring/Magic Ring", 0x64AB, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@East Cave: Key Item/Key Item", 0x64AB, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Oasis Cave: Fruit of Power 1/Fruit of Power 1", 0x64AB, 0x04)
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64AB, 0x08) Not Used
        updateSectionChestCountFromByteAndFlag(segment, "@Evil Spirit Island: Lysis/Lysis Plant", 0x64AB, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Sabera's Floor: Lysis/Lysis Plant", 0x64AB, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre North: Antidote/Antidote", 0x64AB, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Kirisa Plant Cave: Antidote/Antidote", 0x64AB, 0x80)
		
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Mado's Floor: Antidote/Antidote", 0x64AC, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Sabera's Fortress: Vampire2/Vampire Reward", 0x64AC, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Sabera's Floor: Fruit of Power/Fruit of Power", 0x64AC, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Mado's Floor: Opel/Opel Statue", 0x64AC, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Oasis Cave: Fruit of Power 2/Fruit of Power 2", 0x64AC, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Hydra: Magic Ring/Magic Ring", 0x64AC, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Sabera's Floor: Fruit of Repun/Fruit of Repun", 0x64AC, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Kensu's Beach House/Take the boat", 0x64AC, 0x80)
		
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64AD, 0x01) Not Used
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre West: Magic Ring/Magic Ring", 0x64AD, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Sabre West: Warp Boots/Warp Boots", 0x64AD, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Mado's Floor: Magic Ring 2/Magic Ring 2", 0x64AD, 0x08) --MIGHT BE 2
        updateSectionChestCountFromByteAndFlag(segment, "@Pyramid Front: Magic Ring/Magic Ring", 0x64AD, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Pyramid Back: Opel Statue/Opel Statue", 0x64AD, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Warp Boots/Warp Boots", 0x64AD, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Mado's Floor: Magic Ring 1/Magic Ring 1", 0x64AD, 0x80)  --Might be 1
			
        updateSectionChestCountFromByteAndFlag(segment, "@Fog Lamp Cave: Mimic 1/Mimic 1", 0x64AE, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Fog Lamp Cave: Mimic 2/Mimic 2", 0x64AE, 0x02)  
        updateSectionChestCountFromByteAndFlag(segment, "@Waterfall Cave: Mimic/Mimic", 0x64AE, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Evil Spirit Island: Mimic/Mimic", 0x64AE, 0x08) 
        updateSectionChestCountFromByteAndFlag(segment, "@Mt. Hydra: Mimic/Mimic", 0x64AE, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Styx: Mimic 1/Mimic 1", 0x64AE, 0x20)
        --updateSectionChestCountFromByteAndFlag(segment, "@Styx: Mimic 1/Mimic 1", 0x64AE, 0x40)
		updateSectionChestCountFromByteAndFlag(segment, "@Styx: Mimic 3/Mimic 3", 0x64AE, 0x80)
			
        updateSectionChestCountFromByteAndFlag(segment, "@Pyramid Back: Mimic/Mimic", 0x64AF, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Mimic 1/Mimic 1", 0x64AF, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Mimic 2/Mimic 2", 0x64AF, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Goa: Karmine's Floor: Mimic 3/Mimic 3", 0x64AF, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@East Cave: Consumable/Consumable Item", 0x64AF, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Styx: Mimic 2/Mimic 2", 0x64AF, 0x20) --13
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64AF, 0x40) Not Used
        --updateSectionChestCountFromByteAndFlag(segment, "@", 0x64AF, 0x80) Not Used

--Note need to find magic ring 3 in mado2 floor
    end
end


function updateKeyItemsFromMemorySegment(segment)
    if not isInGame(segment) then
        return false
    end

    InvalidateReadCaches()

    if AUTOTRACKER_ENABLE_ITEM_TRACKING then

    
	--updateToggleItemFromByte(segment, "kelbesque1_cleared", 0x64A1, 0x01)  
	--updateProgessiveItemFromByteAndFlag(segment, "Kelbesque 1", 0x64A1, 0x01)
	--updateToggleItemFromByte(segment, "kelbesque2_cleared", 0x64A4, 0x40)
	--updateToggleItemFromByte(segment, "sabera1_cleared", 0x64A7, 0x01)
	--updateToggleItemFromByte(segment, "sabera2_cleared", 0x64A4, 0x08)
	--updateToggleItemFromByte(segment, "mado1_cleared", 0x64A1, 0x08)
	--updateToggleItemFromByte(segment, "mado2_cleared", 0x64A2, 0x04)
	--updateToggleItemFromByte(segment, "karmine_cleared", 0x64A1, 0x10)	
	--updateToggleItemFromByte(segment, "vampire_cleared", 0x64A5, 0x40)
	--updateToggleItemFromByte(segment, "giantinsect_cleared", 0x64A0, 0x80)	
	--updateToggleItemFromByte(segment, "draygon1_cleared", 0x64A8, 0x01)  Needs to be made
	
	updateWindSword(segment, "windsword", 0x6430)
    updateToggleItemFromByte(segment, "firesword", 0x6431, 0x01)
    updateToggleItemFromByte(segment, "watersword", 0x6432, 0x02)
    updateToggleItemFromByte(segment, "thundersword", 0x6433, 0x03)

    updateWindBall(segment, "windball", 0x643C)
    updateFireBall(segment, "fireball", 0x643D)
    updateWaterBall(segment, "waterball", 0x643E)
    updateThunderBall(segment, "thunderball", 0x643F)

    updateWindBraclet(segment, "tornadobracelet", 0x643C)
    updateFireBraclet(segment, "flamebracelet", 0x643D)
    updateWaterBraclet(segment, "blizzardbracelet", 0x643E)
    updateThunderBraclet(segment, "stormbracelet", 0x643F)

   
    updateRefresh(segment, "refresh")
    updateParalysis(segment, "paralysis")
	updateTelepathy(segment, "telepathy")
    updateTeleport(segment, "teleport")
	updateRecover(segment, "recover")
    updateBarrier(segment, "barrier")
	updateChange(segment, "change")
    updateFlight(segment, "flight")

    updateGasMask(segment, "gasmask")
    updatePowerRing(segment, "powerring")
    updateWarriorRing(segment, "warriorring")
    updateIronNecklace(segment, "ironpendant")
    updateDeosPendant(segment, "deospendant")
    updateRabbitBoots(segment, "rabbitboots")
    updateSpeedBoots(segment, "speedboots")
    updateShieldRing(segment, "shieldring")

    updateMoonBow(segment, "bowofmoon")
    updateSunBow(segment, "bowofsun")
    updateTruthBow(segment, "bowoftruth")

    updateWindKey(segment, "windmillkey")
    updatePrisonKey(segment, "keytoprison")
    updateStyxKey(segment, "keytostyx")

    updateFogLamp(segment, "foglamp")
    updateGlowLamp(segment, "glowinglamp")

    updateAlarmFlute(segment, "alarmflute")
    updateBugFlute(segment, "insectflute")
    updateLimeFlute(segment, "fluteoflime")
    updateShellFlute(segment, "shellflute")
    
    updateIvoryStatue(segment, "ivorystatue")
    updateBrokenStatue(segment, "brokenstatue")
    updateGoldStatue(segment, "goldstautue")
    updateOnyxStatue(segment, "statueofonyx")

    updateOpelStatue(segment, "opelstatue")
    updateFruitofRepun(segment, "fruitofrepun")

    updateKarissaPlant(segment, "kirisaplant")
    updateLovePendant(segment, "lovependant")
    updateXrayGlasses(segment, "eyeglasses")

    updatePsychoArmor(segment, "psychoarmor")
    updateSacredShield(segment, "sacredshield")


    

    end
    
end


-- I know this is bad practice but the amount of resets makes it so all the sanity
-- checking needs to be done on the segment
ScriptHost:AddMemoryWatch("Item Data", 0x6430, 0x500, updateKeyItemsFromMemorySegment)
ScriptHost:AddMemoryWatch("Location Data", 0x64A0, 0x20, updateChestsFromMemorySegmentCorridor)
