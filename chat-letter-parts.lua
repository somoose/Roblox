local alphabet_meshes = {
	["v"] = "rbxassetid://3255271899",
	["w"] = "rbxassetid://3255271820",
	["y"] = "rbxassetid://3255271675",
	["x"] = "rbxassetid://3255271755",
	["p"] = "rbxassetid://3255272297",
	["q"] = "rbxassetid://3255272233",
	["r"] = "rbxassetid://3255272168",
	["z"] = "rbxassetid://3255265947",
	["l"] = "rbxassetid://3255266778",
	["m"] = "rbxassetid://3255266697",
	["s"] = "rbxassetid://3255272100",
	["n"] = "rbxassetid://3255266625",
	["o"] = "rbxassetid://3255266550",
	["u"] = "rbxassetid://3255271964",
	["t"] = "rbxassetid://3255272028",
	["k"] = "rbxassetid://3255266841",
	["g"] = "rbxassetid://3255272520",
	["j"] = "rbxassetid://3255266921",
	["e"] = "rbxassetid://3255272664",
	["h"] = "rbxassetid://3255272444",
	["f"] = "rbxassetid://3255272594",
	["c"] = "rbxassetid://3255272808",
	["d"] = "rbxassetid://3255272733",
	["i"] = "rbxassetid://3255272374",
	["a"] = "rbxassetid://3255272951",
	["b"] = "rbxassetid://3255272874",
	[":"] = "rbxassetid://3255269859",
	["|"] = "rbxassetid://3255265792",
	["!"] = "rbxassetid://3255275935",
	["&"] = "rbxassetid://3255275500",
	["^"] = "rbxassetid://3255267521",
	["$"] = "rbxassetid://3255275649",
	["%"] = "rbxassetid://3255275563",
	["£"] = "rbxassetid://3265135425",
	["<"] = "rbxassetid://3255269700",
	[">"] = "rbxassetid://3255269408",
	["{"] = "rbxassetid://3255265870",
	["]"] = "rbxassetid://3255267591",
	["*"] = "rbxassetid://3255270827",
	["}"] = "rbxassetid://3255265726",
	["."] = "rbxassetid://3255270523",
	[","] = "rbxassetid://3255270678",
	["["] = "rbxassetid://3255267711",
	[")"] = "rbxassetid://3255275319",
	["\""] = "rbxassetid://3255275870",
	["("] = "rbxassetid://3255275383",
	["_"] = "rbxassetid://3255267460",
	["-"] = "rbxassetid://3255270599",
	["+"] = "rbxassetid://3255270749",
	["/"] = "rbxassetid://3255270451",
	["\\"] = "rbxassetid://3255267662",
	["="] = "rbxassetid://3255269621",
	["~"] = "rbxassetid://3255265665",
	["@"] = "rbxassetid://3255274455",
	["#"] = "rbxassetid://3255275727",
	["A"] = "rbxassetid://3255274385",
	["X"] = "rbxassetid://3255273169",
	["Z"] = "rbxassetid://3255267779",
	["W"] = "rbxassetid://3255273234",
	["V"] = "rbxassetid://3255273311",
	["T"] = "rbxassetid://3255273463",
	["U"] = "rbxassetid://3255273397",
	["N"] = "rbxassetid://3255268429",
	["R"] = "rbxassetid://3255273618",
	["Q"] = "rbxassetid://3255273680",
	["S"] = "rbxassetid://3255273537",
	["P"] = "rbxassetid://3255273740",
	["M"] = "rbxassetid://3255268515",
	["L"] = "rbxassetid://3255268592",
	["I"] = "rbxassetid://3255273815",
	["J"] = "rbxassetid://3255268738",
	["G"] = "rbxassetid://3255273960",
	["O"] = "rbxassetid://3255268343",
	["Y"] = "rbxassetid://3255273087",
	["B"] = "rbxassetid://3255274326",
	["E"] = "rbxassetid://3255274105",
	["H"] = "rbxassetid://3255273871",
	["K"] = "rbxassetid://3255268668",
	["F"] = "rbxassetid://3255274031",
	["C"] = "rbxassetid://3255274265",
	["D"] = "rbxassetid://3255274190",
	["1"] = "rbxassetid://3255275198",
	["2"] = "rbxassetid://3255275122",
	["3"] = "rbxassetid://3255275040",
	["4"] = "rbxassetid://3255274974",
	["5"] = "rbxassetid://3255274905",
	["6"] = "rbxassetid://3255274752",
	["7"] = "rbxassetid://3255274687",
	["8"] = "rbxassetid://3255274621",
	["9"] = "rbxassetid://3255274524",
	["0"] = "rbxassetid://3255275263",
}

function form_letter (parsed, parent, setposition)
	local part = Instance.new"Part"
	part.Size = Vector3.one * 3
	part.Name = parsed
	
	if parsed == " " then
		part.Size = part.Size + Vector3.new(1, 0, 0)
	end

	if parsed and alphabet_meshes[parsed] then
		local mesh = Instance.new"SpecialMesh"
		mesh.Scale = Vector3.one * 7
		mesh.MeshId = alphabet_meshes[parsed]
		mesh.Parent = part
	else
		part.Transparency = 1
	end
	
	if setposition then
		part:PivotTo(owner.Character:GetPivot() * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.rad(180), 0))
	end
	part.Parent = script
	
	return part
end

function form_word (parsed, parent) 
	if parsed:sub(1, 3):lower() == "/e " then parsed = parsed:sub(4, #parsed) end
	local letters = parsed:split""
	
	local lettert = {}
	
	local previous
	
	for _, letter in pairs(letters) do task.wait()
		if previous then
			local new = form_letter(letter, script, false)
			new.CFrame = previous.CFrame * CFrame.new(-previous.Size.X/2, 0, 0)
			new:SetAttribute("placer", owner.Name)
			previous.Anchored = true
			
			previous = new
		else
			previous = form_letter(letter, script, true)
			previous:SetAttribute("placer", owner.Name)
			previous.Anchored = true
		end
		
		table.insert(lettert, previous)
	end
	
	for _, letter in pairs(lettert) do
		letter.Anchored = false
	end
end

owner.Chatted:Connect(function (message)
	if message:lower() == "/e clear" then
		for _, letter in pairs(script:GetChildren()) do
			if letter:IsA"BasePart" and letter:GetAttribute"placer" == owner.Name then
				letter:Destroy()
			end
		end
	elseif message:lower() == "/e alphabet" then
		form_word"abcdefghijklmnopqrstuvwxyz"
	elseif message:lower() == "/e numbers" then
		form_word"1234567890"
	end
	
	local lower = message:lower()
	
	if lower ~= "/e alphabet" and lower ~= "/e numbers" and lower ~= "/e clear" then
		form_word(message)
	end
end)

warn[[commands:
/e alphabet
/e numbers
/e clear

also when saying 
'/e text'
it will spawn the text but hide the /e
]]
