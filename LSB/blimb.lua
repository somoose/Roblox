local TestModel = LoadAssets(124860912232716):Get("TestModel")
TestModel.Parent = script

TestModel.VehicleSeat.MovementControl:Destroy()
TestModel.VehicleSeat.MovementClient:Destroy()

local ClientSource = [[
		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		local Players = game:GetService("Players")

		local Player = Players.LocalPlayer

		local BlimpModel = script.BlimpModelValue.Value
		local Base = BlimpModel.Base
		local AlignPosition = Base.AlignPosition
		local AlignOrientation = Base.AlignOrientation

		local HeightIncrement = 0.4 -- The speed the blimp increases and decreases height.
		local MovementIncrement = 30 -- The speed the blimp moves. (Velocity)
		local RotationIncrement = 1 -- The speed the blimp rotates in degrees.
		local MovementTilt = 5 -- The degrees that the blimp tilts forward when moving.
		local BarrelTilt = 5 -- The degrees that the blimp rolls when it rotates.
		local MaxHeight = 50 -- The max height in studs the blimp can reach.
		local MovementVelocityLerp = 0.1 -- The time variable used when lerping movement velocity.

		local CurrentAngle = Base.Orientation.Y -- The current angle of the blimp.
		local CurrentTilt = 0 -- The current tilt of the blimp.
		local CurrentBarrelTilt = 0 -- The current barrel roll tilt of the blimp.
		local Stopping = false -- Dictates whether the blimp is coming to a slow stop.

		local function UpdateOrientation ()
			AlignOrientation.CFrame = CFrame.Angles(0, math.rad(CurrentAngle), 0) * CFrame.Angles(math.rad(-CurrentTilt), 0, 0)
		end

		RunService.PostSimulation:Connect(UpdateOrientation)

		local Inputs = {
			{ -- Increase height.
				KeyCode = Enum.KeyCode.E,
				func = function ()
					if AlignPosition.Position.Y > MaxHeight then
						AlignPosition.Position = AlignPosition.Position + Vector3.new(0, MaxHeight - AlignPosition.Position.Y, 0)
					elseif AlignPosition.Position.Y == MaxHeight then
						return
					end
					AlignPosition.Position = AlignPosition.Position + Vector3.new(0, HeightIncrement, 0)
				end,
				Recursive = true -- Press and hold.
			},
			{ -- Decrease height.
				KeyCode = Enum.KeyCode.Q,
				func = function ()
					local Result = workspace:Raycast(BlimpModel.Base.Position, Vector3.yAxis * -1e5)
					if Result and math.abs(Result.Position.Y - AlignPosition.Position.Y) <= BlimpModel.Base.Size.Y * 6 then return end
					AlignPosition.Position = AlignPosition.Position - Vector3.new(0, HeightIncrement, 0)
				end,
				Recursive = true -- Press and hold.
			},
			{ -- Forward.
				KeyCode = Enum.KeyCode.W,
				func = function ()
					Stopping = false
					CurrentTilt = MovementTilt
					BlimpModel.Base.AssemblyLinearVelocity = BlimpModel.Base.AssemblyLinearVelocity:Lerp(Base.CFrame.LookVector * Vector3.new(1, 0, 1) * MovementIncrement, MovementVelocityLerp)
				end,
				endfunc = function ()
					Stopping = true
					task.spawn(function()
						while Stopping do
							BlimpModel.Base.AssemblyLinearVelocity = BlimpModel.Base.AssemblyLinearVelocity:Lerp(Vector3.zero, 0.1)
							if BlimpModel.Base.AssemblyLinearVelocity.Magnitude == 0 then break end
							task.wait()
						end
					end)
				end,
				Recursive = true -- Press and hold.
			},
			{ -- Left.
				KeyCode = Enum.KeyCode.A,
				func = function ()
					CurrentAngle = CurrentAngle + RotationIncrement
					CurrentBarrelTilt = -BarrelTilt
				end,
				Recursive = true -- Press and hold.
			},
			{ -- Backward.
				KeyCode = Enum.KeyCode.S,
				func = function ()
					Stopping = false
					BlimpModel.Base.AssemblyLinearVelocity = BlimpModel.Base.AssemblyLinearVelocity:Lerp(Base.CFrame.LookVector * -MovementIncrement, MovementVelocityLerp)
				end,
				endfunc = function ()
					Stopping = true
					task.spawn(function()
						while Stopping do
							BlimpModel.Base.AssemblyLinearVelocity = BlimpModel.Base.AssemblyLinearVelocity:Lerp(Vector3.zero, 0.1)
							if BlimpModel.Base.AssemblyLinearVelocity.Magnitude == 0 then break end
							task.wait()
						end
					end)
				end,
				Recursive = true -- Press and hold.
			},
			{ -- Right.
				KeyCode = Enum.KeyCode.D,
				func = function ()
					CurrentAngle = CurrentAngle - RotationIncrement
					CurrentBarrelTilt = BarrelTilt
				end,
				Recursive = true -- Press and hold.
			},
			{ -- Align. This is used to realign the blimp if it is flipped upside down and can't right itself.
				KeyCode = Enum.KeyCode.V,
				func = function ()
					AlignOrientation.RigidityEnabled = true
					task.wait(0.5)
					AlignOrientation.RigidityEnabled = false
				end,
				Recursive = false -- Press and hold.
			}
		}
		local ActiveInputs = {} -- Stores which inputs are currently pressed.

		UserInputService.InputBegan:Connect(function(Input, GPE)
			if GPE then return end
			
			if Input.UserInputType == Enum.UserInputType.Keyboard then
				for _, InputT in pairs(Inputs) do
					if Input.KeyCode == InputT.KeyCode then
						if InputT.Recursive then
							ActiveInputs[InputT.KeyCode] = true
							local i = 0
							repeat task.wait() i = i + 1 InputT.func(i)
							until not ActiveInputs[InputT.KeyCode]
							if InputT.endfunc then InputT.endfunc() end
							CurrentTilt = 0
							CurrentBarrelTilt = 0
						else
							InputT.func()
						end
					end
				end
			end
		end)
		UserInputService.InputEnded:Connect(function(Input, GPE)
			if GPE then return end

			if Input.UserInputType == Enum.UserInputType.Keyboard then
				for _, InputT in pairs(Inputs) do
					if Input.KeyCode == InputT.KeyCode then
						if InputT.Recursive then
							ActiveInputs[InputT.KeyCode] = false
						end
					end
				end
			end
		end)
	]]

NLS(
	ClientSource,
	TestModel.VehicleSeat
).Name = "MovementClient"
NS(
	[[
		local ARGS = {...}
		local ClientSource = ARGS[1]
		local Players = game:GetService("Players")

		local LastOccupant -- The last player who sat down.

		local ParkWhenExited = false -- Causes the blimp to automatically lower itself to the ground when the player exits the vehicle seat.
		local FreeFloatWhenParked = false -- Allows the blimp to be affects by velocity when parked.

		local VehicleSeat = script.Parent
		local BlimpModel = VehicleSeat.Parent

		local AlignPosition = BlimpModel.Base.AlignPosition
		local AlignOrientation = BlimpModel.Base.AlignOrientation

		AlignPosition.Position = BlimpModel.Base.Position
		AlignOrientation.CFrame = BlimpModel.Base.CFrame

		local MovementClient = VehicleSeat.MovementClient -- Cloneable local script.

		local BlimpModelValue = Instance.new("ObjectValue", MovementClient)
		BlimpModelValue.Name = "BlimpModelValue"
		BlimpModelValue.Value = script.Parent.Parent -- Make this lead to the model containing the blimp.

		local function SetBlimpNetworkOwner (Owner)
			for _, BasePart in pairs(BlimpModel:GetDescendants()) do
				if BasePart:IsA("BasePart") then
					BasePart:SetNetworkOwner(Owner)
				end
			end
		end

		VehicleSeat:GetPropertyChangedSignal("Occupant"):Connect(function()
			local Humanoid = VehicleSeat.Occupant
			if Humanoid then
				AlignPosition.MaxAxesForce = Vector3.new(0, 1e10, 0)
				AlignPosition.Enabled = true
				AlignOrientation.Enabled = true
				local Character = Humanoid.Parent
				local Player = Players:GetPlayerFromCharacter(Character)
				
				if Player then
					SetBlimpNetworkOwner(Player)
					local ls = NLS(ClientSource)
					MovementClient.BlimpModelValue:Clone().Parent = ls
					ls.Parent = Player.PlayerGui
					LastOccupant = Player
				end
			else -- Last player who sat down is getting up.
				if not FreeFloatWhenParked then
					AlignPosition.MaxAxesForce = Vector3.new(1e10, 1e10, 1e10)
				end
				for _, v in pairs(LastOccupant:GetDescendants()) do
					if v:IsA("LocalScript") and v.Name == MovementClient.Name then
						v:Destroy() -- Destroy the movement local script.
					end
				end
				if ParkWhenExited then
					local Result = workspace:Raycast(BlimpModel.Base.Position, Vector3.yAxis * -1e5)
					if Result then
						AlignPosition.Position = Result.Position
						AlignOrientation.CFrame = AlignOrientation.Attachment0.WorldCFrame
						repeat task.wait() until BlimpModel.Base.AssemblyLinearVelocity.Magnitude < 0.1
					end
					AlignPosition.Enabled = false
					AlignOrientation.Enabled = false
				else
					AlignPosition.Position = BlimpModel.Base.Position
					AlignOrientation.CFrame = CFrame.Angles(0, math.rad(BlimpModel.Base.Orientation.Y), 0)
					SetBlimpNetworkOwner(nil)
					BlimpModel.Base.AssemblyLinearVelocity = Vector3.zero
				end
			end
		end)--sped
	]],
	TestModel.VehicleSeat,
	ClientSource
).Name = "MovementControl"
