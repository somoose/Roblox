local X = 1000 -- Amount of parts.
local XScale = 2048 -- Scale of each part along the X axis. (Max: 2048)
local Width = workspace.Base.Size.Z -- Scale of each part along the Z axis.
local WallThickness = 20 -- The thickness of the walls. (They are offsetted by this number)
local WallHeight = 400 -- The height of the walls. (They are offsetted by this number)
local RampHeight = 50 -- The height of the wedges optionally applied to the top of each part.
local MakeRamps = false
local RotateEverySecondRamp = true
local SubtractWallThickness = true
if SubtractWallThickness then Width = Width - WallThickness * 2 end

local function CloneBase (Parent)
	local Clone = workspace.Base:Clone()
	Clone.Parent = Parent
	local SpawnLocation = Clone:FindFirstChildWhichIsA("SpawnLocation")
	if SpawnLocation then
		SpawnLocation:Destroy()
	end
	Clone.Size = Vector3.new(XScale, workspace.Base.Size.Y, Width)
	return Clone
end

for x = 0, X do
	if x % 100 == 0 then task.wait() end -- Delay every 100 iterations.
	local Clone = CloneBase(script)
	Clone.CFrame = workspace.Base.CFrame * CFrame.new(workspace.Base.Size.X/2 + x * XScale + XScale/2, 0, 0)

	if MakeRamps then
		local Wedge = Clone:Clone()
		Wedge.Size = Vector3.new(Clone.Size.Z, RampHeight, Clone.Size.X)
		Wedge.CFrame = Clone.CFrame * CFrame.new(0, Clone.Size.Y/2 + RampHeight/2, 0) * CFrame.Angles(0, math.pi/2, 0)
		Wedge.Shape = Enum.PartType.Wedge
		Wedge.Parent = Clone

		if RotateEverySecondRamp then
			if x % 2 ~= 0 then
				Wedge.CFrame = Wedge.CFrame * CFrame.Angles(0, math.pi, 0)
			end
		end
	end

	local LeftWall = CloneBase(Clone)
	LeftWall.Size = Vector3.new(Clone.Size.X, Clone.Size.Y + WallHeight, WallThickness)
	LeftWall.CFrame = Clone.CFrame * CFrame.new(0, WallHeight/2, Clone.Size.Z/2 + WallThickness/2)

	local RightWall = CloneBase(Clone)
	RightWall.Size = Vector3.new(Clone.Size.X, Clone.Size.Y + WallHeight, WallThickness)
	RightWall.CFrame = Clone.CFrame * CFrame.new(0, WallHeight/2, -Clone.Size.Z/2 - WallThickness/2)

	if x == X then
		local Wall = CloneBase(Clone)
		Wall.Size = Vector3.new(WallThickness, WallHeight, Width)
		Wall.CFrame = Clone.CFrame * CFrame.new(Clone.Size.X/2, WallHeight/2, 0)
	end
end
