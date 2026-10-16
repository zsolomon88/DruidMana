local manaPowerType = Enum and Enum.PowerType and Enum.PowerType.Mana or 0

local bar = CreateFrame("StatusBar", "DruidManaBar", UIParent)
bar:SetSize(190, 18)
bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
bar:SetStatusBarColor(0.1, 0.35, 1)
bar:SetMinMaxValues(0, 1)
bar:SetValue(0)
bar:SetFrameStrata("MEDIUM")

local background = bar:CreateTexture(nil, "BACKGROUND")
background:SetAllPoints()
background:SetColorTexture(0, 0, 0, 0.75)

local text = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
text:SetPoint("CENTER")

if PlayerFrame then
    bar:SetPoint("TOP", PlayerFrame, "BOTTOM", 0, -8)
else
    bar:SetPoint("CENTER", UIParent, "CENTER", 0, -180)
end

bar:Hide()

local function IsDruid()
    local _, class = UnitClass("player")
    return class == "DRUID"
end

local function IsShapeshifted()
    if type(GetShapeshiftForm) == "function" then
        local form = GetShapeshiftForm()
        if type(form) == "number" then
            return form > 0
        end
    end

    if type(GetShapeshiftFormID) == "function" then
        local formID = GetShapeshiftFormID()
        if type(formID) == "number" then
            return formID > 0
        end
    end

    local currentPowerType = UnitPowerType("player")
    return currentPowerType ~= manaPowerType
end

local function UpdateManaBar()
    if not IsDruid() or not IsShapeshifted() then
        bar:Hide()
        return
    end

    local currentMana = UnitPower("player", manaPowerType)
    local maximumMana = UnitPowerMax("player", manaPowerType)

    bar:SetMinMaxValues(0, math.max(maximumMana, 1))
    bar:SetValue(currentMana)
    text:SetText(("Mana: %d / %d"):format(currentMana, maximumMana))
    bar:Show()
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
events:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
events:RegisterEvent("UNIT_POWER_UPDATE")
events:RegisterEvent("UNIT_MAXPOWER")
events:RegisterEvent("UNIT_DISPLAYPOWER")
events:SetScript("OnEvent", function(_, event, unit)
    if event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" or event == "UNIT_DISPLAYPOWER" then
        if unit ~= "player" then
            return
        end
    end

    UpdateManaBar()
end)
