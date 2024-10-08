local Life = loadstring(game.HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/utilities/modules/GameOfLife.lua"))()

local LSB_PARAMS = {...}

local X = tonumber(LSB_PARAMS[1]) or 40
local Y = tonumber(LSB_PARAMS[2]) or 40
local XS = tonumber(LSB_PARAMS[3]) or 1
local YS = tonumber(LSB_PARAMS[4]) or 1

local GameObj, GameModel = Life.new(X, Y, XS, YS)
GameModel.Parent = script
GameModel:PivotTo(CFrame.new(owner.Character.Head.Position + Vector3.new(0, owner.Character.Head.Size.Y/2 + 0.5, 0)))

local Button = Instance.new("Part", GameModel)
Button.Anchored = true
Button.Size = Vector3.new(X, 1, 1)
Button.CFrame = GameModel:GetPivot() * CFrame.new(0, 0, Y/2 + Button.Size.Z/2)
Button.Color = Color3.fromRGB(255, 0, 0)
Button.Material = Enum.Material.SmoothPlastic

local ClickDetector = Instance.new("ClickDetector", Button)
ClickDetector.MouseClick:Connect(function()
	GameObj:NextGeneration()
end)
