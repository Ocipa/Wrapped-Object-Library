--[[

local testFrame = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("Frame")


wait(2)
local wrapper = require(game.ReplicatedStorage.CreateModule.wrapper)
local wrapped = wrapper:Wrap(testFrame)


print(555555, wrapped.s)
--]]