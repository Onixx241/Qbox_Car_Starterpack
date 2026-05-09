
RegisterNetEvent("myServerEvent:getIdentifier")
AddEventHandler("myServerEvent:getIdentifier", function()
    -- 'source' is automatically passed by FiveM for net events
    local playerSrc = source
    local identifiers = GetPlayerIdentifierByType(playerSrc, "license2")
    TriggerClientEvent("myClientEvent:receiveIdentifiers", playerSrc, identifiers)
    --MySQL.prepare('INSERT INTO ox_inventory (owner, name, data) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE data = VALUES(data)', { owner, dbId, inventory })
    while identifiers == nil do
        Citizen.Wait(10)
    end

    print(identifiers)
    local response = MySQL.query.await('SELECT `name` FROM `players` WHERE `license` = ?', {identifiers}) 
    
    if response then

        print(response.name) -- this is coming out nil

    end

end)


AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print("Resource Active")
end)

function CheckIfInTable()
--return bool
end

function AddToTable()
end

function GiveCar()

end

