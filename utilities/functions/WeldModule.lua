WeldModule = {}

WeldModule.Weld = function (Part0, Part1)
	local Weld = Instance.new("Weld", Part0)
	Weld.C0 = Part0.CFrame:Inverse() * Part1.CFrame
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	
	return Weld
end

WeldModule.AttachWeld = function (Model)
	local PrimaryPart = Model.PrimaryPart or Model:FindFirstChildWhichIsA("BasePart")
	
	for _, BasePart in pairs(Model:GetDescendants()) do
		if BasePart:IsA("BasePart") and BasePart ~= PrimaryPart then
			WeldModule.Weld(PrimaryPart, BasePart)
		end
	end
end

WeldModule.TouchWeld = function (Model)
	for _, BasePart in pairs(Model:GetDescendants()) do
		if BasePart:IsA("BasePart") then
			local TouchingParts = workspace:GetPartBoundsInBox(BasePart.CFrame, BasePart.Size)
			
			for _, TouchingPart in pairs(TouchingParts) do
				WeldModule.Weld(BasePart, TouchingPart)
			end
		end
	end
end

WeldModule.ProximityWeld = function (Model)
	local UsedParts = {}
	
	for _, BasePart in pairs(Model:GetDescendants()) do
		if BasePart:IsA("BasePart") then
			local ClosestBasePart
			local MinimumDistance = math.huge
			
			for _, BasePart1 in pairs(Model:GetDescendants()) do
				if BasePart1:IsA("BasePart") and BasePart1 ~= BasePart and not table.find(UsedParts, BasePart1) then
					local Distance = (BasePart1.Position - BasePart.Position).Magnitude
					
					if Distance < MinimumDistance then
						MinimumDistance = Distance
						ClosestBasePart = BasePart1
					end
				end
			end
			
			if ClosestBasePart then
				WeldModule.Weld(BasePart, ClosestBasePart)
				UsedParts[ClosestBasePart] = true
			end
		end
	end
end