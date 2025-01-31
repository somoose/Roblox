local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "Build"
Tool.RequiresHandle = false

local PlaceRemote = Instance.new("RemoteEvent", Tool)
PlaceRemote.Name = "PlaceRemote"
PlaceRemote.OnServerEvent:Connect(function(_, ObjectData, Position)
	local Part = Instance.new("Part", script)
	Part.Anchored = true
	for Property, Value in pairs(ObjectData) do
		Part[Property] = Value
	end
	Part.Position = Position
end)

-- Custom mouse module.
local Mouse = Instance.new("StringValue", Tool)
Mouse.Name = "Mouse"
Mouse.Value = game.HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/utilities/modules/Mouse.lua")

NLS([[
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function SnapToGrid (Position, GridScale, GridOffset)
	return Vector3.new(
		math.round((Position.X - GridOffset.X) / GridScale.X) * GridScale.X + GridOffset.X,
		math.round((Position.Y - GridOffset.Y) / GridScale.Y) * GridScale.Y + GridOffset.Y,
		math.round((Position.Z - GridOffset.Z) / GridScale.Z) * GridScale.Z + GridOffset.Z
	)
end

local Tool = script.Parent
local Mouse = loadstring(Tool.Mouse.Value)()
local PlaceRemote = Tool.PlaceRemote

local GhostObject = Instance.new("Part")
GhostObject.CanCollide = false
GhostObject.Anchored = true
GhostObject.Size = Vector3.one * 2
GhostObject.Transparency = 0.5

local function Place (Position)
	PlaceRemote:FireServer({Size = GhostObject.Size, Material = GhostObject.Material, Color = GhostObject.Color}, Position)
end

Mouse:AddToFilterList(GhostObject)

local CurrentSnappedMousePosition
local Equipped = false

local function ToolEquipped ()
	GhostObject.Parent = owner.Character
	Equipped = true
end
local function ToolUnequipped ()
	GhostObject.Parent = nil
	Equipped = false
end

Tool.Equipped:Connect(ToolEquipped)
Tool.Unequipped:Connect(ToolUnequipped)

RunService.PostSimulation:Connect(function()
	if Equipped and GhostObject.Parent ~= nil then
		local GridScale = Vector3.one
		local GridOffset = Vector3.zero
		local Position = SnapToGrid(Mouse.Position, GridScale, GridOffset)
		GhostObject.Position = GhostObject.Position:Lerp(Position, 0.5)
		CurrentSnappedMousePosition = Position
	end
end)

UserInputService.InputBegan:Connect(function(Input, GPE)
	if not Equipped then return end
	if GPE then return end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Place(CurrentSnappedMousePosition)
	end
end)
]], Tool)
