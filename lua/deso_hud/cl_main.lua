--[[-------------------------------------------------
	Hooks
---------------------------------------------------]]

deso.col.dark = Color(48, 48, 48)
deso.col.light = Color(78, 78, 78)
deso.col.outline = Color(28, 28, 28)

local toHide = 
{
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudAmmo"] = true
}

hook.Add("HUDShouldDraw", "deso_hide_default", function(name)
	if (toHide[name]) then return false end
end)

hook.Add("HUDPaint", "deso_hud", function()
	deso.hud.Main()
	deso.hud.Ammo()
	deso.hud.Agenda()
	deso.hud.Sprint()
end)