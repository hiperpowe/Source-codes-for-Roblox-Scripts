local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Thief Simulator", "Synapse")

game.StarterGui:SetCore("SendNotification", {Title = "Loaded", Text = "Thief Simulator Load", Duration = 4,})

local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Usual Stuff")

MainSection:NewSlider("WalkSpeed", "Move Faster", 200, 16, function(s) -- 200 (MaxValue) | 16 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewSlider("JumpPower (Broken)", "Jump High", 200, 50, function(s) -- 200 (MaxValue) | 50 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

local TP = Window:NewTab("Teleoprt")
local TPSection = TP:NewSection("Teleport To Stores")

TPSection:NewButton("Shop", "Shop Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(33.1039581, 131.591919, 473.312531, -0.999963105, -8.12291456e-10, 0.00858676527, -3.28800265e-10, 1, 5.63079681e-08, -0.00858676527, 5.63030689e-08, -0.999963105)
end)

TPSection:NewButton("Sell", "Sell location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7.26882792, 131.891876, 483.403503, -0.999997914, 3.42420647e-10, 0.0020533388, 1.8721806e-10, 1, -7.55856746e-08, -0.0020533388, -7.55851275e-08, -0.999997914)
end)

TPSection:NewButton("Skin Shop", "Skin Shop Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-42.5879135, 131.591904, 466.881714, -0.973915875, -1.97435828e-08, 0.226909384, 3.24438454e-09, 1, 1.00936063e-07, -0.226909384, 9.90394184e-08, -0.973915875)
end)

local TPSection = TP:NewSection("Teleport To Zones")

TPSection:NewButton("Zone 2", "Teleport to zone 2", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(251.655548, 131.591919, -113.79483, 0.999346554, 2.67568134e-10, -0.0361456648, -1.29325786e-10, 1, 3.82692855e-09, 0.0361456648, -3.81975296e-09, 0.999346554)
end)

TPSection:NewButton("Zone 3", "Teleport to zone 3", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-166.608109, 131.591919, -199.625458, 0.998928905, -1.11938911e-08, -0.0462718122, 1.11929301e-08, 1, -2.79864409e-10, 0.0462718122, -2.38352532e-10, 0.998928905)
end)

local TPSection = TP:NewSection("ROB PLACES TP")

TPSection:NewButton("Bank", "Bank Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-217.24263, 133.569977, -83.7240906, -0.0301958565, 6.05330825e-08, 0.999544024, -4.33842651e-09, 1, -6.0691761e-08, -0.999544024, -6.16908791e-09, -0.0301958565)
end)

TPSection:NewButton("Royal Ice", "Royal Ice Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-134.525803, 131.691925, -235.226578, 0.00362322433, 8.77664377e-08, -0.999993443, -7.18224635e-09, 1, 8.77409931e-08, 0.999993443, 6.86429402e-09, 0.00362322433)
end)

TPSection:NewButton("Tech Shop", "Tech Shop Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(415.90683, 131.891876, -238.365814, 0.000718526659, 3.86310361e-08, -0.999999762, 2.26053523e-08, 1, 3.86472863e-08, 0.999999762, -2.26331149e-08, 0.000718526659)
end)

TPSection:NewButton("Bets Shop", "Bets Shop Location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(168.165512, 131.891907, 142.330154, 0.0101894038, -1.6319099e-08, -0.999948084, -4.21303853e-10, 1, -1.63242397e-08, 0.999948084, 5.87616233e-10, 0.0101894038)
end)

local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Destroy Stuff")

MiscSection:NewButton("Destroy Border Zone 2", "It will destroy Border Zone 2", function()
    game.workspace["Zone 2"]:Destroy()
end)

MiscSection:NewButton("Destroy Border Zone 3", "It will destroy Border Zone 3", function()
    game.workspace["Zone 3"]:Destroy()
end)

MiscSection:NewButton("No World blockers", "All World blockers Destroyed", function()
    game.workspace.MapBlockers:Destroy()
end)

MiscSection:NewButton("No Water", "Make water go bye bye", function()
    game.workspace.Water:Destroy()
end)

local MiscSection = Misc:NewSection("Destroy Walls to Stores")

MiscSection:NewButton("Royal Ice Modifirs", "Destroys the walls", function()
    game.workspace.World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.Building:Destroy()
    game:GetService("Workspace").World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.InvisibleWalls:Destroy()
end)

MiscSection:NewButton("Tech Shop Modifirs", "Destroys the walls", function()
    game.workspace.World1.Stores["Tech Stores"]["Tech Store"].BuildingModel.Building:Destroy()
end)

MiscSection:NewButton("Bank Modifirs", "Destroys the walls", function()
    game.workspace.World1.Stores.Banks.Bank.BuildingModel.Building:Destroy()
end)

MiscSection:NewButton("BETS Modifirs", "Destroys the walls", function()
    game:GetService("Workspace").World1.Stores["Betting Stores"]["Betting Store"].BuildingModel.Building:Destroy()
end)

local useful = Window:NewTab("Useful for Heists")
local usefulSection = useful:NewSection("Destroy Lasers")

usefulSection:NewButton("No Lasers In bank", "Destroys all Lasers", function()
    game:GetService("Workspace").World1.Stores.Banks.Bank.BuildingModel.Layout2:Destroy()
    game.workspace.World1.Stores.Banks.Bank.BuildingModel.Layout1:Destroy()
end)

usefulSection:NewButton("No Lasers/Bear Trap In Royal Ice", "Destroys all Lasers", function()
    game:GetService("Workspace").World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.Layout2:Destroy()
    game:GetService("Workspace").World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.LasersRotation:Destroy()
    game:GetService("Workspace").World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.Layout1:Destroy()
    game:GetService("Workspace").World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.LasersRotation:Destroy()
    game:GetService("Workspace").World1.Stores["Jewelry Stores"]["Jewelry Store"].BuildingModel.BearTrap:Destroy()
end)

usefulSection:NewButton("No Lasers In Tech shop", "Destroys all Lasers", function()
    game:GetService("Workspace").World1.Stores["Tech Stores"]["Tech Store"].BuildingModel.Layout2:Destroy()
end)

local usefulSection = useful:NewSection("Destroy Water Puddles")

usefulSection:NewButton("No Water In bank", "Destroys all Water", function()
    game:GetService("Workspace").World1.Stores.Banks.Bank.BuildingModel.Puddle:Destroy()
end)

local UI = Window:NewTab("UI Toggle")
local UISection = UI:NewSection("Show/Hide")

UISection:NewKeybind("Show/Hide GUI", "Toggle UI", Enum.KeyCode.Insert, function()
	Library:ToggleUI()
end)

UISection:NewTextBox("Change Locking text", "Chenges the text of the lockpick text", function(txt)
	game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.Text = txt
end)

UISection:NewToggle("RGB Text", "red green blue", function(state)
    if state then
        i = true
        while wait() do
            if i == true then
                game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(255, 0, 0)
                wait(0.5)
                game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(255, 85, 0)
                wait(0.5)
                game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(255, 255, 0)
                wait(0.5)
                game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(0, 255, 0)
                wait(0.5)
                game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(0, 0, 255)
                wait(0.5)
                game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(255, 0, 255)
            elseif i == false then
                break
            end
        end
    else
        i = false
        wait(1)
        game:GetService("Players").LocalPlayer.PlayerGui.Tasks.Container.Lockpick.Circle.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)
