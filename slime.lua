local TweenService = game:GetService"TweenService"
local TweenService = game:GetService"TweenService"
local Players = game:GetService"Players"

local Player = owner
local Character = Player.Character

local PRNG = Random.new()

function NewSlime (Parent, Scale, TargetCharacter, Force, WalkSpeed)
	Force = Force or Scale * 16
	WalkSpeed = WalkSpeed or Scale * 14

	local Players = game:GetService"Players"
	local HttpService = game:GetService"HttpService"
	local TweenService = game:GetService"TweenService"
	
	local RandomName = "https://api.namefake.com/"
	
	local Colors = {
		BrickColor.new"Forest green",
		BrickColor.new"Deep blue",
		BrickColor.new"Carnation pink",
		BrickColor.new"Really red",
		BrickColor.new"Bright purple",
		BrickColor.new"Cool yellow",
	}
	
	local TargetValue = Instance.new"ObjectValue"
	TargetValue.Value = TargetCharacter
	
	TargetValue:GetPropertyChangedSignal"Value":Connect(function()
		TargetCharacter = TargetValue.Value
	end)
	
	local Model = Instance.new"Model"
	Model.Name = "Slime"
	Model.Parent = Parent
	
	local Humanoid = Instance.new("Humanoid", Model)
	
	task.spawn(function()
		pcall(function()
			local Table = HttpService:GetAsync(RandomName)
			Table = HttpService:JSONDecode(Table)

			local Name = Table.name
			local Space = Name:split" "

			if #Space == 2 then
				Name = Space[1]
			elseif #Space > 2 then
				Name = Space[2]
			end

			Humanoid.DisplayName = Name
		end)
	end)
	
	local Slime = Instance.new"Part"
	Slime.Name = "Head"

	Slime.Material = Enum.Material.SmoothPlastic
	Slime.Transparency = 0.5
	Slime.BrickColor = Colors[math.random(#Colors)]

	Slime.Size = Vector3.one * Scale
	Slime.CFrame = CFrame.new(0, 30, 0)
	Slime.CustomPhysicalProperties = 
		PhysicalProperties.new(
			Slime.AssemblyMass,
			0, 0, 0, 
			4
		)
	Slime.Parent = Model
	
	Humanoid:GetPropertyChangedSignal"Health":Connect(function()
		if Humanoid.Health < 1 then
			Model:Destroy()
		end
	end)

	local Attachment0 = Instance.new("Attachment", Slime)

	local AlignOrientation = Instance.new"AlignOrientation"
	AlignOrientation.Attachment0 = Attachment0
	AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	AlignOrientation.Responsiveness = 200
	AlignOrientation.RigidityEnabled = true
	AlignOrientation.Parent = Slime

	local Face = Instance.new"Decal"
	Face.Transparency = 0.75
	Face.Texture = "rbxassetid://296233945"
	Face.Parent = Slime

	--// Constant Variables \\
	local DefaultSize = Slime.Size

	local SquishTime = 0.25 -- Default: 0.25
	local Squish = DefaultSize.Y / 3

	local Info = TweenInfo.new(SquishTime, 0, 2, 0, true)
	--\\====================//

	local Debounce = false
	local DamageDebounce = false

	Slime.Touched:Connect(function(BasePart)
		if not DamageDebounce then DamageDebounce = true
			if BasePart.Parent:FindFirstChildOfClass"Humanoid" and BasePart.Parent.Name ~= "Slime" then
				BasePart.Parent.Humanoid:TakeDamage(Slime.Size.Magnitude/2)
			end
			task.wait(SquishTime) DamageDebounce = false
		end
		
		if not Debounce and not BasePart.Parent:FindFirstChildOfClass"Humanoid" then Debounce = true
			Slime.AssemblyLinearVelocity = Vector3.new(0, -Force/4, 0) -- Push down 

			TweenService:Create(Slime, Info,
				{
					Size = DefaultSize - Vector3.new(0, Squish, 0),
				}
			):Play() -- Compressing size

			task.wait(SquishTime * 2)

			Slime.AssemblyLinearVelocity = Vector3.new(0, Force, 0) -- Push up

			TweenService:Create(Slime, Info,
				{
					Size = DefaultSize + Vector3.new(-Squish/2, Squish/1.5, -Squish/2),
				}
			):Play() -- Stretching in size

			local RootPart = TargetCharacter.HumanoidRootPart.Position
			RootPart = Vector3.new(RootPart.X, Slime.Position.Y, RootPart.Z)

			local Difference = RootPart - Slime.Position

			AlignOrientation.CFrame = CFrame.lookAt(Slime.Position, Slime.Position + Difference.Unit)

			if Difference.Magnitude > -100 then
				Slime.AssemblyLinearVelocity += Difference.Unit * WalkSpeed
			end
			task.wait(SquishTime) Debounce = false 
		end
	end)
	
	return Slime, TargetValue
end

function GetRandomPlayer ()
	local Player = Players:GetChildren()[math.random(#Players:GetChildren())]
	
	if Player.Character and Player.Character:FindFirstChild"HumanoidRootPart" then
		return Player.Character
	else
		return GetRandomPlayer()
	end
end

local Tool = Instance.new"Tool"
Tool.Name = "Slime"
Tool.Parent = Player.Backpack

local Handle = Instance.new"Part"
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Transparency = 0.5
Handle.Material = Enum.Material.SmoothPlastic
Handle.BrickColor = BrickColor.new"Forest green"
Handle.Parent = Tool

function CallSlime ()
    local Slime, Target = 
		NewSlime(script, PRNG:NextNumber(0.5, 5), GetRandomPlayer())
	
	Slime.CFrame = Handle.CFrame
	
	task.spawn(function()
		while true do task.wait(6)
			Target.Value = GetRandomPlayer()
		end
	end)
end

Tool.Activated:Connect(CallSlime)
