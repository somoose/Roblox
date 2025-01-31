local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local StartTimeInMinutes = 12
local TotalDayTimeInSeconds = 20
local Start = os.clock()
local Active = true
RunService.PostSimulation:Connect(function()
	if not Active then return end
	local ElapsedTimeInSeconds = StartTimeInMinutes + os.clock() - Start
	local Time = ElapsedTimeInSeconds / TotalDayTimeInSeconds -- ranges from 0 to 1, used to calculate a time position between 0 and 24.
	Lighting:SetMinutesAfterMidnight(Time * 24 * 60)
	print(ElapsedTimeInSeconds, Lighting.TimeOfDay)
	if ElapsedTimeInSeconds >= TotalDayTimeInSeconds then Active = false end
end)
