-- Update to use RunService
-- (bypasses HyperNull: when stack overflow causes signals to not fire)

local Lock = {List = {}}
function Lock:LockProperties (Instance, Properties)
	local InstanceList = self.List[Instance]
	if not InstanceList then
		InstanceList = {}
		self.List[Instance] = InstanceList
	end
	for Property, Value in pairs(Properties) do
		if InstanceList[Property] then
			InstanceList[Property].Connection:Disconnect()
			InstanceList[Property] = nil
		end
		Instance[Property] = Value
		local Connection = Instance:GetPropertyChangedSignal(Property):Connect(function()
			if Instance[Property] ~= Value then
				Instance[Property] = Value
			end
		end)
		InstanceList[Property] = {
			Value = Value,
			Connection = Connection
		}
	end
end
function Lock:UnlockProperties (Instance, Properties)
	local InstanceList = self.List[Instance]
	if not InstanceList then
		return
	end
	for _, Property in pairs(Properties) do
		local t = InstanceList[Property]
		t.Connection:Disconnect()
		InstanceList[Property] = nil
	end
end
function Lock:UnlockAllProperties (Instance)
	local InstanceList = self.List[Instance]
	for Property, t in pairs(InstanceList) do
		t.Connection:Disconnect()
		InstanceList[Property] = nil
	end
end
function Lock:ClearAllLockedProperties ()
	local List = self.List
	for _, InstanceList in pairs(List) do
		for Property, t in pairs(InstanceList) do
			t.Connection:Disconnect()
		end
	end
	table.clear(List)
end
function Lock:GetLockedProperties (Instance)
	local InstanceList = self.List[Instance]
	local Properties = {}
	for Property, t in pairs(InstanceList) do
		Properties[Property] = t.Value
	end
	return Properties
end
-- Make this return a function that disables the recreation.
function Lock:RecreateWhenDestroyed (Instance)
	local Parent = Instance.Parent
	local t = {}
	t.Event = function ()
		local Properties = self:GetLockedProperties(Instance)
		local New = Instance:Clone()
		New.Parent = Parent -- You can't set up signals on parts with nil parents.
		self:LockProperties(New, Properties)
		if Properties.CFrame then
			New.CFrame = Properties.CFrame
		end
		Instance:Destroy() -- Disconnects all events connected to prior Instance.
		Instance = New
		t.Connect()
	end
	t.Connect = function ()
		Instance:GetPropertyChangedSignal("Parent"):Connect(function()
			if Instance.Parent ~= Parent then
				t.Event()
			end
		end)
	end
	t.Connect()
	return function ()
		return Instance -- Return the current instance.
	end
end

local BASE = {}
BASE.__index = BASE
BASE.Skins = {
	Default = {
		Material = Enum.Material.SmoothPlastic,
		Color = Color3.fromRGB(91, 91, 91)
	},
	Grass = {
		Material = Enum.Material.Grass,
		Color = BrickColor.new("Forest green").Color
	},
	Red = {
		Material = Enum.Material.Grass,
		Color = BrickColor.new("Maroon").Color
	},
	Blue = {
		Material = Enum.Material.Grass,
		Color = BrickColor.new("Storm blue").Color
	}
}
BASE.SelectedSkin = BASE.Skins.Blue
BASE.ApplyTexture = true
BASE.ApplyWalls = true
BASE.DefaultSize = Vector3.new(200, 10, 200)
BASE.PropertiesToBeLocked = {
	"Name",
	"Anchored",
	"CanCollide",
	"CastShadow",
	"Locked",
	"Shape",
	"Material",
	"Color",
	"Size",
	"Color",
	"CFrame"
}
function BASE:GetProperties (BasePart)
	if BasePart then
		local Properties = {}
		for _, Property in pairs(self.PropertiesToBeLocked) do
			Properties[Property] = BasePart[Property]
		end
		return Properties
	else
		return {
			Name = "LockedBase",
			Anchored = true,
			CanCollide = true,
			CastShadow = true,
			Locked = true,
			Shape = Enum.PartType.Block,
			Material = BASE.SelectedSkin.Material,
			Reflectance = 0,
			Transparency = 0,
			Color = BASE.SelectedSkin.Color,
			Size = self.DefaultSize,
			Position = Vector3.new(
				math.random(-100000, 100000),
				math.random(100000),
				math.random(-100000, 100000)
			)
		}
	end
end
function BASE:new (Player)
	local OBJ = setmetatable({}, BASE)

	local Part = Instance.new("Part", workspace)
	Lock:LockProperties(Part, OBJ:GetProperties())
	OBJ.GetPart = Lock:RecreateWhenDestroyed(Part)
	if OBJ.ApplyTexture then
		OBJ:AddTexture()
	end
	if OBJ.ApplyWalls then
		OBJ:AddWalls()
	end

	Player.Chatted:Connect(function(Message)
		local Sections = Message:split("/")
		if Sections[1] == "b" then
			if Sections[2] == "return" then
				OBJ:Bring(owner)
			elseif Sections[2] == "size" then
				local X, Y, Z = tonumber(Sections[3]), tonumber(Sections[4]), tonumber(Sections[5])
				OBJ:ChangeSize(Vector3.new(X, Y, Z))
			elseif Sections[2] == "color" then
				
			elseif Sections[2] == "walls" then
				OBJ:AddWalls()
			elseif Sections[2] == "nowalls" then
				
			end
		end
	end)

	return OBJ
end
function BASE:AddTexture ()
	local Texture = Instance.new("Texture", self.GetPart())
	Texture.Texture = "rbxassetid://6372755229"
	Texture.Transparency = 0.8
	Texture.Color3 = Color3.fromRGB()
	Texture.StudsPerTileU = 8
	Texture.StudsPerTileV = 8
	Texture.Face = Enum.NormalId.Top
end
function BASE:ChangeSize (Size)
	Lock:LockProperties(self.GetPart(), {Size = Size})
end
function BASE:Bring (...) 
	local Part = self.GetPart()
	for _, Player in pairs({...}) do
		local Character = Player.Character
		Character:PivotTo(Part.CFrame * CFrame.new(0, Part.Size.Y/2 + Character:GetExtentsSize().Y/2, 0))
	end
end
function BASE:GetWallPart (Parent)
	local Part = Instance.new("Part", Parent)
	Part.Material = self.GetPart().Material
	Part.Color = self.GetPart().Color
	Part.Anchored = true
	return Part
end
function BASE:AddWalls (WallHeight, WallThickness)
	local Base = self.GetPart()
	WallHeight = WallHeight or Base.Size.X/3
	WallThickness = WallThickness or 2
	local BaseCFrame = Base.CFrame
	local BaseSize = Base.Size

	local Walls = {}
	local WallLeft = self:GetWallPart(workspace)
	local WallRight = self:GetWallPart(workspace)
	local WallBack = self:GetWallPart(workspace)
	local WallFront = self:GetWallPart(workspace)
	table.insert(Walls, WallLeft)
	table.insert(Walls, WallRight)
	table.insert(Walls, WallBack)
	table.insert(Walls, WallFront)
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
	for _, Wall in pairs(Walls) do
		local Properties = self:GetProperties()
		Properties.Size = Wall.Size
		Properties.CFrame = Wall.CFrame
		Lock:LockProperties(Wall, Properties)
		Lock:RecreateWhenDestroyed(Wall)
	end
	self.WALLS = Walls
end
function BASE:RemoveWalls ()
	
end

local Base = BASE:new(owner)
Base:Bring(owner)
