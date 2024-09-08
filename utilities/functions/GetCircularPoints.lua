function GetCircularPoints (Radius, Segments)
	local Points = {}
	
	local AngleStep = 2 * math.pi / Segments
	-- The angle between each segment.
	
	for i = 1, Segments do
		Points[i] = Vector3.new(math.sin(i * AngleStep) * Radius, 0, math.cos(i * AngleStep) * Radius)
	end
	
	return Points
end
