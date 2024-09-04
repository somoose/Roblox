local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Potato"

local Potato = InsertService:CreateMeshPartAsync("rbxassetid://477543051", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Potato.TextureID = "rbxassetid://477543054"
Potato.Parent = Model

return Model
