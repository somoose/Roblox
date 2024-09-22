local LSB_PARAMS = {...}

local function GetPlayer (Text)
	if not Text or Text == "" then return end

	Text = Text:lower()
	
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Text) == Text or Player.DisplayName:lower():sub(1, #Text) == Text then
			return Player
		end
	end
end

owner = GetPlayer(LSB_PARAMS[1]) or owner

-- Make character undetectable by touched events and queries (that don't use BruteForceAllSlow)
local function DisableQueryAndTouch (Character)
	for _, BasePart in pairs(owner.Character:GetDescendants()) do
		if not BasePart:IsA("BasePart") then continue end
		BasePart.CanTouch = false
		BasePart.CanQuery = false
	end
end
DisableQueryAndTouch(owner.Character)
owner.CharacterAdded:Connect(DisableQueryAndTouch)
