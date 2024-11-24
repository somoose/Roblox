local Model = LoadAssets(124860912232716):Get("Blimp")
Model.Parent = script
Model:PivotTo(owner.Character:GetPivot() * CFrame.new(0, Model:GetExtentsSize().Y/2 - owner.Character:GetExtentsSize().Y/2, -Model:GetExtentsSize().Z/2))

local MCS = Model.VehicleSeat.MovementControl
NS(MCS.Value, MCS.Parent).Name = "MovementControl"
MCS:Destroy()
