local _, main = ...

local select = select
local WorldFrame = WorldFrame
local pcall = pcall
local geterrorhandler = geterrorhandler

local TYPE_NAMEPLATE = 1
local TYPE_CHATBUBBLE = 2

local function safecall(...)
    local isOk, err = pcall(...)
    if not isOk then
        geterrorhandler()(err)
    end
end

local function IdentifyFrame(self)
    if self:GetName() then return end
    if self.GetRegions then
        local region = self:GetRegions()
        if region.GetTexture then
        	local texturePath = region:GetTexture()
        	if texturePath == "Interface\\TargetingFrame\\UI-TargetingFrame-Flash" then
        		return TYPE_NAMEPLATE
        	elseif texturePath == "Interface\\Tooltips\\ChatBubble-Background" then
        		return TYPE_CHATBUBBLE
        	end
        end
    end
end

local function HandleChilds(...)
    local child, type, func
    for i = 1, select("#", ...) do
        child = select(i, ...)
        type = IdentifyFrame(child)
        if type == TYPE_NAMEPLATE then
            func = main.OnNameplateCreate
            if func then safecall(func, main, child) end
            func = main.OnNameplateShow
            if func then safecall(func, main, child) end
        elseif type == TYPE_CHATBUBBLE then
            func = main.OnBubbleCreate
            if func then safecall(func, main, child) end
            func = main.OnBubbleShow
            if func then safecall(func, main, child) end
        end
    end
end

local lastChildrensCount = 0
CreateFrame("frame"):SetScript("OnUpdate", function()
	if WorldFrame:GetNumChildren() ~= lastChildrensCount then
        HandleChilds(select(lastChildrensCount + 1, WorldFrame:GetChildren()))
		lastChildrensCount = WorldFrame:GetNumChildren()
	end
end)