local smoothHealth, smoothArmor = 0, 0

function deso.hud.CalcHPWidth(width, value)
	local max, num = 100

	if (value > 100) then
		max = 200
		value = 200
	else
		value = 100
	end

	num = width / max

	return width - math.Clamp(value * num, 0, width)
end

function deso.hud.CalcHPWidthLerp(width, value)
	local max, num = 100

	if (value > 100) then
		max = 200
	end

	num = width / max
	
	if (value != smoothHealth) then
		smoothHealth = Lerp(10 * FrameTime(), smoothHealth, value)
	end

	return width - math.Clamp(math.Round(smoothHealth * num), 0, width)
end

function deso.hud.CalcArmorWidth(width, value)
	local max, num = 100

	if (value > 100) then
		max = 200
	elseif (value > 200) then
		max = 255
	end

	num = width / max
	
	if (value != smoothArmor) then
		smoothArmor = Lerp(10 * FrameTime(), smoothArmor, value)
	end

	return math.Clamp(math.Round(smoothArmor * num), 0, width)
end