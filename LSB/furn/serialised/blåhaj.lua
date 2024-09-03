local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Blåhaj"

local Blahaj = InsertService:CreateMeshPartAsync("rbxassetid://12291346966", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Blahaj.TextureID = "rbxassetid://12291347416"
Blahaj.Size *= 6
Blahaj.Parent = Model

return Model
