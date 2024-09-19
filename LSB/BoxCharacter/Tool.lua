local HttpService = game:GetService("HttpService")
loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/LSB/BoxCharacter/Module.lua"))()

local NPCTool = Instance.new("Tool", owner.Backpack)
NPCTool.Name = "Spawn Box"

local Handle = Instance.new("Part", NPCTool)
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Transparency = 1

local Activated = false

NPCTool.Activated:Connect(function()
	Activated = true

	repeat
		local NPC = BoxCharacter.CreateNPC(script)
		NPC.Head.CFrame = Handle.CFrame
		NPC.Humanoid.DisplayName = " "
		
		task.wait(0.1)
	until not Activated
end)

NPCTool.Deactivated:Connect(function()
	Activated = false
end)

NPCTool.Unequipped:Connect(function()
	Activated = false
end)
