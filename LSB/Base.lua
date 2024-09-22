local t = time()

local BASE = {}
BASE.__index = BASE

BASE.LockedProperties = {
	Name = "LockedBase",
	Anchored = true,
	CanCollide = true,
	CastShadow = true,
	Locked = true,
	Shape = Enum.PartType.Block,
	Material = Enum.Material.Plastic,
	Color = Color3.fromRGB(100, 100, 100),
	Size = Vector3.new(512, 50, 512),
	Position = Vector3.new(math.sin(time()) * math.random(10000, 100000), 0, math.random(10000, 100000))
}

function BASE:new ()
	local i = 0
	local self = setmetatable({}, BASE)

	local function NewPart ()
		local Part = Instance.new("Part", workspace)

		for Property, Value in pairs(self.LockedProperties) do
			Part[Property] = Value
			Part:GetPropertyChangedSignal(Property):Connect(function()
				Part[Property] = Value
			end)
		end

		Part:GetPropertyChangedSignal("Parent"):Connect(function()
			if Part.Parent ~= workspace then
				i = i + 1
				self.LockedProperties.Name = "LockedBase" .. i
				Part:Destroy()
				self.Part = NewPart()
			end
		end)

		return Part
	end

	self.Part = NewPart()
	return self
end

function BASE:Bring (...)
	for _, Character in pairs({...}) do
		Character:PivotTo(self.Part.CFrame * CFrame.new(0, self.Part.Size.Y, 0))
	end
end

local Base = BASE:new()
Base:Bring(owner.Character)
