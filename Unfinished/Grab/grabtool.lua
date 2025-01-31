local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "Grab"
Tool.RequiresHandle = false
local Handle = Instance.new("Part")
Handle.Name = "Handle"
Handle.Size = Vector3.zero
local GrabRemote = Instance.new("RemoteEvent", Tool)
GrabRemote.Name = "GrabRemoteEvent"

local Part0 = Instance.new("Part", workspace)
Part0.Name = "BeamPart0Server"
Part0.CanCollide = false
Part0.CanTouch = false
Part0.CanQuery = false
Part0.Transparency = 1
Part0.Size = Vector3.one
Part0:SetNetworkOwner(owner)
Part0.Anchored = false
Part0.Parent = Tool

local AlignPositionAttachment0 = Instance.new("Attachment", Part0)
local AlignPosition = Instance.new("AlignPosition", Part0)
AlignPosition.Attachment0 = AlignPositionAttachment0
AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
AlignPosition.RigidityEnabled = true
AlignPosition.MaxForce = math.huge
AlignPosition.Responsiveness = 100

local Attachment1 = Instance.new("Attachment", Part0)
Attachment1.Name = "BeamAttachment1Server"
Attachment1.Visible = true
local Beam = Instance.new("Beam", Part0)
Beam.Attachment0 = owner.Character:FindFirstChild("RightGripAttachment", true)
Beam.Attachment1 = Attachment1
Beam.FaceCamera = false
Beam.Width0 = 0.5
Beam.Width1 = 0.5
Beam.TextureMode = Enum.TextureMode.Wrap
Beam.Texture = "http://www.roblox.com/asset/?id=277037193"
Beam.TextureLength = 2
Beam.TextureSpeed = 1.5
Beam.Brightness = 3
Beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))

local PreviousCache = {
	Item = nil,
	NetworkOwner = {},
	Properties = {}
}
local NewProperties = { -- These properties will be applied to Items when they're picked up.
	CustomPhysicalProperties = function (Item)
		if Item:IsA("BasePart") then return PhysicalProperties.new(0.5, 50, 0) end
		local Parts = {}
		for _, BasePart in pairs(Item:GetDescendants()) do
			if BasePart:IsA("BasePart") then
				table.insert(Parts, BasePart)
			end
		end
		return PhysicalProperties.new(1 / (#Parts == 1 and 10 or #Parts), 50, 0)
	end
}
GrabRemote.OnServerEvent:Connect(function(Player, Item, Attachment1Offset)
	Attachment1.Parent = Item
	Attachment1.Position = Attachment1Offset or Vector3.zero
	if Item then
		Handle.Parent = Tool
		local Model = Item:FindFirstAncestorOfClass("Model")
		if Model then
			PreviousCache.Item = Model
			local Parts = {}
			for _, BasePart in pairs(Model:GetDescendants()) do
				if BasePart:IsA("BasePart") then
					table.insert(Parts, BasePart)
					PreviousCache.NetworkOwner[BasePart] = BasePart:GetNetworkOwner() -- Don't set network owner in the same loop you use to fetch
					-- and store the previous network owners. Once you set yourself as the owner of one part, it transfers over to other parts.
					for Property, Value in pairs(NewProperties) do
						if not PreviousCache.Properties[BasePart] then PreviousCache.Properties[BasePart] = {} end
						PreviousCache.Properties[BasePart][Property] = BasePart[Property]
						BasePart[Property] = (type(Value) == "function" and Value(Model) or Value)
					end
				elseif BasePart:IsA("Humanoid") then
					BasePart.Sit = true
				end
			end
			for _, BasePart in pairs(Parts) do
				BasePart:SetNetworkOwner(Player)
			end
		else
			PreviousCache.Item = Item
			PreviousCache.NetworkOwner[Item] = Item
			Item:SetNetworkOwner(Player)
			for Property, Value in pairs(NewProperties) do
				PreviousCache.Properties[Property] = Item[Property]
				Item[Property] = (type(Value) == "function" and Value(Item) or Value)
			end
		end
	else
		Handle.Parent = nil
		if PreviousCache.Item:IsA("Model") then
			for BasePart, Owner in pairs(PreviousCache.NetworkOwner) do
				BasePart:SetNetworkOwner(Owner)
			end
			for BasePart, t in pairs(PreviousCache.Properties) do
				for Property, Value in pairs(t) do
					BasePart[Property] = Value
				end
			end
		else
			PreviousCache.Item:SetNetworkOwner(PreviousCache.NetworkOwner[PreviousCache.Item])
			for Property, Value in pairs(PreviousCache.Properties) do
				PreviousCache.Item[Property] = Value
			end
		end
		PreviousCache.NetworkOwner = {}
		PreviousCache.Properties = {}
	end
end)

local function Lerp (a, b, t) return a + (b - a) * t end

local function UpdateBeam ()
	local Position = Part0.Position
	local Distance = (Attachment1.WorldPosition - Position).Magnitude
	local LocalDirection = Part0.CFrame:PointToObjectSpace(Attachment1.WorldPosition)
	if LocalDirection.X < 0 then -- Left
		Beam.CurveSize0 = -Distance--Lerp(Beam.CurveSize1, -Distance, 0.1)
	else -- Right
		Beam.CurveSize0 = Distance--Lerp(Beam.CurveSize1, Distance, 0.1)
	end
end

--[[task.spawn(function()
	while task.wait() do
		UpdateBeam()
	end
end)]]

NLS([[
local Mouse = owner:GetMouse()
local Camera = workspace.CurrentCamera

local Tool = script.Parent
local GrabRemote = Tool.GrabRemoteEvent
local BeamPart0Server = Tool.BeamPart0Server
BeamPart0Server.Anchored = true
local BeamPartAlignPosition = BeamPart0Server:FindFirstChildOfClass("AlignPosition")
local BeamAttachment1 = BeamPart0Server.BeamAttachment1Server

local Attachment0 = Instance.new("Attachment")
local AlignPosition = Instance.new("AlignPosition")
local AlignOrientation = Instance.new("AlignOrientation")
Attachment0.Visible = true
AlignPosition.Attachment0 = Attachment0
AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
AlignPosition.ApplyAtCenterOfMass = false
AlignPosition.RigidityEnabled = false
AlignPosition.Responsiveness = 40 -- Use responsiveness if you want velocity to continue once the BodyMover is removed from the Item.
AlignOrientation.Attachment0 = Attachment0
AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
AlignOrientation.RigidityEnabled = true
AlignOrientation.Responsiveness = 40

local Cache = {}
Cache.ToolActivated = false
Cache.HoldDistance = 0
Cache.Item = nil
Cache.FirstMousePosition = nil

local function ParentBodyMovers (Parent)
	Attachment0.Parent = Parent
	AlignPosition.Parent = Parent
	AlignPosition.Attachment0 = Attachment0 -- Reset the Attachment0 property so that ApplyAtCenterOfMass updates to the new position.
	AlignOrientation.Parent = Parent
	AlignOrientation.Attachment0 = Attachment0
end
local function GetGrabPosition ()
	local Direction = (Mouse.Hit.Position - owner.Character.Head.Position).Unit
	return owner.Character.Head.Position + Direction * Cache.HoldDistance
	--return owner.Character.Head.Position + Camera.CFrame.LookVector * Cache.HoldDistance
end

local function Pickup ()
	Attachment0.Position = Cache.Item.CFrame:PointToObjectSpace(Cache.FirstMousePosition)
	BeamPart0Server.Anchored = false
	GrabRemote:FireServer(Cache.Item, Attachment0.Position)
	ParentBodyMovers(Cache.Item)
end
local function Hold ()
	local GrabPosition = GetGrabPosition()
	AlignPosition.Position = GrabPosition
	AlignOrientation.CFrame = Camera.CFrame * Cache.OriginalCFrameOffset
	BeamPart0Server.Anchored = false
	BeamPartAlignPosition.Position = GrabPosition
	BeamPart0Server.Position = GrabPosition
end
local function Drop ()
	BeamPart0Server.Position = Vector3.zero
	BeamPart0Server.Anchored = true
	GrabRemote:FireServer()
	ParentBodyMovers(nil)
	Cache.Item = nil
end

local function Activate ()
	if Cache.ToolActivated then -- Drop.
		Cache.ToolActivated = false
		BeamAttachment1.Parent = nil
		Drop()
	else -- Pick up.
		Cache.ToolActivated = true
		local Target = Mouse.Target
		if Target then
			if not Target:IsA("BasePart") then return end
			if Target.Anchored then return end
			Cache.Item = Target
			Cache.FirstMousePosition = Mouse.Hit.Position
			Cache.HoldDistance = (Cache.FirstMousePosition - owner.Character.Head.Position).Magnitude
			Cache.OriginalCFrameOffset = Camera.CFrame:ToObjectSpace(Cache.Item.CFrame)
			BeamAttachment1.Parent = nil
			BeamAttachment1.Position = Cache.Item.CFrame:PointToObjectSpace(Cache.FirstMousePosition)
			Pickup()
			repeat
				Hold()
				task.wait()
			until not Cache.ToolActivated
		end
	end
end
local function Deactivate ()
	Cache.ToolActivated = false
	if Cache.Item then
		Drop()
	end
end
Tool.Activated:Connect(Activate)
Tool.Unequipped:Connect(Deactivate)
]], Tool)
