-- Apparate, move yourself or any other players any amount in any direction.
-- r/apparate/X/Y/Z/(player or display name)

function GetPlayerFromPlayers (Username)
	if not Username then return end
	
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Username) == Username:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Username) == Username:lower() then return Player end
	end
end

local args = {...}

local X = tonumber(args[1])
local Y = tonumber(args[2])
local Z = tonumber(args[3])

local Player = GetPlayerFromPlayers(args[4])

if Player then
	Player.Character:PivotTo(Player.Character:GetPivot() * CFrame.new(X, Y, Z))
else
	owner.Character:PivotTo(owner.Character:GetPivot() * CFrame.new(X, Y, Z))
end
