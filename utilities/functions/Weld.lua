function Weld (Part0, Part1)
	local Weld = Instance.new("Weld", Part0)
	Weld.C0 = Part0.CFrame:Inverse() * Part1.CFrame
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	
	return Weld
end
