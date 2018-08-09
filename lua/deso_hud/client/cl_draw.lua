local scrW, scrH = ScrW(), ScrH()

local money = Material("icon16/money.png")
local job = Material("icon16/briefcase.png")
local heart = Material("icon16/heart.png")
local shield = Material("icon16/shield.png")
local sprint = Material("deso_hud/sprint.png")
local circle = Material("deso_hud/circle.png")

local w = 600
local h = 80
local x = (scrW / 2) - (w / 2)
local y = scrH - h
local p = 10 -- padding
local b = 25-- bar height

function deso.hud.Main()
	local hp, ap = LocalPlayer():Health(), LocalPlayer():Armor()
	local wallet = DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money"))
	local plyProps = "Prop Count: " .. LocalPlayer():GetCount("props")
	local plyJob = team.GetName(LocalPlayer():Team()) .. " (" .. DarkRP.formatMoney(LocalPlayer():getDarkRPVar("salary")) .. ")"

	surface.SetFont("deso_hud") -- so surface.GetTextSize fucking works properly
	local jobW = surface.GetTextSize(plyJob) + 24

	surface.SetDrawColor(deso.col.dark) -- background
	surface.DrawRect(x, y, w, h) -- main background

	surface.SetDrawColor(deso.col.light) -- light background
	surface.DrawRect(x + p, y + p, (w / 2) - p, h - 35 - (p * 2)) -- health background

	surface.SetDrawColor(255, 28, 28)
	surface.DrawRect(x + p + deso.hud.CalcHPWidthLerp((w / 2) - p, hp), y + p, (w / 2) - p, b) -- health

	surface.SetDrawColor(deso.col.light) -- light background
	surface.DrawRect(x + (w / 2), y + p, (w / 2) - p, h - 35 - (p * 2)) -- armor background
	surface.DrawRect(x + p, y + (p * 2) + b, 30 + surface.GetTextSize(wallet), b) -- wallet background
	surface.DrawRect(x + (w / 2) - 55, y + (p * 2) + b, 110, b) -- prop count background
	surface.DrawRect(x + w - p - jobW - 6, y + (p * 2) + b, jobW + 6, b) -- job background

	surface.SetDrawColor(0, 100, 255)
	surface.DrawRect(x + (w / 2) + 1, y + p, deso.hud.CalcArmorWidth((w / 2) - p - 1, ap), b) -- armor

	surface.SetDrawColor(deso.col.outline) -- dark outline
	surface.DrawOutlinedRect(x - 1, y - 1, w + 2, h + 2) -- main outline
	surface.DrawOutlinedRect(x + p, y + p, w - (p * 2), b) -- health/armor outline
	surface.DrawLine(x + (w / 2), y + p, x + (w / 2), y + p + b) -- health/armor outline
	surface.DrawOutlinedRect(x + p, y + (p * 2) + b, 30 + surface.GetTextSize(wallet), b) -- wallet outline
	surface.DrawOutlinedRect(x + (w / 2) - 55, y + (p * 2) + b, 110, b) -- prop count background
	surface.DrawOutlinedRect(x + w - p - jobW - 6, y + (p * 2) + b, jobW + 6, b) -- job background

	surface.SetDrawColor(255, 255, 255) -- have to reset color for textured rect
	surface.SetMaterial(money)
	surface.DrawTexturedRect(x + p + 5, (y + (p * 2) + b) + 4, 16, 16)
	surface.SetMaterial(job)
	surface.DrawTexturedRect(x + w - p - jobW, (y + (p * 2) + b) + 4, 16, 16)
	surface.SetMaterial(heart)
	surface.DrawTexturedRect(x + p + 5, y + p + 5, 16, 16)
	surface.SetMaterial(shield)
	surface.DrawTexturedRect(x + w - p * 3, y + p + 4, 16, 16)

	draw.SimpleText(wallet, "deso_hud", x + p + 24, y + p + 39, Color(255, 255, 255))
	draw.SimpleText(plyProps, "deso_hud", x + (w / 2), y + p + 39, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	draw.SimpleText(plyJob, "deso_hud", x + w - p - 5, y + p + 39, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
	draw.SimpleTextOutlined(math.Clamp(hp, 0, hp), "deso_hud_bold", x + (w / 4), y + p + 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, deso.col.outline)
	draw.SimpleTextOutlined(math.Clamp(ap, 0, ap), "deso_hud_bold", x + (w / 2) + (w / 4), y + p + 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, deso.col.outline)
end

local y = scrH - 100
local h = 80

local blacklist = 
{
	["weapon_physcannon"] = true,
	["weapon_bugbait"] = true,
	["weapon_keypadchecker"] = true
}

function deso.hud.Ammo()
	if (LocalPlayer():Alive() && LocalPlayer():IsValid()) then
		local wep = LocalPlayer():GetActiveWeapon()
		local clip = wep:Clip1()
		local reserve = LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType())
		
		surface.SetFont("deso_hud_clip")
		local clip_w = surface.GetTextSize(clip)

		surface.SetFont("deso_hud_reserve")
		local reserve_w = surface.GetTextSize(reserve)

		local w = (p * 3) + clip_w + reserve_w
		local x = scrW - 20 - w

		if (wep:IsValid() && wep:Clip1() != -1 && !blacklist[wep:GetClass()]) then
			surface.SetDrawColor(deso.col.dark)
			surface.DrawRect(x, y, w, h)
			
			surface.SetDrawColor(deso.col.outline)
			surface.DrawOutlinedRect(x, y, w, h)
			
			draw.SimpleText(clip, "deso_hud_clip", x + p, y + 5, Color(255, 255, 255))
			draw.SimpleText(reserve, "deso_hud_reserve", x + (p * 2) + clip_w, y + 28, Color(255, 255, 255))
		end
	end
end

local x = 20
local y = 20
local w = 300
local h = 130

function deso.hud.Agenda()
	if (LocalPlayer():isCP()) then
		local agendaText = LocalPlayer():getDarkRPVar("agenda")

		if (agendaText && agendaText != "") then
			agendaText = DarkRP.textWrap(agendaText, "deso_hud", w)

			surface.SetDrawColor(deso.col.light)
			surface.DrawRect(x, y, w, h)

			surface.SetDrawColor(deso.col.dark)
			surface.DrawRect(x, y, w, 30)

			surface.SetDrawColor(deso.col.outline)
			surface.DrawLine(x, y + 30, x + w, y + 30)
			surface.DrawOutlinedRect(x, y, w, h)

			draw.SimpleTextOutlined("Police Agenda", "deso_hud_bold", x + (p * 2), y + 5, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, deso.col.outline)
			draw.DrawText(agendaText, "deso_hud", x + p, y + 30 + 5, Color(255, 255, 255))
		end
	end
end

local w = 60
local h = 60
local x = (scrW / 2) - 300 - w - p
local y = scrH - 70

function deso.hud.Sprint()
	if (LocalPlayer():KeyDown(IN_SPEED)) then
		surface.SetMaterial(sprint)
		surface.SetDrawColor(255, 255, 255)
		surface.DrawTexturedRect(x, y, w, h)
	end
end

function deso.hud.OverHead()
	for _, ent in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 200)) do
		if (ent:IsPlayer() && ent != LocalPlayer()) then
			local nick = ent:Nick()
			local pos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1"))
			local ang = EyeAngles()

			pos = pos + Vector(0, 0, 15)

			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), -90)

			cam.Start3D2D(pos + ang:Up() * 6 + ang:Forward() * -1, ang, 0.05)
				draw.SimpleTextOutlined(nick, "deso_hud_clip", 25, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(0, 0, 0))
			
				surface.SetMaterial(circle)
				surface.SetDrawColor(255, 255, 255)
				surface.DrawTexturedRect(0, 50, 50, 50)
			cam.End3D2D()
		end
	end
end