local function moveIK(ChainRoot, EndEffector, Target)
    local joints = {}
    local current = ChainRoot

    -- Create a function to find the next connected part through joints
    local function findNextPart(part)
        for _, joint in ipairs(part:GetJoints()) do
            if joint:IsA("Motor6D") then
                if joint.Part0 == part then
                    return joint.Part1, joint
                elseif joint.Part1 == part then
                    return joint.Part0, joint
                end
            end
        end
        return nil, nil
    end

    -- Collect joints while moving from ChainRoot to EndEffector
    while current and current ~= EndEffector do
        local nextPart, joint = findNextPart(current)
        if joint then
            table.insert(joints, joint)
            current = nextPart
        else
            break -- No more joints found
        end
        task.wait()
    end

    -- Set the end effector to the target position
    EndEffector.Position = Target.Position

    -- Calculate adjustments to C1 for each joint to reach the target
    for i = #joints, 1, -1 do
        local joint = joints[i]
        local part0 = joint.Part0
        local part1 = joint.Part1

        -- Calculate the direction to the target
        local directionToTarget = (EndEffector.Position - part0.Position).unit
        local currentDirection = (part1.Position - part0.Position).unit

        -- Check if currentDirection is not zero to avoid invalid operations
        if currentDirection.magnitude > 0 then
            -- Calculate the angle required
            local angle = math.acos(math.clamp(directionToTarget:Dot(currentDirection), -1, 1))

            -- Calculate the rotation axis
            local rotationAxis = currentDirection:Cross(directionToTarget)

            -- Update C1 based on the rotation needed
            if angle > 0 and rotationAxis.magnitude > 0 then
                -- Normalize the rotation axis
                rotationAxis = rotationAxis.unit
                -- Create a rotation CFrame
                local rotationCFrame = CFrame.Angles(rotationAxis.x * angle, rotationAxis.y * angle, rotationAxis.z * angle)

                -- Update the C1 property to rotate the joint
                joint.C1 = joint.C1 * rotationCFrame
            end
        end
    end
end

local TargetPart = Instance.new("Part", script)
TargetPart.Anchored = true
TargetPart.Size = Vector3.one
TargetPart.CanCollide = false
TargetPart.CanTouch = false
TargetPart.CanQuery = false

local Highlight = Instance.new("Highlight", TargetPart)

local Character = owner.Character

local RightShoulder = owner.Character:FindFirstChild("RightElbow", true)
local RightHand = owner.Character:FindFirstChild("RightHand", true)

while task.wait() do
	moveIK(RightShoulder, RightHand, TargetPart)
end
