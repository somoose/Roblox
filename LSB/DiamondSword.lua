local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "DiamondSword"
local Mesh = game.InsertService:CreateMeshPartAsync("rbxassetid://8827558932", Enum.CollisionFidelity.PreciseConvexDecomposition, Enum.RenderFidelity.Automatic)
Mesh.TextureID = "rbxassetid://8827558969"
Mesh.Size *= 0.18
Mesh.Name = "Handle"
Mesh.Parent = Tool
Mesh.Massless = true
Tool.Grip = CFrame.new(0, 0, -Mesh.Size.Z/3.5) * CFrame.Angles(math.pi/2, math.pi/2, 0)

local HitSound = Instance.new("Sound", Mesh)
HitSound.SoundId = "rbxassetid://8766809464"

local HitHighlight = Instance.new("Highlight", script)
HitHighlight.OutlineTransparency = 1
HitHighlight.FillColor = Color3.fromRGB(255, 0, 0)
HitHighlight.FillTransparency = 0.5

local HitDamage = 10
local HitDebounce = false
local HitWait = 0.5

Mesh.Touched:Connect(function(Touch)
	if Touch.Parent:FindFirstChildWhichIsA("Humanoid") and Touch.Parent ~= Tool.Parent then
		Touch.Parent.Humanoid.BreakJointsOnDeath = false
		if not HitDebounce then
			HitDebounce = true
			HitSound:Play()
			HitHighlight.Adornee = Touch.Parent
			Touch.Parent.Humanoid:TakeDamage(HitDamage)
			task.wait(HitWait)
			HitHighlight.Adornee = nil
			HitDebounce = false
		end
	end
end)

local Sound = Instance.new("Sound", Mesh)
Sound.SoundId = "rbxassetid://125088209125242"
Sound.Looped = true
Sound.Volume = 10000
Sound.Pitch = 1.5

Tool.Equipped:Connect(function()
	Sound:Play()
end)
Tool.Unequipped:Connect(function()
	Sound:Pause()
end)
