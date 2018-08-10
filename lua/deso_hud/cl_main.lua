--[[-------------------------------------------------
	Hooks
---------------------------------------------------]]

deso.col.dark = Color(48, 48, 48)
deso.col.light = Color(78, 78, 78)
deso.col.outline = Color(28, 28, 28)
deso.col.text = Color(0, 156, 255)

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

hook.Add("HUDDrawTargetID", "deso_hide_targetID", function() return false end)

hook.Add("HUDPaint", "deso_hud", function()
	deso.hud.Main()
	deso.hud.Ammo()
	deso.hud.Agenda()
end)

hook.Add("PostDrawOpaqueRenderables", "deso_hud_overhead", deso.hud.OverHead)