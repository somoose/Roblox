local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Camera = workspace.CurrentCamera

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Mouse = {
	FilterList = {Character},
	FilterType = Enum.RaycastFilterType.Blacklist
}

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Mouse.FilterType
RaycastParams.FilterDescendantsInstances = Mouse.FilterList

local function UpdateRaycastParams ()
	RaycastParams.FilterType = Mouse.FilterType
	RaycastParams.FilterDescendantsInstances = Mouse.FilterList
end

function Mouse:SetFilterType (FilterType)
	Mouse.FilterType = FilterType
	UpdateRaycastParams()
end

function Mouse:ClearFilterList ()
	table.clear(Mouse.FilterList)
	UpdateRaycastParams()
end

function Mouse:AddToFilterList (...)
	for _, Instance in pairs({...}) do
		if not table.find(Mouse.FilterList, Instance) then
			table.insert(Mouse.FilterList, Instance)
		end
	end
	UpdateRaycastParams()
end

function Mouse:RemoveFromFilterList (...)
	for _, Instance in pairs({...}) do
		local Index = table.find(Mouse.FilterList, Instance)

		if Index then
			table.remove(Mouse.FilterList, Index)
		end
	end
	UpdateRaycastParams()
end

local function GetMouseRaycastResult ()
	local MouseLocation = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
	local ScreenRay = Camera:ScreenPointToRay(MouseLocation.X, MouseLocation.Y)

	local Origin = Camera.CFrame.Position
	local Direction = ScreenRay.Direction * 1e10

	local Result = workspace:Raycast(Origin, Direction, RaycastParams)

	return Result, Origin, Direction.Unit or {}, Vector3.zero, Vector3.zero
end

local RaycastCache = {
	Origin = nil,
	Direction = nil,
	Result = nil
}

local function UpdateRaycastCache ()
	local Result, Origin, Direction = GetMouseRaycastResult()

	RaycastCache.Result = Result or {}
	RaycastCache.Origin = Origin or Vector3.zero
	RaycastCache.Direction = Direction or Vector3.zero
end

local MouseMetaTable = {
	__index = function (table, index)
		if index == "Position" or index == "Target" or index == "Normal" or index == "Direction" or index == "Distance" then
			UpdateRaycastCache()
		end
		
		if index == "Position" then
			return RaycastCache.Result.Position or Vector3.zero
		elseif index == "Target" then
			return RaycastCache.Result.Instance
		elseif index == "Normal" then
			return RaycastCache.Result.Normal or Vector3.zero
		elseif index == "Direction" then
			return RaycastCache.Direction
		elseif index == "Distance" then
			return (Mouse.Position - RaycastCache.Origin).Magnitude
		end
		
		return rawget(table, index)
	end,
	__newindex = function (table, index, value)
		warn("Mouse is locked through metatable.")
	end
}
setmetatable(Mouse, MouseMetaTable)

return Mouse
