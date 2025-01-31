local CastleAssets = LoadAssets(87516819941842)

local function PositionInFront (Model)
	local ModelSize = Model:GetExtentsSize()
	local CharacterSize = owner.Character:GetExtentsSize()
	Model:PivotTo(owner.Character:GetPivot() * CFrame.new(0, ModelSize.Y/2 - CharacterSize.Y/2, -ModelSize.Z/2))
end

local function AnchorModel (Model)
	for _, BasePart in pairs(Model:GetDescendants()) do
		if BasePart:IsA("BasePart") then
			BasePart.Anchored = true
		end
	end
end

local Castle = CastleAssets:Get("Castle")
AnchorModel(Castle)
Castle:ScaleTo(0.25)
Castle.Parent = script
PositionInFront(Castle)
