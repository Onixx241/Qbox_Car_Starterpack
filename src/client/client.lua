local timer = 3000
local lastpress = 0



RegisterNetEvent("myClientEvent:receiveIdentifiers")
AddEventHandler("myClientEvent:receiveIdentifiers", function(ShouldGivePack)

    if ShouldGivePack then
        lib.notify({
            title = 'Starter Pack Claimed',
            type = 'success'
        })  
    else
        lib.notify({
            title = 'You have already claimed the starter pack!',
            type = 'failure'
        })  
    end

end)

RegisterCommand("getmyids", function()
    TriggerServerEvent("myServerEvent:getIdentifier")
end, false)
--------------------------------------------------
local pedHash = GetConvar("starter_npc_model", "")
local pedCoords = vector4(351.50 , -622.48, 29.29, 68.46)

Citizen.CreateThread(function()

    

    RequestModel(GetHashKey(pedHash))

    while not HasModelLoaded(GetHashKey(pedHash)) do
        Wait(10)
    end
    
    local ped = CreatePed(4, GetHashKey(pedHash), pedCoords.x, pedCoords.y, pedCoords.z - 1, 150.0, true, true)

    while not DoesEntityExist(ped)do
        Citizen.Wait(10)
    end

    if DoesEntityExist(ped)then
        SetEntityHeading(ped, 150.0)
        SetEntityHeading(ped, 150.0)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
    
    

    --TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)

    local toggle = false
    
    local box = lib.zones.box({
    coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z),
    size = vec3(2.5, 2.5, 2),
    rotation = vector3(0,0,0),
    debug = true,
    inside = inside,
    onEnter = onEnter,
    onExit = onExit
    })

end)

function onEnter()
    --dont need
end

function onExit()
    lib.hideTextUI()
    pressed = false
end

function inside()
    
    lib.showTextUI('[E] - Claim Starter Pack', 
    {
    position = "top-center",
    icon = 'hand',
    style = 
    {
        borderRadius = 0,
        backgroundColor = '#FFADAF2E',
        color = 'white'
    }
    })

    GlobalThread = Citizen.CreateThread(function() 

        if IsControlJustReleased(0,  54) then
            --trigger event to check/give starter pack vehicle/s THEN notify, wait until the process is done (all of this is async) remember to account for it 
            local currentTime = GetGameTimer()
            
            
            if (currentTime - lastpress) > timer then
                TriggerServerEvent("myServerEvent:getIdentifier")
                
                lastpress = currentTime
            else
                
            end
            
            
        end

    end)

end 
