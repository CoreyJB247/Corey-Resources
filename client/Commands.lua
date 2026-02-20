Citizen.CreateThread(function()
    local angle = 0.0
    local speed = 0.0
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if DoesEntityExist(veh) then
            local tangle = GetVehicleSteeringAngle(veh)
            if tangle > 10.0 or tangle < -10.0 then
                angle = tangle
            end
            speed = GetEntitySpeed(veh)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
            if speed < 0.1 and DoesEntityExist(vehicle) and not GetIsTaskActive(PlayerPedId(), 151) and not GetIsVehicleEngineRunning(vehicle) then
                SetVehicleSteeringAngle(GetVehiclePedIsIn(PlayerPedId(), true), angle)
            end
        end
    end
end)

-- Vehicle 

usingKeyPress = true -- Allow use of a key press combo (default Ctrl + E) to open trunk/hood from outside
togKey = 38 -- E

RegisterCommand("trunk", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = 'Trunk Closed',
                type = 'success'
            })
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = 'Trunk Opened',
                type = 'success'
            })
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Trunk Closed',
                    type = 'success'
                })
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Trunk Opened',
                    type = 'success'
                })
            end
        else
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = 'Too far away from vehicle',
                type = 'warning'
            })
        end
    end
end)

RegisterCommand("hood", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = 'Hood Closed',
                type = 'success'
            })
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = 'Hood Opened',
                type = 'success'
            })
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Hood Closed',
                    type = 'success'
                })
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Hood Opened',
                    type = 'success'
                })
            end
        else
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = 'Too far away from vehicle',
                type = 'warning'
            })
        end
    end
end)

RegisterCommand("door", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    
    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
        lib.notify({
            title = 'Vehicle Door',
            description = 'Usage: /door [door]\n1: Front Left Door\n2: Front Right Door\n3: Back Left Door\n4: Back Right Door',
            type = 'info',
            duration = 7000
        })
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Door Closed',
                    type = 'success'
                })
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Door Opened',
                    type = 'success'
                })
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    lib.notify({
                        title = 'Corey Vehicle Actions',
                        description = 'Door Closed',
                        type = 'success'
                    })
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    lib.notify({
                        title = 'Corey Vehicle Actions',
                        description = 'Door Opened',
                        type = 'success'
                    })
                end
            else
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Too far away from vehicle',
                    type = 'warning'
                })
            end
        end
    end
end)

if usingKeyPress then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            local ped = GetPlayerPed(-1)
            local veh = GetVehiclePedIsUsing(ped)
            local vehLast = GetPlayersLastVehicle()
            local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
            local door = 5
            if IsControlPressed(1, 224) and IsControlJustPressed(1, togKey) then
                if not IsPedInAnyVehicle(ped, false) then
                    if distanceToVeh < 4 then
                        if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                            SetVehicleDoorShut(vehLast, door, false)
                            lib.notify({
                                title = 'Corey Vehicle Actions',
                                description = 'Trunk Closed',
                                type = 'success'
                            })
                        else	
                            SetVehicleDoorOpen(vehLast, door, false, false)
                            lib.notify({
                                title = 'Corey Vehicle Actions',
                                description = 'Trunk Opened',
                                type = 'success'
                            })
                        end
                    else
                        lib.notify({
                            title = 'Corey Vehicle Actions',
                            description = 'Too far away from vehicle',
                            type = 'warning'
                        })
                    end
                end
            end
        end
    end)
end

-- DV
RegisterCommand( "dv", function()
    TriggerEvent( "wk:deleteVehicle" )
end, false )
TriggerEvent( "chat:addSuggestion", "/dv", "Deletes the vehicle you're sat in, or standing next to." )

-- The distance to check in front of the player for a vehicle   
local distanceToCheck = 5.0

-- The number of times to retry deleting a vehicle if it fails the first time 
local numRetries = 5

-- Add an event handler for the deleteVehicle event. Gets called when a user types in /dv in chat
RegisterNetEvent( "wk:deleteVehicle" )
AddEventHandler( "wk:deleteVehicle", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'You must be in the driver\'s seat!',
                    type = 'error'
                })
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'You must be in or near a vehicle to delete it',
                    type = 'warning'
                })
            end 
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        lib.notify({
            title = 'Corey Vehicle Actions',
            description = 'Failed to delete vehicle, trying again...',
            type = 'error'
        })

        -- Fallback if the vehicle doesn't get deleted
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            -- The vehicle has been banished from the face of the Earth!
            if ( not DoesEntityExist( veh ) ) then 
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Vehicle deleted',
                    type = 'success'
                })
            end 

            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1 
            Citizen.Wait( 500 )

            -- We've timed out and the vehicle still hasn't been deleted. 
            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                lib.notify({
                    title = 'Corey Vehicle Actions',
                    description = 'Failed to delete vehicle after ' .. timeoutMax .. ' retries',
                    type = 'error'
                })
            end 
        end 
    else 
        lib.notify({
            title = 'Corey Vehicle Actions',
            description = 'Vehicle deleted',
            type = 'success'
        })
    end 
end 

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

local notify = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)

        if not notify then
            if IsPedInAnyVehicle(ped, true) then
                lib.notify({
                    description = 'Hold F when exiting to leave engine running',
                    type = 'info',
                    duration = 6250
                })
                notify = true
            end
        end
        
        if RestrictEmer then
            if GetVehicleClass(veh) == 18 then
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    Citizen.Wait(150)
                    if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                        SetVehicleEngineOn(veh, true, true, false)
                        if highBeams then
                            SetVehicleLights(veh, 2) -- Force turn light on
                            SetVehicleFullbeam(veh, true) 
                            SetVehicleLightMultiplier(veh, 1.0)
                        end
                        if keepDoorOpen then
                            TaskLeaveVehicle(ped, veh, 256)
                        else
                            TaskLeaveVehicle(ped, veh, 0)
                        end
                    end
                end
            end
        else
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                Citizen.Wait(150)
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    SetVehicleEngineOn(veh, true, true, false)
                    if highBeams then
                        SetVehicleLights(veh, 2) -- Force turn light on
                        SetVehicleFullbeam(veh, true) 
                        SetVehicleLightMultiplier(veh, 1.0)
                    end
                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local angle = 0.0
    local speed = 0.0
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if DoesEntityExist(veh) then
            local tangle = GetVehicleSteeringAngle(veh)
            if tangle > 10.0 or tangle < -10.0 then
                angle = tangle
            end
            speed = GetEntitySpeed(veh)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
            if speed < 0.1 and DoesEntityExist(vehicle) and not GetIsTaskActive(PlayerPedId(), 151) and not GetIsVehicleEngineRunning(vehicle) then
                SetVehicleSteeringAngle(GetVehiclePedIsIn(PlayerPedId(), true), angle)
            end
        end
    end
end)

-- Seat Shuffle

-- optimizations
local tonumber = tonumber
local CreateThread = Citizen.CreateThread
local Wait = Citizen.Wait
local TriggerEvent = TriggerEvent
local RegisterCommand = RegisterCommand
local PlayerPedId = PlayerPedId
local IsPedInAnyVehicle = IsPedInAnyVehicle
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehiclePedIsIn = GetVehiclePedIsIn
local SetPedIntoVehicle = SetPedIntoVehicle
-- end optimizations

local disabled = false

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local restrictSwitching = false
        
        if IsPedInAnyVehicle(ped, false) and not disabled then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), 0) == ped then
                restrictSwitching = true
            end
        end
        
        SetPedConfigFlag(ped, 184, restrictSwitching)
        Wait(150)
    end
end)

local function switchSeat(_, args)
    local seatIndex = tonumber(args[1]) - 1
    
    if seatIndex < -1 or seatIndex >= 4 then
        SetNotificationTextEntry('STRING')
        AddTextComponentString("~r~Seat ~b~" .. (seatIndex + 1) .. "~r~ is not recognized")
        DrawNotification(true, true)
    else
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
        if veh ~= nil and veh > 0 then
            CreateThread(function()
                disabled = true
                SetPedIntoVehicle(PlayerPedId(), veh, seatIndex)
                Wait(50)
                disabled = false
            end)
        end
    end
end

local function shuffleSeat()
    CreateThread(function()
        disabled = true
        Wait(3000)
        disabled = false
    end)
end

RegisterCommand("seat", switchSeat)
RegisterCommand("shuff", shuffleSeat)
RegisterCommand("shuffle", shuffleSeat)

TriggerEvent('chat:addSuggestion', '/shuff', "Switch to the driver's seat")
TriggerEvent('chat:addSuggestion', '/shuffle', "Switch to the driver's seat")
TriggerEvent('chat:addSuggestion', '/seat', 'Switch seats in the current vehicle',
  { { name = 'seat', help = "Switch seats in the current vehicle. 0 = driver, 1 = passenger, 2-3 = back seats" } })

AddEventHandler('onClientResourceStop', function(name)
    if name == 'seat-switcher' then
        SetPedConfigFlag(PlayerPedId(), 184, false)
    end
end)


--[[ SEAT SHUFFLE ]]--
--[[ BY JAF ]]--

local actionkey=9999 --Lshift (or whatever your sprint key is bound to)
local allowshuffle = false
local playerped=nil
local currentvehicle=nil

--getting vars
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		--constantly getting the current 
		playerped=PlayerPedId()
		--constantly get player vehicle
		currentvehicle=GetVehiclePedIsIn(playerped, false)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if IsPedInAnyVehicle(playerped, false) and allowshuffle == false then
			--if they're trying to shuffle for whatever reason
			SetPedConfigFlag(playerped, 184, true)
			if GetIsTaskActive(playerped, 165) then
				--getting seat player is in 
				seat=0
				if GetPedInVehicleSeat(currentvehicle, -1) == playerped then
					seat=-1
				end
				--if the passenger doesn't shut the door, shut it manually
				--if GetVehicleDoorAngleRatio(currentvehicle,1) > 0.0 and seat == 0 then
					--SetVehicleDoorShut(currentvehicle,1,false)
				--end
				--move ped back into the seat right as the animation starts
				SetPedIntoVehicle(playerped, currentvehicle, seat)
			end
		elseif IsPedInAnyVehicle(playerped, false) and allowshuffle == true then
			SetPedConfigFlag(playerped, 184, false)
		end
	end
end)


RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(playerped, false) then
		--getting seat
		seat=0
		if GetPedInVehicleSeat(currentvehicle, -1) == playerped then
			seat=-1
		end
		--if they're a driver
		if GetPedInVehicleSeat(currentvehicle,-1) == playerped then
			TaskShuffleToNextVehicleSeat(playerped,currentvehicle)
		end
		--if they're a passenger
		--adding a block until they are actually in their new seat
		allowshuffle=true
		while GetPedInVehicleSeat(currentvehicle,seat) == playerped do
			Citizen.Wait(0)
		end
		allowshuffle=false
	else
		allowshuffle=false
		CancelEvent('SeatShuffle')
	end
end)


local elapsed=0
--thread to get duration of key press
Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
	elapsed=0
	while IsControlPressed(0,actionkey) and GetIsTaskActive(playerped, 165) do
		Citizen.Wait(100)
		elapsed=elapsed+0.1
	end
  end
end)



Citizen.CreateThread(function()
  while true do
  --if the press the control then start the animation
	if IsControlJustPressed(1, actionkey) then -- Lshift
	   TriggerEvent("SeatShuffle")
    end
	--if they release the control mid anim then set back
	if IsControlJustReleased(1, actionkey) and allowshuffle == true then 
		--setting threshold for how long the ksy should be pressed for
		threshhold=0.8
		--if they're in passenger seat then remove add 1 second to the threshold because of slight delay when moving from passenger side
		--if GetPedInVehicleSeat(currentvehicle, 0) == playerped then
			--threshhold=threshhold+0.55
		--end
		--if the animation is playing and the key is pressed down for long enough, cancel the animation
	   if GetIsTaskActive(playerped, 165) and elapsed < threshhold then
			allowshuffle=false
	   end
    end
    Citizen.Wait(0)
  end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it
