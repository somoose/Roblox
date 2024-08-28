function DrawPart (A, B, Thickness)
	Thickness = Thickness or 0.1
	local Difference = B - A
	
	local Part = Instance.new("Part", workspace)
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.Size = Vector3.new(Thickness, Thickness, Difference.Magnitude)
	Part.CFrame = CFrame.new(A + Difference/2, B)
	
	return Part
end
