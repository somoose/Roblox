local player = owner
local character = player.Character
local humanoid = character.Humanoid

if character:FindFirstChild"Animate" and character.Animate:FindFirstChild"idle" and character.Animate.idle:FindFirstChild"Animation2" then
	character.Animate.idle.Animation2:Destroy()
end

local bodycolor = Color3.fromRGB(125, 125, 125)

local description = Instance.new"HumanoidDescription"
description.WidthScale = 0.5
description.HeightScale = 0.5
description.DepthScale = 0.5
description.HeadScale = 0.5
description.Name = player.DisplayName
description.HatAccessory = "7097509286"
description.WaistAccessory = "7097514511"
description.Shirt = 8720364995
description.Pants = 8720366509
description.Face = 15432080
description.HeadColor = bodycolor
description.TorsoColor = bodycolor
description.LeftArmColor, description.RightArmColor = bodycolor, bodycolor
description.LeftLegColor, description.RightLegColor = bodycolor, bodycolor
description.Parent = script

humanoid:ApplyDescription(description)

local tail

for _, accessory in pairs(character:GetChildren()) do
	if accessory:IsA"Accessory" then
		if accessory.AccessoryType == Enum.AccessoryType.Waist then
			tail = accessory
			break
		end
	end
end

local weld = tail.Handle:FindFirstChildOfClass"Weld"
local defaultweld = weld.C0

task.spawn(function()
	local x = 0
	
	while true do x = x + 1 task.wait()
		weld.C0 = defaultweld * CFrame.Angles(
			math.rad(math.sin(x/14) * 8), math.rad(math.cos(x/28) * 20), 0
		)
	end
end)

local torso = character.Torso
local root = character.HumanoidRootPart
local neck = torso.Neck

local rootjoint = root.RootJoint
local neck = torso.Neck
local leftshoulder, rightshoulder = torso["Left Shoulder"], torso["Right Shoulder"]
local lefthip, righthip = torso["Left Hip"], torso["Right Hip"]

rootjoint.C0 *= CFrame.new(0, 0, -root.Size.Y/1.5)
	* CFrame.Angles(math.pi/2.05, 0, 0)
neck.C0 *= CFrame.new(0, root.Size.Y/8, 0)
	* CFrame.Angles(-math.pi/2, 0, 0)
leftshoulder.C0 *= CFrame.new(-root.Size.Z * 0.2, root.Size.Z/4, -root.Size.X/2.5)
	* CFrame.Angles(0, math.rad(-5), -math.pi/2.15)
rightshoulder.C0 *= CFrame.new(root.Size.Z * 0.2, root.Size.Z/4, -root.Size.X/2.5)
	* CFrame.Angles(0, math.rad(5), math.pi/2.15)
lefthip.C0 *= CFrame.new(root.Size.Z/3, 0, 0)
	* CFrame.Angles(0, math.rad(7.5), -math.pi/1.95)
righthip.C0 *= CFrame.new(-root.Size.Z/3, 0, 0)
	* CFrame.Angles(0, math.rad(-7.5), math.pi/1.95)

local defaultneck = neck.C0

task.spawn(function()
	local x = 0

	while true do x = x + 1 task.wait()
		neck.C0 = defaultneck * CFrame.Angles(
			0, math.rad(math.cos(x/12) * 6), 0
		)
	end
end)
