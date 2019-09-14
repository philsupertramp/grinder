local currentXP = nil
local gainedXP = nil

local function calc_xp(self)
    local level = UnitLevel("player")
    local XP = UnitXP("player")
    local XPMax = UnitXPMax("player")

    if currentXP ~= XP then
        if currentXP ~= nil then
            gainedXP = XP - currentXP
        end
        currentXP = XP
    end
    if gainedXP == nil then
        gainedXP = 1
    end
    local killsLeft = floor((XPMax - currentXP) / gainedXP) + 1
    if killsLeft > 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|c98FB98ff(" .. killsLeft .. ") kills left to Level " .. level + 1 .. ".")
    end
end

function grinder_xp_OnLoad(self, event, ...)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_LEVEL_UP")
    self:RegisterEvent("PLAYER_XP_UPDATE")
end

function grinder_xp_OnEvent(self, event, ...)
    if event == "ADDON_LOADED" and ... == "grinder" then
        self:UnregisterEvent("ADDON_LOADED")
        grinder:SetSize(100, 50)
        grinder:SetPoint("TOP", "Minimap", "BOTTOM", 5, -5)
        grinder:Show()
    elseif event == "PLAYER_LEVEL_UP" then
        calc_xp()
    elseif event == "PLAYER_XP_UPDATE" then
        calc_xp()
    end
end
