function Reflect (Normal, HitNormal)
	-- https://devforum.roblox.com/t/how-to-reflect-rays-on-hit/18143
	
	-- Normal is the normal of your raycast.
	-- HitNormal is the surface normal that our raycast hit.
	
	return Normal - 2 * (Normal:Dot(HitNormal)) * HitNormal
end
