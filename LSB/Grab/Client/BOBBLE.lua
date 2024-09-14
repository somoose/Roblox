RunService.PreRender:Connect(function(Delta)
	local Velocity = math.round(Vector3.new(owner.Character.HumanoidRootPart.AssemblyLinearVelocity.X, 0, owner.Character.HumanoidRootPart.AssemblyLinearVelocity.Z).Magnitude)
	
	if not FUNCTIONS.IsFirstPerson() then
		Velocity = 0
	end

	Velocity = (PreviousVelocity ~= nil) and FUNCTIONS.Lerp(PreviousVelocity, Velocity, 0.25) or Velocity

	PreviousVelocity = Velocity
	
	Camera.CFrame = Camera.CFrame * CFrame.new(0, FUNCTIONS.GetCurve(BobbleFrequency, BobbleIntensity) * Velocity / DefaultWalkSpeed, 0) * CFrame.Angles(0, 0, math.rad(FUNCTIONS.GetCurve(RotationFrequency, RotationIntensity) * Velocity / DefaultWalkSpeed))
end)
