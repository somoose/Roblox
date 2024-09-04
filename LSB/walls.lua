local ARGS = {...}

local BaseSize = workspace.Base.Size
local BaseCFrame = workspace.Base.CFrame

local WallHeight = BaseSize.X / tonumber(ARGS[1] or 3) or 3
local WallThickness = tonumber(ARGS[2] or 4) or 4

function GetPart (Parent)
	local Part = Instance.new("Part", Parent)
	Part.Material = workspace.Base.Material
	Part.Color = workspace.Base.Color
	Part.Anchored = true
	Part.CanQuery = false
	
	return Part
end
 
function CreateWalls (WallHeight, WallThickness)
	local WallsFolder = Instance.new("Folder", workspace)
	WallsFolder.Name = "Walls"
	
	local WallLeft = GetPart(WallsFolder)
	local WallRight = GetPart(WallsFolder)
	local WallBack = GetPart(WallsFolder)
	local WallFront = GetPart(WallsFolder)
	
	WallLeft.Name = "Left Wall"
	WallLeft.Size = Vector3.new(WallThickness, WallHeight, BaseSize.X)
	WallLeft.CFrame = BaseCFrame * CFrame.new(-BaseSize.X/2, BaseSize.Y/2 + WallLeft.Size.Y/2, 0)
	
	WallRight.Name = "Right Wall"
	WallRight.Size = Vector3.new(WallThickness, WallHeight, BaseSize.X)
	WallRight.CFrame = BaseCFrame * CFrame.new(BaseSize.X/2, BaseSize.Y/2 + WallRight.Size.Y/2, 0)
	
	WallBack.Name = "Back Wall"
	WallBack.Size = Vector3.new(BaseSize.X, WallHeight, WallThickness)
	WallBack.CFrame = BaseCFrame * CFrame.new(0, BaseSize.Y/2 + WallBack.Size.Y/2, BaseSize.X/2)
	
	WallFront.Name = "Front Wall"
	WallFront.Size = Vector3.new(BaseSize.X, WallHeight, WallThickness)
	WallFront.CFrame = BaseCFrame * CFrame.new(0, BaseSize.Y/2 + WallFront.Size.Y/2, -BaseSize.X/2)
end

CreateWalls(WallHeight, WallThickness)
