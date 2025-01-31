local Snail = Instance.new("Model")
Snail.Name = "Snail"
Snail.WorldPivot = CFrame.new(-10.137478828430176, 0.4500000476837158, 11.499985694885254)
Snail.Parent = script

local Body = Instance.new("Model")
Body.Name = "Body"
Body.WorldPivot = CFrame.new(-10.176239967346191, 0.31338632106781006, 11.499985694885254)
Body.Parent = Snail

local Head = Instance.new("Part")
Head.Name = "Head"
Head.BottomSurface = Enum.SurfaceType.Smooth
Head.TopSurface = Enum.SurfaceType.Smooth
Head.Color = Color3.fromRGB(56, 49, 45)
Head.Material = Enum.Material.Sand
Head.Reflectance = 0.5
Head.Size = Vector3.new(0.2299877107143402, 0.19999998807907104, 0.24999389052391052)
Head.CFrame = CFrame.new(-9.299969673156738, 0.10000608116388321, 11.499978065490723, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Head.Parent = Body

local Neck = Instance.new("Part")
Neck.Name = "Neck"
Neck.BottomSurface = Enum.SurfaceType.Smooth
Neck.TopSurface = Enum.SurfaceType.Smooth
Neck.Color = Color3.fromRGB(56, 49, 45)
Neck.Material = Enum.Material.Sand
Neck.Reflectance = 0.5
Neck.Size = Vector3.new(0.4499998688697815, 0.34999996423721313, 0.3749999701976776)
Neck.CFrame = CFrame.new(-9.612472534179688, 0.17501217126846313, 11.499985694885254, 0, 0, -1, 0, 1, 0, 1, 0, 0)
Neck.Parent = Body

local NeckToHead = Instance.new("Motor6D")
NeckToHead.Name = "NeckToHead"
NeckToHead.C1 = CFrame.new(0.00000762939453125, 0.14999347925186157, 0.900011420249939, 0, 0, 1, 0, 1, -0, -1, 0, 0)
NeckToHead.C0 = CFrame.new(0, 0.07498738914728165, 0.5875087380409241, 0, 0, 1, 0, 1, -0, -1, 0, 0)
NeckToHead.Parent = Neck

local Tail1 = Instance.new("Part")
Tail1.Name = "Tail1"
Tail1.BottomSurface = Enum.SurfaceType.Smooth
Tail1.TopSurface = Enum.SurfaceType.Smooth
Tail1.Color = Color3.fromRGB(56, 49, 45)
Tail1.Material = Enum.Material.Sand
Tail1.Reflectance = 0.5
Tail1.Size = Vector3.new(0.09999984502792358, 0.5000000596046448, 0.6000000834465027)
Tail1.CFrame = CFrame.new(-10.649984359741211, 0.25, 11.499985694885254)
Tail1.Parent = Body

local Root = Instance.new("Part")
Root.Name = "Root"
Root.BottomSurface = Enum.SurfaceType.Smooth
Root.TopSurface = Enum.SurfaceType.Smooth
Root.Color = Color3.fromRGB(56, 49, 45)
Root.Material = Enum.Material.Sand
Root.Reflectance = 0.5
Root.Size = Vector3.new(0.7999998331069946, 0.5000000596046448, 0.8000001311302185)
Root.CFrame = CFrame.new(-10.199984550476074, 0.25, 11.499985694885254)
Root.Parent = Body

local RootToNeck = Instance.new("Motor6D")
RootToNeck.Name = "RootToNeck"
RootToNeck.C1 = CFrame.new(0, 0.07498782873153687, 0.5875120162963867, 0, 0, 1, 0, 1, -0, -1, 0, 0)
RootToNeck.Parent = Root

local Weld = Instance.new("Weld")
Weld.C0 = CFrame.new(-0.4500002861022949, 0, 0)
Weld.Parent = Root

local Weld1 = Instance.new("Weld")
Weld1.C0 = CFrame.new(-0.5999999046325684, -0.09999999403953552, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Weld1.Parent = Root

local Weld2 = Instance.new("Weld")
Weld2.C0 = CFrame.new(-0.7999997138977051, -0.15000000596046448, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Weld2.Parent = Root

local Tail2 = Instance.new("Part")
Tail2.Name = "Tail2"
Tail2.BottomSurface = Enum.SurfaceType.Smooth
Tail2.TopSurface = Enum.SurfaceType.Smooth
Tail2.Color = Color3.fromRGB(56, 49, 45)
Tail2.Material = Enum.Material.Sand
Tail2.Reflectance = 0.5
Tail2.Size = Vector3.new(0.1999998688697815, 0.30000004172325134, 0.6000000834465027)
Tail2.CFrame = CFrame.new(-10.799983978271484, 0.15000000596046448, 11.499985694885254, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Tail2.Parent = Body

local Tail3 = Instance.new("Part")
Tail3.Name = "Tail3"
Tail3.BottomSurface = Enum.SurfaceType.Smooth
Tail3.TopSurface = Enum.SurfaceType.Smooth
Tail3.Color = Color3.fromRGB(56, 49, 45)
Tail3.Material = Enum.Material.Sand
Tail3.Reflectance = 0.5
Tail3.Size = Vector3.new(0.19999994337558746, 0.20000003278255463, 0.40000003576278687)
Tail3.CFrame = CFrame.new(-10.999984741210938, 0.09999999403953552, 11.499985694885254, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Tail3.Parent = Body

local Shell = Instance.new("Model")
Shell.Name = "Shell"
Shell.WorldPivot = CFrame.new(-10.499984741210938, 1.0499999523162842, 11.499985694885254)
Shell.Parent = Snail

local Part = Instance.new("Part")
Part.BottomSurface = Enum.SurfaceType.Smooth
Part.TopSurface = Enum.SurfaceType.Smooth
Part.Color = Color3.fromRGB(105, 64, 40)
Part.Material = Enum.Material.Sand
Part.Size = Vector3.new(0.0999998077750206, 0.20000003278255463, 0.6000000834465027)
Part.CFrame = CFrame.new(-10.74998664855957, 0.40000006556510925, 11.499985694885254)
Part.Parent = Shell

local Part1 = Instance.new("Part")
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Color = Color3.fromRGB(105, 64, 40)
Part1.Material = Enum.Material.Sand
Part1.Size = Vector3.new(0.0999998077750206, 0.20000004768371582, 0.6000000834465027)
Part1.CFrame = CFrame.new(-10.649986267089844, 0.5999999046325684, 11.499985694885254)
Part1.Parent = Shell

local Part2 = Instance.new("Part")
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Color = Color3.fromRGB(105, 64, 40)
Part2.Material = Enum.Material.Sand
Part2.Size = Vector3.new(0.29999983310699463, 0.5, 0.10000014305114746)
Part2.CFrame = CFrame.new(-10.349985122680664, 0.5499999523162842, 11.0499849319458)
Part2.Parent = Shell

local Part3 = Instance.new("Part")
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Color = Color3.fromRGB(105, 64, 40)
Part3.Material = Enum.Material.Sand
Part3.Size = Vector3.new(0.0999998077750206, 0.40000003576278687, 0.10000008344650269)
Part3.CFrame = CFrame.new(-10.649986267089844, 0.4999999701976776, 11.849987983703613)
Part3.Parent = Shell

local Part4 = Instance.new("Part")
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Color = Color3.fromRGB(105, 64, 40)
Part4.Material = Enum.Material.Sand
Part4.Size = Vector3.new(0.09999983757734299, 0.40000003576278687, 0.10000014305114746)
Part4.CFrame = CFrame.new(-10.5499849319458, 0.4999999701976776, 11.0499849319458)
Part4.Parent = Shell

local Part5 = Instance.new("Part")
Part5.BottomSurface = Enum.SurfaceType.Smooth
Part5.TopSurface = Enum.SurfaceType.Smooth
Part5.Color = Color3.fromRGB(105, 64, 40)
Part5.Material = Enum.Material.Sand
Part5.Size = Vector3.new(0.29999983310699463, 0.5, 0.10000014305114746)
Part5.CFrame = CFrame.new(-10.349985122680664, 0.5499999523162842, 11.949986457824707)
Part5.Parent = Shell

local Part6 = Instance.new("Part")
Part6.BottomSurface = Enum.SurfaceType.Smooth
Part6.TopSurface = Enum.SurfaceType.Smooth
Part6.Color = Color3.fromRGB(105, 64, 40)
Part6.Material = Enum.Material.Sand
Part6.Size = Vector3.new(0.1999998390674591, 0.30000004172325134, 0.8000001311302185)
Part6.CFrame = CFrame.new(-10.099985122680664, 0.6500000953674316, 11.499985694885254)
Part6.Parent = Shell

local Part7 = Instance.new("Part")
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Color = Color3.fromRGB(105, 64, 40)
Part7.Material = Enum.Material.Sand
Part7.Size = Vector3.new(0.09999980032444, 0.30000004172325134, 0.8000001311302185)
Part7.CFrame = CFrame.new(-10.549985885620117, 0.6500000953674316, 11.499985694885254)
Part7.Parent = Shell

local Part8 = Instance.new("Part")
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Color = Color3.fromRGB(105, 64, 40)
Part8.Material = Enum.Material.Sand
Part8.Size = Vector3.new(0.1999998390674591, 0.30000004172325134, 0.10000014305114746)
Part8.CFrame = CFrame.new(-10.099985122680664, 0.5499999523162842, 11.949986457824707)
Part8.Parent = Shell

local Part9 = Instance.new("Part")
Part9.BottomSurface = Enum.SurfaceType.Smooth
Part9.TopSurface = Enum.SurfaceType.Smooth
Part9.Color = Color3.fromRGB(105, 64, 40)
Part9.Material = Enum.Material.Sand
Part9.Size = Vector3.new(0.09999983757734299, 0.40000003576278687, 0.10000014305114746)
Part9.CFrame = CFrame.new(-10.5499849319458, 0.4999999701976776, 11.949986457824707)
Part9.Parent = Shell

local Part10 = Instance.new("Part")
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Color = Color3.fromRGB(105, 64, 40)
Part10.Material = Enum.Material.Sand
Part10.Size = Vector3.new(0.0999998077750206, 0.40000003576278687, 0.10000008344650269)
Part10.CFrame = CFrame.new(-10.649986267089844, 0.4999999701976776, 11.14998722076416)
Part10.Parent = Shell

local Root1 = Instance.new("Part")
Root1.Name = "Root"
Root1.BottomSurface = Enum.SurfaceType.Smooth
Root1.TopSurface = Enum.SurfaceType.Smooth
Root1.Color = Color3.fromRGB(105, 64, 40)
Root1.Material = Enum.Material.Sand
Root1.Size = Vector3.new(0.29999983310699463, 0.40000003576278687, 0.8000001311302185)
Root1.CFrame = CFrame.new(-10.349985122680664, 0.7000000476837158, 11.499985694885254)
Root1.Parent = Shell

local Weld3 = Instance.new("Weld")
Weld3.C0 = CFrame.new(-0.40000104904174805, -0.29999998211860657, 0)
Weld3.Parent = Root1

local Weld4 = Instance.new("Weld")
Weld4.C0 = CFrame.new(-0.3000006675720215, -0.10000014305114746, 0)
Weld4.Parent = Root1

local Weld5 = Instance.new("Weld")
Weld5.C0 = CFrame.new(0, -0.15000009536743164, -0.4500007629394531)
Weld5.Parent = Root1

local Weld6 = Instance.new("Weld")
Weld6.C0 = CFrame.new(-0.3000006675720215, -0.2000000774860382, 0.3500022888183594)
Weld6.Parent = Root1

local Weld7 = Instance.new("Weld")
Weld7.C0 = CFrame.new(-0.19999980926513672, -0.2000000774860382, -0.4500007629394531)
Weld7.Parent = Root1

local Weld8 = Instance.new("Weld")
Weld8.C0 = CFrame.new(0, -0.15000009536743164, 0.4500007629394531)
Weld8.Parent = Root1

local Weld9 = Instance.new("Weld")
Weld9.C0 = CFrame.new(0.25, -0.04999995231628418, 0)
Weld9.Parent = Root1

local Weld10 = Instance.new("Weld")
Weld10.C0 = CFrame.new(-0.20000028610229492, -0.04999995231628418, 0)
Weld10.Parent = Root1

local Weld11 = Instance.new("Weld")
Weld11.C0 = CFrame.new(0.25, -0.15000009536743164, 0.4500007629394531)
Weld11.Parent = Root1

local Weld12 = Instance.new("Weld")
Weld12.C0 = CFrame.new(-0.19999980926513672, -0.2000000774860382, 0.4500007629394531)
Weld12.Parent = Root1

local Weld13 = Instance.new("Weld")
Weld13.C0 = CFrame.new(-0.3000006675720215, -0.2000000774860382, -0.34999847412109375)
Weld13.Parent = Root1

local Weld14 = Instance.new("Weld")
Weld14.C0 = CFrame.new(0.25, -0.15000009536743164, -0.4500007629394531)
Weld14.Parent = Root1

local Weld15 = Instance.new("Weld")
Weld15.C0 = CFrame.new(0.39999961853027344, -0.05000025033950806, 0)
Weld15.Parent = Root1

local Weld16 = Instance.new("Weld")
Weld16.C0 = CFrame.new(0.39999961853027344, -0.15000015497207642, 0.000003814697265625)
Weld16.Parent = Root1

local Weld17 = Instance.new("Weld")
Weld17.C0 = CFrame.new(-0.40000104904174805, -0.1499999761581421, 0)
Weld17.Parent = Root1

local Part11 = Instance.new("Part")
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Color = Color3.fromRGB(105, 64, 40)
Part11.Material = Enum.Material.Sand
Part11.Size = Vector3.new(0.1999998390674591, 0.30000004172325134, 0.10000014305114746)
Part11.CFrame = CFrame.new(-10.099985122680664, 0.5499999523162842, 11.0499849319458)
Part11.Parent = Shell

local Part12 = Instance.new("Part")
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Color = Color3.fromRGB(105, 64, 40)
Part12.Material = Enum.Material.Sand
Part12.Size = Vector3.new(0.09999984502792358, 0.10000000149011612, 0.6000000238418579)
Part12.CFrame = CFrame.new(-9.94998550415039, 0.6499997973442078, 11.499985694885254)
Part12.Parent = Shell

local Part13 = Instance.new("Part")
Part13.BottomSurface = Enum.SurfaceType.Smooth
Part13.TopSurface = Enum.SurfaceType.Smooth
Part13.Color = Color3.fromRGB(105, 64, 40)
Part13.Material = Enum.Material.Sand
Part13.Size = Vector3.new(0.09999984502792358, 0.10000000149011612, 0.800000011920929)
Part13.CFrame = CFrame.new(-9.94998550415039, 0.5499998927116394, 11.49998950958252)
Part13.Parent = Shell

local Part14 = Instance.new("Part")
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.TopSurface = Enum.SurfaceType.Smooth
Part14.Color = Color3.fromRGB(105, 64, 40)
Part14.Material = Enum.Material.Sand
Part14.Size = Vector3.new(0.0999998077750206, 0.10000000149011612, 0.4000000059604645)
Part14.CFrame = CFrame.new(-10.74998664855957, 0.5500000715255737, 11.499985694885254)
Part14.Parent = Shell

NeckToHead.Part1 = Head
NeckToHead.Part0 = Neck

RootToNeck.Part1 = Neck
RootToNeck.Part0 = Root

Weld.Part1 = Tail1
Weld.Part0 = Root

Weld1.Part1 = Tail2
Weld1.Part0 = Root

Weld2.Part1 = Tail3
Weld2.Part0 = Root

Weld3.Part1 = Part
Weld3.Part0 = Root1

Weld4.Part1 = Part1
Weld4.Part0 = Root1

Weld5.Part1 = Part2
Weld5.Part0 = Root1

Weld6.Part1 = Part3
Weld6.Part0 = Root1

Weld7.Part1 = Part4
Weld7.Part0 = Root1

Weld8.Part1 = Part5
Weld8.Part0 = Root1

Weld9.Part1 = Part6
Weld9.Part0 = Root1

Weld10.Part1 = Part7
Weld10.Part0 = Root1

Weld11.Part1 = Part8
Weld11.Part0 = Root1

Weld12.Part1 = Part9
Weld12.Part0 = Root1

Weld13.Part1 = Part10
Weld13.Part0 = Root1

Weld14.Part1 = Part11
Weld14.Part0 = Root1

Weld15.Part1 = Part12
Weld15.Part0 = Root1

Weld16.Part1 = Part13
Weld16.Part0 = Root1

Weld17.Part1 = Part14
Weld17.Part0 = Root1

Snail:PivotTo(owner.Character.Head.CFrame)
