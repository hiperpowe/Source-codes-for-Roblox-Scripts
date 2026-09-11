local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Pet Chechers", "Synapse")

local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Usual Stuff")

MainSection:NewSlider("WalkSpeed", "Move Faster", 200, 16, function(s) -- 200 (MaxValue) | 16 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewSlider("JumpPower (Broken)", "Jump High", 200, 50, function(s) -- 200 (MaxValue) | 50 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

local TP = Window:NewTab("Teleoprt")
local TPSection = TP:NewSection("Teleport To Shops/Sell")

TPSection:NewButton("Craft Station", "Craft Station Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(819.365601, 24.3408012, 1113.87183, 0.714326739, 0, -0.699812353, 0, 1, 0, 0.699812353, 0, 0.714326739)
end)

TPSection:NewButton("Shop 1", "Shop 1 Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(782.118164, 24.2216759, 1066.71509, 0.693665564, -3.92627125e-10, -0.720297217, 9.87137316e-11, 1, -4.50026461e-10, 0.720297217, 2.4106464e-10, 0.693665564)
end)

TPSection:NewButton("Gem Trader/Sell Fish", "Gem Trader Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1320.74243, 39.9901047, 577.276672, 0.550957203, -3.61750628e-14, -0.834533513, 1.7207969e-12, 1, 1.09271869e-12, 0.834533513, -2.03810384e-12, 0.550957203)
end)

TPSection:NewButton("Shop", "Shop Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new()
end)

local TPSection = TP:NewSection("Boss Fights")

TPSection:NewButton("Slime Boss", "Slime boss Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(710.249512, 24.3408165, 1210.09729, -0.509349763, -2.76225123e-08, 0.860559583, -3.61276982e-08, 1, 1.07149773e-08, -0.860559583, -2.56323673e-08, -0.509349763)
end)

TPSection:NewButton("Kraken Boss", "Kraken Boss Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1222.77734, 40.9544067, 421.789124, 0.923709929, 0, 0.383092642, 0, 1, 0, -0.383092642, 0, 0.923709929)
end)

local TPSection = TP:NewSection("Quests Location")

TPSection:NewButton("Bounty Quests", "Get Bounty Quests Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1021.83575, 40.344635, 587.093994, 0.929979682, 0, -0.367610991, 0, 1, 0, 0.367610991, 0, 0.929979682)
end)

TPSection:NewButton("Fish Quest", "Get Fish Quests Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1318.49768, 40.5781555, 629.887634, -0.532004118, 1.86617805e-10, -0.846741736, -2.98973242e-11, 1, 2.39179537e-10, 0.846741736, 1.52559812e-10, -0.532004118)
end)

TPSection:NewButton("Fish Quest", "Get Fish Quests Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1318.49768, 40.5781555, 629.887634, -0.532004118, 1.86617805e-10, -0.846741736, -2.98973242e-11, 1, 2.39179537e-10, 0.846741736, 1.52559812e-10, -0.532004118)
end)

local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Destroy all Gates")

MiscSection:NewButton("Destroy Gates", "Destroys all gates on the map", function()
    maps = Workspace.Map
    for _, map in ipairs(maps:GetChildren()) do
        for _, barrier in ipairs(map:GetChildren()) do
            if barrier.Name == "Barrier" then
                barrier:Destroy()
            end
        end
    end
end)

local Rewards = Window:NewTab("Rewards TP")
local RewardsSection = Rewards:NewSection("Get Rewards Places")

RewardsSection:NewButton("Gem Shrine Reward", "Shine Reward Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1321.92993, 39.9901047, 589.948608, -0.66353035, -6.29874462e-13, -0.748149395, 6.28887263e-12, 1, -6.419483e-12, 0.748149395, -8.96453831e-12, -0.66353035)
end)

RewardsSection:NewButton("Egg Shrine Reward", "Shine Reward Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1308.57971, 39.990097, 563.227051, 0.995878398, 4.94429164e-09, 0.09069819, -5.0863842e-09, 1, 1.33550937e-09, -0.09069819, -1.79133075e-09, 0.995878398)
end)

RewardsSection:NewButton("Golden Ticket Shrine Reward", "Shine Reward Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1836.82214, 51.6008224, 280.420654, 0.0894223824, 0, -0.995993793, 0, 1, 0, 0.995993793, 0, 0.0894223824)
end)

RewardsSection:NewButton("COMING SOON", "THIS SCRIPT IS COMING SOON", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new()
end)

local Games = Window:NewTab("MiniGames")
local GamesSection = Games:NewSection("NEEDS GOLDEN TICKETS")

GamesSection:NewButton("Archeologist Quest", "Enter the dig Quest Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1844.45361, 51.6008224, 265.181458, -0.141438663, 6.37461817e-13, -0.989947021, 4.29625817e-13, 1, 5.82552507e-13, 0.989947021, -3.42911355e-13, -0.141438663)
end)
