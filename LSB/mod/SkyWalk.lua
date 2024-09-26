local UIS = game:GetService("UserInputService")

local Space = false

UIS.InputBegan:Connect(function(Input, GPE)
	if GPE then return end

	if Input.KeyCode == Enum.KeyCode.Space then
		Space = true
		repeat task.wait()
			if owner.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				owner.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
			end
		until not Space
	end
end)

UIS.InputEnded:Connect(function(Input, GPE)
	if GPE then return end

	if Input.KeyCode == Enum.KeyCode.Space then
		Space = false
	end
end)
