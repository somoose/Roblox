local player = owner
local character = player.Character

function forcefield ()
	local ff = Instance.new"ForceField"
	ff.Visible = false
	
	ff.Destroying:Connect(function()
		forcefield()
	end)
	
	ff.Parent = character
end

forcefield()

character.Animate.idle.Animation2:Destroy()

warn([[

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	Script written by @E7LK.
	Credit to @ArchUsagi, animations were based off his. <3
	
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	animations: keybinds
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		q: undo
		e: sit
		r: sit2
		f: lay back
		g: lay front
		t: split
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	actions: keybinds, based off mouse
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		x: piggyback
		c: piggyfront
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	Have fun!
		-@E7LK
		
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]])

--// remotes \\
local animremote = Instance.new"RemoteEvent"
animremote.Name = "AnimRemote"
animremote.Parent = character

local weldremote = Instance.new"RemoteEvent"
weldremote.Name = "WeldRemote"
weldremote.Parent = character
--\\---------//

--// manipulative \\
local new = CFrame.new
local angles = CFrame.Angles
local rad = math.rad
--\\--------------//

--// animation booleans \\
local sit = false
local sit2 = false
local lay = false
local lay2 = false
local split = false
--\\--------------------//

local currentweld

function weldcharacter (target, position)
	position = position:lower()
	local weldp = Instance.new"Weld"

	if position == "back" then
		weldp.C0 = new(0, -character.HumanoidRootPart.Size.Y/3, -character.HumanoidRootPart.Size.Z)
	elseif position == "front" then
		weldp.C0 = new(0, -character.HumanoidRootPart.Size.Y/3, -character.HumanoidRootPart.Size.Z) * angles(0, rad(180), 0)
	end

	weldp.Part0 = character.HumanoidRootPart
	weldp.Part1 = target:FindFirstChild"Torso" or target:FindFirstChild"UpperTorso"

	weldp.Parent = character.HumanoidRootPart

	local player = game.Players:GetPlayerFromCharacter(target)

	if player then
		for _, basepart in pairs(character:GetDescendants()) do
			if basepart:IsA"BasePart" and not basepart.Anchored then
				basepart:SetNetworkOwner(player)
			end
		end
	end

	return weldp
end

function setmassless (character, bool)
	for _, basepart in pairs(character:GetDescendants()) do
		if basepart:IsA"BasePart" then
			basepart.Massless = bool
		end
	end
end

function easeinoutcubic (a)
	if a < 0.5 then
		return 4 * a * a * a
	else
		return 1 - (-2 * a + 2) ^ 2 / 2
	end
end

function lerpjoint (joint, c0, c1, t, c)
	local runs = game:GetService"RunService"
	local currentt = 0

	local start0 = joint.C0
	local start1 = joint.C1

	task.spawn(function()
		while currentt <= t do
			--// breaking specific anims when necessary \\
			if c == "lay2" and not lay2 then
				break
			end
			--\\----------------------------------------//

			currentt = currentt + runs.Heartbeat:Wait()

			joint.C0 = start0:Lerp(c0, easeinoutcubic(currentt/t))
			joint.C1 = start1:Lerp(c1, easeinoutcubic(currentt/t))
		end
	end)
end

function getjoints (character)
	local joints = {}

	for _, joint in pairs(character:GetDescendants()) do
		if joint:IsA"Motor6D" then
			joints[joint.Name] = {["joint"] = joint, ["C0"] = joint.C0, ["C1"] = joint.C1}
		end
	end

	return joints
end

function estroelk (parent)
	local part = Instance.new"Part"
	part.Size = Vector3.new(0.7, 1, 0.7)
	
	local mesh = Instance.new"SpecialMesh"
	mesh.Scale = Vector3.one * 0.2
	mesh.MeshId = "rbxassetid://11220772006"
	mesh.TextureId = "rbxassetid://11221449941"
	mesh.Parent = part
	
	part.Parent = parent
	
	return part
end

--// unpacking joints \\
local joints = getjoints(character)
local root, neck, lefthip, righthip, leftshoulder, rightshoulder

function unpackj (joints)
	root = joints["RootJoint"]
	neck = joints["Neck"]

	lefthip = joints["Left Hip"]
	righthip = joints["Right Hip"]

	leftshoulder = joints["Left Shoulder"]
	rightshoulder = joints["Right Shoulder"]
end

unpackj(joints)
--\\------------------//

function runanim (anim,t)
	anim = anim:lower()

	if anim == "stop" then
		character.Animate.Enabled = true
		character:SetAttribute("isanimated", false)

		if currentweld then
			currentweld:Destroy()
		end
		
		setmassless(character, false)

		sit, sit2, lay, lay2, split = false, false, false, false, false

		character.Humanoid.PlatformStand = false
		character.Humanoid.WalkSpeed = 16
		character.Humanoid.JumpPower = 50

		for _, joint in pairs(joints) do
			lerpjoint(joint.joint, joint.C0, joint.C1, t)
		end
	else
		character.Humanoid.WalkSpeed = 0
		character.Humanoid.JumpPower = 0

		character:SetAttribute("isanimated", true)

		task.spawn(function()
			task.wait(0.15)
			character.Animate.Enabled = false
		end)

		if anim == "sit" then sit = true
			local rootc0 = root.C0 * new(0, 0, -character.HumanoidRootPart.Size.Y/1.2) * angles(rad(-10), 0, 0)
			local lefthipc1 = lefthip.C1 * new(character["Left Leg"].Size.Y/7.5, -character["Left Leg"].Size.Y/8, 0)
				* angles(rad(15), rad(10), rad(75))
			local righthipc0 = righthip.C0 * new(-character["Right Leg"].Size.Y/8, character["Right Leg"].Size.Y/7.5, 0)
				* angles(rad(-15), rad(-10), rad(75))
			local leftshoulderc1 = leftshoulder.C1 * new(0, character["Right Arm"].Size.Y/5, 0) * angles(rad(5), 0, rad(-25))
			local rightshoulderc0 = rightshoulder.C0 * new(0, -character["Right Arm"].Size.Y/5, 0) * angles(rad(-5), 0, rad(-25))
			local neckc0 = neck.C0 * angles(rad(10), 0, 0)

			lerpjoint(root.joint,rootc0,root.C1,t)
			lerpjoint(lefthip.joint,lefthip.C0,lefthipc1,t)
			lerpjoint(righthip.joint,righthipc0,righthip.C1,t)
			lerpjoint(leftshoulder.joint,leftshoulder.C0,leftshoulderc1,t)
			lerpjoint(rightshoulder.joint,rightshoulderc0,rightshoulder.C1,t)
			lerpjoint(neck.joint,neckc0,neck.C1,t)
		elseif anim == "sit2" then sit2 = true
			local rootc0 = root.C0 * new(0, 0, -character.HumanoidRootPart.Size.Y) * angles(rad(2.5), 0, 0)
			local lefthipc0 = lefthip.C0 * new(-character["Left Leg"].Size.Z/1.5, character["Left Leg"].Size.Y/1.05, 0)
				* angles(rad(-15), 0, rad(-10))
			local righthipc1= righthip.C1 * new(-character["Right Leg"].Size.Z/2, 0, -character["Right Leg"].Size.X/4)
				* angles(rad(-90), rad(20), 0)
			local leftshoulderc0 = leftshoulder.C0 * angles(rad(5), 0, rad(-40))
			local rightshoulderc1 = rightshoulder.C1 * angles(rad(-25), 0, rad(-40))

			lerpjoint(root.joint,rootc0,root.C1,t)
			lerpjoint(lefthip.joint,lefthipc0,lefthip.C1,t)
			lerpjoint(righthip.joint,righthip.C0,righthipc1,t)
			lerpjoint(leftshoulder.joint,leftshoulderc0,leftshoulder.C1,t)
			lerpjoint(rightshoulder.joint,rightshoulder.C0,rightshoulderc1,t)
		elseif anim == "lay" then lay = true
			local rootc0 = root.C0 * new(0, 0, -character.HumanoidRootPart.Size.Y*1.3) * angles(rad(-90), 0, 0)
			local lefthipc1 = lefthip.C1 * angles(rad(-15), rad(-15), rad(10))
			local righthipc0 = righthip.C0 * angles(rad(10), rad(-10), rad(-10))
			local leftshoulderc0 = leftshoulder.C0 * angles(rad(-30), rad(30), rad(160))
			local rightshoulderc1 = rightshoulder.C1 * angles(rad(-30), rad(-30), rad(150))

			lerpjoint(root.joint,rootc0,root.C1,t)
			lerpjoint(lefthip.joint,lefthip.C0,lefthipc1,t)
			lerpjoint(righthip.joint,righthipc0,righthip.C1,t)
			lerpjoint(leftshoulder.joint,leftshoulderc0,leftshoulder.C1,t)
			lerpjoint(rightshoulder.joint,rightshoulder.C0,rightshoulderc1,t)
		elseif anim == "lay2" then lay2 = true
			local rootc0 = root.C0 * new(0, 0, -character.HumanoidRootPart.Size.Y*1.3) * angles(rad(90), 0, 0)
			local neckc0 = neck.C0 * new(0, -character.Head.Size.Y/6, 0) * angles(rad(-75), 0, 0)
			local leftshoulderc0 = leftshoulder.C0 * angles(rad(-20), 0, rad(180))
			local rightshoulderc1 = rightshoulder.C1 * angles(rad(-20), 0, rad(180))

			local lefthipc0a = lefthip.C0 * angles(0, 0, rad(20))
			local lefthipc0b = lefthip.C0 * angles(0, 0, rad(50))

			local righthipc0a = righthip.C0 * angles(0, 0, rad(-20))
			local righthipc0b = righthip.C0 * angles(0, 0, rad(-50))

			lerpjoint(root.joint,rootc0,root.C1,t)
			lerpjoint(neck.joint,neckc0,neck.C1,t)
			lerpjoint(leftshoulder.joint,leftshoulderc0,leftshoulder.C1,t)
			lerpjoint(rightshoulder.joint,rightshoulder.C0,rightshoulderc1,t)
			lerpjoint(lefthip.joint,lefthipc0a,lefthip.C1,t)
			lerpjoint(righthip.joint,righthipc0b,righthip.C1,t)

			task.spawn(function()
				task.wait(t)
				local legmovementtime = 1
				local class = "lay2"

				while lay2 do
					lerpjoint(lefthip.joint,lefthipc0b,lefthip.C1,legmovementtime,class)
					lerpjoint(righthip.joint,righthipc0a,righthip.C1,legmovementtime,class)
					task.wait(legmovementtime)
					lerpjoint(lefthip.joint,lefthipc0a,lefthip.C1,legmovementtime,class)
					lerpjoint(righthip.joint,righthipc0b,righthip.C1,legmovementtime,class)
					task.wait(legmovementtime)
				end
			end)
		elseif anim == "split" then
			local rootc0 = root.C0 * new(0, 0, -character.HumanoidRootPart.Size.Y/1.5)
			local lefthipc1 = lefthip.C1 * new(0, -character["Left Leg"].Size.Y/2.75, -character["Left Leg"].Size.X/3.5) * angles(rad(90), 0, 0)
			local righthipc0 = righthip.C0 * new(0, character["Left Leg"].Size.X/3.5, -character["Right Leg"].Size.Y/2.75) * angles(rad(-90), 0, 0)
			local leftshoulderc0 = leftshoulder.C0 * angles(rad(20), rad(-10), rad(30))
			local rightshoulderc1 = rightshoulder.C1 * angles(rad(-20), rad(10), rad(-30))

			lerpjoint(root.joint,rootc0,root.C1,t)
			lerpjoint(lefthip.joint,lefthip.C0,lefthipc1,t)
			lerpjoint(righthip.joint,righthipc0,righthip.C1,t)
			lerpjoint(leftshoulder.joint,leftshoulderc0,leftshoulder.C1,t)
			lerpjoint(rightshoulder.joint,rightshoulder.C0,rightshoulderc1,t)
		elseif anim == "piggy" then
			local neckc0 = neck.C0 * angles(0, rad(10), 0)
			local rootc0 = root.C0 * angles(rad(5), 0, 0)
			local lefthipc0 = lefthip.C0 * angles(rad(-10), rad(10), rad(-80))
			local righthipc0 = righthip.C0 * angles(rad(-10), rad(-10), rad(80))
			local leftshoulderc0 = leftshoulder.C0 * angles(0, rad(-40), rad(-80))
			local rightshoulderc0 = rightshoulder.C0 * angles(0, rad(40), rad(80))

			lerpjoint(neck.joint,neckc0,neck.C1,t)
			lerpjoint(root.joint,rootc0,root.C1,t)
			lerpjoint(lefthip.joint,lefthipc0,lefthip.C1,t)
			lerpjoint(righthip.joint,righthipc0,righthip.C1,t)
			lerpjoint(leftshoulder.joint,leftshoulderc0,leftshoulder.C1,t)
			lerpjoint(rightshoulder.joint,rightshoulderc0,rightshoulder.C1,t)
		end
	end
end

function runendinganim (anim, t)
	if anim == "nod" then
		local current = neck.joint.C0
		local neckc0 = current * angles(rad(15), 0, 0)

		lerpjoint(neck.joint,neckc0,neck.C1,t)
		task.wait(t)
		lerpjoint(neck.joint,current,neck.C1,t)
	elseif anim == "wave" then
		local current = rightshoulder.joint.C0
		local rightshoulderc0a = rightshoulder.C0 * angles(rad(40), 0, rad(-185))
		local rightshoulderc0b = rightshoulder.C0 * angles(rad(-10), 0, rad(-185))
		
		local t2 = t/1.5
		
		lerpjoint(rightshoulder.joint,rightshoulderc0a,rightshoulder.C1,t2)
		task.wait(t2)
		lerpjoint(rightshoulder.joint,rightshoulderc0b,rightshoulder.C1,t2)
		task.wait(t2)
		lerpjoint(rightshoulder.joint,rightshoulderc0a,rightshoulder.C1,t2)
		task.wait(t2)
		lerpjoint(rightshoulder.joint,rightshoulderc0b,rightshoulder.C1,t2)
		task.wait(t2)
		lerpjoint(rightshoulder.joint,current,rightshoulder.C1,t2)
	elseif anim == "throw" then
		local current = rightshoulder.joint.C0
		local rightshoulderc0a = rightshoulder.C0 * angles(rad(-30), 0, rad(-180))
		local rightshoulderc0b = rightshoulder.C0 * angles(rad(-20), 0, rad(-260))
		
		local elk = estroelk(script)
		
		local weld = Instance.new"Weld"
		weld.Part0 = elk
		weld.Part1 = character["Right Arm"]
		weld.C0 = new(0, character["Right Arm"].Size.Y/2, 0)
		weld.Parent = elk
		
		local t2 = t/1.5
		
		print("moving joints")
		
		lerpjoint(rightshoulder.joint,rightshoulderc0a,rightshoulder.C1,t2)
		task.wait(t2)
		lerpjoint(rightshoulder.joint,rightshoulderc0b,rightshoulder.C1,t2)
		task.wait(t2)
		
		print("finished moving joints")
		
		weld:Destroy()
		
		task.wait(0.1)
		print("force applied")
		
		elk.AssemblyLinearVelocity = character.HumanoidRootPart.CFrame.LookVector * 30
		lerpjoint(rightshoulder.joint,current,rightshoulder.C1,t2)
	end
end
--// remote handling \\
-- anim remote
local animdebounce = false
local animdebouncetime = 0.4
animremote.OnServerEvent:Connect(function(_, anim, ending)
	if not animdebounce then animdebounce = true
		if (character:GetAttribute"isanimated" and anim == "stop") or (not character:GetAttribute"isanimated" and anim ~= "stop") then
			if not ending then
				runanim(anim, animdebouncetime)
			end
		end
		
		if ending then
			runendinganim(anim, animdebouncetime)
		end
		task.wait(animdebouncetime) animdebounce = false
	end
end)

-- weld remote
weldremote.OnServerEvent:Connect(function(_, target, position)
	task.spawn(function()
		task.wait(0.15)
		setmassless(character, true)
		currentweld = weldcharacter(target, position)
		character.Humanoid.PlatformStand = true
	end)
end)
--\\------------------//

--// client \\
NLS([[
local uis = game:GetService"UserInputService"

local player = owner
local mouse = player:GetMouse()
local character = player.Character

local animremote = character:WaitForChild"AnimRemote"
local weldremote = character:WaitForChild"WeldRemote"

function gettarget (mousetarget)
	if mousetarget then
		local character1 = mousetarget.Parent
		local character2 = mousetarget.Parent.Parent
		local target

		if character1:IsA"Model" and character1:FindFirstChildOfClass"Humanoid" and character1 ~= character then
			target = character1
		elseif character2:IsA"Model" and character2:FindFirstChildOfClass"Humanoid" and character2 ~= character then
			target = character2
		end

		if target then
			return target
		end
	end
end

function began (key, ev)
	if not ev then
		if key.UserInputType == Enum.UserInputType.Keyboard then
			if key.KeyCode == Enum.KeyCode.Q then
				animremote:FireServer("stop")
			elseif key.KeyCode == Enum.KeyCode.E then
				animremote:FireServer("sit")
			elseif key.KeyCode == Enum.KeyCode.R then
				animremote:FireServer("sit2")
			elseif key.KeyCode == Enum.KeyCode.F then
				animremote:FireServer("lay")
			elseif key.KeyCode == Enum.KeyCode.G then
				animremote:FireServer("lay2")
			elseif key.KeyCode == Enum.KeyCode.T then
				animremote:FireServer("split")
			elseif key.KeyCode == Enum.KeyCode.X then
				if not character:GetAttribute"isanimated" then
					local target = gettarget(mouse.Target)
				
					if target then
						animremote:FireServer("piggy")
						weldremote:FireServer(target, "back")
					end
				end
			elseif key.KeyCode == Enum.KeyCode.C then
				if not character:GetAttribute"isanimated" then
					local target = gettarget(mouse.Target)

					if target then
						animremote:FireServer("piggy")
						weldremote:FireServer(target, "front")
					end
				end
			elseif key.KeyCode == Enum.KeyCode.V then
				animremote:FireServer("nod", true)
			elseif key.KeyCode == Enum.KeyCode.B then
				animremote:FireServer("wave", true)
			elseif key.KeyCode == Enum.KeyCode.N then
				animremote:FireServer("throw", true)
			end
		end
	end
end

uis.InputBegan:Connect(began)
]], player.PlayerGui)
--\\---------//
