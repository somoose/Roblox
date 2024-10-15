local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://5943406060"
Sound.Looped = false

local function Honk (Index)
	if Index == 1 then
		Sound.TimePosition = 0
		Sound:Play()
		task.wait(0.5)
		Sound:Pause()
	elseif Index == 2 then
		Sound.TimePosition = 0.6
		Sound:Play()
		task.wait(0.4)
		Sound:Pause()
	elseif Index == 3 then
		Sound.TimePosition = 1.4
		Sound:Play()
		task.wait(0.6)
		Sound:Pause()
	elseif Index == 4 then
		Sound.TimePosition = 2
		Sound:Play()
		task.wait(0.5)
		Sound:Pause()
	elseif Index == 5 then
		Sound.TimePosition = 2.7
		Sound:Play()
		task.wait(0.5)
		Sound:Pause()
	end
end

local ClickPart = Instance.new("Part", script)
ClickPart.Size = owner.Character:GetExtentsSize()
ClickPart.Transparency = 1
ClickPart.CanCollide = false
ClickPart.CanTouch = false
ClickPart.CanQuery = true
ClickPart.Anchored = false
Sound.Parent = ClickPart

local Weld = Instance.new("Weld", ClickPart)
Weld.Part0 = ClickPart
Weld.Part1 = owner.Character.HumanoidRootPart

local ClickDetector = Instance.new("ClickDetector", ClickPart)

local ClickDebounce = false
ClickDetector.MouseClick:Connect(function(Player)
	if not ClickDebounce then
		ClickDebounce = true
		local HonkIndex = math.random(5)
		print(Player.Name .. " provoked a honk " .. HonkIndex)
		Honk(HonkIndex)
		ClickDebounce = false
	end
end)
