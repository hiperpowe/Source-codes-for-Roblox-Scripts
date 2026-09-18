local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("West Wood: Remake", "Ocean")

local wp = false
local jp = false
local hh = false
local noclip = false
local nocliptable = {}
local lightingconnects = {}
local NoFogConnect = nil
local MonsterESP = false
local MonsterESPtable = {}
local MonsterESPConnect = nil
local playertable = {}
local player = false
local playerconnect

local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Usual Stuff")

MainSection:NewSlider("WalkSpeed", "Move Faster", 200, 16, function(s) -- 200 (MaxValue) | 16 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewSlider("JumpPower", "Jump High", 200, 50, function(s) -- 200 (MaxValue) | 50 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

MainSection:NewSlider("HipHight", "Hip Point Higher", 400, 0, function(s) -- 400 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = s
end)

MainSection:NewToggle("Loop Walkspeed", "Loop Speed", function(state)
    if state then
        wp = true
        local a = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
        while task.wait(0.1) do
            if wp then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
            elseif wp == false then
                break
            end
        end
    else
        wp = false
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

MainSection:NewToggle("Loop JumpPower", "Loop Jump Height", function(state)
    if state then
        jp = true
        local a = game.Players.LocalPlayer.Character.Humanoid.JumpPower
        while task.wait(0.1) do
            if jp then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
            elseif jp == false then
                break
            end
        end
    else
        jp = false
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

MainSection:NewToggle("Loop HipHeight", "Loop HipHeight", function(state)
    if state then
        hh = true
        local a = game.Players.LocalPlayer.Character.Humanoid.HipHeight
        while task.wait(0.1) do
            if hh then
                game.Players.LocalPlayer.Character.Humanoid.HipHeight = a
            elseif hh == false then
                break
            end
        end
    else
        hh = false
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = 0
    end
end)

local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Usual Stuff")

PlayerSection:NewToggle("Noclip", "Clip Through Walls", function(state)
    if state then
        noclip = true
        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v and (v:IsA("Part") or v:IsA("MeshPart")) then
                if v.CanCollide then
                    table.insert(nocliptable, v)
                end
            end
        end
        while task.wait(0.1) do
            if noclip then
                for _, v in pairs(nocliptable) do
                    v.CanCollide = false
                end
            elseif noclip == false then
                break
            end
        end
    else
        noclip = false
        for _, v in pairs(nocliptable) do
            v.CanCollide = true
        end
        nocliptable = {}
    end
end)

local Visual = Window:NewTab("Visuals")
local VisualSection = Visual:NewSection("Better Visuals")

VisualSection:NewToggle("FullBright", "Brighten The Game", function(state)
    if state then
        local lighting = game:GetService("Lighting")
        local properties = {ClockTime = 14, GlobalShadows = false, Ambient = Color3.fromRGB(255, 255, 255), Brightness = 10, OutdoorAmbient = Color3.fromRGB(255, 255, 255)}
        for i, v in pairs(properties) do
            lighting[i] = v
            lightingconnects[i] = lighting:GetPropertyChangedSignal(i):Connect(function()
                if lighting[i] ~= v then
                    lighting[i] = v
                end
            end)
        end
    else
        for _, v in pairs(lightingconnects) do
            v:Disconnect()
        end
        lightingconnects = {}
    end
end)

VisualSection:NewToggle("No Fog", "Removes Fog", function(state)
    if state then
        local v = game.Lighting.Atmosphere
        NoFogConnect = game.Lighting.Atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
            if v.Density ~= 0 then
                v.Density = 0
            end
        end)
        v.Density = 0
    else
        NoFogConnect:Disconnect()
    end
end)

local ESP = Window:NewTab("ESP")
local ESPSection = ESP:NewSection("toggle ESP")

ESPSection:NewToggle("Wendigo ESP", "See Wendigo Highlight", function(state)
    if state then
        MonsterESP = true
        for _, v in pairs(game.workspace.NPC.Enemy:GetChildren()) do
            table.insert(MonsterESPtable, v)
        end
        MonsterESPConnect = game.workspace.NPC.Enemy.ChildAdded:Connect(function(v)
                table.insert(MonsterESPtable, v)
        end)
        while task.wait(1) do
            if MonsterESP then
                xpcall(function()
                    for i = #MonsterESPtable, 1, -1 do
                        local v = MonsterESPtable[i]
                        if not v or not v.Parent then
                            table.remove(MonsterESPtable, i)
                        else
                            if not v:FindFirstChild("ESPHighlight") and v:FindFirstChild("HumanoidRootPart") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "ESPHighlight"
                                highlight.FillColor = Color3.new(1, 0, 0)
                                highlight.OutlineTransparency = 0
                                highlight.Parent = v
                            end
                        end
                    end
                end, function(err)
                    warn("Highlight ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif MonsterESP == false then 
                break
            end
        end
    else
        MonsterESP = false
        MonsterESPConnect:Disconnect()
        MonsterESPtable = {}
        for _, v in pairs(game.workspace.NPC.Enemy:GetChildren()) do
            if v:FindFirstChild("ESPHighlight") then
                v.ESPHighlight:Destroy()
            end
        end
    end
end)

local items = Window:NewTab("Items")
local itemsSection = items:NewSection("Mod Items")

itemsSection:NewButton("Mod Flashlight", "Make the flashlight better", function()
    if game.Players.LocalPlayer.Character:FindFirstChild("FlashLight") then
        game.Players.LocalPlayer.Character.FlashLight.Ring:Destroy()
        game.Players.LocalPlayer.Character.FlashLight.Light.SpotLight.Angle = 180
        game.Players.LocalPlayer.Character.FlashLight.Light.SpotLight.Shadows = false
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("FlashLight") then
        game.Players.LocalPlayer.Backpack.FlashLight.Ring:Destroy()
        game.Players.LocalPlayer.Backpack.FlashLight.Light.SpotLight.Angle = 180
        game.Players.LocalPlayer.Backpack.FlashLight.Light.SpotLight.Shadows = false
    end
end)

itemsSection:NewSlider("Adjust Brightness", "Change the Brightness value", 500, 6, function(s) -- 500 (MaxValue) | 6 (MinValue)
    if game.Players.LocalPlayer.Character:FindFirstChild("FlashLight") then
        game.Players.LocalPlayer.Character.FlashLight.Light.SpotLight.Brightness = s
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("FlashLight") then
        game.Players.LocalPlayer.Backpack.FlashLight.Light.SpotLight.Brightness = s
    end
end)

ESPSection:NewToggle("Player ESP", "See Player Names", function(state)
    if state then
        player = true
        for _, v in pairs(game.workspace:GetChildren()) do
            table.insert(playertable, v)
        end
        playerconnect = game.workspace.ChildAdded:Connect(function(v)
            table.insert(playertable, v)
        end)
        while task.wait(0.1) do
            if player then
                xpcall(function()
                    for i = #playertable, 1, -1 do
                        local v = playertable[i]
                        if not v or not v.Parent then
                            table.remove(playertable, i)
                        else
                            if v.Name ~= game.Players.LocalPlayer.Name then
                                if v:FindFirstChild("HumanoidRootPart") then
                                    if not v.HumanoidRootPart:FindFirstChild("ESPBillboard") then
                                        local billboard = Instance.new("BillboardGui")
                                        billboard.Name = "ESPBillboard"
                                        billboard.Size = UDim2.new(0, 50, 0, 50)
                                        billboard.StudsOffset = Vector3.new(0, 1, 0)
                                        billboard.AlwaysOnTop = true
                                        billboard.Parent = v.HumanoidRootPart

                                        local textLabel = Instance.new("TextLabel")
                                        textLabel.Size = UDim2.new(2, 0, 0.5, 0)
                                        textLabel.Position = UDim2.new(0, 0, 0, 0)
                                        textLabel.BackgroundTransparency = 0
                                        textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
                                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                                        textLabel.Text = v.Name
                                        textLabel.Parent = billboard
                                    end
                                end
                            end
                        end
                    end
                end, function(err)
                    warn("Player ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif player == false then
                break
            end
        end
    else
        player = false
        playerconnect:Disconnect()
        playertable = {}
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                if v.HumanoidRootPart:FindFirstChild("ESPBillboard") then
                    v.HumanoidRootPart.ESPBillboard:Destroy()
                end
            end
        end
    end
end)

local UI = Window:NewTab("UI Toggle")
local UISection = UI:NewSection("Show/Hide")

UISection:NewKeybind("Show/Hide GUI", "Toggle UI", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)
