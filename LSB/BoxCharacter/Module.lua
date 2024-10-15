local InsertService = game:GetService("InsertService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local FakeNameAPI = "https://api.namefake.com/"

local function GetRandomName ()
	local success, JSONData = pcall(function() return HttpService:GetAsync(FakeNameAPI) end)

	if JSONData then
		local DecodedData = HttpService:JSONDecode(JSONData)

		return DecodedData.name
	end
end

BoxCharacter = {}

BoxCharacter.new = function (Parent, MeshId, TextureID, Size)
	local Model = Instance.new("Model", Parent)

	local Box

	if MeshId then
		Box = InsertService:CreateMeshPartAsync(MeshId, Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
		Box.TextureID = TextureID
		Box.Size = Box.Size.Unit * Size
	else
		Box = Instance.new("Part")
		Box.Size = Size and (type(Size) == "number" and Vector3.one * Size or Size) or Vector3.one * 2
	end

	Box.Parent = Model
	Box.Name = "Head"
	Box.CustomPhysicalProperties = PhysicalProperties.new(5, 60, 0)
	Box.PivotOffset = CFrame.Angles(0, math.pi/2, 0)

	local HumanoidRootPart = Instance.new("Part", Model)
	HumanoidRootPart.Name = "HumanoidRootPart"
	HumanoidRootPart.CanCollide = false
	HumanoidRootPart.CanQuery = false
	HumanoidRootPart.CanTouch = false
	HumanoidRootPart.Transparency = 1
	HumanoidRootPart.Size = Vector3.one
	HumanoidRootPart.Massless = true

	local Root = Instance.new("Weld", HumanoidRootPart)
	Root.Part0 = HumanoidRootPart
	Root.Part1 = Box

	local RightGripWeld = Instance.new("Weld", Box)
	RightGripWeld.Part0 = Box
	RightGripWeld.C0 = CFrame.new(-Box.Size.X/2, 0, -Box.Size.Z/2)

	local Humanoid = Instance.new("Humanoid", Model)
	Humanoid.DisplayName = "Box"

	Model.ChildAdded:Connect(function(Child)
		if Child:IsA("Tool") then
			RightGripWeld.Part1 = Child.Handle
		end
	end)

	Model.ChildRemoved:Connect(function(Child)
		if Child:IsA("Tool") then
			RightGripWeld.Part1 = nil
			Child.Handle.CFrame = Box.CFrame * CFrame.new(0, 0, -5)
		end
	end)

	return Model
end

BoxCharacter.LoadCharacter = function (Player, SaveOriginalPosition)
	local Pivot = CFrame.new()

	local Character = BoxCharacter.new(Player.Character.Parent, BoxCharacter.IDs.Amazon.Mesh, BoxCharacter.IDs.Amazon.Texture, 3)
	Character.Name = Player.Character.Name
	Character.Humanoid.DisplayName = Player.DisplayName

	if SaveOriginalPosition then
		Pivot = owner.Character.HumanoidRootPart.CFrame
	end
	
	Player.Character = Character
	Player.Character.Head.CFrame = Pivot

	NLS(BoxCharacter.LocalScript, Player.PlayerGui)

	task.spawn(function()
		while Character do
			if Character:FindFirstChild("Head") then
				if Character.Head:GetNetworkOwner() ~= Player then
					Character.Head:SetNetworkOwner(Player)
				end
			end

			task.wait()
		end
	end)

	return Character
end

BoxCharacter.MoveTowards = function (Part, Location, Force)
	local Direction = (Location * Vector3.new(1, 0, 1) - Part.Position * Vector3.new(1, 0, 1)).Unit

	Part.AssemblyAngularVelocity = Direction:Cross(Vector3.new(0, -1, 0)) * Force * 1.5
	
	if Part.AssemblyLinearVelocity.Magnitude < Force then
		Part.AssemblyLinearVelocity = Part.AssemblyLinearVelocity + Direction * Force * 1.5
	end
end

BoxCharacter.Jump = function (Part, Force)
	Part:ApplyImpulse(Vector3.new(0, Force, 0) * Part.AssemblyMass)
end

BoxCharacter.CanJump = function (Character)
	local Parts = workspace:GetPartBoundsInBox(Character.Head.CFrame, Character.Head.Size * 1.1)
	table.remove(Parts, table.find(Parts, Character.Head))

	return #Parts > 0
end

BoxCharacter.GetClosestPlayer = function (Position)
	local ClosestPlayer = nil
	local MinimumDistance = math.huge

	for _, Player in pairs(Players:GetPlayers()) do
		if not Player.Character then continue end
		local Distance = (Player.Character:GetPivot().Position - Position).Magnitude
		
		if Distance < MinimumDistance then
			ClosestPlayer = Player
			MinimumDistance = Distance
		end
	end

	return ClosestPlayer
end

BoxCharacter.IsFacingAt = function (CFrame0, CFrame1)
	local Direction = (CFrame1.Position - CFrame0.Position).Unit * Vector3.new(1, 0, 1)
	
	return CFrame0.LookVector:Dot(Direction) > 0.5
end

BoxCharacter.BoxExtensions = {
	"Package",
	"Parcel",
	"Box",
	"Delivery",
	"Bundle",
	"Packet",
	"Gift"
}

BoxCharacter.IDs = {
	Amazon = {
		Mesh = "rbxassetid://11096354972",
		Texture = "rbxassetid://11096372860"
	},
	Other = {
		Mesh = "rbxassetid://10465152751",
		Texture = "rbxassetid://10465153306"
	}
}

BoxCharacter.LocalScript = [[
local PartName = "Head"

function MoveTowards (Part, Location, Force)
	local Direction = (Location * Vector3.new(1, 0, 1) - Part.Position * Vector3.new(1, 0, 1)).Unit

	Part.AssemblyAngularVelocity = Direction:Cross(Vector3.new(0, -1, 0)) * Force * 1.5
	
	if Part.AssemblyLinearVelocity.Magnitude < Force then
		Part.AssemblyLinearVelocity = Part.AssemblyLinearVelocity + Direction * Force * 1.5
	end
end

function Jump (Part, Force)
	Part:ApplyImpulse(Vector3.new(0, Force, 0) * Part.AssemblyMass)
end

function CanJump (Character)
	local Parts = workspace:GetPartBoundsInBox(Character.Head.CFrame, Character.Head.Size * 1.1)
	table.remove(Parts, table.find(Parts, Character.Head))

	return #Parts > 0
end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local W_DOWN = false
local A_DOWN = false
local S_DOWN = false
local D_DOWN = false
local SPACE_DOWN = false

local SPACE_DEBOUNCE = false
local SPACE_WAIT = 0.1

local Camera = workspace.CurrentCamera

Camera.CameraSubject = owner.Character[PartName]

UserInputService.InputBegan:Connect(function(Input, GPE)
	if GPE then return end

	if Input.KeyCode == Enum.KeyCode.W then
		W_DOWN = true
	elseif Input.KeyCode == Enum.KeyCode.A then
		A_DOWN = true
	elseif Input.KeyCode == Enum.KeyCode.S then
		S_DOWN = true
	elseif Input.KeyCode == Enum.KeyCode.D then
		D_DOWN = true
	elseif Input.KeyCode == Enum.KeyCode.Space then
		SPACE_DOWN = true
	end
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
	if GPE then return end

	if Input.KeyCode == Enum.KeyCode.W then
		W_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.A then
		A_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.S then
		S_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.D then
		D_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.Space then
		SPACE_DOWN = false
	end
end)

RunService.PostSimulation:Connect(function()
	local Direction = Vector3.zero
	
	if W_DOWN then
		Direction = Direction + Camera.CFrame.LookVector
	end
	if A_DOWN then
		Direction = Direction - Camera.CFrame.RightVector
	end
	if S_DOWN then
		Direction = Direction - Camera.CFrame.LookVector
	end
	if D_DOWN then
		Direction = Direction + Camera.CFrame.RightVector
	end
	if SPACE_DOWN and not SPACE_DEBOUNCE then
		SPACE_DEBOUNCE = true

		if CanJump(owner.Character) then
			Jump(owner.Character.Head, owner.Character.Humanoid.JumpPower * (40 / 50))
		end

		task.wait(SPACE_WAIT)

		SPACE_DEBOUNCE = false
	end

	if Direction.Magnitude > 0 then
		MoveTowards(owner.Character[PartName], owner.Character[PartName].Position + Direction, owner.Character.Humanoid.WalkSpeed * (9 / 16))
	end
end)
]]

BoxCharacter.CreateNPC = function (Parent, Scale)
	local NPC = BoxCharacter.new(Parent or script, BoxCharacter.IDs.Amazon.Mesh, BoxCharacter.IDs.Amazon.Texture, Scale or math.random(2, 3))

	task.spawn(function()
		NPC.Humanoid.DisplayName = GetRandomName() .. "'s " .. BoxCharacter.BoxExtensions[math.random(#BoxCharacter.BoxExtensions)]
	end)
	
	task.spawn(function()
		while true do
			local Target = BoxCharacter.GetClosestPlayer(NPC.Head.Position)

			if Target then
				if (Target.Character.Head.Position - NPC.Head.Position).Magnitude < 100 then
					if not BoxCharacter.IsFacingAt(Target.Character.Head.CFrame, NPC.Head.CFrame) then
						BoxCharacter.MoveTowards(NPC.Head, Target.Character.Head.Position, NPC.Humanoid.WalkSpeed * (9 / 16))
					end
				end
			end
			
			task.wait()
		end
	end)

	NPC.Head.CFrame = owner.Character.Head.CFrame

	return NPC
end
