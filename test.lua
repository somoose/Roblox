if game:GetService("RunService"):IsClient() then error("no..") end
local Player,Mouse,mouse,UserInputService,ContextActionService = owner
do
	script.Parent = Player.Character
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput_Event"

	local function fakeEvent()
		local t = {_fakeEvent=true,Connect=function(self,f)self.Function=f end}
		t.connect = t.Connect
		return t
	end

	local m = {Target=nil,Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent()}
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}
	CAS.UnbindAction = CAS.BindAction

	local function te(self,ev,...)
		local t = m[ev]
		if t and t._fakeEvent and t.Function then
			t.Function(...)
		end
	end
	m.TrigEvent = te
	UIS.TrigEvent = te

	Event.OnServerEvent:Connect(function(plr,io)
		if plr~=Player then return end
		if io.isMouse then
			m.Target = io.Target
			m.Hit = io.Hit
		else
			local b = io.UserInputState == Enum.UserInputState.Begin
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				return m:TrigEvent(b and "Button1Down" or "Button1Up")
			end
			for _,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			m:TrigEvent(b and "KeyDown" or "KeyUp",io.KeyCode.Name:lower())
			UIS:TrigEvent(b and "InputBegan" or "InputEnded",io,false)
		end
	end)
	Event.Parent = NLS([==[
	local Player = game:GetService("Players").LocalPlayer
	local Event = script:WaitForChild("UserInput_Event")

	local UIS = game:GetService("UserInputService")
	local input = function(io,a)
		if a then return end
		Event:FireServer({KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState})
	end
	UIS.InputBegan:Connect(input)
	UIS.InputEnded:Connect(input)

	local Mouse = Player:GetMouse()
	local h,t
	while wait(1/30) do
		if h~=Mouse.Hit or t~=Mouse.Target then
			h,t=Mouse.Hit,Mouse.Target
			Event:FireServer({isMouse=true,Target=t,Hit=h})
		end
	end]==],Player.Character)
	Mouse,mouse,UserInputService,ContextActionService = m,m,UIS,CAS
end

Character = Player.Character


---------------------------------------
local sine=0
Animation_Speed = 1.5
local CHANGE = 2 / Animation_Speed
-----------------------




wait()
local plr = owner
local char = plr.Character
local hum = char.Humanoid
local hed = char.Head
local root = char.HumanoidRootPart
local rootj = root.RootJoint
local tors = char.Torso
local ra = char["Right Arm"]
local la = char["Left Arm"]
local rl = char["Right Leg"]
local ll = char["Left Leg"]
local neck = tors["Neck"]

local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14)
local RHCF = CFrame.fromEulerAnglesXYZ(0, 1.6, 0)
local LHCF = CFrame.fromEulerAnglesXYZ(0, -1.6, 0)
local Player = owner
local Character = Player.Character
local Humanoid = Character.Humanoid

local LeftArm = Character["Left Arm"]
local RightArm = Character["Right Arm"]
local LeftLeg = Character["Left Leg"]
local RightLeg = Character["Right Leg"]
local Head = Character.Head
local Torso = Character.Torso

local FE = Workspace.FilteringEnabled

CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
FLOOR = math.floor
-------------------------------------------------------
--Start HumanoidName and Invincibility--
-------------------------------------------------------	
hum.MaxHealth = 2.e10
hum.Health = 2.e10
Field = Instance.new("ForceField")
Field.Visible = false
Field.Parent = char
-------------------------------------------------------
--End HumanoidName and Invincibility--
-------------------------------------------------------
print("Just Relax")
print(" ")
print("--Actions--")
warn("Q - Cancel Anim")
warn("Z - Sit1")
warn("B - Sit2")
warn("N - Sit3")
warn("X - Rest1")
warn("C - Rest2")
warn("V - Rest3(in prague)")
warn("E - Wave")
warn("R - Hug")
warn("T - Whistle")
warn("G - Chibi")
warn("M - Piggybackback")
warn("F - Piggybackfront(dont use this on me >︿< -Au)")
warn("Y - Gun")
print("--Objects--")
warn("P - Fireflies")
warn("L - Tree")
warn("K - Picnic")
warn("J - Radio")
warn("H - Pillow")



-------------------------------------------------------
--Start Good Stuff--
-------------------------------------------------------
cam = game.Workspace.CurrentCamera
CF = CFrame.new
VT = Vector3.new
angles = CFrame.Angles
attack = false
Euler = CFrame.fromEulerAnglesXYZ
Rad = math.rad
Cos = math.cos
COS = math.cos
Acos = math.acos
Sin = math.sin
Asin = math.asin
Abs = math.abs
Floor = math.floor
-------------------------------------------------------
--End Good Stuff--
-------------------------------------------------------
necko = CF(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
RSH, LSH = nil, nil 
RW = Instance.new("Weld") 
LW = Instance.new("Weld")
RH = tors["Right Hip"]
LH = tors["Left Hip"]
RSH = tors["Right Shoulder"] 
LSH = tors["Left Shoulder"] 
RSH.Parent = nil 
LSH.Parent = nil 
RW.Name = "RW"
RW.Part0 = tors 
RW.C0 = CF(1.5, 0.5, 0)
RW.C1 = CF(0, 0.5, 0) 
RW.Part1 = ra
RW.Parent = tors 
LW.Name = "LW"
LW.Part0 = tors 
LW.C0 = CF(-1.5, 0.5, 0)
LW.C1 = CF(0, 0.5, 0) 
LW.Part1 = la
LW.Parent = tors
-------------------------------------------------------
--Start Important Functions--
-------------------------------------------------------


if plr.Character.Parent == nil then
	local model = Instance.new("Model")
	model.Name = plr.Name
	plr.Character = model
	for i,v in pairs(char:GetChildren()) do
		v.Parent = plr.Character
	end
end


function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function Clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function swait(num)
	if num == 0 or num == nil then
		game:service("RunService").Stepped:wait(0)
	else
		for i = 0, num do
			game:service("RunService").Stepped:wait(0)
		end
	end
end
function thread(f)
	coroutine.resume(coroutine.create(f))
end
function clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m00 < m11 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end


function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp
	if cosTheta >= 1.0E-4 then
		if 1 - cosTheta > 1.0E-4 then
			local theta = math.acos(cosTheta)
			local invSinTheta = 1 / Sin(theta)
			startInterp = Sin((1 - t) * theta) * invSinTheta
			finishInterp = Sin(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	elseif 1 + cosTheta > 1.0E-4 then
		local theta = math.acos(-cosTheta)
		local invSinTheta = 1 / Sin(theta)
		startInterp = Sin((t - 1) * theta) * invSinTheta
		finishInterp = Sin(t * theta) * invSinTheta
	else
		startInterp = t - 1
		finishInterp = t
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function rayCast(Position, Direction, Range, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Position, Direction.unit * (Range or 999.999)), Ignore)
end
local RbxUtility = LoadLibrary("RbxUtility")
local Create = RbxUtility.Create

CFuncs = {
	Part = {
		Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
			local Part = Create("Part")({
				Parent = Parent,
				Reflectance = Reflectance,
				Transparency = Transparency,
				CanCollide = false,
				Locked = true,
				BrickColor = BrickColor.new(tostring(BColor)),
				Name = Name,
				Size = Size,
				Material = Material
			})
			RemoveOutlines(Part)
			return Part
		end
	},
	Mesh = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh)({
				Parent = Part,
				Offset = OffSet,
				Scale = Scale
			})
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end
	},
	Mesh = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh)({
				Parent = Part,
				Offset = OffSet,
				Scale = Scale
			})
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end
	},
	Weld = {
		Create = function(Parent, Part0, Part1, C0, C1)
			local Weld = Create("Weld")({
				Parent = Parent,
				Part0 = Part0,
				Part1 = Part1,
				C0 = C0,
				C1 = C1
			})
			return Weld
		end
	},
	Sound = {
		Create = function(id, par, vol, pit)
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound")({
					Volume = vol,
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace
				})
				wait()
				S:play()
				game:GetService("Debris"):AddItem(S, 6)
			end))
		end
	},
	ParticleEmitter = {
		Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
			local fp = Create("ParticleEmitter")({
				Parent = Parent,
				Color = ColorSequence.new(Color1, Color2),
				LightEmission = LightEmission,
				Size = Size,
				Texture = Texture,
				Transparency = Transparency,
				ZOffset = ZOffset,
				Acceleration = Accel,
				Drag = Drag,
				LockedToPart = LockedToPart,
				VelocityInheritance = VelocityInheritance,
				EmissionDirection = EmissionDirection,
				Enabled = Enabled,
				Lifetime = LifeTime,
				Rate = Rate,
				Rotation = Rotation,
				RotSpeed = RotSpeed,
				Speed = Speed,
				VelocitySpread = VelocitySpread
			})
			return fp
		end
	}
}
function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end

-----------------------------------

function CreateSoundObject(ID, PARENT, VOLUME, PITCH)
	local FakeSound = nil
	coroutine.resume(coroutine.create(function()
		FakeSound = Instance.new("Sound", PARENT)
		FakeSound.Volume = VOLUME
		FakeSound.Pitch = PITCH
		FakeSound.SoundId = "http://www.roblox.com/asset/?id="..ID
		swait()
		FakeSound:play()
	end))
	return FakeSound
end

-------------------------------------------------------
--End Important Functions--
-------------------------------------------------------
-------------------------------------------------------

-------------------------------------------------------
--Start Customization--
-------------------------------------------------------
thic = .2
---------------------------------------------
Player_Size = 1
if Player_Size ~= 1 then
	root.Size = root.Size * Player_Size
	tors.Size = tors.Size * Player_Size
	hed.Size = hed.Size * Player_Size
	ra.Size = ra.Size * Player_Size
	la.Size = la.Size * Player_Size
	rl.Size = rl.Size * Player_Size --+ thic
	ll.Size = ll.Size * Player_Size --+ thic
	----------------------------------------------------------------------------------
	rootj.Parent = root
	neck.Parent = tors
	RW.Parent = tors
	LW.Parent = tors
	RH.Parent = tors
	LH.Parent = tors
	----------------------------------------------------------------------------------
	rootj.C0 = RootCF * CF(0 * Player_Size, 0 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(0), Rad(0))
	rootj.C1 = RootCF * CF(0 * Player_Size, 0 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(0), Rad(0))
	neck.C0 = necko * CF(0 * Player_Size, 0 * Player_Size, 0 + ((1 * Player_Size) - 1)) * angles(Rad(0), Rad(0), Rad(0))
	neck.C1 = CF(0 * Player_Size, -0.5 * Player_Size, 0 * Player_Size) * angles(Rad(-90), Rad(0), Rad(180))
	RW.C0 = CF(1.5 * Player_Size, 0.5 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(0), Rad(0)) --* RIGHTSHOULDERC0
	LW.C0 = CF(-1.5 * Player_Size, 0.5 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(0), Rad(0)) --* LEFTSHOULDERC0
	----------------------------------------------------------------------------------
	RH.C0 = CF(1 * Player_Size, -1 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(90), Rad(0)) * angles(Rad(0), Rad(0), Rad(0))
	LH.C0 = CF(-1 * Player_Size, -1 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(-90), Rad(0)) * angles(Rad(0), Rad(0), Rad(0))
	RH.C1 = CF(0.5 * Player_Size, 1 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(90), Rad(0)) * angles(Rad(0), Rad(0), Rad(0))
	LH.C1 = CF(-0.5 * Player_Size, 1 * Player_Size, 0 * Player_Size) * angles(Rad(0), Rad(-90), Rad(0)) * angles(Rad(0), Rad(0), Rad(0))
end
----------------------------------------------------------------------------------
local idle = 0
local change = 1
local val = 0
local toim = 0
local idleanim = 0.4
local sine = 0
----------------------------------------------------------------------------------
hum.WalkSpeed = 15
hum.JumpPower = 50
hum.Animator.Parent = nil

ch = Character:GetChildren()
for i = 1, #ch do
	if ch[i].ClassName == "BasePart" then
		ch[i].Massless = true
	end
end

resting = false
waving = false
sitting = false
hugging = false
-----------------------------------------------------
--Start Attacks N Stuff--
-------------------------------------------------------
function rest1() --sit1
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(-10 + .5 *math.cos(sine / 20)), Rad(-5) *math.cos(sine / 20), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(1.5, 0.3, 0) * CFrame.Angles(math.rad(-25),math.rad(5) *math.cos(sine / 20),math.rad(15)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.3, 0) * CFrame.Angles(math.rad(-25),math.rad(5) *math.cos(sine / 20),math.rad(-15)),.1)
			RH.C0 = clerp(RH.C0, CF(1, -0.8, .2) * RHCF * angles(Rad(0), Rad(-15), Rad(75 + 5 *math.cos(sine / 20))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -0.8, .2) * LHCF * angles(Rad(0), Rad(15), Rad(-75 + 5 *math.cos(sine / 20))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1.8) * angles(Rad(-11.18 + .5 *math.cos(sine / 20)), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest1smol() --sit1smol
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, -.5) * angles(Rad(-10 + .5 *math.cos(sine / 20)), Rad(-5) *math.cos(sine / 20), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(.75, 0.3, 0) * CFrame.Angles(math.rad(-25),math.rad(5) *math.cos(sine / 20),math.rad(15)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.3, 0) * CFrame.Angles(math.rad(-25),math.rad(5) *math.cos(sine / 20),math.rad(-15)),.1)
			RH.C0 = clerp(RH.C0, CF(.75, -0.4, .6) * RHCF * angles(Rad(0), Rad(-15), Rad(75 + 5 *math.cos(sine / 20))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, -0.4, .6) * LHCF * angles(Rad(0), Rad(15), Rad(-75 + 5 *math.cos(sine / 20))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -.8) * angles(Rad(-11.18 + .5 *math.cos(sine / 20)), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest2() --rest1
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(25 - 2 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(1.45, 0.9 + .03 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(1 - 1 * math.cos(sine / 20)),math.rad(-35)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.45, 0.9 + .03 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(-1 + 1 * math.cos(sine / 20)),math.rad(35)),.1)
			RH.C0 = clerp(RH.C0, CF(1, -1, .1) * RHCF * angles(Rad(45), Rad(-15 + 1 * math.cos(sine / 20)), Rad(25)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -0.8, .1) * LHCF * angles(Rad(-1.5), Rad(15 - 1 * math.cos(sine / 20)), Rad(-5)), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -2.4) * angles(Rad(-90), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest2smol() --rest1smol
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, -.5) * angles(Rad(25 - 2 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(0.725, 0.9 + .03 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(1 - 1 * math.cos(sine / 20)),math.rad(-35)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-0.725, 0.9 + .03 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(-1 + 1 * math.cos(sine / 20)),math.rad(35)),.1)
			RH.C0 = clerp(RH.C0, CF(.75, -.5, .1) * RHCF * angles(Rad(45), Rad(-15 + 1 * math.cos(sine / 20)), Rad(25)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0, .1) * LHCF * angles(Rad(-1.5), Rad(15 - 1 * math.cos(sine / 20)), Rad(-5)), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1) * angles(Rad(-90), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest3() --rest2
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, .2) * angles(Rad(-75 + 4 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(1.3, 0.9 + .01 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(-25)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.3, 0.9 + .01 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(25)),.1)
			RH.C0 = clerp(RH.C0, CF(1, -0.8, .2) * RHCF * angles(Rad(0), Rad(1 - 1 *math.cos(sine / 20)), Rad(-35 + 10 *math.cos(sine / 20))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -0.8, .2) * LHCF * angles(Rad(0), Rad(-1 + 1 *math.cos(sine / 20)), Rad(35 + 10 *math.cos(sine / 20))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0 , 0, -2.4) * angles(Rad(90), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest3smol() --rest2smol
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, -.5) * angles(Rad(-75 + 4 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(0.75, 0.05 + .01 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(-12.5)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-0.75, 0.05 + .01 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(12.5)),.1)
			RH.C0 = clerp(RH.C0, CF(.75, -0.1, -.3) * RHCF * angles(Rad(0), Rad(1 - 1 *math.cos(sine / 20)), Rad(-35 + 10 *math.cos(sine / 20))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, -0.1, -.3) * LHCF * angles(Rad(0), Rad(-1 + 1 *math.cos(sine / 20)), Rad(35 + 10 *math.cos(sine / 20))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0 , 0, -1.4) * angles(Rad(90), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest4() --rest3
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(-10 + .5 *math.cos(sine / 20)), Rad(-5), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(1.2, 0.9 + .01 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(0)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .01 * math.cos(sine / 20), 0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.1)
			RH.C0 = clerp(RH.C0, CF(1, -0.8, 0) * RHCF * angles(Rad(0), Rad(1 - 1 *math.cos(sine / 20)), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -0.8, 0) * LHCF * angles(Rad(0), Rad(-1 + 1 *math.cos(sine / 20)), Rad(0)), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -2.5) * angles(Rad(90), Rad(-90), Rad(90)), 1)
			swait()
		end
	end
end

function rest5() --sit2
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(0 - 2 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(1.2, 0.4, -.2) * CFrame.Angles(math.rad(45),math.rad(15),math.rad(-15 - 2 *math.cos(sine / 20))),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.2, 0.4, -.2) * CFrame.Angles(math.rad(45),math.rad(-15),math.rad(15 + 2 *math.cos(sine / 20))),.1)
			RH.C0 = clerp(RH.C0, CF(1, -0.8, .2) * RHCF * angles(Rad(0), Rad(-15 + 1.5 *math.cos(sine / 20)), Rad(75 + .5 *math.cos(sine / 20))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -0.8, .2) * LHCF * angles(Rad(0), Rad(15 - 1.5 *math.cos(sine / 20)), Rad(-75 + .5 *math.cos(sine / 20))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1.8) * angles(Rad(-11.18 + .5 *math.cos(sine / 20)), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function restspecial() --evadesit
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(-10 + 15 *math.cos(sine / 40)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(1.5, 0.2, 0) * CFrame.Angles(math.rad(15),math.rad(0 + 5 *math.cos(sine / 30)),math.rad(15)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.6, .2, -.8) * CFrame.Angles(math.rad(120 + 5 *math.cos(sine / 30)),math.rad(-15),math.rad(20)),.1)
			RH.C0 = clerp(RH.C0, CF(1.3, -0.4, -.9 + .03 *math.cos(sine / 60)) * RHCF * angles(Rad(10), Rad(65), Rad(80 + 2 *math.cos(sine / 30))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.8, 1, -.9 - .03 *math.cos(sine / 60)) * LHCF * angles(Rad(-5), Rad(0), Rad(-35 - 2 *math.cos(sine / 30))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -2) * angles(Rad(15 + 2 * math.cos(sine / 30)), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function restspecialsmol() --evadesitsmol
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, -.5) * angles(Rad(-5 + 7.5 *math.cos(sine / 40)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(.75, 0.2, 0) * CFrame.Angles(math.rad(15),math.rad(0 + 5 *math.cos(sine / 30)),math.rad(15)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.8, 0, -.1) * CFrame.Angles(math.rad(120 + 5 *math.cos(sine / 30)),math.rad(-15),math.rad(20)),.1)
			RH.C0 = clerp(RH.C0, CF(1.05, -0.4, -.3 + .015 *math.cos(sine / 60)) * RHCF * angles(Rad(10), Rad(65), Rad(80 + 2 *math.cos(sine / 30))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.55, .6, -.15 - .015 *math.cos(sine / 60)) * LHCF * angles(Rad(-5), Rad(0), Rad(-35 - 2 *math.cos(sine / 30))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -.8) * angles(Rad(7.5 + 1 * math.cos(sine / 30)), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

function rest5smol() --sit2smol
	resting = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	while resting do
		for i = 1, 14 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, -.5) * angles(Rad(0 - 2 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
			RW.C0 = RW.C0:lerp(CFrame.new(.6, 0.4, -.2) * CFrame.Angles(math.rad(45),math.rad(15),math.rad(-15 - 2 *math.cos(sine / 20))),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.6, 0.4, -.2) * CFrame.Angles(math.rad(45),math.rad(-15),math.rad(15 + 2 *math.cos(sine / 20))),.1)
			RH.C0 = clerp(RH.C0, CF(.75, -0.4, .5) * RHCF * angles(Rad(0), Rad(-15 + 1.5 *math.cos(sine / 20)), Rad(75 + .5 *math.cos(sine / 20))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, -0.4, .5) * LHCF * angles(Rad(0), Rad(15 - 1.5 *math.cos(sine / 20)), Rad(-75 + .5 *math.cos(sine / 20))), 0.15)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -.8) * angles(Rad(-11.18 + .5 *math.cos(sine / 20)), Rad(0), Rad(0)), 1)
			swait()
		end
	end
end

kanbae = false

function kanye()
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	kanbae = true
	while kanbae do
		for i = 1, 17 do
			tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(-45 + 10 *math.cos(sine / 100)), Rad(0), Rad(0)), 0.05)
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, .3 + 1 *math.cos(sine / 100)) * angles(Rad(-90 + 10 *math.cos(sine / 100)), Rad(0), Rad(0)), 1)
			RH.C0 = clerp(RH.C0, CF(1, -0.8, .2) * RHCF * angles(Rad(-3.5), Rad(15 - 3 *math.cos(sine / 100)), Rad(-65 + 8 *math.cos(sine / 100))), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -0.8, .2) * LHCF * angles(Rad(-1.5), Rad(-15 + 3 *math.cos(sine / 100)), Rad(65 - 8 *math.cos(sine / 100))), 0.15)
			RW.C0 = RW.C0:lerp(CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-75),math.rad(15) *math.cos(sine / 100),math.rad(0)),.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-75),math.rad(-15) *math.cos(sine / 100),math.rad(0)),.1)
			swait()
		end
	end
end

function vital() --vitalitydance
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	resting = true
	vitalmusic = Instance.new("Sound", Torso)
	vitalmusic.Pitch = 1
	vitalmusic.Looped = true
	vitalmusic.SoundId = "rbxassetid://6328707753"
	vitalmusic.Volume = 1
	vitalmusic.MaxDistance = 25
	vitalmusic:Play()
	while resting do
		for i = 1, 16 do --frame1
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -.2) * angles(Rad(-15), Rad(-10), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(15), Rad(5), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -.9 + .2, 0) * RHCF * angles(Rad(-15), Rad(0), Rad(-15)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1.3 + .2, -.3) * LHCF * angles(Rad(10), Rad(10), Rad(25)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.2, 0) * angles(Rad(0), Rad(0),Rad(-15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.2, 0) * angles(Rad(0),Rad(0),Rad(15)),.1)
			swait()
		end
		for i = 1, 8 do --frame1.5
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(-10), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(5), Rad(5), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1.2, 0) * RHCF * angles(Rad(0), Rad(0), Rad(-15)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1.2, 0) * LHCF * angles(Rad(0), Rad(0), Rad(15)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.2, -.1) * angles(Rad(0), Rad(0),Rad(-15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.2, -.1) * angles(Rad(0),Rad(0),Rad(15)),.1)
			swait()
		end
		for i = 1, 16 do --frame2
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -.2) * angles(Rad(5), Rad(10), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(15), Rad(5), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1.2 + .2, 0) * RHCF * angles(Rad(10), Rad(-25), Rad(5)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -.8 + .2, 0) * LHCF * angles(Rad(-15), Rad(0), Rad(-5)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.2, 0) * angles(Rad(0), Rad(0),Rad(-15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.2, 0) * angles(Rad(0),Rad(0),Rad(15)),.1)
			swait()
		end
		for i = 1, 8 do --frame1.5
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(-15), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(5), Rad(5), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1.2, 0) * RHCF * angles(Rad(0), Rad(0), Rad(-15)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1.2, 0) * LHCF * angles(Rad(0), Rad(0), Rad(15)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.2, -.1) * angles(Rad(0), Rad(0),Rad(-15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.2, -.1) * angles(Rad(0),Rad(0),Rad(15)),.1)
			swait()
		end
	end
end

function wave() --wave
	waving = true
	attack = true
	for i = 1, 14 do
		RW.C0 = RW.C0:lerp(CFrame.new(1.5 * Player_Size, 0.5, 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(35)),.1)
		swait()
	end
	for i = 1, 14 do
		RW.C0 = RW.C0:lerp(CFrame.new(1.5 * Player_Size, 0.5, 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(0)),.1)
		swait()
	end
	for i = 1, 14 do
		RW.C0 = RW.C0:lerp(CFrame.new(1.5 * Player_Size, 0.5, 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(35)),.1)
		swait()
	end
	for i = 1, 14 do
		RW.C0 = RW.C0:lerp(CFrame.new(1.5 * Player_Size, 0.5, 0) * CFrame.Angles(math.rad(-180),math.rad(0),math.rad(0)),.1)
		swait()
	end
	attack = false
	waving = false
end

function awake()
	hum.WalkSpeed = 15
	hum.JumpPower = 50
	resting = false
	if vitalmusic then
		vitalmusic:Destroy()
	end
end

function hug()
	target = nil
	targettorso = nil
	if Mouse.Target ~= nil then
		if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			target = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			targettorso = Mouse.Target.Parent:FindFirstChild("HumanoidRootPart") or Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
		end
	end
	if target ~= nil then
		VALUE1 = true
		hugging = true
		target.PlatformStand = true
		targettorso.Massless = true
		targettorso.Anchored = true
		WeldGrab = Instance.new("Weld", tors)
		WeldGrab.Part0 = tors
		WeldGrab.Part1 = targettorso
		WeldGrab.C1 = CFrame.new(0,0,-1.2)	
		WeldGrab.C0 = CFrame.Angles(math.rad(0),math.rad(180),math.rad(0), 0)
		for i = 1, 14 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(.4, 0, 0) * angles(Rad(0), Rad(25), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90),Rad(0),Rad(15)),.1)
			swait()
		end
		for i = 1, 80 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(.4, 0, 0) * angles(Rad(0), Rad(25), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), -1.3) * angles(Rad(90), Rad(0),Rad(-55)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), -1.3) * angles(Rad(90),Rad(0),Rad(55)),.1)
			swait()
		end
		for i = 1, 24 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(.4, 0, 0) * angles(Rad(0), Rad(25), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -.8, .1) * RHCF * angles(Rad(0), Rad(0), Rad(-25)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), -1.3) * angles(Rad(90), Rad(0),Rad(-55)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), -1.3) * angles(Rad(90),Rad(0),Rad(55)),.1)
			swait()
		end
		target.PlatformStand = false
		targettorso.Massless = false
		targettorso.Anchored = false
		hugging = false
		WeldGrab:destroy()
	end
end

function hugsmol()
	target = nil
	targettorso = nil
	if Mouse.Target ~= nil then
		if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			target = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			targettorso = Mouse.Target.Parent:FindFirstChild("HumanoidRootPart") or Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
			leftleg = target.Parent:FindFirstChild("Left Leg") or target.Parent:FindFirstChild("LeftLowerLeg")
		end
	end
	if target ~= nil then
		VALUE1 = true
		hugging = true
		target.PlatformStand = true
		targettorso.Massless = true
		targettorso.Anchored = true
		WeldGrab = Instance.new("Weld", tors)
		WeldGrab.Part0 = tors
		WeldGrab.Part1 = leftleg
		WeldGrab.C1 = CFrame.new(0,.5,-1)	
		WeldGrab.C0 = CFrame.Angles(math.rad(0),math.rad(180),math.rad(0), 0)
		for i = 1, 14 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, .3) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(-.2, 0, -.5) * angles(Rad(0), Rad(-25), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(.75, 0, 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0, 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(.75, 0.25 + .015 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.25 + .015 *math.cos(sine / 12), 0) * angles(Rad(90),Rad(0),Rad(15)),.1)
			swait()
		end
		for i = 1, 40 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, .3) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(-.2, 0, -.5) * angles(Rad(0), Rad(-25), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(.75, 0, 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0, 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(.75, 0.25 + .015 *math.cos(sine / 12), -1) * angles(Rad(90), Rad(0),Rad(-55)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.25 + .015 *math.cos(sine / 12), -1) * angles(Rad(90),Rad(0),Rad(55)),.1)
			swait()
		end
		for i = 1, 24 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, .3) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(-.2, 0, -.5) * angles(Rad(0), Rad(-25), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(.75, .1, .1) * RHCF * angles(Rad(0), Rad(0), Rad(-25)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0, 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(.75, 0.25 + .015 *math.cos(sine / 12), -1) * angles(Rad(90), Rad(0),Rad(-55)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.25 + .015 *math.cos(sine / 12), -1) * angles(Rad(90),Rad(0),Rad(55)),.1)
			swait()
		end

		target.PlatformStand = false
		targettorso.Massless = false
		targettorso.Anchored = false
		hugging = false
		WeldGrab:destroy()
	end
end

riding = false

function ride()
	local target = nil
	local targettorso = nil
	if Mouse.Target ~= nil then
		if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			target = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			targettorso = Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
			targethead = Mouse.Target.Parent:FindFirstChild("Head")
		end
	end
	if target ~= nil then
		VALUE1 = true
		hum.PlatformStand = true
		--	hed.Massless = true
		--	tors.Massless = true
		--	ra.Massless = true
		----	la.Massless = true
		--	rl.Massless = true
		--	ll.Massless = true
		--  		root.Massless = true
		riding = true
		W1 = Instance.new("Weld",root)
		W1.Name = "Weld1"
		W1.Part0 = root
		W1.Part1 = targettorso
		--W1.C1 = CFrame.new(0,0,0)	
		--W1.C0 = CFrame.Angles(math.rad(0),math.rad(0),math.rad(0), 0)
		while riding do
			for i = 1, 14 do
				rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 1, .5) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
				neck.C0 = clerp(neck.C0, necko* CF(-.3, 0, 0) * angles(Rad(0), Rad(-15 - 1 *math.cos(sine / 20)), Rad(0)), 0.08)
				RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(-15 + .5 *math.cos(sine / 20)), Rad(90)), 0.15)
				LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(15 - 1 *math.cos(sine / 20)), Rad(-90)), 0.15)
				RW.C0 = clerp(RW.C0, CF(1.3, 0.5 + .01 *math.cos(sine / 20), -.5) * angles(Rad(75), Rad(0),Rad(-35 + 1 *math.cos(sine / 25))), 0.1)
				LW.C0 = LW.C0:lerp(CFrame.new(-1.3, 0.5 + .01 *math.cos(sine / 20), -.5) * angles(Rad(75),Rad(0),Rad(35 + .5 *math.cos(sine / 25))),.1)
				swait()
			end
		end
	end
end




function ridefront()
	local target = nil
	local targettorso = nil
	if Mouse.Target ~= nil then
		if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			target = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			targettorso = Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
			targethead = Mouse.Target.Parent:FindFirstChild("Head")
		end
	end
	if target ~= nil then
		VALUE1 = true
		hum.PlatformStand = true
		--	hed.Massless = true
		--	tors.Massless = true
		--	ra.Massless = true
		----	la.Massless = true
		--	rl.Massless = true
		--	ll.Massless = true
		--  		root.Massless = true
		riding = true
		W1 = Instance.new("Weld",root)
		W1.Name = "Weld1"
		W1.Part0 = root
		W1.Part1 = targettorso
		--W1.C1 = CFrame.new(0,0,0)	
		--W1.C0 = CFrame.Angles(math.rad(0),math.rad(0),math.rad(0), 0)
		while riding do
			for i = 1, 14 do
				rootj.C0 = clerp(rootj.C0, RootCF * CF(0, -1, .5) * angles(Rad(0), Rad(0), Rad(180)), 0.15)
				neck.C0 = clerp(neck.C0, necko* CF(-.3, 0, 0) * angles(Rad(0), Rad(-15 - 1 *math.cos(sine / 20)), Rad(0)), 0.08)
				RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(-15 + .5 *math.cos(sine / 20)), Rad(90)), 0.15)
				LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(15 - 1 *math.cos(sine / 20)), Rad(-90)), 0.15)
				RW.C0 = clerp(RW.C0, CF(1.3, 0.5 + .01 *math.cos(sine / 20), -.5) * angles(Rad(75), Rad(0),Rad(-35 + 1 *math.cos(sine / 25))), 0.1)
				LW.C0 = LW.C0:lerp(CFrame.new(-1.3, 0.5 + .01 *math.cos(sine / 20), -.5) * angles(Rad(75),Rad(0),Rad(35 + .5 *math.cos(sine / 25))),.1)
				swait()
			end
		end
	end
end

function grab()
	local target = nil
	local targettorso = nil
	if Mouse.Target ~= nil then
		if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			target = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			targettorso = Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
		end
	end
	if target ~= nil then
		VALUE1 = true
		holdweld = Instance.new("Weld",ra)
		holdweld.Part0 = ra
		holdweld.Part1 = targettorso
	end
end

function ride2()
	local target = nil
	local targettorso = nil
	if Mouse.Target ~= nil then
		if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			target = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			targettorso = Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
			targethead = Mouse.Target.Parent:FindFirstChild("Head")
		end
	end
	if target ~= nil then
		VALUE1 = true
		hum.PlatformStand = true
		--	hed.Massless = true
		--	tors.Massless = true
		--	ra.Massless = true
		----	la.Massless = true
		--	rl.Massless = true
		--	ll.Massless = true
		--  		root.Massless = true
		riding = true
		W1 = Instance.new("Weld",root)
		W1.Name = "Weld1"
		W1.Part0 = root
		W1.Part1 = targettorso
		--W1.C1 = CFrame.new(0,0,0)	
		--W1.C0 = CFrame.Angles(math.rad(0),math.rad(0),math.rad(0), 0)
		while riding do
			for i = 1, 14 do
				rootj.C0 = clerp(rootj.C0, RootCF * CF(0, .7, 1.5) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
				neck.C0 = clerp(neck.C0, necko* CF(-.3, 0, -.5) * angles(Rad(0), Rad(-15 - 1 *math.cos(sine / 20)), Rad(0)), 0.08)
				RH.C0 = clerp(RH.C0, CF(.75, -.5, .4) * RHCF * angles(Rad(0), Rad(-15 + .5 *math.cos(sine / 20)), Rad(90)), 0.15)
				LH.C0 = clerp(LH.C0, CF(-.75, -.5, .4) * LHCF * angles(Rad(0), Rad(15 - 1 *math.cos(sine / 20)), Rad(-90)), 0.15)
				RW.C0 = clerp(RW.C0, CF(.65, 0.25 + .01 *math.cos(sine / 20), -.5) * angles(Rad(80), Rad(0),Rad(-35 + 1 *math.cos(sine / 25))), 0.1)
				LW.C0 = LW.C0:lerp(CFrame.new(-.65, 0.25 + .01 *math.cos(sine / 20), -.5) * angles(Rad(80),Rad(0),Rad(35 + .5 *math.cos(sine / 25))),.1)
				swait()
			end
		end
	end
end

function noride()
	W1:Destroy()
	riding = false
	hum.PlatformStand = false
	--  hed.Massless = false
	--	tors.Massless = false
	--	ra.Massless = false
	--la.Massless = false
	--rl.Massless = false
	--	ll.Massless = false
	--	root.Massless = false
end



hum:GetPropertyChangedSignal("Sit"):Connect(function()
	if hum.Sit == true and smol == false then
		sitting = true
		--print("sitting") 
		while sitting do
			for i = 1, 14 do
				tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, 0) * angles(Rad(0 - 2 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
				RW.C0 = RW.C0:lerp(CFrame.new(1.2, 0.4, -.2) * CFrame.Angles(math.rad(45),math.rad(10),math.rad(-35 - 1 *math.cos(sine / 20))),.1)
				LW.C0 = LW.C0:lerp(CFrame.new(-1.2, 0.4, -.2) * CFrame.Angles(math.rad(45),math.rad(-10),math.rad(35 + 1 *math.cos(sine / 20))),.1)
				RH.C0 = clerp(RH.C0, CF(1, -0.6, -.8) * RHCF * angles(Rad(0), Rad(-12 + .5 *math.cos(sine / 20)), Rad(0)), 0.15)
				LH.C0 = clerp(LH.C0, CF(-1, -0.6, -.8) * LHCF * angles(Rad(0), Rad(15 - 1.5 *math.cos(sine / 20)), Rad(-5)), 0.15)
				rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -.4) * angles(Rad(-5 - .35 *math.cos(sine / 20)), Rad(0), Rad(0)), 1)
				swait()
			end
		end
	elseif hum.Sit == false then
		sitting = false
		--print("got up") 
	end
end)

hum:GetPropertyChangedSignal("Sit"):Connect(function()
	if hum.Sit == true and smol == true then
		sitting = true
		--print("sitting") 
		while sitting do
			for i = 1, 14 do
				tors.Neck.C0 = clerp(tors.Neck.C0, necko* CF(0, 0, -.5) * angles(Rad(0 - 2 * math.cos(sine / 20)), Rad(0), Rad(0)), 0.05)
				RW.C0 = RW.C0:lerp(CFrame.new(.6, 0.2, -.2) * CFrame.Angles(math.rad(22.5),math.rad(10),math.rad(-35 - 1 *math.cos(sine / 20))),.1)
				LW.C0 = LW.C0:lerp(CFrame.new(-.6, 0.2, -.2) * CFrame.Angles(math.rad(22.5),math.rad(-10),math.rad(35 + 1 *math.cos(sine / 20))),.1)
				RH.C0 = clerp(RH.C0, CF(.75, 0, -.3) * RHCF * angles(Rad(0), Rad(-12 + .5 *math.cos(sine / 20)), Rad(0)), 0.15)
				LH.C0 = clerp(LH.C0, CF(-.75, 0, -.3) * LHCF * angles(Rad(0), Rad(15 - 1.5 *math.cos(sine / 20)), Rad(-5)), 0.15)
				rootj.C0 = clerp(rootj.C0, RootCF * CF(0, -.5, -.45) * angles(Rad(-5 - .35 *math.cos(sine / 20)), Rad(0), Rad(0)), 1)
				swait()
			end
		end
	elseif hum.Sit == false then
		sitting = false
		--print("got up") 
	end
end)

whistling = false

function whistle()
	whistling = true
	local randomsnd = math.random(1,2)
	outlinewhistle = Instance.new("Highlight",owner.Character)
	outlinewhistle.FillTransparency = 1
	outlinewhistle.DepthMode = 0
	outlinewhistle.OutlineColor = Color3.fromRGB(28, 3, 252)
	outlinewhistle.FillColor = Color3.new(0,0,0)
	outlinewhistle.Enabled = true
	tone = Instance.new("Sound", Head) 
	tone.Volume = 1
	tone.Pitch = 1
	if randomsnd == 1 then
		tone.SoundId = "rbxassetid://9120674705"
	end
	if randomsnd == 2 then
		tone.SoundId = "rbxassetid://9120687891"
	end
	tone:Play()
	tone.Ended:Wait()
	tone:Destroy()
	whistling = false
	outlinewhistle:Destroy()
end

smol = false

function chibi()
	smol = true
	Player_Size = .5
	root.Size = root.Size * Player_Size
	tors.Size = tors.Size * Player_Size
	--hed.Size = hed.Size * Player_Size
	ra.Size = ra.Size * Player_Size
	la.Size = la.Size * Player_Size
	rl.Size = rl.Size * Player_Size
	ll.Size = ll.Size * Player_Size  
end

function unchibi()
	smol = false
	Player_Size = 2
	root.Size = root.Size * Player_Size
	tors.Size = tors.Size * Player_Size
	--hed.Size = hed.Size * Player_Size
	ra.Size = ra.Size * Player_Size
	la.Size = la.Size * Player_Size
	rl.Size = rl.Size * Player_Size
	ll.Size = ll.Size * Player_Size
	Player_Size = 1
end

function robotics()
	dancing = true
	--   deaddance = Instance.new("Sound", Torso)
	--deaddance.Pitch = 1
	--deaddance.SoundId = "rbxassetid://4938731676"
	--deaddance.Volume = 2
	--  deaddance.Looped = true
	--deaddance:Play()
	while dancing do
		for i = 1, 14 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0 , 0) * angles(Rad(-2.464), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), 0, math.rad(-28.533)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(-1.146), math.rad(-27.387), math.rad(-55.577)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(-2.578), math.rad(0.057), math.rad(0.229)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), 0, Rad(15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), 0, Rad(-15)), .1)
			swait()
		end
		for i = 1, 14 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(-0.2, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(2.922), math.rad(-1.604), math.rad(-28.476)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(-4.412), math.rad(-24.179), math.rad(17.418)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(-3.094), math.rad(-13.808), math.rad(1.948)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(-28.992), 0, Rad(45)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(-20.455), 0, Rad(-45)),.1)
			swait()
		end
		for i = 1, 14 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(-0.1, 0, 0.08) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), 0, math.rad(-28.533)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(-3.839), math.rad(0.688), math.rad(-1.318)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(-10.428), math.rad(25.955), math.rad(65.54)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), 0, Rad(15)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), 0, Rad(-15)),.1)
			swait()
		end
		for i = 1, 14 do
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(2.922), math.rad(-1.604), math.rad(-28.476)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(-1.833), math.rad(15.355), math.rad(6.646)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(-10.428), math.rad(25.955), math.rad(-13.579)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), Rad(0),Rad(45)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(-45)),.1)
			swait()
		end
	end
end

starboy = false 


function nite()
	starboy = true
	local newrightarm = RightArm:Clone()
	StarTheme = Instance.new("Sound", ra)
	StarTheme.Pitch = 1
	StarTheme.SoundId = "rbxassetid://1843519857"
	StarTheme.Volume = 1
	StarTheme.Looped = true
	StarTheme:Play()
	Gun = Instance.new("Part", char)
	Gun.Massless = true
	Gun.CanCollide = false
	Gun.Locked = true
	Gun.Material = "ForceField"
	Gun.Size = Vector3.new(1, 1, 1)
	local Weld = Instance.new("Weld", Gun)
	Weld.Part0 = ra
	Weld.Part1 = Gun
	Weld.C1 = CFrame.new(-.2,0,-2)
	Weld.C0 = CFrame.Angles(math.rad(-90),math.rad(170),math.rad(0),0)
	local GunMesh = Instance.new("SpecialMesh")
	GunMesh.Parent = Gun
	GunMesh.MeshId = "http://www.roblox.com/asset/?id=7850031927"
	GunMesh.TextureId = "http://www.roblox.com/asset/?id=3789977396"
	GunMesh.Scale = Vector3.new(1,1,.7)
	ra.Transparency = 1
	RightArmGun = newrightarm:Clone()
	RightArmGun.Parent = char
	RightArmGun.Material = "ForceField"
	local Weld = Instance.new("Weld", ra)
	Weld.Part0 = RightArmGun
	Weld.Part1 = ra
	while starboy do
		Gun.BrickColor = BrickColor.Random()
		RightArmGun.BrickColor = Gun.BrickColor
		wait(0.1)
	end
end

function nonite()
	ra.Transparency = 0
	RightArmGun:Destroy()
	Character["Right Arm"].Material = "Plastic"
	starboy = false
	Gun:Destroy()
	StarTheme:destroy()
end

function heavens()
	heaven = true
	timeblock = Instance.new("Part")
	timeblock.CanCollide = false
	timeblock.Material = "Neon"
	timeblock.Transparency = 1
	timeblock.BrickColor = BrickColor.new("Really black")
	timeblock.Position = mouse.Hit.p
	timeblock.Shape = Enum.PartType.Ball
	timeblock.Size = Vector3.new(5,5,5)
	timeblock.Parent = script
	local Debris = game:GetService("Debris")
	Debris:AddItem(timeblock, 1)
	beam = Instance.new("Beam")
	beam.Texture = "rbxassetid://7151842823"
	beam.Width0 = 2
	beam.Width1 = 1
	beam.FaceCamera = true
	beam.TextureSpeed = 50    
	beam.Color = ColorSequence.new({ 
		ColorSequenceKeypoint.new(0, Gun.Color),
		ColorSequenceKeypoint.new(1, Gun.Color)
	}
	)
	atch1 = Instance.new("Attachment", Gun)
	atch2 = Instance.new("Attachment", timeblock)
	newBeam = beam:Clone()
	newBeam.Attachment0 = atch1
	newBeam.Attachment1 = atch2
	newBeam.Parent = atch1
	atch1 = atch2
	timeblock.Touched:connect(function(part)
		if part.Name == 'Base' or part.Parent.Name == 'ArchUsagi' or part.Parent.Name == 'KamiiiTegs' or part.Parent == owner then
		elseif part.ClassName == 'Part' or part.ClassName == 'BasePart' or part.ClassName == 'MeshPart' or part.ClassName == 'BuildingBrick' or part.ClassName == 'WedgePart' or part.ClassName == 'TrussPart' then
			part:Destroy()
		elseif part.Parent ~= char and part.Parent.Parent ~= char and part.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			local testchar = part.Parent
			for index, descendant in pairs (testchar:GetDescendants()) do
				if descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("Part") or descendant:IsA("BuildingBrick") or descendant:IsA("WedgePart") or descendant:IsA("TrussPart") then
					descendant:Destroy()
				end
			end
		end
	end)
	CreateSoundObject("904440937", ra, .5, 1)
	wait(.1)
	heaven = false
	timeblock:Destroy()
end

--------
--fireflies--
--------
local JAR = Instance.new("Model")
local LID = Instance.new("Part")
local Mesh = Instance.new("SpecialMesh")
local Flies = Instance.new("Part")
local PointLight = Instance.new("PointLight")
local ParticleEmitter = Instance.new("ParticleEmitter")
local Handle = Instance.new("Part") -- THIS IS THE ACTUAL JAR LIKE THE GLASS AND MODEL NAMED JAR :D
local Mesh_1 = Instance.new("SpecialMesh")
local BTWeld = Instance.new("Weld")
local BTWeld_1 = Instance.new("Weld")


JAR.Name = [[JAR]]

LID.BottomSurface = Enum.SurfaceType.Smooth
LID.CFrame = CFrame.new(-15, 1.44899869, 8, -1.11065318e-27, 1.4210604e-14, 0.999996245, -7.81608461e-14, 0.999999642, -9.94758204e-14, -0.999996245, -5.47117364e-13, 2.33249915e-26)
LID.Material = Enum.Material.Foil
LID.Name = [[LID]]
LID.Orientation = Vector3.new(0, 90, 0)
LID.Parent = JAR
LID.Position = Vector3.new(-15, 1.4489986896514893, 8)
LID.Rotation = Vector3.new(90, 89.83999633789062, -90)
LID.Size = Vector3.new(0.7999998331069946, 0.19999995827674866, 0.5999999046325684)
LID.TopSurface = Enum.SurfaceType.Smooth

Mesh.MeshId = [[http://www.roblox.com/asset/?id=115296503]]
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.Parent = LID
Mesh.Scale = Vector3.new(0.9999999403953552, 0.9999999403953552, 0.9999998211860657)
Mesh.TextureId = [[http://www.roblox.com/asset?id=115340918]]

Flies.Anchored = true
Flies.BackSurface = Enum.SurfaceType.SmoothNoOutlines
Flies.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
Flies.BrickColor = BrickColor.new([[Br. yellowish orange]])
Flies.CFrame = CFrame.new(-15, 0.694995224, 8, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Flies.CanCollide = false
Flies.Color = Color3.new(0.886275, 0.607843, 0.25098)
Flies.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
Flies.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
Flies.Material = Enum.Material.Neon
Flies.Name = [[Flies]]
Flies.Orientation = Vector3.new(0, 90, 0)
Flies.Parent = JAR
Flies.Position = Vector3.new(-15, 0.6949952244758606, 8)
Flies.RightSurface = Enum.SurfaceType.SmoothNoOutlines
Flies.Rotation = Vector3.new(0, 90, 0)
Flies.Size = Vector3.new(0.40998533368110657, 0.9899908304214478, 0.6400001645088196)
Flies.TopSurface = Enum.SurfaceType.SmoothNoOutlines
Flies.Transparency = 1

PointLight.Color = Color3.new(0.984314, 1, 0.027451)
PointLight.Parent = Flies

ParticleEmitter.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0.615686,0.615686,0.305882),0),ColorSequenceKeypoint.new(1,Color3.new(0.615686,0.615686,0.305882),0)})
ParticleEmitter.EmissionDirection = Enum.NormalId.Back
ParticleEmitter.Lifetime = NumberRange.new(1.25,1.25)
ParticleEmitter.LightEmission = 1
ParticleEmitter.LightInfluence = 1
ParticleEmitter.Parent = Flies
ParticleEmitter.Rate = 8
ParticleEmitter.RotSpeed = NumberRange.new(90,90)
ParticleEmitter.Rotation = NumberRange.new(155,155)
ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.155172,0.375,0),NumberSequenceKeypoint.new(0.565517,0,0),NumberSequenceKeypoint.new(0.597701,0,0),NumberSequenceKeypoint.new(1,0.2,0)})
ParticleEmitter.Speed = NumberRange.new(0,0)
ParticleEmitter.Texture = [[rbxassetid://243664672]]
ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.239238,0.296296,0),NumberSequenceKeypoint.new(0.875828,0.425926,0),NumberSequenceKeypoint.new(1,1,0)})
ParticleEmitter.ZOffset = 0.20000000298023224

Handle.BottomSurface = Enum.SurfaceType.Smooth
Handle.BrickColor = BrickColor.new([[Pastel light blue]])
Handle.CFrame = CFrame.new(-15, 0.850000679, 8, -1.11071323e-26, -7.10540838e-14, 0.999993742, 3.90797448e-13, 0.999999404, -7.10540906e-14, -0.999993742, -3.90797475e-13, 1.11071338e-26)
Handle.Color = Color3.new(0.686275, 0.866667, 1)
Handle.Name = [[Handle]]
Handle.Orientation = Vector3.new(0, 90, 0)
Handle.Parent = JAR
Handle.Position = Vector3.new(-15, 0.8500006794929504, 8)
Handle.Rotation = Vector3.new(90, 89.80000305175781, 90)
Handle.Size = Vector3.new(0.7999998331069946, 1.6999999284744263, 0.5999999046325684)
Handle.TopSurface = Enum.SurfaceType.Smooth
Handle.Transparency = 0.30000001192092896

Mesh_1.MeshId = [[http://www.roblox.com/asset/?id=115289510]]
Mesh_1.MeshType = Enum.MeshType.FileMesh
Mesh_1.Parent = Handle
Mesh_1.Scale = Vector3.new(0.9999999403953552, 0.9999999403953552, 0.9999998211860657)
Mesh_1.TextureId = [[http://www.roblox.com/asset?id=115340918]]

BTWeld.C1 = CFrame.new(0, 0.598998368, 0, 0.999997497, 4.6895826e-13, -1.66607254e-26, -1.56320364e-13, 0.999999762, -8.52650063e-14, -3.3321034e-27, 2.84214909e-14, 0.999997497)
BTWeld.Name = [[BTWeld]]
BTWeld.Parent = LID
BTWeld.Part0 = LID
BTWeld.Part1 = Handle

BTWeld_1.C1 = CFrame.new(0, 0.754003465, 0, 0.999996245, 5.47117364e-13, -2.33249915e-26, -7.81608461e-14, 0.999999642, -9.94758204e-14, -1.11065318e-27, 1.4210604e-14, 0.999996245)
BTWeld_1.Name = [[BTWeld]]
BTWeld_1.Parent = LID
BTWeld_1.Part0 = LID
BTWeld_1.Part1 = Flies
--------
--tree--
--------
local tree = Instance.new("Model")
local TRUNK = Instance.new("Part")
local LEAF = Instance.new("Part")
local Mesh = Instance.new("SpecialMesh") 
local Mesh_1 = Instance.new("SpecialMesh") 
local tree_collision = Instance.new("Part")
local tree_collision_1 = Instance.new("Part")
local tree_collision_2 = Instance.new("Part")
local tree_collision_3 = Instance.new("Part")
local tree_collision_4 = Instance.new("Part")
local tree_collision_5 = Instance.new("Part")
local tree_collision_6 = Instance.new("Part")
local tree_collision_7 = Instance.new("Part")
local tree_collision_8 = Instance.new("Part")
local tree_collision_9 = Instance.new("Part")
local tree_collision_10 = Instance.new("Part")
tree.Name = [[tree]]
TRUNK.Anchored = true
TRUNK.BottomSurface = Enum.SurfaceType.Smooth
TRUNK.BrickColor = BrickColor.new([[Reddish brown]])
TRUNK.CFrame = CFrame.new(-18.1500015, 3.03752375, 11.8499994, 1, 0, 0, 0, 1, 0, 0, 0, 1)
TRUNK.Color = Color3.new(0.411765, 0.25098, 0.156863)
TRUNK.Name = [[TRUNK]]
TRUNK.Parent = tree
TRUNK.Position = Vector3.new(-18.150001525878906, 3.0375237464904785, 11.84999942779541)
TRUNK.Size = Vector3.new(0.8000001907348633, 6.074999809265137, 0.6500000953674316)
TRUNK.TopSurface = Enum.SurfaceType.Smooth

LEAF.Anchored = true
LEAF.BottomSurface = Enum.SurfaceType.Smooth
LEAF.BrickColor = BrickColor.new([[Parsley green]])
LEAF.CFrame = CFrame.new(-18.1500015, 14.1625252, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1)
LEAF.Color = Color3.new(0.172549, 0.396078, 0.113725)
LEAF.Name = [[LEAF]]
LEAF.Parent = TRUNK
LEAF.Position = Vector3.new(-18.150001525878906, 14.162525177001953, 12)
LEAF.Size = Vector3.new(1.1999998092651367, 10.675000190734863, 0.75)
LEAF.TopSurface = Enum.SurfaceType.Smooth

Mesh.MeshId = [[rbxassetid://4747999984]]
Mesh.MeshType = Enum.MeshType.FileMesh
Mesh.Parent = LEAF
Mesh.Scale = Vector3.new(2.125, 1.375, 2.375)

Mesh_1.MeshId = [[rbxassetid://4748005890]]
Mesh_1.MeshType = Enum.MeshType.FileMesh
Mesh_1.Parent = TRUNK
Mesh_1.Scale = Vector3.new(1.375, 2.2, 1.375)

tree_collision.Anchored = true
tree_collision.BottomSurface = Enum.SurfaceType.Smooth
tree_collision.CFrame = CFrame.new(-18.1000023, 9.70003796, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision.Name = [[tree collision]]
tree_collision.Parent = TRUNK
tree_collision.Position = Vector3.new(-18.10000228881836, 9.700037956237793, 11.974998474121094)
tree_collision.Size = Vector3.new(4.100000381469727, 1, 5.399999618530273)
tree_collision.TopSurface = Enum.SurfaceType.Smooth
tree_collision.Transparency = 1

tree_collision_1.Anchored = true
tree_collision_1.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_1.CFrame = CFrame.new(-18.1000023, 7.60004425, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_1.Name = [[tree collision]]
tree_collision_1.Parent = TRUNK
tree_collision_1.Position = Vector3.new(-18.10000228881836, 7.600044250488281, 11.974998474121094)
tree_collision_1.Size = Vector3.new(6.100000381469727, 1, 7.399999618530273)
tree_collision_1.TopSurface = Enum.SurfaceType.Smooth
tree_collision_1.Transparency = 1

tree_collision_2.Anchored = true
tree_collision_2.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_2.CFrame = CFrame.new(-18.1000023, 13.7000475, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_2.Name = [[tree collision]]
tree_collision_2.Parent = TRUNK
tree_collision_2.Position = Vector3.new(-18.10000228881836, 13.700047492980957, 11.974998474121094)
tree_collision_2.Size = Vector3.new(1.1000003814697266, 1, 2.3999996185302734)
tree_collision_2.TopSurface = Enum.SurfaceType.Smooth
tree_collision_2.Transparency = 1

tree_collision_3.Anchored = true
tree_collision_3.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_3.CFrame = CFrame.new(-18.1000023, 14.700036, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_3.Name = [[tree collision]]
tree_collision_3.Parent = TRUNK
tree_collision_3.Position = Vector3.new(-18.10000228881836, 14.70003604888916, 11.974998474121094)
tree_collision_3.Size = Vector3.new(1.1000003814697266, 1, 2.3999996185302734)
tree_collision_3.TopSurface = Enum.SurfaceType.Smooth
tree_collision_3.Transparency = 1

tree_collision_4.Anchored = true
tree_collision_4.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_4.CFrame = CFrame.new(-18.1000023, 16.5000267, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_4.Name = [[tree collision]]
tree_collision_4.Parent = TRUNK
tree_collision_4.Position = Vector3.new(-18.10000228881836, 16.50002670288086, 11.974998474121094)
tree_collision_4.Size = Vector3.new(1.1000003814697266, 1, 2.3999996185302734)
tree_collision_4.TopSurface = Enum.SurfaceType.Smooth
tree_collision_4.Transparency = 1

tree_collision_5.Anchored = true
tree_collision_5.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_5.CFrame = CFrame.new(-18.1000023, 15.6000328, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_5.Name = [[tree collision]]
tree_collision_5.Parent = TRUNK
tree_collision_5.Position = Vector3.new(-18.10000228881836, 15.600032806396484, 11.974998474121094)
tree_collision_5.Size = Vector3.new(1.1000003814697266, 1, 2.3999996185302734)
tree_collision_5.TopSurface = Enum.SurfaceType.Smooth
tree_collision_5.Transparency = 1

tree_collision_6.Anchored = true
tree_collision_6.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_6.CFrame = CFrame.new(-18.1000023, 10.7000418, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_6.Name = [[tree collision]]
tree_collision_6.Parent = TRUNK
tree_collision_6.Position = Vector3.new(-18.10000228881836, 10.700041770935059, 11.974998474121094)
tree_collision_6.Size = Vector3.new(3.1000003814697266, 1, 4.399999618530273)
tree_collision_6.TopSurface = Enum.SurfaceType.Smooth
tree_collision_6.Transparency = 1

tree_collision_7.Anchored = true
tree_collision_7.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_7.CFrame = CFrame.new(-18.1000023, 12.7000418, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_7.Name = [[tree collision]]
tree_collision_7.Parent = TRUNK
tree_collision_7.Position = Vector3.new(-18.10000228881836, 12.700041770935059, 11.974998474121094)
tree_collision_7.Size = Vector3.new(1.1000003814697266, 1, 2.3999996185302734)
tree_collision_7.TopSurface = Enum.SurfaceType.Smooth
tree_collision_7.Transparency = 1

tree_collision_8.Anchored = true
tree_collision_8.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_8.CFrame = CFrame.new(-18.1000023, 8.70002651, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_8.Name = [[tree collision]]
tree_collision_8.Parent = TRUNK
tree_collision_8.Position = Vector3.new(-18.10000228881836, 8.700026512145996, 11.974998474121094)
tree_collision_8.Size = Vector3.new(5.100000381469727, 1, 6.399999618530273)
tree_collision_8.TopSurface = Enum.SurfaceType.Smooth
tree_collision_8.Transparency = 1

tree_collision_9.Anchored = true
tree_collision_9.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_9.CFrame = CFrame.new(-18.1000023, 11.7000284, 11.9749985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_9.Name = [[tree collision]]
tree_collision_9.Parent = TRUNK
tree_collision_9.Position = Vector3.new(-18.10000228881836, 11.700028419494629, 11.974998474121094)
tree_collision_9.Size = Vector3.new(2.1000003814697266, 1, 3.3999996185302734)
tree_collision_9.TopSurface = Enum.SurfaceType.Smooth
tree_collision_9.Transparency = 1

tree_collision_10.Anchored = true
tree_collision_10.BottomSurface = Enum.SurfaceType.Smooth
tree_collision_10.CFrame = CFrame.new(-18.1000023, 6.57502365, 11.9749994, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tree_collision_10.Name = [[tree collision]]
tree_collision_10.Parent = tree
tree_collision_10.Position = Vector3.new(-18.10000228881836, 6.575023651123047, 11.97499942779541)
tree_collision_10.Size = Vector3.new(8.100000381469727, 1, 9.399999618530273)
tree_collision_10.TopSurface = Enum.SurfaceType.Smooth
tree_collision_10.Transparency = 1
--------
--picnic--
--------
local picnic = Instance.new("Model")
local Part1 = Instance.new("Part")
local Decal2 = Instance.new("Decal")
local Part3 = Instance.new("Part")
local SpecialMesh4 = Instance.new("SpecialMesh")
picnic.Name = "Picnic"
Part1.Name = "blanket"
Part1.Parent = picnic
Part1.CFrame = CFrame.new(131.320786, 1.00050497, 737.34613, -0.599303603, 0, 0.800521851, 0, 1, 0, -0.800521851, 0, -0.599303603)
Part1.Orientation = Vector3.new(0, 126.81999969482422, 0)
Part1.Position = Vector3.new(131.32078552246094, 1.100504970550537, 737.3461303710938)
Part1.Rotation = Vector3.new(-180, 53.18000030517578, -180)
Part1.Color = Color3.new(1, 0.34902, 0.34902)
Part1.Size = Vector3.new(9.80228042602539, 0.0010000000474974513, 14.708320617675781)
Part1.Anchored = true
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.BrickColor = BrickColor.new("Persimmon")
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.brickColor = BrickColor.new("Persimmon")
Decal2.Parent = Part1
Decal2.Texture = "rbxassetid://158549481"
Decal2.Face = Enum.NormalId.Top
Part3.Name = "basket"
Part3.Parent = picnic
Part3.CFrame = CFrame.new(135.975082, 2.70774293, 736.463135, -0.253809363, 0, -0.967254281, 0, 1, 0, 0.967254281, 0, -0.253809363)
Part3.Orientation = Vector3.new(0, -104.69999694824219, 0)
Part3.Position = Vector3.new(135.97508239746094, 2.707742929458618, 736.463134765625)
Part3.Rotation = Vector3.new(-180, -75.30000305175781, -180)
Part3.Size = Vector3.new(4, 1, 2)
Part3.Anchored = true
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.CanCollide = false
Part3.TopSurface = Enum.SurfaceType.Smooth
SpecialMesh4.Parent = Part3
SpecialMesh4.MeshId = "rbxassetid://4856812867"
SpecialMesh4.TextureId = "rbxassetid://4856812885"
SpecialMesh4.MeshType = Enum.MeshType.FileMesh
--------
--radio--
--------
local radio = Instance.new("Model")
local Part1 = Instance.new("Part")
local SpecialMesh2 = Instance.new("SpecialMesh")
radio.Name = "Radio"
Part1.Name = "Radiopart"
Part1.Parent = radio
Part1.CFrame = CFrame.new(120.817986, 6.39313984, 599.818298, -1, 0, 0, 0, 1, 0, 0, 0, -1)
Part1.Orientation = Vector3.new(0, 180, 0)
Part1.Position = Vector3.new(120.81798553466797, 6.393139839172363, 599.8182983398438)
Part1.Rotation = Vector3.new(-180, 0, -180)
Part1.Color = Color3.new(1, 0, 0.74902)
Part1.Size = Vector3.new(3.1999971866607666, 2.0099997520446777, 1.27000093460083)
Part1.Anchored = true
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.BrickColor = BrickColor.new("Hot pink")
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.brickColor = BrickColor.new("Hot pink")
SpecialMesh2.Parent = Part1
SpecialMesh2.Name = "RadioMesh"
SpecialMesh2.MeshId = "rbxassetid://5462858191"
SpecialMesh2.Scale = Vector3.new(8, 8, 8)
SpecialMesh2.TextureId = "rbxassetid://5462934653"
SpecialMesh2.MeshType = Enum.MeshType.FileMesh
--------
--pillow--
--------
local pillow = Instance.new("Model")
pillow.Parent = workspace
pillow.Name = "BodyPill"
-------
placing = false

function spawnpillow()
	placing = true
	for i = 1, 14 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(15), Rad(0), Rad(0)), 0.08)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), Rad(0),Rad(0)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		swait()
	end
	for i = 1, 7 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1) * angles(Rad(5), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(35), Rad(0), Rad(0)), 0.08)
		RH.C0 = clerp(RH.C0, CF(1, -.5, -.5) * RHCF * angles(Rad(0), Rad(0), Rad(-5)), 0.15)
		LH.C0 = clerp(LH.C0, CF(-1, -.5, -.5) * LHCF * angles(Rad(0), Rad(0), Rad(5)), 0.15)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(35)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90),Rad(0),Rad(-35)),.1)
		swait()
	end
	pillowclone = pillow:Clone()
	pillowclone.Parent = workspace
	pillowclone.Name = "RabbitPillow"
	pillowpart = Instance.new("Part")
	pillowpart.Name = "bodypil"
	pillowmesh = Instance.new("SpecialMesh")
	pillowpart.Parent = pillowclone
	pillowpart.CFrame = CFrame.new(2.10571003, 1.2084918, 687.187866, 0.740217984, 0, -0.672366977, 0, 1, 0, 0.672366977, 0, 0.740217984)
	pillowpart.Orientation = Vector3.new(0, -42.25, 0)
	pillowpart.Position = Vector3.new(2.105710029602051, 1.2084918022155762, 687.1878662109375)
	pillowpart.Rotation = Vector3.new(0, -42.25, 0)
	pillowpart.Color = Color3.new(0.972549, 0.972549, 0.972549)
	pillowpart.Size = Vector3.new(2.5799996852874756, 0.6100001335144043, 5.450000762939453)
	pillowpart.Anchored = true
	pillowpart.BottomSurface = Enum.SurfaceType.Smooth
	pillowpart.BrickColor = BrickColor.new("Institutional white")
	pillowpart.TopSurface = Enum.SurfaceType.Smooth
	pillowpart.brickColor = BrickColor.new("Institutional white")
	pillowmesh.Parent = pillowpart
	pillowmesh.MeshId = "rbxassetid://471315266"
	pillowmesh.Scale = Vector3.new(0.00800000037997961, 0.004999999888241291, 0.009999999776482582)
	pillowmesh.MeshType = Enum.MeshType.FileMesh
	PillowTexture = Instance.new("Decal")
	PillowTexture.Parent = pillowclone.bodypil
	PillowTexture.Face = Enum.NormalId.Bottom
	PillowTexture.Color3 = Color3.new(0.701961, 0.701961, 0.701961)

	pillowclone:MoveTo(mouse.Hit.p)
	placing = false
	CreateSoundObject("9119536562", pillowclone.bodypil, 2, 1, false)
	local mr = math.random(1,4)
	if mr == 1 then

		PillowTexture.Texture = "rbxassetid://10903457264"
	end
	if mr == 2 then
		PillowTexture.Texture = "rbxassetid://11177622183"
	end
	if mr == 3 then
		PillowTexture.Texture = "rbxassetid://5648978542"
	end
	if mr == 4 then
		PillowTexture.Texture = "rbxassetid://10959291861"
	end
end

function spawnjar()
	placing = true
	for i = 1, 18 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(15), Rad(0), Rad(-25)), 0.08)
		RW.C0 = clerp(RW.C0, CF(1.2, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(-35), Rad(0),Rad(-35)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		swait()
	end
	for i = 1, 14 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1) * angles(Rad(5), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(35), Rad(0), Rad(0)), 0.08)
		RH.C0 = clerp(RH.C0, CF(1, -.5, -.5) * RHCF * angles(Rad(0), Rad(0), Rad(-5)), 0.15)
		LH.C0 = clerp(LH.C0, CF(-1, -.5, -.5) * LHCF * angles(Rad(0), Rad(0), Rad(5)), 0.15)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		swait()
	end
	jarclone = JAR:Clone()
	jarclone.Parent = workspace
	jarclone.Name = "Firejar"
	jarclone:MoveTo(mouse.Hit.p)
	placing = false
	CreateSoundObject("9119028530", jarclone.LID, 3, 1, false)
end


local musicids = {1847457012,9039874431,1840718845,1839053537,9047105108,9047105533,9047104411} --1841650288

function getmusic()
	local i = math.random(1, #musicids)
	return musicids[i]
end

function spawnradio()
	placing = true
	for i = 1, 18 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(15), Rad(0), Rad(-25)), 0.08)
		RW.C0 = clerp(RW.C0, CF(1.2, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(-35), Rad(0),Rad(-35)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		swait()
	end
	for i = 1, 14 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1) * angles(Rad(5), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(35), Rad(0), Rad(0)), 0.08)
		RH.C0 = clerp(RH.C0, CF(1, -.5, -.5) * RHCF * angles(Rad(0), Rad(0), Rad(-5)), 0.15)
		LH.C0 = clerp(LH.C0, CF(-1, -.5, -.5) * LHCF * angles(Rad(0), Rad(0), Rad(5)), 0.15)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		swait()
	end
	radioclone = radio:Clone()
	radioclone.Parent = workspace
	radioclone.Name = "Boombox"
	radioclone:MoveTo(mouse.Hit.p)
	Music = Instance.new("Sound", radioclone.Radiopart) 
	Music.Volume = 1
	Music.Pitch = 1
	Music.MaxDistance = 100
	local    TweenService = game:GetService("TweenService")
	tween = TweenService:Create(
		radioclone.Radiopart.RadioMesh,
		TweenInfo.new(.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, -3, true, 0),
		{Scale = Vector3.new(9,9,9)}
	)
	tween:Play()
	placing = false
	playmusic()
	CreateSoundObject("9116894398", radioclone.Radiopart, 3, .8, false)
end

function playmusic()
	i = getmusic()
	Music:Play()
	Music.SoundId = "rbxassetid://" .. i
	Music.TimePosition = 0
	Music.Ended:Wait()
	playmusic()
end



function spawntree()
	placing = true
	for i = 1, 18 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, .5) * angles(Rad(-10), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(-35), Rad(0), Rad(0)), 0.08)
		RW.C0 = clerp(RW.C0, CF(1.2, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(175), Rad(0),Rad(35)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(175),Rad(0),Rad(-35)),.1)
		RH.C0 = clerp(RH.C0, CF(1, -.5, -.5) * RHCF * angles(Rad(0), Rad(0), Rad(-10)), 0.15)
		LH.C0 = clerp(LH.C0, CF(-1, -.5, -.5) * LHCF * angles(Rad(0), Rad(0), Rad(10)), 0.15)
		swait()
	end
	for i = 1, 14 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1) * angles(Rad(5), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(35), Rad(0), Rad(0)), 0.08)
		RH.C0 = clerp(RH.C0, CF(1, -.5, -.5) * RHCF * angles(Rad(0), Rad(0), Rad(-5)), 0.15)
		LH.C0 = clerp(LH.C0, CF(-1, -.5, -.5) * LHCF * angles(Rad(0), Rad(0), Rad(5)), 0.15)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90),Rad(0),Rad(0)),.1)
		swait()
	end
	treeclone = tree:Clone()
	treeclone.Parent = workspace
	treeclone.Name = "Pinetree"
	treeclone:MoveTo(mouse.Hit.p)
	placing = false
	CreateSoundObject("9125585143", treeclone.TRUNK, 3, .5, false)
end

function spawnpicnic()
	placing = true
	for i = 1, 14 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(15), Rad(0), Rad(0)), 0.08)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), Rad(0),Rad(0)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		swait()
	end
	for i = 1, 7 do
		rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, -1) * angles(Rad(5), Rad(0), Rad(0)), 0.15)
		neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(35), Rad(0), Rad(0)), 0.08)
		RH.C0 = clerp(RH.C0, CF(1, -.5, -.5) * RHCF * angles(Rad(0), Rad(0), Rad(-5)), 0.15)
		LH.C0 = clerp(LH.C0, CF(-1, -.5, -.5) * LHCF * angles(Rad(0), Rad(0), Rad(5)), 0.15)
		RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90), Rad(0),Rad(35)), 0.1)
		LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90),Rad(0),Rad(-35)),.1)
		swait()
	end
	picnicclone = picnic:Clone()
	picnicclone.Parent = workspace
	picnicclone.Name = "Calmpicnic"
	picnicclone:MoveTo(mouse.Hit.p)
	ClickDetector1 = Instance.new("ClickDetector")
	ClickDetector1.Parent = picnicclone.blanket
	ClickDetector1.MaxActivationDistance = 15
	ClickDetector1.MouseClick:Connect(function(plr)
		plr.Character.Humanoid.Sit = true
	end)
	placing = false
	CreateSoundObject("9125714540", picnicclone.blanket, 2, 1, false)
end

function deleteobject()
	if mouse.Target.Parent.Name == "Pinetree" or mouse.Target.Parent.Parent.Name == "Pinetree" or mouse.Target.Name == "Pinetree" or mouse.Target.Parent.Name == "Firejar" or mouse.Target.Parent.Parent.Name == "Firejar" or mouse.Target.Name == "Firejar" or mouse.Target.Parent.Name == "Calmpicnic" or mouse.Target.Parent.Parent.Name == "Calmpicnic" or mouse.Target.Name == "Calmpicnic" or mouse.Target.Parent.Name == "Boombox" or mouse.Target.Parent.Parent.Name == "Boombox" or mouse.Target.Name == "Boombox" or mouse.Target.Parent.Name == "RabbitPillow" or mouse.Target.Parent.Parent.Name == "RabbitPillow" or mouse.Target.Name == "RabbitPillow" then
		--  descendants = mouse.Target.Parent:GetDescendants()
		-- for index, descendant in pairs(descendants) do
		--	descendant:Destroy()
		mouse.Target.Parent:Destroy()
		--end
	end
end

-------------------------------------------------------
--End Attacks N Stuff--
-------------------------------------------------------
mouse.Button1Down:connect(function(key)
	if starboy == false then
		deleteobject()
	elseif starboy == true then
		heavens()
	end
end)



mouse.KeyDown:connect(function(key)
	if attack == false then
		if key == 'z' and resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false then
			rest1()
		elseif key == 'z' and resting == false and sitting == false and hugging == false and riding == false and placing == false and starboy == false and smol == true  then
			rest1smol()
		elseif key == 'x' and resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false  then
			rest2()
		elseif key == 'x' and resting == false and sitting == false and hugging == false and riding == false and placing == false and starboy == false and smol == true  then
			rest2smol()
		elseif key == 'c' and resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false  then
			rest3()
		elseif key == 'c' and resting == false and sitting == false and hugging == false and riding == false and placing == false and starboy == false and smol == true  then
			rest3smol()
		elseif key == 'v' and resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false  then
			rest4()
		elseif key == 'b' and resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false  then
			rest5()
		elseif key == 'b' and resting == false and sitting == false and hugging == false and riding == false and placing == false and starboy == false and smol == true  then
			rest5smol()
		elseif key == 'y' and resting == false and sitting == false and hugging == false and riding == false and placing == false and starboy == false and smol == false  then
			nite()
		elseif key == 'y' and starboy == true  then
			nonite()
		elseif key == 't' and whistling == false then
			whistle()
		elseif key == 'n' and resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false  then
			restspecial()
		elseif key == 'n' and resting == false and sitting == false and hugging == false and riding == false and placing == false and starboy == false and smol == true  then
			restspecialsmol()
		elseif key == 'e' and waving == false and hugging == false and riding == false and placing == false and starboy == false then
			wave()
		elseif key == 'r' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			hug()
		elseif key == 'r' and hugging == false and resting == false and waving == false and riding == false and placing == false and starboy == false and smol == true  then
			hugsmol()
		elseif key == 'm' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			ride()
		elseif key == 'f' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			ridefront()
		elseif key == 'm' and hugging == false and resting == false and waving == false and riding == false and placing == false and starboy == false and smol == true  then
			ride2()
		elseif key == 'm' or key == 'f'  and riding == true then
			noride()
		elseif key == 'g' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false then
			chibi()
		elseif key == 'g' and hugging == false and resting == false and waving == false and riding == false and placing == false and starboy == false and smol == true then
			unchibi()
		elseif key == 'p' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			spawnjar()
		elseif key == 'l' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			spawntree()
		elseif key == 'k' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			spawnpicnic()
		elseif key == 'j' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			spawnradio()
		elseif key == 'h' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false  then
			spawnpillow()
		elseif key == 'q' and resting == true then
			awake()
		elseif key == 'q' and hugging == false and resting == false and waving == false and riding == false and placing == false and smol == false and starboy == false then
			vital()
		end
	end
end)
-------------------------------------------------------
--Start Animations--
-------------------------------------------------------
while true do
	swait()
	sine = sine + change
	hum.Health = 2.e10
	hum.PlatformStand = false
	hum.MaxHealth = 2.e10
	local torvel = (root.Velocity * Vector3.new(1, 0, 1)).magnitude
	local velderp = root.Velocity.y
	hitfloor, posfloor = rayCast(root.Position, CFrame.new(root.Position, root.Position - Vector3.new(0, 1, 0)).lookVector, 4* Player_Size, char)
	if attack == false then
		idle = idle + 1
	else
		idle = 0
	end
	if 1 < root.Velocity.y and hitfloor == nil then
		Anim = "Jump"
		if resting == false and waving == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(-15), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(-15)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(15)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5, 0) * angles(Rad(120), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5, 0) * angles(Rad(120),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false and waving == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(-15), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(-15)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(15)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5, 0) * angles(Rad(120), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5, 0) * angles(Rad(120),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and waving == false and starboy == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(-15), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(-15)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(15)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5, 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5, 0) * angles(Rad(120),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and waving == false and starboy == false and smol == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, -.5) * angles(Rad(-7.5), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(.75, 0, 0) * RHCF * angles(Rad(0), Rad(0), Rad(-7.5)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0, 0) * LHCF * angles(Rad(0), Rad(0), Rad(7.5)), 0.15)
			RW.C0 = clerp(RW.C0, CF(.75, 0.5, 0) * angles(Rad(60), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.5, 0) * angles(Rad(60),Rad(0),Rad(0)),.1)
		end
	elseif -1 > root.Velocity.y and hitfloor == nil then
		Anim = "Fall"
		if resting == false and waving == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1 - 0.05 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1 - 0.05 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false and waving == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1 - 0.05 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1 - 0.05 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and waving == false and starboy == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5, 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
			RH.C0 = clerp(RH.C0, CF(1, -1 - 0.05 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1 - 0.05 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		end
	elseif torvel < 1 and hitfloor ~= nil then
		Anim = "Idle"
		change = 1            
		if resting == false and waving == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1 - 0.05 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1 - 0.05 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false and waving == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1 - 0.05 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1 - 0.05 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and waving == false and starboy == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.05 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5, 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
			RH.C0 = clerp(RH.C0, CF(1, -1 - 0.05 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1 - 0.05 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and waving == false and starboy == false and smol == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0 + 0.025 * Cos(sine / 10)) * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, -.5) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(.75, 0 - 0.025 * Cos(sine / 10), 0) * RHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0 - 0.025 * Cos(sine / 10), 0) * LHCF * angles(Rad(0), Rad(0), Rad(0)), 0.15)
			RW.C0 = clerp(RW.C0, CF(.75, 0.5 + .015 *math.cos(sine / 12), 0) * angles(Rad(0), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.5 + .015 *math.cos(sine / 12), 0) * angles(Rad(0),Rad(0),Rad(0)),.1)
		end
	elseif torvel > 2 and torvel < 25 and hitfloor ~= nil then
		Anim = "Walk"
		change = 1.1
		if resting == false and waving == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(3) * math.cos(sine / 5)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(75) *math.cos(sine / 5)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(75) * math.cos(sine / 5)), 0.15)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(-90) *math.cos(sine / 7), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90) * math.cos(sine / 7),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and starboy == false and waving == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(3) * math.cos(sine / 5)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(75) *math.cos(sine / 5)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(75) * math.cos(sine / 5)), 0.15)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90) * math.cos(sine / 7),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and smol == false and waving == false and starboy == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(3) * math.cos(sine / 5)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RW.C0 = clerp(RW.C0, CF(1.5, 0.5, 0) * angles(Rad(90), Rad(0),Rad(0)), 0.1)
			RH.C0 = clerp(RH.C0, CF(1, -1, 0) * RHCF * angles(Rad(0), Rad(0), Rad(75) *math.cos(sine / 5)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-1, -1, 0) * LHCF * angles(Rad(0), Rad(0), Rad(75) * math.cos(sine / 5)), 0.15)
			LW.C0 = LW.C0:lerp(CFrame.new(-1.5, 0.5 + .03 *math.cos(sine / 12), 0) * angles(Rad(90) * math.cos(sine / 7),Rad(0),Rad(0)),.1)
		elseif resting == false and sitting == false and hugging == false and riding == false and placing == false and waving == false and starboy == false and smol == true then
			rootj.C0 = clerp(rootj.C0, RootCF * CF(0, 0, 0) * angles(Rad(0), Rad(0), Rad(3) * math.cos(sine / 5)), 0.15)
			neck.C0 = clerp(neck.C0, necko* CF(0, 0, -.5) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
			RH.C0 = clerp(RH.C0, CF(.75, 0, 0) * RHCF * angles(Rad(0), Rad(0), Rad(37.5) *math.cos(sine / 5)), 0.15)
			LH.C0 = clerp(LH.C0, CF(-.75, 0, 0) * LHCF * angles(Rad(0), Rad(0), Rad(37.5) *math.cos(sine / 5)), 0.15)
			RW.C0 = clerp(RW.C0, CF(.75, 0.5 + .015 *math.cos(sine / 12), 0) * angles(Rad(-45) *math.cos(sine / 7), Rad(0),Rad(0)), 0.1)
			LW.C0 = LW.C0:lerp(CFrame.new(-.75, 0.5 + .015 *math.cos(sine / 12), 0) * angles(Rad(45) * math.cos(sine / 7),Rad(0),Rad(0)),.1)
		end
	end
end
-------------------------------------------------------
--End Animations And Script--
