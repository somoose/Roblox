for _, Part in pairs(owner.Character:GetDescendants()) do
	if Part:IsA("BasePart") then
		Part.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 4, 1)
	end
end
