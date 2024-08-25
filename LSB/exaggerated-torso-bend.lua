local Player = owner
local PlayerGui = Player.PlayerGui
local Character = Player.Character
local RigType = Character.Humanoid.RigType

local Remote = script:FindFirstChild("CameraRemote"..Player.Name) or Instance.new("RemoteEvent", script)
Remote.Name = "CameraRemote"..Player.Name

local Mul = 1.5

if RigType == Enum.HumanoidRigType.R15 then
	local Neck = Character:FindFirstChild("Neck", true)
	local Waist = Character:FindFirstChild("Waist", true)

	local NeckC0 = Neck.C0
	local WaistC0 = Waist.C0

	Remote.OnServerEvent:Connect(function(Player, LookVector)
		Neck.C0 = NeckC0 * CFrame.Angles(LookVector.Y * Mul, 0, 0)
		Waist.C0 = WaistC0 * CFrame.Angles(LookVector.Y * Mul, 0, 0)
	end)
else
	local Neck = Character:FindFirstChild("Neck", true)
	local Root = Character:FindFirstChild("RootJoint", true) or Character:FindFirstChild("Root Joint", true)
	local LeftHip = Character:FindFirstChild("Left Hip", true)
	local RightHip = Character:FindFirstChild("Right Hip", true)

	local NeckC1 = Neck.C1
	local RootC1 = Root.C1
	local LHC0 = LeftHip.C0
	local RHC0 = RightHip.C0

	Remote.OnServerEvent:Connect(function(Player, LookVector)
		Neck.C1 = NeckC1 * CFrame.Angles(LookVector.Y * Mul, 0, 0)
		Root.C1 = RootC1 * CFrame.Angles(LookVector.Y * Mul, 0, 0)
		LeftHip.C0 = LHC0 * CFrame.Angles(0, 0, LookVector.Y * Mul)
		RightHip.C0 = RHC0 * CFrame.Angles(0, 0, -LookVector.Y * Mul)
	end)
end

--// Client
NLS([[
local Camera = workspace.CurrentCamera
local Remote = workspace:FindFirstChild("CameraRemote"..owner.Name, true)

Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
	Remote:FireServer(Camera.CFrame.LookVector)
end)
]], PlayerGui)
