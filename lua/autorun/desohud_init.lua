if (SERVER) then
	deso = deso || {}
	deso.hud = deso.hud || {}
	deso.col = deso.col || {}

	resource.AddFile "materials/deso_hud/sprint.png"

	AddCSLuaFile "deso_hud/client/cl_fonts.lua"
	AddCSLuaFile "deso_hud/client/cl_desohud.lua"
	AddCSLuaFile "deso_hud/client/cl_draw.lua"
	AddCSLuaFile "deso_hud/cl_main.lua"
end

if (CLIENT) then
	deso = deso || {}
	deso.hud = deso.hud || {}
	deso.col = deso.col || {}

	include "deso_hud/client/cl_fonts.lua"
	include "deso_hud/client/cl_desohud.lua"
	include "deso_hud/client/cl_draw.lua"
	include "deso_hud/cl_main.lua"
end