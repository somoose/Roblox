local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "PS1 Rat"

local Rat = InsertService:CreateMeshPartAsync("rbxassetid://14597516279", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Rat.TextureID = "rbxassetid://14597516340"
Rat.Parent = Model

return Model
