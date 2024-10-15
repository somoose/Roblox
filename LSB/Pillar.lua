local function PositionInFrontOfCharacter (Object, Character)
	local CharacterPivot = Character:GetPivot()
	local CharacterSize = Character:GetExtentsSize()
	Object:PivotTo(CharacterPivot * CFrame.new(0, Object.Size.Y/2 - CharacterSize.Y/2, -Object.Size.Z/2))
end
local OPillar = game.InsertService:CreateMeshPartAsync("rbxassetid://9769344464", Enum.CollisionFidelity.PreciseConvexDecomposition, Enum.RenderFidelity.Automatic)
OPillar.Anchored = false
OPillar.Material = Enum.Material.Concrete
OPillar.Color = Color3.fromRGB(120, 120, 120)
OPillar.CustomPhysicalProperties = PhysicalProperties.new(1e100, 1e100, 0)
local function MakePillar (Parent)
	local Clone = OPillar:Clone()
	Clone.Parent = Parent
	return Clone
end

local Pillar = MakePillar(script)
PositionInFrontOfCharacter(Pillar, owner.Character)
