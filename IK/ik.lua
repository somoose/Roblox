IK = {}

IK.MakeArm = function (NumberOfSegments, SegmentLength, SegmentThickness, CreateJoints, Properties)
	local Segments = {}
	local PreviousSegment = nil

	local Model = Instance.new("Model", script)
	Model.Name = "ArmModel"

	for i = 1, NumberOfSegments do
		local Thickness = SegmentThickness
		if type(SegmentThickness) == "function" then Thickness = SegmentThickness(i) end
		
		local Segment = Instance.new("Part", Model)
		Segment.Name = "Segment" .. i
		
		Segment.Anchored = false
		Segment.CanCollide = false
		
		Segment.Size = Vector3.new(Thickness, Thickness, SegmentLength)
		Segment.CFrame = CFrame.new(Vector3.new(i * SegmentLength, 5, 0), Vector3.new(i * SegmentLength * 2, 5, 0))

		for Property, Value in pairs(Properties) do
			Segment[Property] = Value
		end

		if CreateJoints then
			if PreviousSegment then
				local Motor6D = Instance.new("Motor6D", PreviousSegment)
				Motor6D.Part0 = PreviousSegment
				Motor6D.Part1 = Segment
				Motor6D.C0 = CFrame.new(0, 0, -PreviousSegment.Size.Z)

				Segments[i-1].Joint = Motor6D

				if i - 1 == 1 then
					local ShoulderMotor6D = Instance.new("Motor6D", PreviousSegment)
					ShoulderMotor6D.Part0 = PreviousSegment
					ShoulderMotor6D.Name = "ShoulderJoint"

					Segments[i-1].ShoulderJoint = ShoulderMotor6D
				end
			end
		end
		
		Segments[i] = {Segment = Segment}

		PreviousSegment = Segment
	end

	return Segments, Model
end

IK.GetEnd = function (Segment, d)
	-- 1 returns the tail end, -1 returns the head end
	return (Segment.CFrame * CFrame.new(0, 0, Segment.Size.Z/2 * d)).Position
end

IK.GetCurrentPosition = function (Arm)
	return IK.GetEnd(Arm[#Arm].Segment, -1)
end

IK.MoveSegment = function (Arm, Index, Position)
	local Segment = Arm[Index].Segment

	Segment.CFrame = CFrame.new(IK.GetEnd(Segment, 1), Position)
	Segment.CFrame = Segment.CFrame * CFrame.new(0, 0, -(IK.GetEnd(Segment, -1) - Position).Magnitude)
end

IK.MoveArm = function (Arm, Origin, Destination)
	for i = 1, 1 do
		IK.MoveSegment(Arm, #Arm, Destination)
		
		for i = #Arm - 1, 1, -1 do
			IK.MoveSegment(Arm, i, IK.GetEnd(Arm[i + 1].Segment, 1))
		end

		if Origin then
			local Offset = IK.GetEnd(Arm[1].Segment, 1) - Origin

			for i = 1, #Arm do
				Arm[i].Segment.Position = Arm[i].Segment.Position - Offset
			end
		end
	end
end




local SnakeArm, SnakeModel = IK.MakeArm(25, 1, 0.25, nil, {Anchored = false, CanCollide = false})

for i, t in pairs(SnakeArm) do
	local Segment = t.Segment
	Segment:SetNetworkOwner(owner)
end

owner.Character = SnakeModel

local RemoteFunction = Instance.new("RemoteFunction", owner.PlayerGui)
RemoteFunction.Name = "getTable"
RemoteFunction.OnServerInvoke = function ()
	return SnakeArm
end

NLS([[
local UIS = game:GetService("UserInputService")

local RemoteFunction = owner.PlayerGui:FindFirstChild"getTable" or owner.PlayerGui:WaitForChild"getTable"

local SnakeArm = RemoteFunction:InvokeServer()

for i, t in pairs(SnakeArm) do
	local Segment = t.Segment
	Segment.Anchored = false
	local Attachment0 = Instance.new("Attachment", Segment)
	local AlignPosition = Instance.new("AlignPosition", Segment)
	local AlignOrientation = Instance.new("AlignOrientation", Segment)

	AlignPosition.Attachment0 = Attachment0
	AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
	AlignPosition.MaxForce = Vector3.one * math.huge
	AlignPosition.RigidityEnabled = true
	AlignPosition.Responsiveness = true

	AlignOrientation.Attachment0 = Attachment0
	AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	AlignOrientation.MaxTorque = Vector3.one * math.huge
	AlignOrientation.RigidityEnabled = true
	AlignOrientation.Responsiveness = true

	t.AlignPosition = AlignPosition
	t.AlignOrientation = AlignOrientation
end

local IK = {}

IK.GetEnd = function (Segment, d)
	-- 1 returns the tail end, -1 returns the head end
	return (Segment.CFrame * CFrame.new(0, 0, Segment.Size.Z/2 * d)).Position
end

IK.GetCurrentPosition = function (Arm)
	return IK.GetEnd(Arm[#Arm].Segment.AlignPosition.Position, -1)
end

IK.MoveSegment = function (Arm, Index, Position)
	local Segment = Arm[Index].Segment
	local AlignPosition = Segment.AlignPosition
	local AlignOrientation = Segment.AlignOrientation

	local DesiredCFrame = CFrame.new(IK.GetEnd(Segment, 1), Position)
	DesiredCFrame = DesiredCFrame * CFrame.new(0, 0, -(IK.GetEnd(Segment, -1) - Position).Magnitude)

	Segment.CFrame = DesiredCFrame

	--AlignPosition = DesiredCFrame.Position
	--AlignOrientation = DesiredCFrame
end

IK.MoveArm = function (Arm, Origin, Destination)
	for i = 1, 1 do
		IK.MoveSegment(Arm, #Arm, Destination)
		
		for i = #Arm - 1, 1, -1 do
			IK.MoveSegment(Arm, i, IK.GetEnd(Arm[i + 1].Segment, 1))
		end

		if Origin then
			local Offset = IK.GetEnd(Arm[1].Segment, 1) - Origin

			for i = 1, #Arm do
				Arm[i].AlignPosition.Position = Arm[i].AlignPosition.Position - Offset
			end
		end
	end
end

local Camera = workspace.CurrentCamera

Camera.CameraSubject = SnakeArm[#SnakeArm].Segment

local W_DOWN = false
local A_DOWN = false
local S_DOWN = false
local D_DOWN = false

local speed = 1

UIS.InputBegan:Connect(function(Input, GPE)
	if GPE then return end

	if Input.KeyCode == Enum.KeyCode.W then
		W_DOWN = true
		repeat
			IK.MoveArm(SnakeArm, nil, IK.GetCurrentPosition(SnakeArm) + Camera.CFrame.LookVector * speed)
			task.wait()
		until not W_DOWN
	elseif Input.KeyCode == Enum.KeyCode.A then
		A_DOWN = true
		repeat
			IK.MoveArm(SnakeArm, nil, IK.GetCurrentPosition(SnakeArm) - Camera.CFrame.RightVector * speed)
			task.wait()
		until not A_DOWN
	elseif Input.KeyCode == Enum.KeyCode.S then
		S_DOWN = true
		repeat
			IK.MoveArm(SnakeArm, nil, IK.GetCurrentPosition(SnakeArm) - Camera.CFrame.LookVector * speed)
			task.wait()
		until not S_DOWN
	elseif Input.KeyCode == Enum.KeyCode.D then
		D_DOWN = true
		repeat
			IK.MoveArm(SnakeArm, nil, IK.GetCurrentPosition(SnakeArm) + Camera.CFrame.RightVector * speed)
			task.wait()
		until not D_DOWN
	end
end)

UIS.InputEnded:Connect(function(Input, GPE)
	if GPE then return end

	if Input.KeyCode == Enum.KeyCode.W then
		W_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.A then
		A_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.S then
		S_DOWN = false
	elseif Input.KeyCode == Enum.KeyCode.D then
		D_DOWN = false
	end
end)
]], owner.PlayerGui)
