local _, main = ...

local prototype = {}
local width, height = main.NAMEPLATE_WIDTH, main.NAMEPLATE_HEIGHT
local iconSize = height * 2 + 2 * 2

function prototype:OnUpdate()
    local nameplate = self:GetParent()
    self:ClearAllPoints()
    self:SetPoint("TOP", nameplate.healthbar, "BOTTOM", 0, -4)
    self:SetSize(width, height)
end

function prototype:OnShow()
    local nameplate = self:GetParent()
    if nameplate.totem:IsShown() then
        self:Hide()
        self.icon:SetAlpha(0)
        return
    end
    local icon = self.icon
    icon:SetAlpha(1)
    icon:ClearAllPoints()
    icon:SetPoint("TOPRIGHT", nameplate.healthbar, "TOPLEFT", -4, 0)
    icon:SetSize(iconSize, iconSize)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
end

function prototype:OnHide()
    self:Hide()
end

main.castbarProto = prototype