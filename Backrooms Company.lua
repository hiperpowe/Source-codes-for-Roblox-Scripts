local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cooolchillX/ScriptHubSources/refs/heads/main/CrystallineApi.lua"))()
local window = library:AddWindow("Crystalline Hub [Backrooms Company]", ui_options)

local wp = false
local jp = false
local hh = false
local noclip = false
local nocliptable = {}
local fb = false
local lightingconnects = {}
local NoFogConnect = nil
local MonsterESP = false
local MonsterESPtable = {}
local MonsterESPConnect = nil
local playertable = {}
local player = false
local playerconnect
local CrateESP = false
local CrateESPtable = {}
local CrateConnect = nil

local Main = window:AddTab("Main")
Main:AddLabel("GUI Options")

Main:AddButton("Go back to Game selection", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hiperpowe/Roblox-Hypers-HUB/refs/heads/main/HypersHUB.lua"))()
end)

Main:AddButton("Close Script", function()
    game.CoreGui.imgui:Destroy()
end)

Main:AddKeybind("Toggle UI", function()
    game.CoreGui.imgui.Visible = not game.CoreGui.imgui.Visible
end, {standard = Enum.KeyCode.RightShift})

Main:AddLabel("")
Main:AddLabel("Player Options")

Main:AddSlider("WalkSpeed", function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end, {min = 16, max = 500})

Main:AddSlider("JumpPower", function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end, {min = 50, max = 500})

Main:AddSlider("HipHeight", function(s)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = s
end, {min = 0, max = 50})

Main:AddSwitch("Loop Walkspeed", function(state)
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

Main:AddSwitch("Loop Jumppower", function(state)
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

Main:AddSwitch("Loop HipHeight", function(state)
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

local Player = window:AddTab("Player")

Player:AddLabel("You must click button only once before using noclip, otherwise it will not work")
Player:AddButton("Use Before noclip", function()
    game.Players.LocalPlayer.Character.ViewBlocker:Destroy()
end)

Player:AddSwitch("Noclip", function(state)
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

local Visuals = window:AddTab("Visuals")
Visuals:AddLabel("Better Visuals")

Visuals:AddSwitch("Fullbright", function(state)
    if state then
        fb = true
        local lighting = game:GetService("Lighting")
        local properties = {ClockTime = 14, GlobalShadows = false, Ambient = Color3.fromRGB(255, 255, 255), Brightness = 5, OutdoorAmbient = Color3.fromRGB(255, 255, 255)}
        for i, v in pairs(properties) do
            lighting[i] = v
            lightingconnects[i] = lighting:GetPropertyChangedSignal(i):Connect(function()
                if lighting[i] ~= v then
                    lighting[i] = v
                end
            end)
        end
        while task.wait(0.1) do
            if fb then
                if game.workspace:FindFirstChild("Wind") then
                    game.workspace.Wind:Destroy()
                end
            elseif fb == false then
                break
            end
        end
    else
        for _, v in pairs(lightingconnects) do
            v:Disconnect()
        end
        lightingconnects = {}
    end
end)

Visuals:AddSwitch("No Fog", function(state)
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

local ESP = window:AddTab("ESP")
ESP:AddLabel("toggle ESP")

ESP:AddSwitch("Player ESP", function(state)
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

                                        local highlight = Instance.new("Highlight")
                                        highlight.Name = "ESPHighlight"
                                        highlight.FillColor = Color3.new(1, 1, 1)
                                        highlight.OutlineTransparency = 0
                                        highlight.Parent = v
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
                    v.ESPHighlight:Destroy()
                end
            end
        end
    end
end)

ESP:AddSwitch("Monster ESP", function(state)
    if state then
        MonsterESP = true
        for _, v in pairs(game.workspace.GameTriggers.SpawnedEntities:GetChildren()) do
            table.insert(MonsterESPtable, v)
        end
        MonsterESPConnect = game.workspace.GameTriggers.SpawnedEntities.ChildAdded:Connect(function(v)
            table.insert(MonsterESPtable, v)
        end)
        while task.wait(0.1) do
            if MonsterESP then
                xpcall(function()
                    for i = #MonsterESPtable, 1, -1 do
                        local v = MonsterESPtable[i]
                        if not v or not v.Parent then
                            table.remove(MonsterESPtable, i)
                        else
                            if v:FindFirstChild("HumanoidRootPart") then
                                if not v.HumanoidRootPart:FindFirstChild("ESPBillboard") then
                                    local billboard = Instance.new("BillboardGui")
                                    billboard.Name = "ESPBillboard"
                                    billboard.Size = UDim2.new(0, 50, 0, 50)
                                    billboard.StudsOffset = Vector3.new(0, 1, 0)
                                    billboard.AlwaysOnTop = true
                                    billboard.Parent = v.HumanoidRootPart

                                    local textLabel = Instance.new("TextLabel")
                                    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
                                    textLabel.Position = UDim2.new(0, 0, 0, 0)
                                    textLabel.BackgroundTransparency = 0
                                    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
                                    textLabel.TextColor3 = Color3.new(0, 1, 0)
                                    textLabel.Text = v.Name
                                    textLabel.Parent = billboard

                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "ESPHighlight"
                                    highlight.FillColor = Color3.new(0, 1, 0)
                                    highlight.OutlineTransparency = 0
                                    highlight.Parent = v
                                end
                            end
                        end
                    end
                end, function(err)
                    warn("Monster ESP/Highlight Error")
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
        for _, v in pairs(game.workspace.GameTriggers.SpawnedEntities:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                if v.HumanoidRootPart:FindFirstChild("ESPBillboard") then
                    v.HumanoidRootPart.ESPBillboard:Destroy()
                    v.ESPHighlight:Destroy()
                end
            end
        end
    end
end)

local Misc = window:AddTab("Misc")
Misc:AddLabel("Gamepasses")

Misc:AddButton("Toggle Gamepasses", function()
    local player = game.Players.LocalPlayer
    player:SetAttribute("FreeRevives", 100)
    player:SetAttribute("HasFasterRunSpeed", true)
    player:SetAttribute("HasInfiniteJumpscares", true)
    player:SetAttribute("HasMoreStamina", true)
    player:SetAttribute("HasRover", true)
    player:SetAttribute("HasUnlimitedSuitColors", true)
    player:SetAttribute("SpeedBoost", true)
end)