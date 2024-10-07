Config = {}

-- Search Zone Settings
Config.SearchZoneRadius = 150.0 -- Size of the search area in meters

-- Speed requirement for hacking (in MPH)
Config.HackSpeedRequirement = 60 -- Speed in miles per hour

-- Items
Config.BoostingTablet = 'boosting_tablet'
Config.GPSHackingTool = 'gps_hacking_tool'
Config.EngineHackingTool = 'engine_hacking_tool'
Config.VINScratcher = 'vin_scratcher'

-- Boosting Coins Settings
Config.BoostingCoinReward = 5 -- Amount of Boosting Coins rewarded per successful boost
Config.BoostingCoinCost = 5 -- Amount of Boosting Coins required to start a boost

-- Boosting Locations (random spawn locations for boosted vehicles)
Config.BoostingLocations = {
    { x = 123.45, y = 678.90, z = 21.32 },
    { x = 234.56, y = 789.01, z = 30.00 },
    { x = 345.67, y = 890.12, z = 40.50 },
    { x = 456.78, y = 901.23, z = 35.20 },
    { x = 567.89, y = 1012.34, z = 25.75 }
}

-- Boosting Coin Rewards based on tiers
Config.TierRewards = {
    S = 5000,
    A = 3500,
    B = 2500,
    C = 1500,
    D = 1000
}

-- Cop Notification Settings
Config.NotifyCopsChance = 50 -- Percentage chance of notifying cops when a VIN is scratched

-- Boosting Cooldowns (in seconds)
Config.BoostingCooldown = 300 -- Cooldown for initiating new boosts
Config.HackGpsCooldown = 120 -- Cooldown for GPS hacking
Config.HackStartCooldown = 150 -- Cooldown for engine start hacking

-- VIN Scratch Settings
Config.VinCheckNotify = true -- Toggle notification for VIN scratch events

-- Notification Colors
Config.NotifySuccessColor = "success" -- Notification color for successful actions
Config.NotifyErrorColor = "error" -- Notification color for failed actions
