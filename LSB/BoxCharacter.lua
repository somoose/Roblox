local InsertService = game:GetService("InsertService")

local CanoeMesh = "rbxassetid://2481755430"
local BoxMeshId = "rbxassetid://10465152751"
local BoxTextureID = "rbxassetid://10465153306"

local OldCharacterCFrame = owner.Character.HumanoidRootPart.CFrame

local NewCharacter = Instance.new("Model", owner.Character.Parent)
NewCharacter.Name = owner.Character.Name

local Box = InsertService:CreateMeshPartAsync(BoxMeshId, Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Box.TextureID = BoxTextureID
Box.Parent = NewCharacter
Box.Name = "Head"
Box.Size *= 0.5
Box.Material = Enum.Material.WoodPlanks
Box.BrickColor = BrickColor.new("Earth orange")
Box:SetNetworkOwner(owner)
Box.CustomPhysicalProperties = PhysicalProperties.new(20, 40, 0)

local Humanoid = Instance.new("Humanoid", NewCharacter)

owner.Character = NewCharacter
Box.CFrame = OldCharacterCFrame

NLS([[
function MoveTowards (Part, Location, Force)
	local Direction = (Location - Part.Position).Unit
	Part.AssemblyAngularVelocity = Direction:Cross(Vector3.new(0, -1, 0)) * Force
end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Camera = workspace.CurrentCamera

Camera.CameraSubject = owner.Character.Head

RunService.PostSimulation:Connect(function()
	local Direction = Vector3.zero
	
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		Direction = Direction + Camera.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		Direction = Direction - Camera.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		Direction = Direction - Camera.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		Direction = Direction + Camera.CFrame.RightVector
	end

	if Direction.Magnitude > 0 then
		MoveTowards(owner.Character.Head, owner.Character.Head.Position + Direction, owner.Character.Humanoid.WalkSpeed * (7 / 16))
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
		if #owner.Character.Head:GetTouchingParts() > 0 then
			owner.Character.Head.AssemblyLinearVelocity = owner.Character.Head.AssemblyLinearVelocity + Vector3.new(0, owner.Character.Humanoid.JumpPower * (45 / 50), 0)
		end
	end
end)
]], owner.PlayerGui)

while true do
	owner.Character.Head:SetNetworkOwner(owner)
	
	task.wait()
end
