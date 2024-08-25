function DrawPart (A, B, Thickness)
	Thickness = Thickness or 0.1
	
	local Difference = B - A
	local MidPoint = (A + B) / 2
	
	local Part = Instance.new("Part", workspace)
	Part.Size = Vector3.new(Thickness, Thickness, Difference.Magnitude)
	Part.CFrame = CFrame.new(MidPoint, B)
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	
	return Part
end
