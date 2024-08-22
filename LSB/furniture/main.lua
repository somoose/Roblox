local HttpService = game:GetService("HttpService")

local Furniture = { -- Make sure to return the final model.
	Bench = "https://raw.githubusercontent.com/somoose/Roblox/master/LSB/furniture/serialised/bench.lua",
	Chair = "https://raw.githubusercontent.com/somoose/Roblox/master/LSB/furniture/serialised/chair.lua,
	Stool = "https://raw.githubusercontent.com/somoose/Roblox/master/LSB/furniture/serialised/stool.lua",
	Table = "https://raw.githubusercontent.com/somoose/Roblox/master/LSB/furniture/serialised/table.lua",
	Jenga = "https://raw.githubusercontent.com/somoose/Roblox/master/LSB/furniture/serialised/jenga.lua"
}

local args = {...}
if args[1]:lower() == "get" then for name,_ in pairs(Furniture) do print(name) end return end
local func

local amount = tonumber(args[2]) or 1
local scale = tonumber(args[3]) or 1

for name, link in pairs(Furniture) do
	if args[1]:lower() == name:lower():sub(1, #args[1]) then
		func = loadstring(HttpService:GetAsync(link))
	end
end

local mainmodel = func()
mainmodel:ScaleTo(scale)
mainmodel.Parent = workspace
local modelsize = mainmodel:GetExtentsSize()
mainmodel.Parent = nil

local characterpivot = owner.Character:GetPivot()
local charactersize = owner.Character:GetExtentsSize()
local feetheight = characterpivot * CFrame.new(0, -charactersize.Y/2, 0)

local modelsize = mainmodel:GetExtentsSize()
local modelpivot = feetheight * CFrame.new(0, 0, -charactersize.Z/2 + -modelsize.Z/2)

for i = 1, amount do task.wait()
	local model = i ~= amount and mainmodel:Clone() or mainmodel
	model:PivotTo(modelpivot * CFrame.new(0, (i - 1) * modelsize.Y, 0))
	model.Parent = workspace
end
