local Life = loadstring(game.HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/utilities/modules/GameOfLife.lua"))()

local LSB_PARAMS = {...}

local X = tonumber(LSB_PARAMS[1]) or 40
local Y = tonumber(LSB_PARAMS[2]) or 40
local XS = tonumber(LSB_PARAMS[3]) or 1
local YS = tonumber(LSB_PARAMS[4]) or 1

local GameObj, GameModel = Life.new(X, Y, XS, YS)
GameModel.Parent = script
GameModel:PivotTo(CFrame.new(owner.Character.Head.Position + Vector3.new(0, owner.Character.Head.Size.Y/2 + 0.5, 0)))

local GridPart = Instance.new("Part", GameModel)
GridPart.Anchored = true
GridPart.CanQuery = false
GridPart.CanCollide = false
GridPart.CanTouch = false
GridPart.Size = Vector3.new(X * XS, 0, Y * YS)
GridPart.CFrame = GameModel:GetPivot() * CFrame.new(0, GridPart.Size.Y/2 + 0.5, 0)
GridPart.Transparency = 1

local GridTexture = Instance.new("Texture", GridPart)
GridTexture.Texture = "http://www.roblox.com/asset/?id=74407047721050"
GridTexture.Face = Enum.NormalId.Top
GridTexture.StudsPerTileU = XS
GridTexture.StudsPerTileV = YS
GridTexture.Color3 = Color3.fromRGB(50, 50, 50)

local OutlineThickness = 1

local Button = Instance.new("Part", GameModel)
Button.Anchored = true
Button.Color = GridTexture.Color3
Button.Size = Vector3.new(X * XS + OutlineThickness * 2, 0.99, Y * YS + OutlineThickness * 2)
Button.CFrame = GameModel:GetPivot() * CFrame.new(0, -(1 - Button.Size.Y), 0)
Button.Material = Enum.Material.SmoothPlastic

local ClickDetector = Instance.new("ClickDetector", Button)
ClickDetector.MouseClick:Connect(function()
	GameObj:NextGeneration()
end)
