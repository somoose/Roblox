local npclib = {}

local players = game:GetService"Players"
local http = game:GetService"HttpService"

local animation = "https://raw.githubusercontent.com/redpawed/Public-Links/main/NPC-Animation"
local animationcode

pcall(function()
	animationcode = http:GetAsync(animation)
end)

function npclib.getrandom (parent, rigtype, conditions)
	local description
	local character
	local name
	local id
	
	local errors = {}
	
	local suc, er = pcall(function()
		if not conditions then
			id = math.random(10000000, 1000000000)
		else
			id = math.random(conditions[1], conditions[2])
		end

		description = players:GetHumanoidDescriptionFromUserId(id)
		character = players:CreateHumanoidModelFromDescription(description, rigtype)
		name = players:GetNameFromUserIdAsync(id)
	end)
	
	if suc then
		character.Name = name
		character:PivotTo(CFrame.new(0, 30, 0))
		
		character:WaitForChild"Humanoid"
		character:WaitForChild"HumanoidRootPart"
		
		character.Humanoid.DisplayName = name
		character.Parent = parent
		
		if animationcode then
			NS(animationcode, character)
		end
		
		return character, id, #errors
	else table.insert(errors, er)
		return npclib.getrandom(parent, rigtype, conditions), id, #errors
	end
end

function npclib.fetch (info, rigtype, parent)
	local description
	local character
	local name = players:GetNameFromUserIdAsync(info)
	
	if name then
		description = players:GetHumanoidDescriptionFromUserId(info)
	else
		local id = players:GetUserIdFromNameAsync(info)
		description = players:GetHumanoidDescriptionFromUserId(id)
	end
	
	character = players:CreateHumanoidModelFromDescription(description, rigtype)
	
	character.Name = name

	character:WaitForChild"Humanoid"
	character:WaitForChild"HumanoidRootPart"
	
	character:PivotTo(CFrame.new(0, 30, 0))
	character.Humanoid.DisplayName = name
	character.Parent = parent

	if animationcode then
		NS(animationcode, character)
	end
	
	return character
end

return npclib
