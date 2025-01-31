Axiom = "F"
RuleSet = {
    F = {
        "F[+F]F[-F]F",            -- Main branching structure
        "F[+F]F[-F]F^F",          -- Add upward growth
        "F[&F]",                  -- Twisting branch
        "FF",                     -- Continue lengthening the main trunk
        "F[+F]F",                 -- Side branch to the right
        "F[-F]",                  -- Side branch to the left
        "F[^F]",                  -- Upward growth
        "F[_F]",                  -- Downward growth
        "F[+F][+F]F[-F]",         -- Multiple branches for bushier look
        "F[&F]F[^F]",             -- Twisting and going upwards
        "F[&F][^F][&F]",          -- Complex branching with twist and rise
        "F[+F][+F][+F][-F]"       -- Dense branching
    }
}

local function ApplyRules (Axiom, RuleSet, NumberOfGenerations)
	local Pattern = Axiom
	
	for i = 1, NumberOfGenerations or 1 do
		local Result = ""
		
		for _, Letter in pairs(Pattern and Pattern:split("") or Axiom:split("")) do
			local Choice = RuleSet[Letter] or Letter

			if type(Choice) == "table" then
				Choice = Choice[math.random(#Choice)]
			end

			Result = Result .. Choice
		end

		Pattern = Result
	end

	return Pattern
end

local Pattern = ApplyRules(Axiom, RuleSet, 5)

local function DrawPart (A, B, Thickness, Parent)
	local Part = Instance.new("Part", Parent or script)
	Part.Anchored = true

	local Difference = B - A
	local MidPoint = (A + B) / 2

	Part.Size = Vector3.new(Thickness, Thickness, Difference.Magnitude)
	Part.CFrame = CFrame.new(MidPoint, B)

	Part.BrickColor = BrickColor.new("Earth orange")
	Part.Material = Enum.Material.Wood

	return Part
end

local function DrawTree (Pattern)
	local NumberOfBranches = 0

	local DistanceStep = 4
	local AngleStep = 45
	local ThicknessStep = 1
	
	local Position = owner.Character.Head.Position
	local Direction = CFrame.Angles(math.pi/2, 0, 0)
	local Thickness = 0.5

	local Stack = {}
	
	for _, Character in ipairs(Pattern:split("")) do
		if Character == "F" then task.wait(0.01)
			NumberOfBranches = NumberOfBranches + 1
			
			local PreviousPosition = Position
			Position = Position + Direction.LookVector * DistanceStep

			DrawPart(PreviousPosition, Position, Thickness, script)
		elseif Character == "[" then
			table.insert(Stack, {Position = Position, Direction = Direction, Thickness = Thickness})
		elseif Character == "]" then
			local State = table.remove(Stack)

			if State then
				Position = State.Position
				Direction = State.Direction
				Thickness = State.Thickness
			end
		elseif Character == "-" then
			Direction = Direction * CFrame.Angles(-math.rad(AngleStep), 0, 0)
		elseif Character == "+" then
			Direction = Direction * CFrame.Angles(math.rad(AngleStep), 0, 0)
		elseif Character == "_" then
			Direction = Direction * CFrame.Angles(0, 0, -math.rad(AngleStep))
		elseif Character == "^" then
			Direction = Direction * CFrame.Angles(0, 0, math.rad(AngleStep))
		elseif Character == "&" then
			Direction = Direction * CFrame.Angles(0, math.rad(AngleStep), 0)
		end
	end

	return NumberOfBranches
end

print(DrawTree(Pattern))
