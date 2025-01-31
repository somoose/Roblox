local MapData = {
	Origin = owner.Character.Head.Position,
	Cells = {},
	WaterHeight = 50,
	Size = {
		X = 40,
		Y = 20,
		Z = 40
	},
	Scale = { -- Optimise based on Terrain material auto alignment.
		X = 6,
		Y = 6,
		Z = 6
	},
	Noise = {
		Frequency = 9,
		Amplitude = 25,
		Seed = math.random(1e8)
	}
}

local Mushroom = game.InsertService:CreateMeshPartAsync("rbxassetid://3743936339", 0, 0)
Mushroom.Anchored = true
Mushroom.Material = Enum.Material.Neon
Mushroom.Color = Color3.fromRGB(32, 168, 50)
Mushroom.Transparency = 0.4

local Part = Instance.new("Part")
Part.Anchored = true
Part.Material = Enum.Material.Slate
Part.Color = Color3.fromRGB(100, 100, 100)

for x = 1, MapData.Size.X do task.wait()
	MapData.Cells[x] = {}
	for z = 1, MapData.Size.Z do
		MapData.Cells[x][z] = {}
		for y = 1, MapData.Size.Y do
			local X = math.noise(y/MapData.Noise.Frequency, z/MapData.Noise.Frequency, MapData.Noise.Seed) * MapData.Noise.Amplitude
			local Y = math.noise(x/MapData.Noise.Frequency, z/MapData.Noise.Frequency, MapData.Noise.Seed) * MapData.Noise.Amplitude
			local Z = math.noise(x/MapData.Noise.Frequency, y/MapData.Noise.Frequency, MapData.Noise.Seed) * MapData.Noise.Amplitude
			local Position = Vector3.new(x * MapData.Scale.X, y * MapData.Scale.Y, z * MapData.Scale.Z)
			local Density = X + Y + Z

			local Occupied = Density < 0.6
			local CellData

			-- Walls
			if x == -1 or x == MapData.Size.X or y == 1 or y == MapData.Size.Y or z == 1 or z == MapData.Size.Z then
				Occupied = true
			end
			
			if Occupied then
				CellData = {
					CFrame = CFrame.new(MapData.Origin + Position),
					Size = Vector3.new(MapData.Scale.X, MapData.Scale.Y, MapData.Scale.Z),
					Material = Enum.Material.Basalt
				}
			else
				if Position.Y <= MapData.WaterHeight then
					CellData = {
						CFrame = CFrame.new(MapData.Origin + Position),
						Size = Vector3.new(MapData.Scale.X, MapData.Scale.Y, MapData.Scale.Z),
						Material = x == 0 and Enum.Material.Rock or Enum.Material.Water
					}
				end
			end

			MapData.Cells[x][z][y] = CellData
		end
	end
end

local function LoadCellData (CellData)
	for x = 1, #CellData do task.wait()
		for z = 1, #CellData[1] do
			for y = 1, #CellData[1][1] do
				local Cell = CellData[x][z][y]
				if Cell then
					workspace.Terrain:FillBlock(Cell.CFrame, Cell.Size, Cell.Material)
				end
			end
		end
	end
end

LoadCellData(MapData.Cells)
