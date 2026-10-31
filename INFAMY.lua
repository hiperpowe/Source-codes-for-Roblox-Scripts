local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cooolchillX/ScriptHubSources/refs/heads/main/CrystallineApi.lua"))()
local window = library:AddWindow("Crystalline Hub [INFAMY]", ui_options)

local Main = window:AddTab("Main")
Main:AddLabel("Usual Stuff")

Main:AddButton("Go back to Game selection", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hiperpowe/Roblox-Hypers-HUB/refs/heads/main/HypersHUB.lua"))()
end)

Main:AddButton("Close Script", function()
    game.CoreGui.imgui:Destroy()
end)

Main:AddLabel("")

Main:AddSlider("WalkSpeed", function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end, {min = 16, max = 500})

Main:AddSlider("JumpPower", function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end, {min = 50, max = 200})

local Toggle = false

Main:AddSwitch("Instant Interaction", function(state)
    Toggle = state

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            if Toggle then
                v.HoldDuration = 0.1
            else
                v.HoldDuration = 1
            end
        end
    end
end)

workspace.DescendantAdded:Connect(function(v)
    if Toggle and v:IsA("ProximityPrompt") then
        v.HoldDuration = 0
    end
end)

local TP = window:AddTab("Teleport")
TP:AddLabel("Teleport to Stores")

TP:AddButton("Gun Shop", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-293.619843, 3.25132871, 92.0819778, 0.0218612384, -5.71011594e-09, 0.999760985, 3.43547732e-08, 1, 4.96026376e-09, -0.999760985, 3.42381234e-08, 0.0218612384)
end)

TP:AddButton("Bunker Store", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(168.224289, -66.0000229, 176.318665, 0.00842621829, -1.52277888e-08, -0.999964476, -5.69535352e-09, 1, -1.52763207e-08, 0.999964476, 5.82387294e-09, 0.00842621829)
end)

TP:AddButton("Criminal AI Store", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(190.015701, 6.24999905, 176.831146, 0.0556231178, -3.74780633e-08, 0.998451829, -1.77027626e-09, 1, 3.76347948e-08, -0.998451829, -3.86090004e-09, 0.0556231178)
end)

TP:AddButton("CellPhone store", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(291.103943, 3.12500334, 319.851196, -0.9991346, 4.24313606e-09, -0.0415942334, 6.54619692e-09, 1, -5.52335209e-08, 0.0415942334, -5.54580062e-08, -0.9991346)
end)

TP:AddButton("Melee Weapon store", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-38.4863396, 3.25000024, -77.628418, 0.999769211, -1.42466294e-09, -0.0214824714, -3.38292394e-10, 1, -8.20611916e-08, 0.0214824714, 8.20495245e-08, 0.999769211)
end)

TP:AddLabel("")

TP:AddLabel("Teleport to Banks/Other")

TP:AddButton("The Club Vault", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(552.888367, 18.8615227, -100.322418, 0.999831498, 8.82787461e-08, -0.0183575228, -8.84175009e-08, 1, -6.74683331e-09, 0.0183575228, 8.36882297e-09, 0.999831498)
end)

TP:AddButton("Bank 1", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(437.676788, 4.61452723, 277.454346, 0.999748051, 3.57573166e-10, -0.0224463549, -1.67976161e-10, 1, 8.44855741e-09, 0.0224463549, -8.44265813e-09, 0.999748051)
end)

TP:AddButton("Bank 2", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7.65458775, 3.15959096, 328.8461, -0.0483167283, -3.35525785e-09, 0.998832047, -2.89884667e-08, 1, 1.95691552e-09, -0.998832047, -2.88600592e-08, -0.0483167283)
end)

TP:AddButton("Bank 3", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-251.518585, 33.2163467, -255.919022, -0.05380309, -4.99890938e-08, 0.998551548, -7.8691464e-08, 1, 4.58216185e-08, -0.998551548, -7.61121441e-08, -0.05380309)
end)

TP:AddButton("Police Station Armory", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-701.103821, 5.99999952, 521.847656, 0.982526362, -4.74555542e-08, -0.186123535, 5.33632978e-08, 1, 2.67311417e-08, 0.186123535, -3.61962158e-08, 0.982526362)
end)

TP:AddLabel("")

TP:AddLabel("Teleport to Hideout Location")

TP:AddButton("Hideout", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1070.8385, 208.956284, 200.445068, -0.999852777, 2.30796946e-08, 0.0171585344, 2.23533316e-08, 1, -4.25242739e-08, -0.0171585344, -4.2134463e-08, -0.999852777)
end)
