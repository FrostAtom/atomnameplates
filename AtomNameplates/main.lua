local _, main = ...

local hiddenFrame = CreateFrame("Frame")
hiddenFrame:Hide()
local nameplateMT = { __index = setmetatable(main.nameplateProto, getmetatable(UIParent)) }
local castbarMT = { __index = setmetatable(main.castbarProto, getmetatable(CastingBarFrame)) }


function main:OnNameplateCreate(frame)
	local healthbar, castbar = frame:GetChildren()
	local threat,hpborder,cbshield,cbborder,cbicon,highlight,name,level,bossicon,raidicon,elite = frame:GetRegions()
    setmetatable(frame, nameplateMT)
	setmetatable(castbar, castbarMT)

	-- healthbar setup
	do
		healthbar:SetFrameLevel(frame:GetFrameLevel())
		healthbar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
		frame.healthbar = healthbar

		-- healthbar background
		local bg = CreateFrame("frame", nil, healthbar)
		bg:SetFrameLevel(healthbar:GetFrameLevel() - 1)
		bg:SetPoint("TOPRIGHT", 2, 2)
		bg:SetPoint("BOTTOMLEFT", -2, -2)
		bg:SetBackdrop({
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = 8,
			bgFile = "Interface\\Buttons\\WHITE8x8",
			insets = {
				top = 1,
				bottom = 1,
				left = 1,
				right = 1,
			}
		})
		bg:SetBackdropColor(0.137, 0.137, 0.137)
		bg:SetBackdropBorderColor(0.2, 0.2, 0.2)

		-- healthbar border
		hpborder:SetParent(healthbar)
		hpborder:SetTexture(0.3, 0.3, 0.3)
		hpborder:SetDrawLayer("BACKGROUND")
		hpborder:SetAllPoints(healthbar)
		healthbar.bg = hpborder
	end

	-- castbar setup
	do
		castbar:SetFrameLevel(frame:GetFrameLevel())
		castbar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
		frame.castbar = castbar

		-- castbar background
		local bg = CreateFrame("frame", nil, castbar)
		bg:SetFrameLevel(castbar:GetFrameLevel() - 1)
		bg:SetPoint("TOPRIGHT", 2, 2)
		bg:SetPoint("BOTTOMLEFT", -2, -2)
		bg:SetBackdrop({
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = 8,
			bgFile = "Interface\\Buttons\\WHITE8x8",
			insets = {
				top = 1,
				bottom = 1,
				left = 1,
				right = 1,
			}
		})
		bg:SetBackdropColor(0.137, 0.137, 0.137)
		bg:SetBackdropBorderColor(0.2, 0.2, 0.2)

		-- icon
		cbicon:SetDrawLayer("ARTWORK")

		-- icon background
		bg = CreateFrame("Frame", nil, castbar)
		bg:SetFrameLevel(castbar:GetFrameLevel() - 1)
		bg:SetPoint("TOPRIGHT", cbicon, 2, 2)
		bg:SetPoint("BOTTOMLEFT", cbicon, -2, -2)
		bg:SetBackdrop({
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = 8,
			bgFile = "Interface\\Buttons\\WHITE8x8",
			insets = {
				top = 1,
				bottom = 1,
				left = 1,
				right = 1,
			}
		})
		bg:SetBackdropColor(0.137, 0.137, 0.137)
		bg:SetBackdropBorderColor(0.2, 0.2, 0.2)

		castbar.icon = cbicon
	end

	-- name
	local newName = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	newName:SetPoint("BOTTOM", healthbar, "TOP")
	newName:SetTextColor(1,0.9,0.8)
	name:Hide()
	frame.origName, frame.newName = name, newName

	-- totem icon
	do
		local texture = frame:CreateTexture(nil, "ARTWORK")
		texture:SetSize(32, 32)
		texture:SetPoint("TOP")
		texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		texture:Hide()

		local bg = frame:CreateTexture(nil, "BORDER")
		bg:SetPoint("TOPRIGHT", texture, 2, 2)
		bg:SetPoint("BOTTOMLEFT", texture, -2, -2)
		bg:SetTexture("Interface\\Buttons\\WHITE8x8")

		texture.bg = bg
		frame.totem = texture
	end

	-- misc regions
	highlight:SetTexture(1,1,1,0.4)
	frame.highlight = highlight
	frame.level = level
	frame.raidicon = raidicon

	-- setup events
	frame:SetScript("OnShow", frame.OnShow)
	frame:SetScript("OnHide", frame.OnHide)
	frame:SetScript("OnUpdate", frame.OnUpdate)
	castbar:SetScript("OnShow", castbar.OnShow)
	castbar:SetScript("OnHide", castbar.OnHide)
	castbar:SetScript("OnUpdate", castbar.OnUpdate)

	-- remove unneded blizzard regions
	threat:SetParent(hiddenFrame)
	bossicon:SetParent(hiddenFrame)
	elite:SetParent(hiddenFrame)
	cbborder:SetParent(hiddenFrame)
	cbshield:SetParent(hiddenFrame)

    frame:OnShow()
	if castbar:IsShown() then castbar:OnShow() end
end