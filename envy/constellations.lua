local RNG = Random.new()

local Origin = owner.Character.HumanoidRootPart

local NumberOfConstellations = 4
local NumberOfStarsPerConstellation = function () return math.random(3, 6) end

local function Positive (v)
	return Vector3.new(math.abs(v.X), math.abs(v.Y), math.abs(v.Z))
end

local function GetClosestStar (Position, Stars, AlreadyConnected)
	local ClosestStar
	local ClosestDistance = math.huge

	for i, t in pairs(Stars) do
		if table.find(AlreadyConnected, i) then continue end
		local Distance = (Position - t.Offset).Magnitude
		if Distance < ClosestDistance then
			ClosestDistance = Distance
			ClosestStar = t
		end
	end

	return ClosestStar
end

local function ConnectStars (Star0, Star1)
	local Beam = Instance.new("Beam", Star0)
	Beam.Transparency = NumberSequence.new(0)
	Beam.Color = ColorSequence.new(Star0.Color)
	Beam.Width0, Beam.Width1 = 0.01, 0.01
	Beam.FaceCamera = true
	Beam.Attachment0 = Star0.Attachment
	Beam.Attachment1 = Star1.Attachment
end

local function GenerateStar (Offset)
	local Star = Instance.new("Part", script)
	Star.CanCollide = true
	Star.Shape = Enum.PartType.Ball
	Star.Size = Vector3.one * 0.1
	Star.Material = Enum.Material.ForceField
	Star.Transparency = -100
	Star.Color = Color3.fromRGB(255, 255, 255)

	local Attachment = Instance.new("Attachment", Star)

	local Attachment1 = Instance.new("Attachment", Origin)
	Attachment1.Position = Offset

	local AlignPosition = Instance.new("AlignPosition", Star)
	--AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
	AlignPosition.Attachment0 = Attachment
	AlignPosition.Attachment1 = Attachment1
	AlignPosition.RigidityEnabled = true
	--[[task.spawn(function()
		while Star do
			--AlignPosition.Position = (Origin.CFrame * CFrame.new(Offset)).Position
			--AlignPosition.Position = Origin.Position + Offset
			task.wait()
		end
	end)]]
	return Star
end

local function GenerateConstellation (BaseOffset)
	local FirstStar
	
	local BaseOffset = BaseOffset or RNG:NextUnitVector() * RNG:NextNumber(3, 4)
	local Stars = {}
	local LastOffset = BaseOffset
	
	for i = 1, math.random(3, 5) do
		local Star
		local Offset
		Offset = BaseOffset + RNG:NextUnitVector() * RNG:NextNumber(0.8, 1.5)
		Star = GenerateStar(Offset)
		Stars[i] = {Star = Star, Offset = Offset, i = i}
		LastOffset = Offset
		if i == 1 then
			FirstStar = Star
		end
	end

	for i, t in pairs(Stars) do
		local NumberOfConnections = math.random(1, 2)

		local AlreadyConnected = {i}
		
		for i = 1, NumberOfConnections do
			local ClosestStar = GetClosestStar(t.Offset, Stars, AlreadyConnected)
			table.insert(AlreadyConnected, ClosestStar.i)
			ConnectStars(t.Star, ClosestStar.Star)
		end
	end
end

GenerateConstellation(Vector3.new(0, 4, 0))
