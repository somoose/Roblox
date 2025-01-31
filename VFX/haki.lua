local TweenService = game:GetService("TweenService")
local InsertService = game:GetService("InsertService")

local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "HAKI"
local Handle = Instance.new("Part")
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Parent = Tool
Tool.Grip = CFrame.new(0, 0, Handle.Size.Z/2)

local Sound = Instance.new("Sound", Handle)
Sound.SoundId = "rbxassetid://979751563"
Sound.Volume = 0.1

local function Haki (BasePart)
	local NewSound = Sound:Clone()
	NewSound.Parent = BasePart
	NewSound:Play()
	TweenService:Create(BasePart, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Color = Color3.fromRGB(20, 20, 20), Reflectance = 0}):Play()
	task.wait(0.2)
	TweenService:Create(BasePart, TweenInfo.new(0.75), {Reflectance = 0.1}):Play()
	task.wait(0.75)
	BasePart.Material = Enum.Material.Neon
	TweenService:Create(BasePart, TweenInfo.new(0.15), {Color = Color3.fromRGB(200, 200, 200), Reflectance = 0.1, Transparency = 0}):Play()
	task.wait(0.15)
	TweenService:Create(BasePart, TweenInfo.new(0.01), {Color = Color3.fromRGB(245, 81, 56), Reflectance = 0.5, Transparency = 0.1}):Play()
	task.wait(0.01)
	TweenService:Create(BasePart, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = Color3.fromRGB(100, 100, 100), Reflectance = 2, Transparency = 0}):Play()
	task.wait(0.25)
	BasePart.Material = Enum.Material.Metal
	TweenService:Create(BasePart, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut), {Reflectance = 0.25}):Play()
end

Tool.Activated:Connect(function()
	local Parts = workspace:GetPartBoundsInBox(Handle.CFrame, Handle.Size)
	for _, Part in pairs(Parts) do
		if Part:IsDescendantOf(owner.Character) or Part == Handle then continue end
		task.spawn(Haki, Part)
		Part.CustomPhysicalProperties = PhysicalProperties.new(1e10, 1e10, 0)
	end
end)
