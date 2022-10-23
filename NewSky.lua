local Lighting = game:GetService"Lighting"
Lighting:ClearAllChildren()

local NewSky = Instance.new"Sky"
NewSky.MoonAngularSize = 11
NewSky.CelestialBodiesShown = true
NewSky.MoonTextureId = "rbxasset://sky/moon.jpg"
NewSky.SkyboxBk = "http://www.roblox.com/asset/?id=144933338"
NewSky.SkyboxDn = "http://www.roblox.com/asset/?id=144931530"
NewSky.SkyboxFt = "http://www.roblox.com/asset/?id=144933262"
NewSky.SkyboxLf = "http://www.roblox.com/asset/?id=144933244"
NewSky.SkyboxRt = "http://www.roblox.com/asset/?id=144933299"
NewSky.SkyboxUp = "http://www.roblox.com/asset/?id=144931564"
NewSky.StarCount = 1500
NewSky.SunAngularSize = 5
NewSky.SunTextureId = "rbxasset://sky/sun.jpg"
NewSky.Parent = Lighting

local Sunrays = Instance.new"SunRaysEffect"
Sunrays.Spread = 3
Sunrays.Parent = Lighting

local Atmosphere = Instance.new"Atmosphere"
Atmosphere.Density = 0.325
Atmosphere.Glare = 8
Atmosphere.Parent = Lighting

local Bloom = Instance.new"BloomEffect"
Bloom.Parent = Lighting
