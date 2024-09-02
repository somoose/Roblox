local RunService = game:GetService("RunService")

local Camera = workspace.CurrentCamera

local RotationFrequency, RotationIntensity = 4.6, 1
local BobbleFrequency, BobbleIntensity = 8.35, 0.1

local DefaultWalkSpeed = 16

local function Lerp (a, b, t)
	return a + (b - a) * t
end

local function GetCurve (Frequency, Intensity)
	return math.sin(os.clock() * Frequency) * Intensity
end

local PreviousVelocity = nil

RunService.RenderStepped:Connect(function()
	local Velocity = math.round(Vector3.new(owner.Character.HumanoidRootPart.AssemblyLinearVelocity.X, 0, owner.Character.HumanoidRootPart.AssemblyLinearVelocity.Z).Magnitude)
	
	if PreviousVelocity then
		Velocity = Lerp(PreviousVelocity, Velocity, 0.25)
	end
	
	PreviousVelocity = Velocity
	
	Camera.CFrame = Camera.CFrame * CFrame.new(0, GetCurve(BobbleFrequency, BobbleIntensity) * Velocity / DefaultWalkSpeed, 0) * CFrame.Angles(0, 0, math.rad(GetCurve(RotationFrequency, RotationIntensity) * Velocity / DefaultWalkSpeed))
end)
