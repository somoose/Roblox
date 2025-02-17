-- This function uses MoveDirection and the CFrame of the Camera to calculate a MoveDirection that incorporates the pitch rotation of the Camera.

local function GetFlyDirection ()
	-- Remove pitch from camera rotation to get a horizontal CFrame.
	local HorizontalCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.LookVector * Vector3.new(1, 0, 1))
	-- Convert MoveDirection to local axes of horizontal camera CFrame.
	local LocalMoveDirection = HorizontalCFrame:VectorToObjectSpace(Humanoid.MoveDirection)
	-- Multiply camera CFrame by LocalMoveDirection to get fly direction CFrame.
	local FlyCFrame = Camera.CFrame * CFrame.new(LocalMoveDirection)
	-- Remove position from fly direction CFrame to get direction.
	return (FlyCFrame - Camera.CFrame.Position).Position
end
