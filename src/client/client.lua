local timer = 3000
local lastpress = 0

local pedHash = GetConvar("starter_npc_model", "")
local pedCoords = vector4(351.50 , -622.48, 29.29, 68.46)


RegisterNetEvent("myClientEvent:claimPack")
AddEventHandler("myClientEvent:claimPack", function(ShouldGivePack)

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

--------------------------------------------------


Citizen.CreateThread(function()

    
    
    
    --local ped = CreatePed(4, GetHashKey(pedHash), pedCoords.x, pedCoords.y, pedCoords.z - 1, 150.0, true, true)
    
    

    --TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)

    local toggle = false
    
    local box = lib.zones.box({
    coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z),
    size = vec3(2.5, 2.5, 2),
    rotation = vector3(0,0,0),
    debug = false,
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

    

    if IsControlJustReleased(0,  54) then
        
        local currentTime = GetGameTimer()
        
        
        if (currentTime - lastpress) > timer then
            TriggerServerEvent("myServerEvent:claimPack")
            
            lastpress = currentTime
        else
            
        end
        
        
    end

    

end 

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        DrawMarker(25, pedCoords.x, pedCoords.y, pedCoords.z - 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 3.0, 3.0, 3.0, 0, 255, 0, 100, false,false ,false, 2, nil, nil, false)
        DrawMarker(36, pedCoords.x, pedCoords.y, pedCoords.z + 1.25, 0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0,0,255,0,100,true,true,0,true,nil,nil,false)
    end

end)
