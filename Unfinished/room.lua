local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local ROOM = {}
ROOM.__index = ROOM
function ROOM:new (Player, Size)
	local LockedProperties = {
		Anchored = true,
		CanCollide = false,
		CastShadow = false,
		Locked = false,
		Shape = Enum.PartType.Ball,
		Material = Enum.Material.ForceField,
		Color = BrickColor.new("Black").Color,
		Transparency = 0.75,
		Reflectance = 100,
		--Size = Vector3.one * Size
	}
	
	local self = setmetatable({}, ROOM)

	self.Player = Player
	self.Size = Size
	self.LockedToPlayer = true
	
    self.Part = Instance.new("Part", script)
    self.Part.Size = Vector3.one

    Player.Chatted:Connect(function(Message)
		if Message:sub(1, 3) ~= "/e " then return end
		Message = Message:sub(4, #Message)
		local Sections = Message:split("/")
		if Sections[1] == "er" then
			if Sections[2] == "l" then
				self.LockedToPlayer = not self.LockedToPlayer
			elseif Sections[2] == "s" then
				self:ChangeSize(tonumber(Sections[3]))
			end
		end
    end)
    
    for Property, Value in pairs(LockedProperties) do
		if Property == "Size" then continue end
		self.Part[Property] = Value
		self.Part:GetPropertyChangedSignal(Property):Connect(function()
			self.Part[Property] = Value
		end)
    end

    local SizeTween = TweenService:Create(self.Part, TweenInfo.new(1), {Size = Vector3.one * Size})
    SizeTween:Play()

    task.spawn(function()
		task.wait(SizeTween.TweenInfo.Time)

		self.Part.Changed:Connect(function(Property)
			if Property == "CFrame" or Property == "Position" or Property == "Orientation" or Property == "Rotation" or Property == "AssemblyCenterOfMass" or Property == "Mass" or Property == "AssemblyMass" then return end
			
			if LockedProperties[Property] then
				self.Part[Property] = LockedProperties[Property]
			end
		end)
    end)
	
    RunService.PostSimulation:Connect(function()
		if self.LockedToPlayer then
			local RootPart = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character:FindFirstChild("Torso") or Player.Character:FindFirstChild("UpperTorso") or Player.Character:FindFirstChild("Head")
			self.Part.Position = RootPart.Position
		end
    end)

    return self
end
function ROOM:ChangeSize (Size)
	self.Size = Size
	local SizeTween = TweenService:Create(self.Part, TweenInfo.new(1), {Size = Vector3.one * Size})
	SizeTween:Play()
end
function ROOM:GetParts ()
	local Base = workspace:FindFirstChild("Base")
	local SpawnLocation = Base and Base:FindFirstChildWhichIsA("SpawnLocation") or nil

	local OverlapParams = OverlapParams.new()
	OverlapParams.FilterType = Enum.RaycastFilterType.Blacklist
	OverlapParams.FilterDescendantsInstances = {self.Part, self.Player.Character, Base, SpawnLocation}
	OverlapParams.BruteForceAllSlow = true
	
	local Parts = workspace:GetPartBoundsInRadius(self.Part.Position, self.Size/2, OverlapParams)
	return Parts
end

-- Make character undetectable by touched events and queries (that don't use BruteForceAllSlow)
local function DisableQueryAndTouch (Character)
	for _, BasePart in pairs(owner.Character:GetDescendants()) do
		if not BasePart:IsA("BasePart") then continue end
		BasePart.CanTouch = false
		BasePart.CanQuery = false
	end
end
DisableQueryAndTouch(owner.Character)
owner.CharacterAdded:Connect(DisableQueryAndTouch)

local Room = ROOM:new(owner, 25)

local function GetAllChildrenWhichAre (Instance, ClassName, Recursive)
	local ChildrenWhichAre = {}
	for _, Descendant in pairs(Instance:GetDescendants()) do
		if Descendant:IsA(ClassName) then
			table.insert(ChildrenWhichAre, Descendant)
		end
	end
	return ChildrenWhichAre
end

while task.wait() do
	local Parts = Room:GetParts()
	for _, Part in pairs(Parts) do
		Part:Destroy()
	end
end
