local HttpService = game:GetService"HttpService"
local Players = game:GetService"Players"

local BaseAsset = "rbxassetid://"
local Anim = "https://raw.githubusercontent.com/redpawed/Public-Links/main/NPC-Animation"

local LocalPlayer = owner
local LocalCharacter = LocalPlayer.Character

function GenerateRandomNPC (Parent, RigType)
	local NPC
	local Name

	local s, e = pcall(function()
		local ID = math.random(10000000, 1000000000)
		local Desc = Players:GetHumanoidDescriptionFromUserId(ID)
		NPC = Players:CreateHumanoidModelFromDescription(Desc, RigType)
		Name = Players:GetNameFromUserIdAsync(ID)
	end)

	if s then
		NPC:PivotTo(CFrame.new(0, 30, 0))
		NS(HttpService:GetAsync(Anim), NPC)
		NPC.Name = Name
		NPC.Humanoid.DisplayName = Name
		NPC:WaitForChild"HumanoidRootPart"
		NPC.Parent = Parent
		return NPC
	else
		return GenerateRandomNPC(Parent, RigType)
	end
end

function FetchCharacterModel (Input, RigType, Parent)
	local NPC

	if not tonumber(Input) then
		local ID = Players:GetUserIdFromNameAsync(Input)
		local Desc = Players:GetHumanoidDescriptionFromUserId(ID)
		NPC = Players:CreateHumanoidModelFromDescription(Desc, RigType)

		NPC.Name = Players:GetNameFromUserIdAsync(ID)
		NPC.Humanoid.DisplayName = Players:GetNameFromUserIdAsync(ID)
		NPC.Parent = Parent
	else
		local Desc = Players:GetHumanoidDescriptionFromUserId(Input)
		NPC = Players:CreateHumanoidModelFromDescription(Desc, RigType)

		NPC.Name = Players:GetNameFromUserIdAsync(Input)
		NPC:WaitForChild"HumanoidRootPart"
		NPC.Parent = Parent
	end

	NPC:PivotTo(CFrame.new(0, 30, 0))
	NS(HttpService:GetAsync(Anim), NPC)
	return NPC
end

function RunAI (NPC, Target)
	if Target:FindFirstChild"Head" and Target:FindFirstChild"HumanoidRootPart" then
		local function SetNetworkOwner ()
			for _, BasePart in pairs(NPC:GetDescendants()) do
				if BasePart:IsA"BasePart" and not BasePart.Anchored then
					BasePart:SetNetworkOwner(Players:GetPlayerFromCharacter(Target) or nil)
				end
			end
		end

		SetNetworkOwner()

		local ActiveValue = Instance.new"BoolValue"
		ActiveValue.Value = true

		local TargetValue = Instance.new"ObjectValue"
		TargetValue.Value = Target

		TargetValue:GetPropertyChangedSignal"Value":Connect(function()
			Target = TargetValue.Value
			SetNetworkOwner()
		end)

		local function Looking (Part0, Part1)
			local IsLooking = false

			local A = Part0.CFrame.LookVector
			local B = (Part1.Position - Part0.Position).Unit

			local Dot = A:Dot(B)

			if Dot > 0.5 then
				IsLooking = true
			end

			return IsLooking
		end

		local BodyGyro = Instance.new"BodyGyro"
		BodyGyro.CFrame = NPC:GetPivot()
		BodyGyro.MaxTorque = Vector3.new(0, math.huge, 0)
		BodyGyro.Parent = nil

		spawn(function()
			while ActiveValue.Value and NPC.Humanoid.Health > 0 do task.wait()
				if Looking(Target.Head, NPC.Head) then
					NPC.Humanoid.AutoRotate = true
					NPC.Humanoid:Move(Vector3.new(0, -1, 0))
				else
					local Difference = Target.Head.Position - NPC.Head.Position

					if Difference.Magnitude > 5 then
						NPC.Humanoid:Move(Difference.Unit)
						BodyGyro.Parent = nil
						NPC.Humanoid.AutoRotate = true
					else
						NPC.Humanoid.AutoRotate = false
						BodyGyro.Parent = NPC.HumanoidRootPart
						BodyGyro.CFrame = Target.HumanoidRootPart.CFrame
						NPC.Humanoid:Move(Vector3.new(0, -1, 0))
						NPC.Humanoid:MoveTo((Target:GetPivot() * CFrame.new(0, 0, Target:GetExtentsSize().Z/3)).Position)
						task.wait(0.1)
						NPC.Humanoid:MoveTo((Target:GetPivot() * CFrame.new(0, 0, 5)).Position)
						task.wait(0.1)
					end
				end
			end
		end)

		return ActiveValue, TargetValue
	end
end

LocalPlayer.Chatted:Connect(function(Message)
	local Space = Message:split" "
	
	if Space[1]:lower() == "/spawn" then
		if Space[2]:lower() == "random" then
			local NPC = GenerateRandomNPC(script, Enum.HumanoidRigType.R6)
			local Active, Target = RunAI(NPC, LocalCharacter)

			spawn(function()
				while true do task.wait(15)
					Target.Value = Players:GetPlayers()[math.random(#Players:GetPlayers())].Character
				end
			end)
		else
			local NPC = FetchCharacterModel(Space[2], Enum.HumanoidRigType.R6, script)
			local Active, Target = RunAI(NPC, LocalCharacter)

			spawn(function()
				while true do task.wait(15)
					Target.Value = Players:GetPlayers()[math.random(#Players:GetPlayers())].Character
				end
			end)
		end
	end
end)

warn[[

"/spawn username"
"/spawn random"
]]
