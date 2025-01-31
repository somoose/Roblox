--[[ FLAMINGO TEA PARTY VIDEO CANOE

make the canoe consist of at least 2 pieces

the top piece should have friction for the player to walk on

the bottom piece (welded to the top piece) should have zero friction to allow sliding

both should have low or no density
]]

local Bottom = Instance.new("Part", script)
Bottom.Size = Vector3.new(3, 2, 8)
Bottom.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 30, 0)
Bottom.CFrame = owner.Character.Head.CFrame * CFrame.new(0, 0, -Bottom.Size.Z)

local Top = Instance.new("Part", script)
Top.CFrame = Bottom.CFrame
Top.Size = Vector3.new(3, 2, 8)
Top.CustomPhysicalProperties = PhysicalProperties.new(10, 1e5, 0, 100, 0)
Top.Parent = script
Top.Color = Color3.fromRGB(100, 100, 100)

local Weld = Instance.new("Weld", Bottom)
Weld.Part0, Weld.Part1 = Bottom, Top
Weld.C0 = CFrame.new(0, Bottom.Size.Y, 0)
