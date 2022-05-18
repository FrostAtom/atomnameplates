local _, main = ...

local tbl = {"", " II", " III", " IV", " V", " VI", " VII", " VIII", " IX", " X"}
local function GetTotemInfo(id)
	local name, rank, texture = GetSpellInfo(id)
	rank = tbl[tonumber(string.match(rank, ("%d+")))]
	if rank ~= nil then
		return format("%s%s", name, rank), texture
	else
		return name, texture
	end
end

local totemList = {
	--Air Totems
	8177, -- Grounding Totem
	10595, -- Nature Resistance Totem I
	10600, -- Nature Resistance Totem II
	10601, -- Nature Resistance Totem III
	25574, -- Nature Resistance Totem IV
	58746, -- Nature Resistance Totem V
	58749, -- Nature Resistance Totem VI
	6495, -- Sentry Totem
	8512, -- Windfury Totem
	3738, -- Wrath of Air Totem
	--Earth Totems
	2062, -- Earth Elemental Totem
	2484, -- Earthbind Totem
	5730, -- Stoneclaw Totem I
	6390, -- Stoneclaw Totem II
	6391, -- Stoneclaw Totem III
	6392, -- Stoneclaw Totem IV
	10427, -- Stoneclaw Totem V
	10428, -- Stoneclaw Totem VI
	25525, -- Stoneclaw Totem VII
	58580, -- Stoneclaw Totem VIII
	58581, -- Stoneclaw Totem IX
	58582, -- Stoneclaw Totem X
	8071, -- Stoneskin Totem I -- Faction Champs
	8154, -- Stoneskin Totem II
	8155, -- Stoneskin Totem III
	10406, -- Stoneskin Totem IV
	10407, -- Stoneskin Totem V
	10408, -- Stoneskin Totem VI
	25508, -- Stoneskin Totem VII
	25509, -- Stoneskin Totem VIII
	58751, -- Stoneskin Totem IX
	58753, -- Stoneskin Totem X
	8075, -- Strength of Earth Totem I -- Faction Champs
	8160, -- Strength of Earth Totem II
	8161, -- Strength of Earth Totem III
	10442, -- Strength of Earth Totem IV
	25361, -- Strength of Earth Totem V
	25528, -- Strength of Earth Totem VI
	57622, -- Strength of Earth Totem VII
	58643, -- Strength of Earth Totem VIII
	8143, -- Tremor Totem
	--Fire Totems
	2894, -- Fire Elemental Totem
	8227, -- Flametongue Totem I -- Faction Champs
	8249, -- Flametongue Totem II
	10526, -- Flametongue Totem III
	16387, -- Flametongue Totem IV
	25557, -- Flametongue Totem V
	58649, -- Flametongue Totem VI
	58652, -- Flametongue Totem VII
	58656, -- Flametongue Totem VIII
	8181, -- Frost Resistance Totem I
	10478, -- Frost Resistance Totem II
	10479, -- Frost Resistance Totem III
	25560, -- Frost Resistance Totem IV
	58741, -- Frost Resistance Totem V
	58745, -- Frost Resistance Totem VI
	8190, -- Magma Totem I
	10585, -- Magma Totem II
	10586, -- Magma Totem III
	10587, -- Magma Totem IV
	25552, -- Magma Totem V
	58731, -- Magma Totem VI
	58734, -- Magma Totem VII
	3599, -- Searing Totem I -- Faction Champs
	6363, -- Searing Totem II
	6364, -- Searing Totem III
	6365, -- Searing Totem IV
	10437, -- Searing Totem V
	10438, -- Searing Totem VI
	25533, -- Searing Totem VII
	58699, -- Searing Totem VIII
	58703, -- Searing Totem IX
	58704, -- Searing Totem X
	30706, -- Totem of Wrath I
	57720, -- Totem of Wrath II
	57721, -- Totem of Wrath III
	57722, -- Totem of Wrath IV
	--Water Totems
	8170, -- Cleansing Totem
	8184, -- Fire Resistance Totem I
	10537, -- Fire Resistance Totem II
	10538, -- Fire Resistance Totem III
	25563, -- Fire Resistance Totem IV
	58737, -- Fire Resistance Totem V
	58739, -- Fire Resistance Totem VI
	5394, -- Healing Stream Totem I -- Faction Champs
	6375, -- Healing Stream Totem II
	6377, -- Healing Stream Totem III
	10462, -- Healing Stream Totem IV
	10463, -- Healing Stream Totem V
	25567, -- Healing Stream Totem VI
	58755, -- Healing Stream Totem VII
	58756, -- Healing Stream Totem VIII
	58757, -- Healing Stream Totem IX
	5675, -- Mana Spring Totem I
	10495, -- Mana Spring Totem II
	10496, -- Mana Spring Totem III
	10497, -- Mana Spring Totem IV
	25570, -- Mana Spring Totem V
	58771, -- Mana Spring Totem VI
	58773, -- Mana Spring Totem VII
	58774, -- Mana Spring Totem VIII
	16190 	-- Mana Tide Totem
}

do
	local name, texture
	for i = 1, #totemList do
		name, texture = GetTotemInfo(totemList[i])
		totemList[name], totemList[i] = texture
	end
end

if GetLocale() == "ruRU" then
	local _, _, texture = GetSpellInfo(58745)
	for i = 1, 6 do
		totemList["Тотем сопротивления льду" .. tbl[i]] = texture
	end
	_, _, texture = GetSpellInfo(58739)
	for i = 1, 6 do
		totemList["Тотем сопротивления огню" .. tbl[i]] = texture
	end
	_, _, texture = GetSpellInfo(58749)
	for i = 1, 6 do
		totemList["Тотем сопротивления силам природы" .. tbl[i]] = texture
	end
end

main.totemlist = totemList