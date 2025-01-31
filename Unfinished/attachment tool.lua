local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local MouseModuleStringValue = Instance.new("StringValue", owner.PlayerGui)
MouseModuleStringValue.Name = "MouseModuleStringValue"
MouseModuleStringValue.Value = HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/utilities/modules/Mouse.lua")

local function HasProperty (Instance, Property)
	local s = pcall(function()
		return Instance[Property]
	end)
	return s
end

-- In order to get the local offset for an attachment to reach a specified world position use the following function:
-- Offset = ObjectCFrame:PointToObjectSpace(WorldPosition)

local CONSTRAINTS = {
	ClassName = "RopeConstraint",
	AttachmentsVisible = false,
	ConstraintsVisible = true
}
function CONSTRAINTS.new (ClassName, Part0, Part1, Offset0, Offset1, Properties)
	local Attachment0 = Instance.new("Attachment", Part0)
	local Attachment1 = Instance.new("Attachment", Part1) 
	Attachment0.Visible = CONSTRAINTS.AttachmentsVisible
	Attachment0.Position = Offset0
	Attachment1.Visible = CONSTRAINTS.AttachmentsVisible
	Attachment1.Position = Offset1
	
	local Constraint = Instance.new(ClassName, Part0)
	Constraint.Attachment0 = Attachment0
	Constraint.Attachment1 = Attachment1
	Constraint.Visible = CONSTRAINTS.ConstraintsVisible

	for Property, Value in pairs(Properties) do
		if HasProperty(Constraint, Property) then
			Constraint[Property] = Value
		end
	end

	return Constraint
end

owner.Chatted:Connect(function(msg)
	if msg:sub(1, 1) == ":" then
		CONSTRAINTS.ClassName = msg:sub(2, #msg)
	end
end)

local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "Attachment"

local Handle = Instance.new("Part", Tool)
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Transparency = 1

local HandleAttachment = Instance.new("Attachment", Handle)
HandleAttachment.Visible = true

local ClickRemoteEvent = Instance.new("RemoteEvent", Tool)
ClickRemoteEvent.Name = "ClickRemoteEvent"
ClickRemoteEvent.OnServerEvent:Connect(function(_, ButtonDown, ButtonUp, Properties)
	CONSTRAINTS.new(
		CONSTRAINTS.ClassName,
		ButtonDown.Instance,
		ButtonUp.Instance,
		ButtonDown.MouseOffset,
		ButtonUp.MouseOffset,
		Properties
	)
end)

local ChangeModeEvent = Instance.new("RemoteEvent", Tool)
ChangeModeEvent.Name = "ChangeModeEvent"
ChangeModeEvent.OnServerEvent:Connect(function(_, ClassName)
	CONSTRAINTS.ClassName = ClassName
end)

NLS([[
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Mouse = loadstring(Player.PlayerGui.MouseModuleStringValue.Value)()
Mouse:ClearFilterList()

local Tool = script.Parent
local ClickRemoteEvent = Tool.ClickRemoteEvent
local ChangeModeEvent = Tool.ChangeModeEvent

local GhostAttachment0 = Instance.new("Part")
local GhostAttachment1 = Instance.new("Part")

local GhostConstraint = Instance.new("RopeConstraint", GhostAttachment0)
local GhostConstraintAttachment0 = Instance.new("Attachment", GhostAttachment0)
local GhostConstraintAttachment1 = Instance.new("Attachment", GhostAttachment1)

GhostConstraint.Visible = true
GhostConstraint.Length = 0
GhostConstraint.Attachment0 = GhostConstraintAttachment0
GhostConstraint.Attachment1 = GhostConstraintAttachment1

GhostAttachment0.Anchored = true
GhostAttachment0.CanCollide = false
GhostAttachment0.CanTouch = false
GhostAttachment0.CanQuery = false
GhostAttachment0.Shape = Enum.PartType.Ball
GhostAttachment0.Color = Color3.fromRGB(0, 255, 0)
GhostAttachment0.Size = Vector3.one * 0.25
GhostAttachment0.Transparency = 0

GhostAttachment1.Anchored = true
GhostAttachment1.CanCollide = false
GhostAttachment1.CanTouch = false
GhostAttachment1.CanQuery = false
GhostAttachment1.Shape = Enum.PartType.Ball
GhostAttachment1.Color = Color3.fromRGB(0, 255, 0)
GhostAttachment1.Size = Vector3.one * 0.25
GhostAttachment1.Transparency = 0

local Highlight0 = Instance.new("Highlight", GhostAttachment0)
local Highlight1 = Instance.new("Highlight", GhostAttachment1)
Highlight0.FillTransparency = 1
Highlight0.OutlineTransparency = 0.5
Highlight1.FillTransparency = 1
Highlight1.OutlineTransparency = 0.5

Mouse:AddToFilterList(GhostAttachment0, GhostAttachment1)

local Activated = false
local Equipped = false

local ToolCache = {
	ButtonDown = {
		Instance = nil,
		MouseOffset = nil
	},
	ButtonUp = {
		Instance = nil,
		MouseOffset = nil
	}
}
local function ClearToolCache ()
	table.clear(ToolCache.ButtonDown)
	table.clear(ToolCache.ButtonUp)
end
local function OnEquipped ()
	Equipped = true

	GhostAttachment0.Parent = Tool

	repeat
		local Instance = Mouse.Target

		if Activated then
			
		else
			GhostAttachment0.Position = Mouse.Position
		end
		
		task.wait()
	until not Equipped
end
local function OnUnequipped ()
	Equipped = false

	GhostAttachment0.Parent = nil
	GhostAttachment1.Parent = nil
end
local function OnActivated ()
	Activated = true
	local Instance = Mouse.Target

	GhostAttachment1.Parent = Tool

	if Instance then
		ToolCache.ButtonDown.Instance = Instance
		ToolCache.ButtonDown.MouseOffset = Instance.CFrame:PointToObjectSpace(Mouse.Position)

		repeat
			GhostAttachment1.Position = Mouse.Position
			task.wait()
		until not Activated
	end
end
local function OnDeactivated ()
	Activated = false
	if ToolCache.ButtonDown.Instance then
		local Instance = Mouse.Target

		GhostAttachment1.Parent = nil

		if Instance then
			ToolCache.ButtonUp.Instance = Instance
			ToolCache.ButtonUp.MouseOffset = Instance.CFrame:PointToObjectSpace(Mouse.Position)

			local Position0 = ToolCache.ButtonDown.Instance.Position + ToolCache.ButtonDown.MouseOffset
			local Position1 = ToolCache.ButtonUp.Instance.Position + ToolCache.ButtonUp.MouseOffset

			local Distance = (Position1 - Position0).Magnitude

			ClickRemoteEvent:FireServer(ToolCache.ButtonDown, ToolCache.ButtonUp, {Length = Distance})
		end
	end
end
Tool.Activated:Connect(OnActivated)
Tool.Deactivated:Connect(OnDeactivated)
Tool.Equipped:Connect(OnEquipped)
Tool.Unequipped:Connect(OnUnequipped)
Tool.Unequipped:Connect(ClearToolCache)
]], Tool)
