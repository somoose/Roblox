local function GetCurve (Frequency, Intensity)
	return math.sin(os.clock() * Frequency) * Intensity
end
