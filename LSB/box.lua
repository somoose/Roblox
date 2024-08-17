local color = owner.Character:FindFirstChild("Torso") and owner.Character.Torso.Color or owner.Character.UpperTorso.Color
 
local tool = Instance.new("Tool",owner.Backpack)
tool.RequiresHandle = false
tool.Name = "recall"
 
local box = Instance.new("Model",script)
box.Name = "box"
 
local base = Instance.new("Part",box)
base.Size = Vector3.new(6,1,6)
base.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
base.Material = "Wood"
base.Color = color
 
local att1 = Instance.new("Attachment",base)
att1.CFrame = CFrame.new(2.5,-.5,0)
local att2 = Instance.new("Attachment",base)
att2.CFrame = CFrame.new(-2.5,-.5,0)
local att3 = Instance.new("Attachment",base)
att3.CFrame = CFrame.new(0,-.5,2.5)
local att4 = Instance.new("Attachment",base)
att4.CFrame = CFrame.new(0,-.5,-2.5)
 
local trail1 = Instance.new("Trail",base)
trail1.Attachment0 = att1
trail1.Attachment1 = att2
trail1.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,base.Color), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))})
local trail2 = Instance.new("Trail",base)
trail2.Attachment0 = att3
trail2.Attachment1 = att4
trail2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,base.Color), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))})
 
local wallF = Instance.new("Part",box)
wallF.Size = Vector3.new(4,4,1)
wallF.CFrame = base.CFrame * CFrame.new(0,2.5,-2.5)
wallF.Material = "Wood"
wallF.Color = color
 
local fWeld = Instance.new("WeldConstraint",base)
fWeld.Part0 = base
fWeld.Part1 = wallF
 
local wallB = Instance.new("Part",box)
wallB.Size = Vector3.new(4,4,1)
wallB.CFrame = base.CFrame * CFrame.new(0,2.5,2.5)
wallB.Material = "Wood"
wallB.Color = color
 
local bWeld = Instance.new("WeldConstraint",base)
bWeld.Part0 = base
bWeld.Part1 = wallB
 
local wallR = Instance.new("Part",box)
wallR.Size = Vector3.new(1,4,6)
wallR.CFrame = base.CFrame * CFrame.new(2.5,2.5,0)
wallR.Material = "Wood"
wallR.Color = color
 
local rWeld = Instance.new("WeldConstraint",base)
rWeld.Part0 = base
rWeld.Part1 = wallR
 
local wallL = Instance.new("Part",box)
wallL.Size = Vector3.new(1,4,6)
wallL.CFrame = base.CFrame * CFrame.new(-2.5,2.5,0)
wallL.Material = "Wood"
wallL.Color = color
 
local lWeld = Instance.new("WeldConstraint",base)
lWeld.Part0 = base
lWeld.Part1 = wallL
 
local sound = Instance.new("Sound",base)
sound.Volume = 1
sound.Looped = true
sound.SoundId = "rbxassetid://12221944"
 
task.spawn(function()
    
    while task.wait() do
        if base.AssemblyLinearVelocity.Magnitude > 0 then
            
            if sound.Playing == false then sound:Play() end
            
            sound.PlaybackSpeed = base.AssemblyLinearVelocity.Magnitude / 20
            
        elseif base.AssemblyLinearVelocity.Magnitude <= 0 then
            
            if sound.Playing == true then sound:Stop() end
            
        end
    end
    
end)
 
tool.Activated:Connect(function()
    
    if box then
        base.AssemblyLinearVelocity = Vector3.new(0,0,0)
        base.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
    end
    
end)
