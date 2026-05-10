local player = exports.qbx_core:GetPlayer(source) -- doesnt work :(

RegisterNetEvent("myServerEvent:getIdentifier")
AddEventHandler("myServerEvent:getIdentifier", function()
    
    local playerSrc = source
    local identifiers = GetPlayerIdentifierByType(playerSrc, "license2")
    local _citizenID = ""
    local ShouldGivePack = false
    

    while identifiers == nil do
        Citizen.Wait(10)
    end

    --print(player) -- nil

    print(identifiers)
    local response = MySQL.query.await('SELECT `citizenid` FROM `players` WHERE `license` = ?', {identifiers} ) 
    
    if response then

        _citizenID = response[1].citizenid
        print(_citizenID) -- remove this when done testing

    end

    local hasReceivedPack = CheckIfInTable(response[1].citizenid)
    

    if not hasReceivedPack then

        ShouldGivePack = true
        AddToTable(response[1].citizenid)
        GiveCar(_citizenID)
        TriggerClientEvent("myClientEvent:receiveIdentifiers", playerSrc, ShouldGivePack)

    else
    -- Player already received, should NOT give pack
        ShouldGivePack = false
        TriggerClientEvent("myClientEvent:receiveIdentifiers", playerSrc, ShouldGivePack)
    end


end)


AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print("Resource Active")
end)

function CheckIfInTable(CitizenID)
    
    local response = MySQL.query.await(
        'SELECT `ID` FROM `player_received_starterpacks` WHERE `CITIZEN_ID` = ?', {CitizenID}
    )

    if response and response[1] ~= nil 
    then
        return true
    end


    return false 

end

function AddToTable(CitizenID) 
    
    local id = MySQL.insert.await('INSERT INTO `player_received_starterpacks` (CITIZEN_ID, CREATE_DATE) VALUES (?, ?)', {
    CitizenID, os.date()})

end

function GiveCar(CitizenID)
    exports.qbx_vehicles:CreatePlayerVehicle({
    source = source, 
    citizenid = CitizenID,
    model = GetConvar("starter_given_vehicle", ""), 
    plate = RandomString(8),
    properties = {
    },
    garage = 'pillboxgarage', 
    state = 1
    })
    exports.qbx_vehicles:CreatePlayerVehicle({
    source = source, 
    citizenid = CitizenID,
    model = GetConvar("starter_given_vehicle_two", ""), 
    plate = RandomString(8),
    properties = {
    },
    garage = 'pillboxgarage', 
    state = 1
    })
end

local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

function RandomString(length)
    math.randomseed(os.time())
    
    local res = ""
    for i = 1, length do
        local randIndex = math.random(1, #charset)
        res = res .. charset:sub(randIndex, randIndex)
    end
    return res
end