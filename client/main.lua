local QBCore = exports['qb-core']:GetCoreObject()

-- Command to use the boosting tablet
RegisterCommand('useBoostTablet', function()
    local hasTablet = QBCore.Functions.HasItem('boosting_tablet')
    if hasTablet then
        TriggerServerEvent('boosting:client:requestBoosts')
    else
        QBCore.Functions.Notify("You don't have a boosting tablet!", "error")
    end
end)

-- Show the tablet UI with Boosting Coins and available boosts
RegisterNetEvent('boosting:client:showTablet', function(coins, boosts)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'showTablet',
        coins = coins,
        boosts = boosts
    })
end)

-- Handle starting a boost via the tablet
RegisterNUICallback('startBoost', function(data, cb)
    local boostId = data.boostId
    TriggerServerEvent('boosting:server:startBoost', boostId)
    cb('ok')
end)

-- Notify the player when the boost starts
RegisterNetEvent('boosting:client:startBoostMission', function(boost)
    -- Generate random spawn location from a predefined list
    local spawnLocations = {
        vector3(123.45, 678.90, 21.32),
        vector3(234.56, 789.01, 30.00),
        vector3(345.67, 890.12, 40.50)
    }
    local randomLocation = spawnLocations[math.random(1, #spawnLocations)]
    local model = GetHashKey(boost.vehicle)

    -- Load the vehicle model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    -- Spawn the vehicle at the random location
    local vehicle = CreateVehicle(model, randomLocation.x, randomLocation.y, randomLocation.z, 0.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    -- Notify the player to hack the GPS first
    TriggerEvent('boosting:client:hackGps')
end)

-- GPS hacking step
RegisterNetEvent('boosting:client:hackGps', function()
    local hasItem = QBCore.Functions.HasItem('gps_hacking_tool')
    if hasItem then
        TriggerServerEvent('boosting:server:hackGps')
        QBCore.Functions.Notify("GPS successfully hacked!", "success")
    else
        QBCore.Functions.Notify("You don't have a GPS hacking tool!", "error")
    end
end)

-- Engine hacking step
RegisterNetEvent('boosting:client:hackEngine', function()
    local hasItem = QBCore.Functions.HasItem('engine_hacking_tool')
    if hasItem then
        TriggerServerEvent('boosting:server:hackEngine')
        QBCore.Functions.Notify("Engine successfully hacked!", "success")
    else
        QBCore.Functions.Notify("You don't have an engine hacking tool!", "error")
    end
end)

-- VIN scratching step
RegisterNetEvent('boosting:client:scratchVin', function()
    local hasItem = QBCore.Functions.HasItem('vin_scratcher')
    if hasItem then
        TriggerServerEvent('boosting:server:scratchVin')
        QBCore.Functions.Notify("VIN successfully scratched!", "success")
    else
        QBCore.Functions.Notify("You don't have a VIN scratcher!", "error")
    end
end)

-- NUI Callbacks for closing the tablet UI
RegisterNUICallback('closeTablet', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Event triggered after a successful boost
RegisterNetEvent('boosting:client:successfulBoost', function(boostReward)
    QBCore.Functions.Notify("Boost successful! You've earned $" .. boostReward, "success")
end)

-- Event triggered when the player fails to hack (optional)
RegisterNetEvent('boosting:client:hackFailed', function()
    QBCore.Functions.Notify("Hack failed! Try again.", "error")
end)

-- Additional notifications or actions can be implemented here if needed.
