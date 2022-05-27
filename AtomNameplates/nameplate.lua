local _, main = ...

local width, height = main.NAMEPLATE_WIDTH, main.NAMEPLATE_HEIGHT
local totemlist = main.totemlist
local prototype = {}


function prototype:UpdateColors(r, g, b)
	if g + b == 0 then -- red
		r, g, b = 0.69, 0.31, 0.31
	elseif r + b == 0 then -- green
		r, g, b = 0.33, 0.59, 0.33
	elseif r + g == 0 then -- blue
		r, g, b = 0.31, 0.45, 0.63
	elseif r + g > 1.99 and b == 0 then -- yellow
		r, g, b = 0.65, 0.63, 0.35
	end
    local healthbar = self.healthbar
	healthbar:SetStatusBarColor(r, g, b)
	healthbar.bg:SetTexture(r * 0.3, g * 0.3, b * 0.3)
	self.totem.bg:SetTexture(r, g, b)
	healthbar.r, healthbar.g, healthbar.b = r, g, b
end

function prototype:OnUpdate()
	local healthbar = self.healthbar
	local r,g,b = healthbar:GetStatusBarColor()
	if r ~= healthbar.r or g ~= healthbar.g or b ~= healthbar.b then
		self:UpdateColors(r, g, b)
	end

	if self.totem:IsShown() then
		self.raidicon:SetAlpha(0)
	else
		local raidicon = self.raidicon
		raidicon:SetSize(24, 24)
		raidicon:ClearAllPoints()
		raidicon:SetPoint("LEFT", healthbar, "RIGHT", 4, 0)
		raidicon:SetAlpha(1)
	end

	if self.threat:IsShown() then
		self.newName:SetTextColor(self.threat:GetVertexColor())
	else
		self.newName:SetTextColor(1, 0.9, 0.8)
	end

	if self:GetAlpha() < 1 then
		self:SetAlpha(66/100)
	end
end

function prototype:OnShow()
	local name = self.origName:GetText()
	local totemTexture = totemlist[name]
	if totemTexture then
		local totem = self.totem
		totem:Show()
		totem.bg:Show()
		totem:SetTexture(totemTexture)
		
		self.newName:Hide()
		self.healthbar:Hide()
		self.highlight:SetAllPoints(totem)
	else
		local healthbar = self.healthbar
		healthbar:Show()
		healthbar:ClearAllPoints()
		healthbar:SetSize(width, height)
		healthbar:SetPoint("TOP", 0, -4)
		self:UpdateColors(healthbar:GetStatusBarColor())
		self.totem:Hide()
		self.totem.bg:Hide()
		self.newName:Show()
		self.newName:SetText(name)
		self.highlight:SetAllPoints(healthbar)
	end
	self.level:Hide()
end

function prototype:OnHide()
	self.highlight:Hide()
end


main.nameplateProto = prototype