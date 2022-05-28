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

		-- healthbar border
		local bg = healthbar:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(.2, .2, .2)
		bg:SetPoint("TOPRIGHT", 2, 2)
		bg:SetPoint("BOTTOMLEFT", -2, -2)
		healthbar.border = bg

		-- healthbar background
		hpborder:SetParent(healthbar)
		hpborder:SetTexture(0.3, 0.3, 0.3)
		hpborder:SetDrawLayer("BORDER")
		hpborder:SetAllPoints(healthbar)
		healthbar.bg = hpborder
	end

	-- castbar setup
	do
		castbar:SetFrameLevel(frame:GetFrameLevel())
		castbar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
		frame.castbar = castbar

		-- castbar background
		local bg = castbar:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(.2, .2, .2)
		bg:SetPoint("TOPRIGHT", 2, 2)
		bg:SetPoint("BOTTOMLEFT", -2, -2)

		-- icon
		cbicon:SetDrawLayer("ARTWORK")

		-- icon background
		bg = castbar:CreateTexture(nil, "BORDER")
		bg:SetTexture(.2, .2, .2)
		bg:SetPoint("TOPRIGHT", cbicon, 2, 2)
		bg:SetPoint("BOTTOMLEFT", cbicon, -2, -2)

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

	-- highlight
	highlight:SetTexture(1,1,1,0.4)

	-- elite icon
	elite:ClearAllPoints()
	elite:SetPoint("CENTER", healthbar, "RIGHT", -8, 0)
	elite:SetSize(46, 27)
	elite:SetDesaturated(true)

	-- aggro background
	--threat:SetTexture("Interface\\BUTTONS\\WHITE8x8")
	--threat:ClearAllPoints()
	--threat:SetPoint("TOPRIGHT", healthbar, 2, 2)
	--threat:SetPoint("BOTTOMLEFT", healthbar, -2, -2)

	-- misc
	frame.highlight = highlight
	frame.level = level
	frame.elite = elite
	frame.raidicon = raidicon
	frame.threat = threat

	-- setup events
	frame:SetScript("OnShow", frame.OnShow)
	frame:SetScript("OnHide", frame.OnHide)
	frame:SetScript("OnUpdate", frame.OnUpdate)
	castbar:SetScript("OnShow", castbar.OnShow)
	castbar:SetScript("OnHide", castbar.OnHide)
	castbar:SetScript("OnUpdate", castbar.OnUpdate)

	-- remove unneded blizzard regions
	bossicon:SetParent(hiddenFrame)
	cbborder:SetParent(hiddenFrame)
	cbshield:SetParent(hiddenFrame)
	threat:SetParent(hiddenFrame)

    frame:OnShow()
	if castbar:IsShown() then castbar:OnShow() end
end