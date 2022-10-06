local npclib = _G.npc --// module needs to be imported manually

function getrandomaccessory (character)
	local accessories = {}
	
	for _, accessory in pairs(character:GetChildren()) do
		if accessory:IsA"Accessory" then
			table.insert(accessories, accessory)
		end
	end
	
	if #accessories > 0 then
		return accessories[math.random(#accessories)]
	end
end

function run (npc, target)
	local tween = game:GetService"TweenService"
	
	local inching = false
	local inchdebounce = false
	local stealdebounce = false
	
	local prng = Random.new()
	
	task.spawn(function()
		while true do task.wait()
			if target then
				local difference = target.HumanoidRootPart.Position - npc.HumanoidRootPart.Position

				if difference.Magnitude > 27 then
					npc.Humanoid:Move(difference.Unit)
					inching = false
				elseif (difference.Magnitude < 22 and difference.Magnitude > 12) or (difference.Magnitude < 22 and inching) then
					if not npclib.islooking(target, npc) then
						inching = true

						if difference.Magnitude > 4 then
							npc.Humanoid:MoveTo(npc.HumanoidRootPart.Position + difference.Unit * 4)
						else
							if not stealdebounce then stealdebounce = true
								task.spawn(function()
									local accessory = getrandomaccessory(target)

									if accessory then
										local rightshoulder = npc:FindFirstChild("RightShoulder", true) or npc:FindFirstChild("Right Shoulder", true)

										tween:Create(rightshoulder, TweenInfo.new(0.5, 0, 0, 0, true),
											{
												C1 = rightshoulder.C1 * CFrame.Angles(0, 0, math.rad(-90))
											}
										):Play()

										task.wait(0.25)
										
										local weld = accessory.Handle:FindFirstChildOfClass"Weld"

										if weld then
											weld:Destroy()
											
											accessory.Parent = npc
										end
									else
										target = game.Players:GetPlayers()[math.random(#game.Players:GetPlayers())].Character
									end

									task.wait(1) stealdebounce = false
								end)
							end
						end
					else
						npc.Humanoid:Move(Vector3.new(-0, -1, -0))
						npc.Humanoid:MoveTo(Vector3.new(
							npc.HumanoidRootPart.Position.X + prng:NextNumber(-0.01, 0.01),
							npc.HumanoidRootPart.Position.Y,
							npc.HumanoidRootPart.Position.Z + prng:NextNumber(-0.01, 0.01)
							)
						)
						inching = false
					end
				elseif difference.Magnitude < 12 and not inching then
					npc.Humanoid:Move(-difference.Unit)
				end
			else
				target = game.Players:GetPlayers()[math.random(#game.Players:GetPlayers())].Character
			end
		end
	end)
end

local npc = npclib.getrandom(script, 0)
npclib.setnetworkowner(npc, owner)

run(npc, game.Players:GetPlayers()[math.random(#game.Players:GetPlayers())].Character)
