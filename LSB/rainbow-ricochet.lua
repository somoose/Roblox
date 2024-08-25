local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "gay riccochet"

local Handle = Instance.new("Part", Tool)
Handle.Size = Vector3.one
Handle.Name = "Handle"

local FireRemote = Instance.new("RemoteEvent", Tool)
FireRemote.Name = "FireRemote"

local TweenService = game:GetService("TweenService")

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RaycastParams.FilterDescendantsInstances = {owner.Character}

function Reflect (Normal, HitNormal)
	-- https://devforum.roblox.com/t/how-to-reflect-rays-on-hit/18143
	
	-- Normal is the normal of your raycast.
	-- HitNormal is the surface normal that our raycast hit.
	
	return Normal - 2 * (Normal:Dot(HitNormal)) * HitNormal
end

function CreateBullet ()
	local Bullet = Instance.new("Part", script)
	Bullet.Material = Enum.Material.Neon
	Bullet.Color = Color3.fromRGB(255, 255, 255)
	Bullet.Anchored = true
	Bullet.CanCollide = false
	Bullet.CanQuery = false
	
	task.spawn(function()
		while Bullet do
			for i = 1, 255 do
				Bullet.Color = Color3.fromHSV(i/255, 1, 1)
				
				task.wait()
			end
		end
	end)
	
	return Bullet
end

function AnimateBullet (Bullet, StartPoint, EndPoint)
	Bullet.Size = Vector3.new(0.2, 0.2, 0)
	Bullet.CFrame = CFrame.new(StartPoint, EndPoint)
	
	local Difference = EndPoint - StartPoint
	local Midpoint = (StartPoint + EndPoint) / 2
	
	local Time = Difference.Magnitude / 150
	
	local CFrameTween = TweenService:Create(Bullet, TweenInfo.new(Time), {
		CFrame = CFrame.new(EndPoint, EndPoint + Difference.Unit)
	})
	
	local FirstSizeTween = TweenService:Create(Bullet, TweenInfo.new(Time / 4), {
		Size = Vector3.new(Bullet.Size.X, Bullet.Size.Y, Difference.Magnitude / 4)
	})
	
	local SecondSizeTween = TweenService:Create(Bullet, TweenInfo.new(Time), {
		Size = Vector3.new(Bullet.Size.X, Bullet.Size.Y, 0)
	})
	
	CFrameTween:Play()
	FirstSizeTween:Play()
	FirstSizeTween.Completed:Wait()
	SecondSizeTween:Play()
	SecondSizeTween.Completed:Wait()
end

function Shoot (Bullet, Origin, Direction)
	local Result = workspace:Raycast(Origin, Direction, RaycastParams)
	
	if Result then
		AnimateBullet(Bullet, Origin, Result.Position)
		
		if not Result.Instance.Anchored then
			Result.Instance:BreakJoints()
			Result.Instance.AssemblyLinearVelocity = Direction / Direction.Magnitude * 250
			Result.Instance.AssemblyAngularVelocity = Vector3.new(math.random(), math.random(), math.random()) * 180
		end
		
		Shoot(Bullet, Result.Position, Reflect(Direction / Direction.Magnitude, Result.Normal) * Direction.Magnitude)
	else
		AnimateBullet(Bullet, Origin, Origin + Direction / Direction.Magnitude * 150)
		Bullet:Destroy()
	end
end

FireRemote.OnServerEvent:Connect(function(_, Direction)
	task.spawn(function()
		local Bullet = CreateBullet()
		
		Shoot(Bullet, Handle.Position, Direction * 1000)
	end)
end)

NLS([[
local Mouse = owner:GetMouse()
local Camera = workspace.CurrentCamera

local Tool = script.Parent
local FireRemote = Tool:WaitForChild("FireRemote")

local Activated = false

Tool.Activated:Connect(function()
	Activated = true
	
	repeat
		local StartPoint = Tool.Handle.Position
		local EndPoint = Mouse.Hit.Position
		local Direction = (EndPoint - StartPoint).Unit
		
		FireRemote:FireServer(Direction)
		
		task.wait()
	until not Activated
end)

Tool.Deactivated:Connect(function()
	Activated = false
end)
]], Tool)
