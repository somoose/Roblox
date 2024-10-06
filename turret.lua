local function Lerp(a, b, t)
	return a + (b - a) * t
end
local function normalizeAngle(angle)
	while angle > math.pi do angle = angle - 2 * math.pi end
	while angle < -math.pi do angle = angle + 2 * math.pi end
	return angle
end
local function rotateTurretTo(targetPosition)
	local currentAngleY = select(2, turretMotor.C0:ToEulerAnglesYXZ())

	local direction = (targetPosition - turretBase.Position).Unit
	local targetAngleY = math.atan2(direction.X, direction.Z)

	-- Normalize angles
	local differenceAngleY = normalizeAngle(targetAngleY - currentAngleY)

	-- Apply a smooth rotation
	local newAngleY = Lerp(currentAngleY, currentAngleY + differenceAngleY, rotationSpeed)

	turretMotor.C0 = turretMotor.C0 * CFrame.Angles(0, newAngleY - currentAngleY, 0)
end
