--[[

	Ideas:
		•
		
		Front Couch
		Floor lamp
		Plants
		Chest (hinge lid)
		Scarecrow
		Pallet
		NPCS (slime, etc.)
		Cookie jar
		Food items
		
		Shift to run
		C to crouch
		
		Inventory GUI / Furniture placement GUI / Building GUI
		
		Redstone / Wiring system.

		Camera bobble
		
		Directional walking animation.
		
		Model Separation: When you remove a part in the middle of a model, split each side of the model into individual models.
		
		Touch Welding: When you pick up a model that is anchored, automatically weld all the touching parts in the model before unanchoring it.
		
		Lerp at a speed of distance.
		
		+ gets more transparent the further your cursor is from it.
		
		GUI TextLabel that scrolls out to the left and the new text scrolls in from the right.
			IsWelding
			Colliding (both modes)
			Mode
			Rotation increment
			Rotation axis
			Grid increment
			Throw velocity
		
		GUI that says the name of the CURRENT_ITEM.
]]


local FUNCTIONS = {}

local CollectionService = game:GetService("CollectionService")
local isHeld_TAG = "__ISHELD__"
local FURN_TAG = "__FURN__"

local GrabRemote = Instance.new("RemoteEvent", owner.PlayerGui) -- Used to pick up and drop items.
GrabRemote.Name = "GrabRemote"

local GetServerScriptRemote = Instance.new("RemoteFunction", owner.PlayerGui)
GetServerScriptRemote.Name = "GetServerScriptRemote"
GetServerScriptRemote.OnServerInvoke = function () return script end

local DeleteRemote = Instance.new("RemoteEvent", owner.PlayerGui)
DeleteRemote.Name = "DeleteRemote"
DeleteRemote.OnServerEvent:Connect(function(_, Item)
	Item:Destroy()
end)

local ChatCommandRemote = Instance.new("RemoteEvent", owner.PlayerGui)
ChatCommandRemote.Name = "ChatCommandRemote"

local PreviousItem = nil
local PreviousNetworkOwners = {}
local PreviousProperties = {}

function CreateUID ()
	return tick() .. "|" .. math.random(100000000, 999999999)
end

local CanCollide = false
local Transparency = 0.5
local HumanoidSit = true

FUNCTIONS.GrabRemoteServerEvent = function (_, Item: Instance, BreakJoints: Boolean, TouchingParts: Array)
	if Item then -- User is picking up Item.
		CollectionService:AddTag(Item, isHeld_TAG)
		
		PreviousItem = Item
		
		if Item:IsA("BasePart") then
			if BreakJoints then
				Item.CanCollide = true
				
				Item:BreakJoints()
				Item.Parent = workspace
			end
			
			PreviousProperties[Item.Name] = {
				Item.CanCollide,
				Item.Transparency,
				Item.Massless
			}
			
			if Item.Anchored then Item.Anchored = false end
			if Item.CanCollide ~= CanCollide then Item.CanCollide = CanCollide end
			if Item.Transparency < Transparency then Item.Transparency = Transparency end
			if not Item.Massless then Item.Massless = true end
			
			if Item:IsA("Seat") or Item:IsA("VehicleSeat") then
				table.insert(PreviousProperties[Item.Name], Item.Disabled)
				if not Item.Disabled then Item.Disabled = true end
			end
			
			PreviousNetworkOwners[Item.Name] = Item:GetNetworkOwner()
			Item:SetNetworkOwner(owner)
		elseif Item:IsA("Model") then
			local Parts = {}
			
			for _, Part in pairs(Item:GetDescendants()) do
				if Part:IsA("BasePart") then table.insert(Parts, Part)
					-- Store Part properties in PreviousProperties
					local UID = CreateUID()
					CollectionService:AddTag(Part, UID)
					
					PreviousProperties[UID] = {
						Part.CanCollide,
						Part.Transparency,
						Part.Massless
					}
					
					if Part.Anchored then Part.Anchored = false end
					if Part.CanCollide ~= CanCollide then Part.CanCollide = CanCollide end
					if Part.Transparency < Transparency then Part.Transparency = Transparency end
					if not Part.Massless then Part.Massless = true end
					
					if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
						table.insert(PreviousProperties[UID], Part.Disabled)
						if not Part.Disabled then Part.Disabled = true end
					end
				elseif Part:IsA("Humanoid") then
					if Part.Sit ~= HumanoidSit then Part.Sit = HumanoidSit end
				end
			end
			
			for _, Part in pairs(Parts) do -- Store original NetworkOwners.
				local NetworkOwner = Part:GetNetworkOwner()
				local UID = CreateUID()
				CollectionService:AddTag(Part, UID)
				
				if NetworkOwner then
					PreviousNetworkOwners[UID] = NetworkOwner
				else
					PreviousNetworkOwners[UID] = "Server"
				end
			end
			
			for _, Part in pairs(Parts) do -- Set NetworkOwner to the user.
				Part:SetNetworkOwner(owner)
			end
		end
	else
		if PreviousItem then -- User is dropping PreviousItem.
			if PreviousItem:IsA("BasePart") then
				if PreviousNetworkOwners[PreviousItem.Name] then
					PreviousItem:SetNetworkOwner(PreviousNetworkOwners[PreviousItem.Name])
				end
				
				if PreviousProperties[PreviousItem.Name] then
					local Properties = PreviousProperties[PreviousItem.Name]
					
					PreviousItem.CanCollide = Properties[1]
					PreviousItem.Transparency = Properties[2]
					PreviousItem.Massless = Properties[3]
					
					if PreviousItem:IsA("Seat") or PreviousItem:IsA("VehicleSeat") then
						PreviousItem.Disabled = Properties[4]
					end
				end
				
				for i, TouchingPart in pairs(TouchingParts) do
					if CollectionService:HasTag(TouchingPart, "__BASE__") then
						PreviousItem.Anchored = true
						
						TouchingParts[i] = nil
						
						break
					end
					
					local Weld = Instance.new("Weld", PreviousItem)
					Weld.C0 = PreviousItem.CFrame:Inverse() * TouchingPart.CFrame
					Weld.Part0 = PreviousItem
					Weld.Part1 = TouchingPart
				end
				
				if #TouchingParts == 1 then
					local Model = TouchingParts[1]:FindFirstAncestorOfClass("Model") or Instance.new("Model", TouchingParts[1].Parent)
					
					TouchingParts[1].Parent = Model
					PreviousItem.Parent = Model
				elseif #TouchingParts == 2 then
					
				end
			elseif PreviousItem:IsA("Model") then
				for _, Part in pairs(PreviousItem:GetDescendants()) do
					if Part:IsA("BasePart") or Part:IsA("Part") then
						local Tags = CollectionService:GetTags(Part)
						
						if Tags then
							for _, Tag in pairs(Tags) do
								if PreviousNetworkOwners[Tag] then
									if typeof(PreviousNetworkOwners[Tag]) == "string" then
										if PreviousNetworkOwners[Tag] == "Server" then
											Part:SetNetworkOwner(nil)
										end
									else
										Part:SetNetworkOwner(PreviousNetworkOwners[Tag])
									end
									
									CollectionService:RemoveTag(Part, Tag)
								end
								
								if PreviousProperties[Tag] then
									local Properties = PreviousProperties[Tag]
									
									Part.CanCollide = Properties[1]
									Part.Transparency = Properties[2]
									Part.Massless = Properties[3]
									
									if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
										Part.Disabled = Properties[4]
									end
									
									CollectionService:RemoveTag(Part, Tag)
								end
							end
						end
					end
				end
			end
			
			table.clear(PreviousNetworkOwners)
			table.clear(PreviousProperties)
			
			CollectionService:RemoveTag(PreviousItem, isHeld_TAG)
		end
	end
end

GrabRemote.OnServerEvent:Connect(FUNCTIONS.GrabRemoteServerEvent)

local ID = 131302043244796
local FURN_ASSETS = LoadAssets(ID)
local ASSET_LIST = FURN_ASSETS:GetArray()

FUNCTIONS.ReturnPlayer = function (Name)
	if not Name then return end
	
	for _, Player in pairs(Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end

FUNCTIONS.ClearAllModels = function ()
	for _, Descendant in pairs(workspace:GetDescendants()) do
		if Descendant:IsA("BasePart") or Descendant:IsA("Model") then
			if CollectionService:HasTag(Descendant, FURN_TAG) then
				Descendant:Destroy()

				task.wait()
			end
		end
	end
end

FUNCTIONS.SpawnFurniture = function (AssetName, Amount, Scale, SeatDisabled)
	Index = Index or ASSET_LIST[math.random(#ASSET_LIST)]
	Amount = tonumber(Amount) or 1
	Scale = tonumber(Scale) or 1
	SeatDisabled = SeatDisabled == "true" and true or false

	local CharacterSize = owner.Character:GetExtentsSize()
	local CharacterPivot = owner.Character:GetPivot()

	for _, ASSET in pairs(ASSET_LIST) do
		if ASSET.Name:lower():sub(1, #AssetName) == AssetName:lower() then
			for i = 1, Amount do
				local Clone = FURN_ASSETS:Get(ASSET.Name)
				CollectionService:AddTag(Clone, FURN_TAG)

				for _, Part in pairs(Clone:GetDescendants()) do
					if Part:IsA("BasePart") then
						Part.Anchored = false
					end
					
					if SeatDisabled then
						if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
							Part.Disabled = true
						end
					end
				end
				
				Clone:ScaleTo(Scale)
				Clone.PrimaryPart = Clone.PrimaryPart or Clone:FindFirstChildWhichIsA("BasePart")

				Clone.Parent = script

				local CloneSize = Clone:GetExtentsSize()
				local PivotDifference = Clone:GetBoundingBox().Position - Clone.PrimaryPart.Position

				Clone.Parent = nil

				local Destination = owner.Character:GetBoundingBox() * CFrame.new(
					0,
					CloneSize.Y/2 - CharacterSize.Y/2 + (i - 1) * CloneSize.Y,
					-(CharacterSize.Z + CloneSize.Z)/2
				) * CFrame.new(-PivotDifference)

				Clone:PivotTo(Destination)

				Clone.Parent = workspace
			end

			print("Spawned: " .. Amount .. " " .. ASSET.Name .. "'s at scale " .. Scale)

			return
		end
	end

	warn("Loop finished without creating anything.")
end

local COMMAND_PREFIX = nil
local COMMAND_SEPARATOR = " "

local COMMANDS = {
	{
		CODE = "bring",
		ARGUMENTS = "player1" .. COMMAND_SEPARATOR .. "player2" .. COMMAND_SEPARATOR .. "...",
		DESCRIPTION = "Brings the parsed players.",
		FUNCTION = function (...)
			local Names = {...}
			
			for _, Name in pairs(Names) do
				local Target = FUNCTIONS.ReturnPlayer(Name)

				if Target then
					if Target.Character then
						Target.Character:PivotTo(owner.Character:GetPivot())
					end
				end
			end
		end
	},
	{
		CODE = "spawn",
		FUNCTION = FUNCTIONS.SpawnFurniture
	},
	{
		CODE = "clear",
		FUNCTION = FUNCTIONS.ClearAllModels
	},
	{
		CODE = "transparency",
		FUNCTION = function (NewTransparency)
			Transparency = tonumber(NewTransparency or 0.5) or 0.5
		end
	},
	{
		CODE = "sit",
		FUNCTION = function (Boolean)
			HumanoidSit = Boolean == "true" and true or false
		end
	},
	{
		CODE = "cancollide",
		FUNCTION = function (Boolean)
			CanCollide = Boolean == "true" and true or false
		end
	},
	{
		CODE = "get",
		FUNCTION = function ()
			print(ASSET_LIST)
		end
	}
}

ChatCommandRemote.OnServerEvent:Connect(function(_, Text)
	if COMMAND_PREFIX then
		if Text:sub(1, 1):lower() ~= COMMAND_PREFIX:lower() then return end
		Text = Text:sub(2, #Text)
	end
	
	local Sections = Text:split(COMMAND_SEPARATOR)
	
	for _, Command in pairs(COMMANDS) do
		if Sections[1]:lower() == Command.CODE:lower() then
			table.remove(Sections, 1)
			Command.FUNCTION(table.unpack(Sections))
		end
	end
end)

NLS([[
local GUI = {}
local FUNCTIONS = {}
local COMMANDS = nil -- Only client sided commands. Server sided commands are above.

local COMMAND_PREFIX = nil
local COMMAND_SEPARATOR = " "


-- Services
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

local BlacklistedTags = {
	ISHELD_TAG = "__ISHELD__", -- The CollectionService tag applied to items when they're picked up.
	BASE_TAG = "__BASE__",
	SPAWN_TAG = "__SPAWNLOCATION__"
}

local Base = workspace:FindFirstChild("Base")

if Base then
	CollectionService:AddTag(Base, BlacklistedTags.BASE_TAG)
	
	local SpawnLocation = Base:FindFirstChildWhichIsA("SpawnLocation")
	
	if SpawnLocation then
		CollectionService:AddTag(SpawnLocation, BlacklistedTags.SPAWN_TAG)
	end
end

local FilterDescendantsInstances = {owner.Character} -- The instances that the hold distance raycast ignores.					(ARRAY)
local RAYCASTPARAMS = RaycastParams.new() --																					(RAYCASTPARAMS)
RAYCASTPARAMS.FilterType = Enum.RaycastFilterType.Blacklist


local Camera = workspace.CurrentCamera
local PlayerGui = owner.PlayerGui
local Mouse = owner:GetMouse()


-- Remotes
local GrabRemote = PlayerGui:WaitForChild("GrabRemote") -- Used to pick up an item.
local GetServerScriptRemote = PlayerGui:WaitForChild("GetServerScriptRemote")
local DeleteRemote = PlayerGui:WaitForChild("DeleteRemote")
local ChatCommandRemote = PlayerGui:WaitForChild("ChatCommandRemote")

local ServerScript = GetServerScriptRemote:InvokeServer()



local TARGET = nil -- Current item at the mouse.									 											(INSTANCE)
local CURRENT_ITEM = nil -- Current item being held. 																			(INSTANCE)

local HOLDING = false -- True when the user is holding an item.																	(BOOLEAN)
local DROPPING = false -- True when the user is in the process of dropping something.											(BOOLEAN)

local THROWING_ENABLED = false -- When true, holding E before releasing it in order to drop an item, will give it velocity.		(STRING)
local COLLISION_ENABLED = true -- When true, the CURRENT_ITEM will be prevented from clipping into objects.						(BOOLEAN)
local WELDING_ENABLED = true -- When true, user is able to weld CURRENT_ITEM to other items.									(BOOLEAN)
local TOUCHING = false -- True when the CURRENT_ITEM is touching other parts.													(BOOLEAN)
local TOUCHING_PARTS = {} -- The parts of CURRENT_ITEM and the parts they're in contact with.									(ARRAY)

local MUST_BE_UNLOCKED = false -- If true, you can only pick up unlocked items.													(BOOLEAN)
local MUST_BE_IN_RANGE = true -- If true, you can only pick up items less than or equal to MAXIMUM_GRAB_DISTANCE away.			(BOOLEAN)
local MAXIMUM_GRAB_DISTANCE = 30 -- The max distance away from which an item can be picked up. 									(NUMBER)

local MOVE_LERP_RANGE = NumberRange.new(0.25, 0.3)
local HOLD_DISTANCE = 5 -- The distance the item is away from the user when they are holding it. 								(NUMBER)
local HOLD_DISTANCE_INCREMENT = 0.5 -- The increment at which the HOLD_DISTANCE increases and decreases. 						(NUMBER)
local MAXIMUM_HOLD_DISTANCE = 25 -- The furthest CURRENT_ITEM can be held from the user. 										(NUMBER)
local MINIMUM_HOLD_DISTANCE = 2 -- The closest CURRENT_ITEM can be held to the user. 											(NUMBER)
local RAYCAST_HOLD_DISTANCE = 0 -- The max distance an object can be held from the user without clipping into objects.			(NUMBER)

local AXIS = "Y" -- The orientation axis being edited. 																			(STRING)
local ORIENTATION = CFrame.new() -- The orientation of the item being held. 													(ARRAY)
local ROTATION_INCREMENT_15 = math.rad(15) --																					(NUMBER)
local ROTATION_INCREMENT_45 = math.rad(45) --																					(NUMBER)
local ROTATION_INCREMENT_90 = math.rad(90) --																					(NUMBER)
local ORIENTATION_INCREMENT = ROTATION_INCREMENT_45 -- The increment that the Orientation value increases at. 					(NUMBER)

local THROW_FORCE = 0 -- The force (velocity) used to throw the CURRENT_ITEM when dropped.										(NUMBER)
local THROW_FORCE_INCREMENT = 10 -- The amount that THROW_FORCE increases by.													(NUMBER)
local MAX_THROW_FORCE = 60 -- The max force that can be used to throw the item.													(NUMBER)

local MOVE_MODE = "Camera" --																									(STRING)
local MOVE_MODES = { --																											(ARRAY)
	["Camera"] = nil, --																										(FUNCTION)
	["Mouse"] = nil --																											(FUNCTION)
}

--		Input KeyCodes
local PICKUP_INPUT = Enum.KeyCode.E --																							(ENUM)
local ROTATE_INPUT = Enum.KeyCode.R --																							(ENUM)
local INCREASEDISTANCE_INPUT = Enum.KeyCode.Five --																				(ENUM)
local DECREASEDISTANCE_INPUT = Enum.KeyCode.Four --																				(ENUM)
local CHANGE_CAMERAMODE_INPUT = Enum.KeyCode.C --																				(ENUM)
local CHANGE_MODE_INPUT = Enum.KeyCode.Q --																						(ENUM)
local DELETE_INPUT = Enum.KeyCode.X --																							(ENUM)
local ZOOM_INPUT = Enum.KeyCode.Z --																								(ENUM)

--		Keys Down Variables
local PICKUP_INPUT_DOWN = false -- True when the pickup input is held down. 													(BOOLEAN)
local CTRL_DOWN = false -- True when the left control button is held down. 														(BOOLEAN)
local SHIFT_DOWN = false -- True when the left shift button is held down. 														(BOOLEAN)
local ALT_DOWN = false -- True when the left alt button is held down.															(BOOLEAN)
local ROTATE_INPUT_DOWN = false -- True when the rotate input is held down.

local PICKUP_INPUTOBJECT = {UserInputType = Enum.UserInputType.Keyboard, KeyCode = PICKUP_INPUT} --	PICKUP Input emulation.		(ARRAY)
local FIRST_INPUT_TARGET = nil -- The first TARGET detected when the E key is pressed. 											(INSTANCE)

-- 		GUI Variables
local PICKUP_HOLD = 0.1 -- The amount of time in seconds it takes GUI.Progress.Value to reach 360. 								(NUMBER)
local GRAB_CARET_SPEED = 0.5 -- The speed GUI.GrabCaret lerps at. 																(NUMBER)
local PICKUP_TWEEN = nil -- The tween used to lerp the GUI.PROGRESS value. Updates with a new Tween on every E InputBegan. 		(INSTANCE)
local CLEAR_TEXT_ON_FOCUS = true

-- 		Event Functions
FUNCTIONS.PICKUP = nil -- The function run when an item is picked up.															(FUNCTION)
FUNCTIONS.HOLDING = nil -- The function run while an item is being held.														(FUNCTION)
FUNCTIONS.DROP = nil -- The function run when an item is dropped.																(FUNCTION)

FUNCTIONS.ReturnPlayer = nil -- Returns the player whose name is closest to the parsed string.
FUNCTIONS.ReturnPrimaryPart = nil -- Returns the PrimaryPart of a Model.														(FUNCTION)
FUNCTIONS.UpdateTarget = nil -- Updates the TARGET variable.																	(FUNCTION)
FUNCTIONS.UpdateRaycastHoldDistance = nil -- Updates RAYCASTHOLD_DISTANCE														(FUNCTION)
FUNCTIONS.FitsCriteria = nil --	Returns true if the parsed item fits pick up criteria.											(FUNCTION)
FUNCTIONS.EditFilterDescendantsInstances = nil -- Adds and removes items to the RAYCASTPARAMS.FilterDescendantsInstances		(FUNCTION)
FUNCTIONS.ParentBodyMovers = nil --	Parents the BodyMovers to the item parsed to it.											(FUNCTION)
--FUNCTIONS.GetModelMass = nil


--		Audios
local ScrollWheelClickSound = Instance.new("Sound", owner.PlayerGui) --															(SOUND)
ScrollWheelClickSound.Name = "ScrollWheelClick"
ScrollWheelClickSound.SoundId = "rbxassetid://9121005567"
ScrollWheelClickSound.PlaybackSpeed = 1
ScrollWheelClickSound.Volume = 2.25

local RotateSound = Instance.new("Sound", owner.PlayerGui) --																	(SOUND)
RotateSound.Name = "Rotate"
RotateSound.SoundId = "rbxassetid://9114067301"
RotateSound.PlaybackSpeed = 1.5
RotateSound.Volume = 0.75


local HighlightColorWhite = { --																								(ARRAY)
	FillColor = Color3.fromRGB(100, 100, 100),
	OutlineColor = Color3.fromRGB(255, 255, 255)
}
local HighlightColorRed = { --																									(ARRAY)
	FillColor = Color3.fromRGB(255, 0, 0),
	OutlineColor = Color3.fromRGB(200, 0, 0)
}


local Highlight = Instance.new("Highlight", ServerScript)
Highlight.FillTransparency = 0.8
Highlight.OutlineTransparency = 0.25
Highlight.FillColor = HighlightColorWhite.FillColor
Highlight.OutlineColor = HighlightColorWhite.OutlineColor

local SelectionBox = Instance.new("SelectionBox", owner.Character)
SelectionBox.LineThickness = 0.01
SelectionBox.Transparency = 0.75
SelectionBox.Color3 = Color3.fromRGB(0, 200, 0)
SelectionBox.Transparency = 0.5

local Attachment0 = Instance.new("Attachment")
local AlignPosition = Instance.new("AlignPosition")
local AlignOrientation = Instance.new("AlignOrientation")

AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
AlignPosition.Attachment0 = Attachment0
AlignPosition.RigidityEnabled = true
AlignPosition.MaxForce = Vector3.one * math.huge
AlignPosition.Responsiveness = Vector3.one * math.huge

AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
AlignOrientation.Attachment0 = Attachment0
AlignOrientation.RigidityEnabled = true
AlignOrientation.MaxTorque = Vector3.one * math.huge
AlignOrientation.Responsiveness = Vector3.one * math.huge

local SparkParticlePart = Instance.new("Part")
SparkParticlePart.Size = Vector3.zero
SparkParticlePart.Transparency = 1
SparkParticlePart.Anchored = true
SparkParticlePart.CanCollide = false
SparkParticlePart.CanQuery = false

local SparkParticleAttachment = Instance.new("Attachment", SparkParticlePart)

local SparkParticleEmitter = Instance.new("ParticleEmitter", SparkParticleAttachment)
SparkParticleEmitter.Name = "SparkParticleEmitter"
SparkParticleEmitter.Texture = "http://www.roblox.com/asset/?id=7587238412"
SparkParticleEmitter.Enabled = false
SparkParticleEmitter.Brightness = 1
SparkParticleEmitter.LightEmission = 1
SparkParticleEmitter.LightInfluence = 0
SparkParticleEmitter.Rate = 10
SparkParticleEmitter.TimeScale = 1
SparkParticleEmitter.Speed = NumberRange.new(10)
SparkParticleEmitter.Lifetime = NumberRange.new(0.5, 1)
SparkParticleEmitter.Rotation = NumberRange.new(0)
SparkParticleEmitter.RotSpeed = NumberRange.new(0)
SparkParticleEmitter.SpreadAngle = Vector2.new(20, -20)
SparkParticleEmitter.Squash = NumberSequence.new(0)
SparkParticleEmitter.Acceleration = Vector3.new(0, -50, 0)
SparkParticleEmitter.Shape = Enum.ParticleEmitterShape.Box
SparkParticleEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
SparkParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
SparkParticleEmitter.Orientation = Enum.ParticleOrientation.VelocityParallel
SparkParticleEmitter.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.5, 0),
	NumberSequenceKeypoint.new(1, 1)
})
SparkParticleEmitter.Size = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.25),
	NumberSequenceKeypoint.new(0.5, 0.25),
	NumberSequenceKeypoint.new(1, 0)
})
SparkParticleEmitter.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 128, 8))
})

SparkParticlePart.CFrame = owner.Character.Head.CFrame * CFrame.new(0, 0, -5)

MOVE_MODES.Camera = function ()
	local Origin = Camera.CFrame.Position
	local Direction = Camera.CFrame.LookVector
	local Distance = math.clamp(HOLD_DISTANCE, MINIMUM_HOLD_DISTANCE, (RAYCAST_HOLD_DISTANCE < MINIMUM_HOLD_DISTANCE and MINIMUM_HOLD_DISTANCE or RAYCAST_HOLD_DISTANCE))
	
	local Destination = Origin + Direction * Distance

	if COLLISION_ENABLED then
		local MouseLocation = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
		local ScreenRay = Camera:ScreenPointToRay(MouseLocation.X, MouseLocation.Y)
		
		local Origin = Camera.CFrame.Position
		local Direction = ScreenRay.Direction * HOLD_DISTANCE
		
		local Result = workspace:Raycast(Origin, Direction, RAYCASTPARAMS)
		
		local Size = CURRENT_ITEM:IsA("BasePart") and CURRENT_ITEM.Size or CURRENT_ITEM:GetExtentsSize()
		
		local RotatedSize = Vector3.new(
			math.abs(ORIENTATION.RightVector.X * Size.X) + math.abs(ORIENTATION.UpVector.X * Size.Y) + math.abs(ORIENTATION.LookVector.X * Size.Z),
			math.abs(ORIENTATION.RightVector.Y * Size.X) + math.abs(ORIENTATION.UpVector.Y * Size.Y) + math.abs(ORIENTATION.LookVector.Y * Size.Z),
			math.abs(ORIENTATION.RightVector.Z * Size.X) + math.abs(ORIENTATION.UpVector.Z * Size.Y) + math.abs(ORIENTATION.LookVector.Z * Size.Z)
		)
		
		if Result then
			Destination = Destination + Result.Normal * RotatedSize / 2
		end
	end
	
	return Destination
end

MOVE_MODES.Mouse = function ()
	local MouseLocation = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
	local ScreenRay = Camera:ScreenPointToRay(MouseLocation.X, MouseLocation.Y)
	
	local Origin = Camera.CFrame.Position
	local Direction = ScreenRay.Direction * 1e6
	
	local Result = workspace:Raycast(Origin, Direction, RAYCASTPARAMS)

	local Destination
	
	if Result then
		Destination = Result.Position

		if COLLISION_ENABLED then
			local Size = CURRENT_ITEM:IsA("BasePart") and CURRENT_ITEM.Size or CURRENT_ITEM:GetExtentsSize()
		
			local RotatedSize = Vector3.new(
				math.abs(ORIENTATION.RightVector.X * Size.X) + math.abs(ORIENTATION.UpVector.X * Size.Y) + math.abs(ORIENTATION.LookVector.X * Size.Z),
				math.abs(ORIENTATION.RightVector.Y * Size.X) + math.abs(ORIENTATION.UpVector.Y * Size.Y) + math.abs(ORIENTATION.LookVector.Y * Size.Z),
				math.abs(ORIENTATION.RightVector.Z * Size.X) + math.abs(ORIENTATION.UpVector.Z * Size.Y) + math.abs(ORIENTATION.LookVector.Z * Size.Z)
			)

			Destination = Destination + Result.Normal * RotatedSize / 2
		end
	else
		Destination = Origin + Direction
	end

	if CURRENT_ITEM:IsA("Model") then
		local PivotDifference = CURRENT_ITEM:GetBoundingBox().Position - CURRENT_ITEM:GetPivot().Position

		Destination = Destination - PivotDifference
	end

	return Destination
end

FUNCTIONS.ReturnPlayer = function (Name)
	if not Name then return end
	
	for _, Player in pairs(Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end

FUNCTIONS.IsFirstPerson = function ()
	return owner.Character.Head.LocalTransparencyModifier > 0
end

FUNCTIONS.ParentBodyMovers = function (Parent)
	Attachment0.Parent = Parent
	AlignPosition.Parent = Parent
	AlignOrientation.Parent = Parent
end

FUNCTIONS.EditFilterDescendantsInstances = function (add, ...)
	for _, v in pairs({...}) do
		if add then
			table.insert(FilterDescendantsInstances, v)
		else
			table.remove(FilterDescendantsInstances, table.find(FilterDescendantsInstances, v))
		end
	end
	
	RAYCASTPARAMS.FilterDescendantsInstances = FilterDescendantsInstances
end

FUNCTIONS.ReturnPrimaryPart = function (Model)
	return Model.PrimaryPart or Model:FindFirstChildOfClass("BasePart", true) or Model:FindFirstChildOfClass("Part", true)
end

FUNCTIONS.FitsCriteria = function (Item) -- Check if an item fits the criteria for being picked up.
	for _, BlacklistedTag in pairs(BlacklistedTags) do
		if CollectionService:HasTag(Item, BlacklistedTag) then return end
	end
	
	if Item:IsA("BasePart") then
		if MUST_BE_UNLOCKED and Item.Locked then return end
		if MUST_BE_IN_RANGE and (Item.Position - owner.Character.Head.Position).Magnitude > MAXIMUM_GRAB_DISTANCE then return end
	elseif Item:IsA("Model") then
		if MUST_BE_UNLOCKED then for _, BasePart in pairs(Item:GetDescendants()) do if BasePart:IsA("BasePart") then if BasePart.Locked then return end end end end
		if MUST_BE_IN_RANGE and (FUNCTIONS.ReturnPrimaryPart(Item).Position - owner.Character.Head.Position).Magnitude > MAXIMUM_GRAB_DISTANCE then return end
	else
		return
	end
	
	return Item
end

FUNCTIONS.UpdateTarget = function () -- Sets TARGET to the suitable Part or Model of Mouse.Target depending on TARGET and INPUT based factors.
	if not HOLDING then
		local MouseTarget = Mouse.Target
		
		if MouseTarget then
			TARGET = FUNCTIONS.FitsCriteria(ALT_DOWN and MouseTarget or (MouseTarget:FindFirstAncestorOfClass("Model") or MouseTarget))
		else
			TARGET = nil
		end
	end
end

FUNCTIONS.UpdateRaycastHoldDistance = function ()
	local RaycastResult = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * MAXIMUM_HOLD_DISTANCE, RAYCASTPARAMS)
	
	if RaycastResult then
		RAYCAST_HOLD_DISTANCE = (RaycastResult.Position - Camera.CFrame.Position).Magnitude
	else
		RAYCAST_HOLD_DISTANCE = MAXIMUM_HOLD_DISTANCE
	end
end

COMMANDS = {
	{
		CODE = "collision",
		FUNCTION = function (Boolean)
			COLLISION_ENABLED = Boolean == "true" and true or false
		end
	},
	{
		CODE = "welding",
		FUNCTION = function (Boolean)
			WELDING_ENABLED = Boolean == "true" and true or false
		end
	}
}

FUNCTIONS.RUN_COMMAND_BAR = function ()
	local Text = GUI.CommandBarTextBox.Text
	
	if COMMAND_PREFIX then
		if Text:sub(1, 1):lower() ~= COMMAND_PREFIX:lower() then return end
		Text = Text:sub(2, #Text)
	end
	
	local ClientCommandsRun = false
	
	local Sections = Text:split(COMMAND_SEPARATOR)
	
	for _, Command in pairs(COMMANDS) do
		if Sections[1]:lower() == Command.CODE:lower() then
			table.remove(Sections, 1)
			Command.FUNCTION(table.unpack(Sections))
			ClientCommandsRun = true
		end
	end

	if ClientCommandsRun then return end
	
	ChatCommandRemote:FireServer(Text)
end

FUNCTIONS.FOCUS_TEXTBOX = function ()
	GUI.CommandBarTextBox.Visible = true
	GUI.CommandBarTextBox.Interactable = true
	
	GUI.CommandBarTextBox:CaptureFocus()
	GUI.CommandBarTextBox:GetPropertyChangedSignal("Text"):Wait()
	GUI.CommandBarTextBox.Text = GUI.CommandBarTextBox.Text:sub(1, #GUI.CommandBarTextBox.Text - 1)
end

FUNCTIONS.FOCUS_LOST = function (EnterPressed)
	GUI.CommandBarTextBox.Visible = false
	GUI.CommandBarTextBox.Interactable = false

	if EnterPressed then
		FUNCTIONS.RUN_COMMAND_BAR()
	end
end


-- // GUI and Handling ======================================================================================================= \\
-- Functions
GUI.InputBegan = nil
GUI.InputChanged = nil
GUI.InputEnded = nil
GUI.UpdateProgressBar = nil
GUI.UpdateGrabCaret = nil

local GrabCaretSize = Camera.ViewportSize.Y * 0.025
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() GrabCaretSize = Camera.ViewportSize.Y * 0.025 GUI.GrabCaret.Size = UDim2.fromOffset(GrabCaretSize, GrabCaretSize) end)

GUI.UpdateProgressBar = function () -- Uses the PROGRESS value in the GUI table.
	local Value = (GUI.PROGRESS.Value % 360 + 360) % 360

	GUI.RightBar.Rotation = math.clamp(Value - 180, -180, 0)
	
	if Value > 180 then
		GUI.LeftBar.Visible = true
		GUI.LeftBar.Rotation = math.clamp(Value - 360, -180, 0)
	else
		GUI.LeftBar.Visible = false
	end
end

GUI.UpdateGrabCaret = function (Position, InBounds)
	if InBounds then
		GUI.GrabCaret.Position = GUI.GrabCaret.Position:Lerp(UDim2.new(0, Position.X, 0, Position.Y), GRAB_CARET_SPEED)
	else
		GUI.GrabCaret.Position = GUI.GrabCaret.Position:Lerp(UDim2.new(0.5, 0, 0.5, 0), GRAB_CARET_SPEED)
	end
end

GUI.CircularProgressBarScreenGui = Instance.new("ScreenGui")
GUI.CircularProgressBar = Instance.new("Frame")
GUI.LeftBack = Instance.new("ImageLabel")
GUI.LeftBar = Instance.new("Frame")
GUI.LeftBarImage = Instance.new("ImageLabel")
GUI.RightBack = Instance.new("ImageLabel")
GUI.RightBar = Instance.new("Frame")
GUI.RightBarImage = Instance.new("ImageLabel")
GUI.GrabCaret = Instance.new("TextLabel")
GUI.PROGRESS = Instance.new("NumberValue")
GUI.PROGRESSBARBACKCOLOR = Color3.new(0, 0, 0)
GUI.PROGRESSBARIMAGECOLOR = Color3.new(150, 150, 150)
GUI.CommandBarTextBox = Instance.new("TextBox", GUI.CircularProgressBarScreenGui)
--GUI.CommandBarUICorner = Instance.new("UICorner", GUI.CommandBarTextBox)
-- \\ ======================================================================================================================== //

-- // Serialized GUI ========================================================= \\
GUI.CommandBarTextBox.FocusLost:Connect(FUNCTIONS.FOCUS_LOST)
GUI.CommandBarTextBox.ClearTextOnFocus = CLEAR_TEXT_ON_FOCUS
GUI.CommandBarTextBox.BorderSizePixel = 0
GUI.CommandBarTextBox.Size = UDim2.fromScale(1, 0.03)
GUI.CommandBarTextBox.Position = UDim2.fromScale(0.5, 0.475)
GUI.CommandBarTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
GUI.CommandBarTextBox.BackgroundTransparency = 0.25
GUI.CommandBarTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GUI.CommandBarTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
GUI.CommandBarTextBox.TextStrokeTransparency = 1
GUI.CommandBarTextBox.Font = Enum.Font.Code
GUI.CommandBarTextBox.TextSize = GUI.CommandBarTextBox.Size.Y.Scale * GUI.CircularProgressBarScreenGui.AbsoluteSize.Y
GUI.CommandBarTextBox.Text = ""
GUI.CommandBarTextBox.PlaceholderText = ""
GUI.CommandBarTextBox.Visible = false
GUI.CommandBarTextBox.Interactable = false

GUI.CircularProgressBarScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.CircularProgressBarScreenGui.Name = "CircularProgressBarScreenGui"
GUI.CircularProgressBarScreenGui.IgnoreGuiInset = true
GUI.CircularProgressBarScreenGui.Parent = owner.PlayerGui

GUI.GrabCaret.AnchorPoint = Vector2.new(0.5, 0.5)
GUI.GrabCaret.Size = UDim2.fromOffset(GrabCaretSize, GrabCaretSize)
GUI.GrabCaret.Position = UDim2.new(0.5, 0, 0.5, 0)
GUI.GrabCaret.BackgroundTransparency = 1
GUI.GrabCaret.BorderColor3 = Color3.new(150, 150, 150)
GUI.GrabCaret.TextStrokeTransparency = 0
GUI.GrabCaret.TextStrokeColor3 = Color3.new(0, 0, 0)
GUI.GrabCaret.TextColor3 = Color3.new(255, 255, 255)
GUI.GrabCaret.TextScaled = true
GUI.GrabCaret.Text = "+"
GUI.GrabCaret.Name = "GrabCaret"
GUI.GrabCaret.Parent = GUI.CircularProgressBarScreenGui

GUI.CircularProgressBar.AnchorPoint = Vector2.new(0.5, 0.5)
GUI.CircularProgressBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GUI.CircularProgressBar.BackgroundTransparency = 1
GUI.CircularProgressBar.Position = UDim2.new(0.5, 0, 0.5, 0)
GUI.CircularProgressBar.Size = UDim2.new(2.5, 0, 2.5, 0)
GUI.CircularProgressBar.Rotation = 180
GUI.CircularProgressBar.Visible = false
GUI.CircularProgressBar.Name = "CircularProgressBar"
GUI.CircularProgressBar.Parent = GUI.GrabCaret

GUI.LeftBack.Image = "rbxassetid://2094637131"
GUI.LeftBack.ImageColor3 = GUI.PROGRESSBARBACKCOLOR
GUI.LeftBack.ImageRectSize = Vector2.new(128, 256)
GUI.LeftBack.SliceCenter = Rect.new(0, 0, 128, 256)
GUI.LeftBack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI.LeftBack.BackgroundTransparency = 1
GUI.LeftBack.Size = UDim2.new(0.5, 0, 1, 0)
GUI.LeftBack.ZIndex = 2
GUI.LeftBack.Name = "LeftBack"
GUI.LeftBack.Parent = GUI.CircularProgressBar

GUI.LeftBar.AnchorPoint = Vector2.new(0.5, 0.5)
GUI.LeftBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI.LeftBar.BackgroundTransparency = 1
GUI.LeftBar.Position = UDim2.new(1, 0, 0.5, 0)
GUI.LeftBar.Size = UDim2.new(2, 0, 1, 0)
GUI.LeftBar.Name = "LeftBar"
GUI.LeftBar.Parent = GUI.LeftBack

GUI.LeftBarImage.Image = "rbxassetid://2094676785"
GUI.LeftBarImage.ImageColor3 = GUI.PROGRESSBARIMAGECOLOR
GUI.LeftBarImage.ImageRectSize = Vector2.new(128, 256)
GUI.LeftBarImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI.LeftBarImage.BackgroundTransparency = 1
GUI.LeftBarImage.Size = UDim2.new(0.5, 0, 1, 0)
GUI.LeftBarImage.Name = "LeftBarImage"
GUI.LeftBarImage.Parent = GUI.LeftBar

GUI.RightBack.Image = "rbxassetid://2094637131"
GUI.RightBack.ImageColor3 = GUI.PROGRESSBARBACKCOLOR
GUI.RightBack.ImageRectOffset = Vector2.new(128, 0)
GUI.RightBack.ImageRectSize = Vector2.new(128, 256)
GUI.RightBack.SliceCenter = Rect.new(0, 0, 128, 256)
GUI.RightBack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI.RightBack.BackgroundTransparency = 1
GUI.RightBack.Position = UDim2.new(0.5, 0, 0, 0)
GUI.RightBack.Size = UDim2.new(0.5, 0, 1, 0)
GUI.RightBack.Name = "RightBack"
GUI.RightBack.Parent = GUI.CircularProgressBar

GUI.RightBar.AnchorPoint = Vector2.new(0.5, 0.5)
GUI.RightBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI.RightBar.BackgroundTransparency = 1
GUI.RightBar.Position = UDim2.new(0, 0, 0.5, 0)
GUI.RightBar.Size = UDim2.new(2, 0, 1, 0)
GUI.RightBar.Name = "RightBar"
GUI.RightBar.Parent = GUI.RightBack

GUI.RightBarImage.Image = "rbxassetid://2094676785"
GUI.RightBarImage.ImageColor3 = GUI.PROGRESSBARIMAGECOLOR
GUI.RightBarImage.ImageRectOffset = Vector2.new(128, 0)
GUI.RightBarImage.ImageRectSize = Vector2.new(128, 256)
GUI.RightBarImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI.RightBarImage.BackgroundTransparency = 1
GUI.RightBarImage.Position = UDim2.new(0.5, 0, 0, 0)
GUI.RightBarImage.Size = UDim2.new(0.5, 0, 1, 0)
GUI.RightBarImage.Name = "RightBarImage"
GUI.RightBarImage.Parent = GUI.RightBar

GUI.PROGRESS:GetPropertyChangedSignal("Value"):Connect(GUI.UpdateProgressBar)
GUI.PROGRESS.Value = 0 -- Doesn't trigger the changed signal because NumberValues are already at 0.
GUI.UpdateProgressBar() -- Ensure that the progress has been updated to 0.
-- \\ ======================================================================== //


-- // Event Functions \\
FUNCTIONS.PICKUP = function ()
	CURRENT_ITEM = TARGET
	FUNCTIONS.EditFilterDescendantsInstances(true, CURRENT_ITEM)
	
	GrabRemote:FireServer(CURRENT_ITEM, ALT_DOWN)
	
	repeat task.wait() until CollectionService:HasTag(CURRENT_ITEM, BlacklistedTags.ISHELD_TAG)
	
	HOLDING = true
	
	GUI.GrabCaret.Visible = false
	
	if CURRENT_ITEM:IsA("BasePart") then
		FUNCTIONS.ParentBodyMovers(CURRENT_ITEM)
	elseif CURRENT_ITEM:IsA("Model") then
		FUNCTIONS.ParentBodyMovers(FUNCTIONS.ReturnPrimaryPart(CURRENT_ITEM))
	end
end

FUNCTIONS.HOLDING = function ()
	if ROTATE_INPUT_DOWN and ALT_DOWN then
		AlignOrientation.CFrame = ORIENTATION
		
		return
	end
	
	local Destination = MOVE_MODES[MOVE_MODE]()
	local NewCFrame = CFrame.new(Destination) * ORIENTATION
	
	local OldCFrame = CURRENT_ITEM:GetPivot()
	local Distance = (NewCFrame.Position - OldCFrame.Position).Magnitude
	
	NewCFrame = OldCFrame:Lerp(NewCFrame, math.clamp(Distance, MOVE_LERP_RANGE.Min, MOVE_LERP_RANGE.Max))
	
	CURRENT_ITEM:PivotTo(NewCFrame)
	
	AlignPosition.Position = NewCFrame.Position
	AlignOrientation.CFrame = NewCFrame
	
	if CURRENT_ITEM:IsA("BasePart") then
		local TouchingParts = workspace:GetPartsInPart(CURRENT_ITEM)
		
		for i, Part in pairs(TouchingParts) do
			if Part:IsDescendantOf(owner.Character) then
				TouchingParts[i] = nil
			end
		end
		
		TOUCHING_PARTS = TouchingParts
		
		if #TOUCHING_PARTS > 0 then -- CURRENT_ITEM is colliding.
			SelectionBox.Adornee = CURRENT_ITEM
		else
			SelectionBox.Adornee = nil
		end
	elseif CURRENT_ITEM:IsA("Model") then
		local IsTouching = false
		
		for i, Part in pairs(CURRENT_ITEM:GetDescendants()) do
			if Part:IsA("BasePart") then
				local TouchingParts = workspace:GetPartsInPart(Part)
				
				for i, TouchingPart in pairs(TouchingParts) do
					if TouchingPart:IsDescendantOf(owner.Character) or TouchingPart:IsDescendantOf(CURRENT_ITEM) then
						TouchingParts[i] = nil
					end
				end
				
				if #TouchingParts > 0 then
					IsTouching = true
					TOUCHING_PARTS[Part.Name .. i] = TouchingParts
				end
			end
		end
		
		TOUCHING = IsTouching
		
		if TOUCHING then
			SelectionBox.Adornee = CURRENT_ITEM
		else
			SelectionBox.Adornee = nil
		end
	end
end

FUNCTIONS.DROP = function ()
	GrabRemote:FireServer(false, false, TOUCHING_PARTS)
	
	local startwait = tick()
	
	repeat
		if (tick() - startwait) > 2 then
			warn("Failed to drop: '" .. CURRENT_ITEM.ClassName .. "' - '" .. CURRENT_ITEM:GetFullName() .. "'")
			
			break
		end
		
		task.wait()
	until not CollectionService:HasTag(CURRENT_ITEM, BlacklistedTags.ISHELD_TAG)
	
	HOLDING = false
	
	SelectionBox.Adornee = nil
	Highlight.Adornee = nil
	
	FUNCTIONS.ParentBodyMovers(nil)
	FUNCTIONS.EditFilterDescendantsInstances(false, CURRENT_ITEM)
	
	if THROW_FORCE > 0 then
		local Velocity = Camera.CFrame.LookVector * THROW_FORCE
		
		if CURRENT_ITEM:IsA("BasePart") then
			CURRENT_ITEM.AssemblyLinearVelocity = Camera.CFrame.LookVector * THROW_FORCE
		elseif CURRENT_ITEM:IsA("Model") then
			local BasePart = CURRENT_ITEM:FindFirstChildWhichIsA("BasePart")

			if BasePart then
				BasePart.AssemblyLinearVelocity = (Camera.CFrame.LookVector * THROW_FORCE)
			end
		end
	end
	
	CURRENT_ITEM = nil
end


-- // Input Handling ============================================================================================ \\
GUI.InputBegan = function (Input, GPE)
	if Input.KeyCode == Enum.KeyCode.BackSlash then
		FUNCTIONS.FOCUS_TEXTBOX()
	end
	
	if GPE then return end
	
	if Input.UserInputType == Enum.UserInputType.Keyboard then
		if Input.KeyCode == PICKUP_INPUT then
			PICKUP_INPUT_DOWN = true
			
			if CURRENT_ITEM then
				DROPPING = true
				
				local DROPSTART = tick()
				
				repeat
					if tick() - DROPSTART > 0.5 then
						THROW_FORCE = math.clamp(THROW_FORCE + THROW_FORCE_INCREMENT, 0, MAX_THROW_FORCE)
					end
					
					task.wait()
				until not DROPPING
			else
				if TARGET then
					FIRST_INPUT_TARGET = TARGET
					GUI.CircularProgressBar.Visible = true
					PICKUP_TWEEN = TweenService:Create(GUI.PROGRESS, TweenInfo.new(PICKUP_HOLD, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Value = 359.9})
					PICKUP_TWEEN:Play()
				end
			end
		elseif Input.KeyCode == Enum.KeyCode.LeftControl then
			CTRL_DOWN = true
		elseif Input.KeyCode == Enum.KeyCode.LeftShift then
			SHIFT_DOWN = true
		elseif Input.KeyCode == Enum.KeyCode.LeftAlt then
			ALT_DOWN = true
			
			Highlight.FillColor = HighlightColorRed.FillColor
			Highlight.OutlineColor = HighlightColorRed.OutlineColor
		elseif Input.KeyCode == INCREASEDISTANCE_INPUT and CURRENT_ITEM then
			HOLD_DISTANCE = math.clamp(HOLD_DISTANCE + HOLD_DISTANCE_INCREMENT, MINIMUM_HOLD_DISTANCE, MAXIMUM_HOLD_DISTANCE)
		elseif Input.KeyCode == DECREASEDISTANCE_INPUT and CURRENT_ITEM then
			HOLD_DISTANCE = math.clamp(HOLD_DISTANCE - HOLD_DISTANCE_INCREMENT, MINIMUM_HOLD_DISTANCE, MAXIMUM_HOLD_DISTANCE)
		elseif Input.KeyCode == CHECK_NETWORK_OWNER_INPUT then
			CheckOwnerRemote:FireServer(Mouse.Target)
		elseif Input.KeyCode == Enum.KeyCode.One then
			AXIS = "X"
		elseif Input.KeyCode == Enum.KeyCode.Two then
			AXIS = "Y"
		elseif Input.KeyCode == Enum.KeyCode.Three then
			AXIS = "Z"
		elseif Input.KeyCode == ROTATE_INPUT then
			ROTATE_INPUT_DOWN = true
			
			if ALT_DOWN then
				local Offset = (Camera.CFrame - owner.Character.Head.Position).Position
				
				Camera.CameraType = Enum.CameraType.Scriptable
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				
				repeat
					--Camera.CFrame = owner.Character.Head.CFrame + Offset
					
					local MouseDelta = UserInputService:GetMouseDelta()
					
					local RotationX = MouseDelta.X * ORIENTATION_INCREMENT
					local RotationY = MouseDelta.Y * ORIENTATION_INCREMENT
					
					ORIENTATION = ORIENTATION * CFrame.Angles(math.rad(RotationY), math.rad(RotationX), 0)
					
					task.wait()
				until not ALT_DOWN or not ROTATE_INPUT_DOWN

				Camera.CameraType = Enum.CameraType.Custom
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				
				return
			end
			
			RotateSound:Play()
			
			if SHIFT_DOWN and CTRL_DOWN then
				ORIENTATION = CFrame.new()
				return
			end
			
			if AXIS == "X" then
				ORIENTATION = ORIENTATION * CFrame.Angles(ORIENTATION_INCREMENT, 0, 0)
			elseif AXIS == "Y" then
				ORIENTATION = ORIENTATION * CFrame.Angles(0, ORIENTATION_INCREMENT, 0)
			elseif AXIS == "Z" then
				ORIENTATION = ORIENTATION * CFrame.Angles(0, 0, ORIENTATION_INCREMENT)
			end
		elseif Input.KeyCode == CHANGE_CAMERAMODE_INPUT then
			if owner.CameraMode == Enum.CameraMode.Classic then
				owner.CameraMode = Enum.CameraMode.LockFirstPerson
			elseif owner.CameraMode == Enum.CameraMode.LockFirstPerson then
				owner.CameraMode = Enum.CameraMode.Classic
			end
		elseif Input.KeyCode == CHANGE_MODE_INPUT then
			if MODE == "Camera" then
				MODE = "Mouse"
			elseif MODE == "Mouse" then
				MODE = "Camera"
			end
		elseif Input.KeyCode == DELETE_INPUT then
			if TARGET or CURRENT_ITEM then
				DeleteRemote:FireServer(CURRENT_ITEM or TARGET)
			end
		end
	end
end

GUI.InputChanged = function (Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.MouseWheel then
			if CURRENT_ITEM and MOVE_MODE == "Camera" then
				ScrollWheelClickSound:Play()
				
				if Input.Position.Z > 0 then -- Up
					HOLD_DISTANCE = math.clamp(HOLD_DISTANCE + HOLD_DISTANCE_INCREMENT, MINIMUM_HOLD_DISTANCE, MAXIMUM_HOLD_DISTANCE)
				else -- Down
					HOLD_DISTANCE = math.clamp(HOLD_DISTANCE - HOLD_DISTANCE_INCREMENT, MINIMUM_HOLD_DISTANCE, MAXIMUM_HOLD_DISTANCE)
				end
			end
		end
	end
end

GUI.InputEnded = function (Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == PICKUP_INPUT then
				if CURRENT_ITEM and DROPPING then
					
					-- //////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
					-- ||||||||||||||||||||||||||||||||| User is dropping CURRENT_ITEM. |||||||||||||||||||||||||||||||||
					-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////////////////
					
					FUNCTIONS.DROP()
					DROPPING = false
					THROW_FORCE = 0
					
				end
				
				PICKUP_INPUT_DOWN = false
				FIRST_INPUT_TARGET = nil
				
				if PICKUP_TWEEN then
					GUI.CircularProgressBar.Visible = false
					PICKUP_TWEEN:Pause()
					PICKUP_TWEEN = nil
					GUI.PROGRESS.Value = 0
				end
			elseif Input.KeyCode == Enum.KeyCode.LeftControl then
				CTRL_DOWN = false
			elseif Input.KeyCode == Enum.KeyCode.LeftShift then
				SHIFT_DOWN = false
			elseif Input.KeyCode == Enum.KeyCode.LeftAlt then
				ALT_DOWN = false
				
				Highlight.FillColor = HighlightColorWhite.FillColor
				Highlight.OutlineColor = HighlightColorWhite.OutlineColor
			elseif Input.KeyCode == ROTATE_INPUT then
				ROTATE_INPUT_DOWN = false
			end
		end
	end
end

UserInputService.InputBegan:Connect(GUI.InputBegan)
UserInputService.InputChanged:Connect(GUI.InputChanged)
UserInputService.InputEnded:Connect(GUI.InputEnded)
-- \\ =========================================================================================================== //



-- // Main Loop \\
RunService.PostSimulation:Connect(function(Delta)
	-- Update the TARGET variable.
	FUNCTIONS.UpdateTarget()
	
	if HOLDING then
		FUNCTIONS.UpdateRaycastHoldDistance()
		
		Highlight.Adornee = nil
	else
		Highlight.Adornee = TARGET
	end
	
	if FUNCTIONS.IsFirstPerson() then
		MOVE_MODE = "Camera"
	else
		MOVE_MODE = "Mouse"
	end
	
	if SHIFT_DOWN and not CTRL_DOWN then
		ORIENTATION_INCREMENT = ROTATION_INCREMENT_90
	elseif CTRL_DOWN and not SHIFT_DOWN then
		ORIENTATION_INCREMENT = ROTATION_INCREMENT_15
	elseif not SHIFT_DOWN and not CTRL_DOWN then
		ORIENTATION_INCREMENT = ROTATION_INCREMENT_45
	elseif SHIFT_DOWN and CTRL_DOWN then
		ORIENTATION_INCREMENT = ROTATION_INCREMENT_45 -- not used.
	end
	
	-- Update GUI GrabCaret and CircularProgressBar.
	if CURRENT_ITEM and HOLDING then
		GUI.GrabCaret.Position = GUI.GrabCaret.Position:Lerp(UDim2.fromScale(0.5, 0.5), GRAB_CARET_SPEED)
		if GUI.CircularProgressBar.Visible then GUI.CircularProgressBar.Visible = false end
		
		-- /////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		-- ||||||||||||||||||||||||||||| User is holding CURRENT_ITEM. |||||||||||||||||||||||||||||
		-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////////////////
		
		FUNCTIONS.HOLDING()
		
	else
		if not GUI.GrabCaret.Visible then GUI.GrabCaret.Visible = true end
	
		if TARGET then
			local TargetPosition, InBounds = Camera:WorldToViewportPoint(TARGET:IsA("Model") and FUNCTIONS.ReturnPrimaryPart(TARGET).Position or TARGET.Position)
			GUI.UpdateGrabCaret(TargetPosition, InBounds)
		else
			GUI.UpdateGrabCaret(UDim2.fromScale(0.5, 0.5))
			
			if PICKUP_TWEEN then PICKUP_TWEEN:Pause() end
			GUI.PROGRESS.Value = 0
			if GUI.CircularProgressBar.Visible then GUI.CircularProgressBar.Visible = false end
		end
	end
	
	if PICKUP_INPUT_DOWN then
		if TARGET then
			if TARGET == FIRST_INPUT_TARGET then
				if not CURRENT_ITEM then
					if GUI.PROGRESS.Value > 359 then
					
						-- ///////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
						-- |||||||||||||||||||||| User is picking up TARGET. Despite being in a RunService loop, this only runs once. ||||||||||||||||||||||
						-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////////////////////////////////
						
						FUNCTIONS.PICKUP()
						
					end
				end
			end
		end
	end
end)
]], owner.PlayerGui)
