local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Gnome"

local Gnome = InsertService:CreateMeshPartAsync("rbxassetid://14596253448", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Gnome.TextureID = "rbxassetid://14596254535"
Gnome.Size = Gnome.Size * 0.25
Gnome.Parent = Model

return Model
