local args = {...}
local OBJFile = game:GetService("HttpService"):GetAsync(args[1])
local Vectors = {}
local Faces = {}
for A,Line in next,OBJFile:split("\n") do
	local Data = Line:split(" ")
	if Data[1] == "v" then
		local Vector = Vector3.new(Data[2],Data[3],Data[4])*5
		table.insert(Vectors,Vector)
		MinX = MinX and math.min(MinX,Vector.X) or Vector.X
		MinY = MinY and math.min(MinY,Vector.Y) or Vector.Y
		MinZ = MinZ and math.min(MinZ,Vector.Z) or Vector.Z
	elseif Data[1] == "f" then
		local Face = {}
		for Index=2,#Data do
			Face[Index-1] = tonumber(Data[Index]:match("^%d+"))
			if Face[Index-1] then
				Face[Index-1] = Face[Index-1]
			end
		end
		table.insert(Faces,Face)
	end
	if A%10000 == 0 then
		game:GetService("RunService").Stepped:Wait()
		print(A)
	end
end
print("Printing")
function awaitInstance(...)
	local s,i = pcall(Instance.new,...)
	while not s do s,i = pcall(Instance.new,...) end
	return i
end
function awaitClone(a)
	local s,i = pcall(a.Clone,a)
	while not s do s,i = pcall(a.Clone,a) end
	return i
end
function DrawTriangle(a, b, c)
	local ab, ac, bc = b - a, c - a, c - b;
	local abd, acd, bcd = ab:Dot(ab), ac:Dot(ac), bc:Dot(bc);

	if (abd > acd and abd > bcd) then
		c, a = a, c;
	elseif (acd > bcd and acd > abd) then
		a, b = b, a;
	end

	ab, ac, bc = b - a, c - a, c - b;

	local right = ac:Cross(ab).unit;
	local up = bc:Cross(right).unit;
	local back = bc.unit;

	local height = math.abs(ab:Dot(up));

	local w1 = awaitInstance("WedgePart")
	w1.Material = Enum.Material.Plastic
	w1.Size = Vector3.new(0, height, math.abs(ab:Dot(back)));
	w1.CFrame = CFrame.fromMatrix((a + b)/2, right, up, back);
	local A = w1.CFrame
	w1.Anchored = true
	w1.Locked = true
	w1.TopSurface = Enum.SurfaceType.Smooth
	w1.BottomSurface = Enum.SurfaceType.Smooth
	w1.CastShadow = false
	w1.Locked = true
	local w2 = awaitClone(w1)
	w2.Size = Vector3.new(0, height, math.abs(ac:Dot(back)));
	w2.CFrame = CFrame.fromMatrix((a + c)/2, -right, up, -back);
	return w1, w2;
end
warn(("%d Faces\n%dVertexs"):format(#Faces,#Vectors))
local Model = Instance.new("Model",script)
for M,FaceWave in next,Faces do
	local Face = {}
	for Index,VectorWave in next,FaceWave do
		Face[Index] = Vectors[VectorWave]
	end
	local WedgeA,WedgeB = DrawTriangle(Face[1],Face[2],Face[3])
	WedgeB.Parent = Model
	WedgeA.Parent = Model
	if M%16 == 0 then
		game:GetService("RunService").Stepped:Wait()
	end
end

return Model
