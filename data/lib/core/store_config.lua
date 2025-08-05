--[[
    ========================================
    STORE CONFIGURATION
    ========================================
    
    Developed by: Mateus Roberto (mateuskl)
    Date: 02/08/2025
    Version: v1.0
    
    This file contains all configuration tables for the Store System
]]

StoreConfig = {}

StoreConfig.expBoostPrices = {
    [1] = 999,   -- 1x boost price
    [2] = 45,   -- 2x boost price  
    [3] = 90,   -- 3x boost price
    [4] = 180,  -- 4x boost price
    [5] = 360   -- 5x boost price
}

StoreConfig.getExpBoostPrice = function(value)
    return StoreConfig.expBoostPrices[value] or StoreConfig.expBoostPrices[1]
end

StoreConfig.vipDiscount = 0.90

function getExpBoostPriceFromLua(value)
    return StoreConfig.getExpBoostPrice(value)
end

return StoreConfig 