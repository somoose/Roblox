local HttpService = game:GetService("HttpService")
local SlimeModule = loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/master/LSB/slime/module.lua"))()

local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "Spawn Slime"

local Handle = Instance.new("Part", Tool)
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Material = Enum.Material.SmoothPlastic
Handle.Transparency = 0.5
Handle.BrickColor = SlimeModule.Colors[math.random(#SlimeModule.Colors)]

local Face = Instance.new("Decal", Handle)
Face.Transparency = 0.8
Face.Texture = "rbxassetid://296233945"

local Activated = false

Tool.Activated:Connect(function()
	Activated = true
	
	repeat
		local Target = owner.Character
		
		local Slime = SlimeModule.new(script)
		SlimeModule.ApplyAppearance(Slime, math.random(2, 3))
		Slime.Head.CFrame = Handle.CFrame * CFrame.new(0, 0, -Handle.Size.Z/2 - Slime.Head.Size.Z/2)
		
		task.spawn(function()
			while Slime do
				if Target then
					if Target:FindFirstChild("Head") then
						SlimeModule.MoveTo(Slime, Target.Head.Position)
						
						repeat task.wait() until Slime.Head.AssemblyLinearVelocity.Magnitude < 1
					end
				end
				
				task.wait()
			end
		end)
		
		task.wait(0.25)
	until not Activated
end)

Tool.Deactivated:Connect(function()
	Activated = false
end)
