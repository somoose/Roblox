local Life = {}
Life.__index = Life
function Life:GetState (x, y)
	if x < 1 or x > self.X then return end
	if y < 1 or y > self.Y then return end
	return self[x][y].State
end
function Life:SetState (x, y, State)
	local t = self[x][y]
	if State == 0 then
		t.Part.Color = Color3.fromRGB(255, 255, 255)
	elseif State == 1 then
		t.Part.Color = Color3.fromRGB()
	end
	t.State = State
end
function Life:GetNeighbourStates (x, y)
	local Left = self:GetState(x - 1, y)
	local Right = self:GetState(x + 1, y)
	
	local Top = self:GetState(x, y - 1)
	local Bottom = self:GetState(x, y + 1)

	local TopLeft = self:GetState(x - 1, y - 1)
	local TopRight = self:GetState(x + 1, y - 1)

	local BottomLeft = self:GetState(x - 1, y + 1)
	local BottomRight = self:GetState(x + 1, y + 1)

	local Alive = 0

	local NeighbourStates = {Left, Right, Top, Bottom, TopLeft, TopRight, BottomLeft, BottomRight}
	
	for _, State in pairs(NeighbourStates) do
		if State == 1 then
			Alive = Alive + 1
		end
	end

	return Alive, Dead
end
function Life:NextGeneration ()
	local Changes = {}
	for x = 1, self.X do
		for y = 1, self.Y do
			local CurrentState = self:GetState(x, y)
			local AliveNeighbours = self:GetNeighbourStates(x, y)
			if CurrentState == 0 then
				if AliveNeighbours == 3 then
					table.insert(Changes, {x = x, y = y, state = 1})
				end
			elseif CurrentState == 1 then
				if AliveNeighbours < 2 then
					table.insert(Changes, {x = x, y = y, state = 0})
				elseif AliveNeighbours > 3 then
					table.insert(Changes, {x = x, y = y, state = 0})
				end
			end
		end
	end
	for _, t in pairs(Changes) do
		self:SetState(t.x, t.y, t.state)
	end
end
function Life.new (X, Y, XS, YS)
	local Model = Instance.new("Model", workspace)
	local OBJ = {
		X = X,
		Y = Y,
		XS = XS,
		YS = YS
	}
	setmetatable(OBJ, Life)
	for x = 1, X do task.wait()
		OBJ[x] = {}
		for y = 1, Y do
			local t = {}
			t.State = 0

			local Offset = Vector3.new((x - 1) * XS, 0, (y - 1) * YS)
			
			local Part = Instance.new("Part", Model)
			Part.Anchored = true
			Part.CastShadow = false
			Part.Material = Enum.Material.SmoothPlastic
			Part.Transparency = 0
			Part.Size = Vector3.new(XS, 1, YS)
			Part.Position = Offset

			local ClickDetector = Instance.new("ClickDetector", Part)
			ClickDetector.MouseClick:Connect(function()
				OBJ:SetState(x, y, OBJ:GetState(x, y) == 0 and 1 or 0)
			end)

			t.Part = Part
			OBJ[x][y] = t
			OBJ:SetState(x, y, 0)
		end
	end
	return OBJ, Model
end
return Life
