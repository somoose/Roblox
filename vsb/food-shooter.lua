-- Food Shooter
local Debris = game:GetService "Debris"
local RunService = game:GetService "RunService"
local PhysicsService = game:GetService "PhysicsService"

pcall(function()
	PhysicsService:CreateCollisionGroup "Fruit"
	PhysicsService:CollisionGroupSetCollidable ("Fruit", "Fruit", false)
end)

local BasePart = Instance.new "Part"
local SpecialMesh = Instance.new ("SpecialMesh", BasePart)

local Player = owner
local Character = Player.Character

local CharacterParts = {}

for _, Descendant in pairs(Character:GetDescendants()) do
	if Descendant:IsA "BasePart" then
		table.insert(CharacterParts, Descendant)
	end
end

RunService.Stepped:Connect(function (DeltaTime)
	for _, BasePart in pairs(CharacterParts) do
		PhysicsService:SetPartCollisionGroup(BasePart, "Fruit")
	end
end)

local FoodTable = {
    -- {MeshId, TextureId, MeshScale, PartSize}

	{ -- Banana
		"rbxassetid://5223124252";
		"rbxassetid://5223124348";
		Vector3.one;
		Vector3.one * 3;
	};
	
	{ -- Cucumber
		"rbxassetid://6749168284";
		"rbxassetid://6749168684";
		Vector3.one * 25;
		Vector3.one * 3;
	};
	
	{ -- Apple
		"rbxassetid://923453681";
		"rbxassetid://923453682";
		Vector3.one / 5;
		Vector3.one * 8;
	};
	
	{ -- Potato
		"rbxassetid://4946447704";
		"rbxassetid://4946447928";
		Vector3.one * 12;
		Vector3.new(6, 4, 4);
	};
	
	{ -- Pineapple
		"rbxassetid://677816839";
		"rbxassetid://677816891";
		Vector3.one * 7;
		Vector3.new(5, 10, 5);
	};
	
	{ -- Pear
		"rbxassetid://2692823214";
		"rbxassetid://2692823323";
		Vector3.one * 15;
		Vector3.new(4, 6, 5);
	};
}

function NewFood (Details, Parent)
    local Part = game.Clone(BasePart)
    Part.Size = Details[4]
    Part.Parent = Parent

	PhysicsService:SetPartCollisionGroup(Part, "Fruit")

    local SpecialMesh = Part:FindFirstChildOfClass "SpecialMesh"
    SpecialMesh.MeshId = Details[1]
    SpecialMesh.TextureId = Details[2]
    SpecialMesh.Scale = Details[3]
    SpecialMesh.Parent = Part

    return Part
end

-- Tool Details
local ForwardsVelocity = 750
local DestroyDelay = 3
local Button1Down = false

local Tool = Instance.new "Tool"
Tool.Name = "Food Shooter"
Tool.GripPos = Vector3.new (0, 0, 0.5)
Tool.Parent = Player.Backpack

local FruitsModel = Instance.new "Folder"
FruitsModel.Name = "Fruits"
FruitsModel.Parent = script

local GetMouse = Instance.new "RemoteFunction"
GetMouse.Name = "GetMouse"
GetMouse.Parent = Tool

NLS([[
local Mouse = owner:GetMouse()

local Tool = owner.Backpack:FindFirstChild "Food Shooter" or owner.Character:FindFirstChild "Food Shooter"
local GetMouse = Tool:FindFirstChild "GetMouse"
local FruitsModel = Tool:FindFirstChild "Fruits"

Mouse.TargetFilter = FruitsModel

GetMouse.OnClientInvoke = function ()
    return Mouse.Hit
end
]], Player.PlayerGui)

FruitsModel.Parent = script

local Handle = Instance.new "Part"
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Parent = Tool

Tool.Activated:Connect(function()
    Button1Down = true

    repeat RunService.Heartbeat:Wait()
        task.spawn (function ()
            local Hit = GetMouse:InvokeClient(Player)
            local Direction = (Hit.Position - Character.HumanoidRootPart.Position).Unit

            local Food = NewFood(FoodTable[math.random(#FoodTable)])
            Food:PivotTo(Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -Food.Size.Z/2))
            Food.Parent = FruitsModel

            Food.AssemblyLinearVelocity = Direction * ForwardsVelocity

            task.wait (DestroyDelay)
            Debris:AddItem(Food, 0)
        end)
    until not Button1Down
end)

Tool.Deactivated:Connect(function()
    Button1Down = false
end)
