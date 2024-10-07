local QBCore = exports['qb-core']:GetCoreObject()

-- Cooldown tracking
local cooldowns = {
    boostCooldown = {},
    hackGpsCooldown = {},
    hackEngineCooldown = {},
    scratchVinCooldown = {}
}

-- Retrieve player's Boosting Coin balance from the database
function GetBoostingCoins(citizenid)
    local result = MySQL.Sync.fetchScalar('SELECT coins FROM boosting_coins WHERE citizenid = ?', { citizenid })
    return result or 0
end

-- Add Boosting Coins to player
function AddBoostingCoins(citizenid, amount)
    local currentCoins = GetBoostingCoins(citizenid)
    MySQL.Sync.execute('INSERT INTO boosting_coins (citizenid, coins) VALUES (?, ?) ON DUPLICATE KEY UPDATE coins = ?', { citizenid, currentCoins + amount, currentCoins + amount })
end

-- Deduct Boosting Coins
function DeductBoostingCoins(citizenid, amount)
    local currentCoins = GetBoostingCoins(citizenid)
    if currentCoins >= amount then
        MySQL.Sync.execute('UPDATE boosting_coins SET coins = ? WHERE citizenid = ?', { currentCoins - amount, citizenid })
        return true
    else
        return false
    end
end

-- Sample boosts (this would ideally be dynamic)
local availableBoosts = {
    { id = "boost1", tier = "S", vehicle = "Lamborghini Aventador", reward = 5000 },
    { id = "boost2", tier = "A", vehicle = "Dodge Challenger", reward = 3500 },
    { id = "boost3", tier = "B", vehicle = "BMW M4", reward = 2500 }
}

-- Request Boosts and Boosting Coin balance
RegisterNetEvent('boosting:client:requestBoosts', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid
    local boostingCoins = GetBoostingCoins(citizenid)

    -- Send Boosting Coins and available boosts to client
    TriggerClientEvent('boosting:client:showTablet', src, boostingCoins, availableBoosts)
end)

-- Handle boost selection and start the boost mission
RegisterNetEvent('boosting:server:startBoost', function(boostId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid

    -- Check if the player is on cooldown for boosting
    if cooldowns.boostCooldown[citizenid] and os.time() < cooldowns.boostCooldown[citizenid] then
        local remainingTime = cooldowns.boostCooldown[citizenid] - os.time()
        TriggerClientEvent('QBCore:Notify', src, "You must wait " .. remainingTime .. " seconds before boosting again.", "error")
        return
    end

    local selectedBoost = nil
    -- Find the selected boost
    for _, boost in ipairs(availableBoosts) do
        if boost.id == boostId then
            selectedBoost = boost
            break
        end
    end

    if selectedBoost then
        local coinsNeeded = 5 -- Example coin cost for a boost
        if DeductBoostingCoins(citizenid, coinsNeeded) then
            TriggerClientEvent('QBCore:Notify', src, "Boost started! Hack the car.", "success")
            TriggerClientEvent('boosting:client:startBoostMission', src, selectedBoost)

            -- Set the cooldown for boosting
            cooldowns.boostCooldown[citizenid] = os.time() + Config.BoostingCooldown
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough Boosting Coins.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Invalid boost selected.", "error")
    end
end)

-- Function to reward Boosting Coins (e.g., after successful boost)
RegisterNetEvent('boosting:server:rewardCoins', function(amount)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid
    AddBoostingCoins(citizenid, amount)
    TriggerClientEvent('QBCore:Notify', src, "You've received " .. amount .. " Boosting Coins.", "success")
end)

-- Handle hacking steps on the server
RegisterNetEvent('boosting:server:hackGps', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid

    -- Check if the player is on cooldown for GPS hacking
    if cooldowns.hackGpsCooldown[citizenid] and os.time() < cooldowns.hackGpsCooldown[citizenid] then
        local remainingTime = cooldowns.hackGpsCooldown[citizenid] - os.time()
        TriggerClientEvent('QBCore:Notify', src, "You must wait " .. remainingTime .. " seconds before hacking the GPS again.", "error")
        return
    end

    -- Proceed with GPS hacking
    cooldowns.hackGpsCooldown[citizenid] = os.time() + Config.HackGpsCooldown
    TriggerClientEvent('boosting:client:hackEngine', src)
end)

RegisterNetEvent('boosting:server:hackEngine', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid

    -- Check if the player is on cooldown for engine hacking
    if cooldowns.hackEngineCooldown[citizenid] and os.time() < cooldowns.hackEngineCooldown[citizenid] then
        local remainingTime = cooldowns.hackEngineCooldown[citizenid] - os.time()
        TriggerClientEvent('QBCore:Notify', src, "You must wait " .. remainingTime .. " seconds before hacking the engine again.", "error")
        return
    end

    -- Proceed with engine hacking
    cooldowns.hackEngineCooldown[citizenid] = os.time() + Config.HackStartCooldown
    TriggerClientEvent('boosting:client:scratchVin', src)
end)

RegisterNetEvent('boosting:server:scratchVin', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid

    -- Check if the player is on cooldown for VIN scratching
    if cooldowns.scratchVinCooldown[citizenid] and os.time() < cooldowns.scratchVinCooldown[citizenid] then
        local remainingTime = cooldowns.scratchVinCooldown[citizenid] - os.time()
        TriggerClientEvent('QBCore:Notify', src, "You must wait " .. remainingTime .. " seconds before scratching VIN again.", "error")
        return
    end

    -- Proceed with VIN scratching
    cooldowns.scratchVinCooldown[citizenid] = os.time() + Config.VinCheckNotify
    TriggerClientEvent('QBCore:Notify', src, "You have successfully scratched the VIN!", "success")

    -- Alert cops that the VIN has been scratched
    local cops = QBCore.Functions.GetPlayers() -- Get all players
    for _, cop in ipairs(cops) do
        local copPlayer = QBCore.Functions.GetPlayer(cop)
        if copPlayer.PlayerData.job.name == "police" then
            TriggerClientEvent('QBCore:Notify', cop, "A VIN has been scratched! Investigate immediately!", "inform")
        end
    end
end)
