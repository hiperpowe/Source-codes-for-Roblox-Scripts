local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cooolchillX/ScriptHubSources/refs/heads/main/CrystallineApi.lua"))()
local window = library:AddWindow("Crystalline Hub [West Wood Remake]", ui_options)

local wp = false
local jp = false
local hh = false
local godmode = false
local antidmg = false
local antidmghook
local antidmgonce = false
local infstam = false
local noclip = false
local nocliptable = {}
local fb = false
local lightingconnects = {}
local NoFogConnect = nil
local MonsterESP = false
local MonsterESPtable = {}
local MonsterESPConnect = nil
local FDealerESP = false
local FDealerESPtable = {}
local FDealerESPConnect = nil
local ContractESP = false
local ContractESPtable = {}
local ContractESPConnect = nil
local playertable = {}
local player = false
local playerconnect
local CrateESP = false
local CrateESPtable = {}
local CrateConnect = nil
local CrateConnect2 = nil
local FastWendigo = false
local FastPlayers = false
local FreezeWendigo = false
local FreezePlayers = false
local playerspeed = 16
local playername = ""

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

Player:AddSwitch("Godmode", function(state)
    if state then
        godmode = true
        while task.wait(0.05) do
            if godmode then
                game.ReplicatedStorage.RemoteEvents.Player.Damage:FireServer(-100)
            elseif godmode == false then
                break
            end
        end
    else
        godmode = false
    end
end)

Player:AddSwitch("Anti localDamage", function(state)
    if state then
        antidmg = true
        if not antidmgonce then
            antidmgonce = true
            antidmghook = hookmetamethod(game, "__namecall", function(self, ...)
                if antidmg then
                    if self == game.ReplicatedStorage.RemoteEvents.Player.Damage and getnamecallmethod() == "FireServer" then
                        local args = {...}
                        if args[1] > 0 then
                            args[1] = 0
                        end
                        return antidmghook(self, unpack(args))
                    end
                end
                return antidmghook(self, ...)
            end)
        end
    else
        antidmg = false
    end
end)

Player:AddSwitch("Infinite Stamina", function(state)
    if state then
        infstam = true
        while task.wait(0.1) do
            if infstam then
                game.ReplicatedStorage.PlayerInfo.Stats[game.Players.LocalPlayer.Name].Stamina.Value = 100
            elseif infstam == false then
                break
            end
        end
    else
        infstam = false
    end
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

Player:AddLabel("Displace Random Teleports player to a random location near by")
Player:AddButton("Displace", function()
    game.ReplicatedStorage.RemoteEvents.Event.DisplaceRandom:FireServer()
end)

Player:AddButton("TP To Closest Crate", function()
    local crates = {}
    local closest = math.huge
    local closestobj = nil
    for _, v in pairs(game.workspace.Utility.LostCrates:GetDescendants()) do
        if v and v:IsA("Model") and v.Name == "Crate" then
            table.insert(crates, v)
        end
    end
    for _, v in pairs(game.workspace.Utility.DropInstances:GetDescendants()) do
        if v and v:IsA("Model") and v.Name == "Crate" then
            table.insert(crates, v)
        end
    end
    for _, v in pairs(crates) do
        local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
        if distance < closest then
            closest = distance
            closestobj = v
        end
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = closestobj:GetPivot()
end)

Player:AddButton("TP To Held Crate Destination", function()
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.Name == "Crate" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Location.Value)
        end
    end
end)

local Visuals = window:AddTab("Visuals")
Visuals:AddLabel("Better Visuals")

Visuals:AddButton("Destroy Environment Effects", function()
    game.workspace.DustParticle:Destroy()
    game.workspace.EnvironmentParticle:Destroy()
    game.workspace.Wind:Destroy()
end)

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

Visuals:AddButton("Open Dealer's Shop", function()
    fireproximityprompt(game.workspace.NPC.Friendly.Dealer.HumanoidRootPart.Attachment.ProximityPrompt)
end)

local ESP = window:AddTab("ESP")
ESP:AddLabel("Contract Board is a Green Highlight")
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

ESP:AddSwitch("Wendigo ESP", function(state)
    if state then
        MonsterESP = true
        for _, v in pairs(game.workspace.NPC.Enemy:GetChildren()) do
            table.insert(MonsterESPtable, v)
        end
        MonsterESPConnect = game.workspace.NPC.Enemy.ChildAdded:Connect(function(v)
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
                    warn("Wendigo ESP/Highlight Error")
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
            if v:FindFirstChild("HumanoidRootPart") then
                if v.HumanoidRootPart:FindFirstChild("ESPBillboard") then
                    v.HumanoidRootPart.ESPBillboard:Destroy()
                    v.ESPHighlight:Destroy()
                end
            end
        end
    end
end)

ESP:AddSwitch("Friendly Dealer ESP", function(state)
    if state then
        FDealerESP = true
        for _, v in pairs(game.workspace.NPC.Friendly:GetChildren()) do
            table.insert(FDealerESPtable, v)
        end
        FDealerESPConnect = game.workspace.NPC.Friendly.ChildAdded:Connect(function(v)
            table.insert(FDealerESPtable, v)
        end)
        while task.wait(0.1) do
            if FDealerESP then
                xpcall(function()
                    for i = #FDealerESPtable, 1, -1 do
                        local v = FDealerESPtable[i]
                        if not v or not v.Parent then
                            table.remove(FDealerESPtable, i)
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
                                    textLabel.TextColor3 = Color3.new(1, 0, 0)
                                    textLabel.Text = v.Name
                                    textLabel.Parent = billboard

                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "ESPHighlight"
                                    highlight.FillColor = Color3.new(1, 0, 0)
                                    highlight.OutlineTransparency = 0
                                    highlight.Parent = v
                                end
                            end
                        end
                    end
                end, function(err)
                    warn("Friendly Dealer ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif FDealerESP == false then
                break
            end
        end
    else
        FDealerESP = false
        FDealerESPConnect:Disconnect()
        FDealerESPtable = {}
        for _, v in pairs(game.workspace.NPC.Friendly:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                if v.HumanoidRootPart:FindFirstChild("ESPBillboard") then
                    v.HumanoidRootPart.ESPBillboard:Destroy()
                    v.ESPHighlight:Destroy()
                end
            end
        end
    end
end)

ESP:AddSwitch("Contract Board ESP", function(state)
    if state then
        ContractESP = true
        for _, v in pairs(game.workspace.Map.Structures.MinorStructures:GetChildren()) do
            if v and v:IsA("Model") and v.Name == "ContractBoard_01" then
                table.insert(ContractESPtable, v)
            end
        end
        ContractESPConnect = game.workspace.Map.Structures.MinorStructures.ChildAdded:Connect(function(v)
            if v and v:IsA("Model") and v.Name == "ContractBoard_01" then
                table.insert(ContractESPtable, v)
            end
        end)
        while task.wait(0.1) do
            if ContractESP then
                xpcall(function()
                    for i = #ContractESPtable, 1, -1 do
                        local v = ContractESPtable[i]
                        if not v or not v.Parent then
                            table.remove(ContractESPtable, i)
                        else
                            if not v:FindFirstChild("ESPHighlight") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "ESPHighlight"
                                highlight.FillColor = Color3.new(0, 1, 0)
                                highlight.OutlineTransparency = 0
                                highlight.Parent = v
                            end
                        end
                    end
                end, function(err)
                    warn("Contract Board Highlight Error")
                    warn(debug.traceback(err))
                end)
            elseif ContractESP == false then
                break
            end
        end
    else
        ContractESP = false
        ContractESPConnect:Disconnect()
        ContractESPtable = {}
        for _, v in pairs(game.workspace.Map.Structures.MinorStructures:GetChildren()) do
            if v:FindFirstChild("ESPHighlight") then
                v.ESPHighlight:Destroy()
            end
        end
    end
end)

ESP:AddSwitch("Crate ESP", function(state)
    if state then
        CrateESP = true
        for _, v in pairs(game.workspace.Utility.LostCrates:GetDescendants()) do
            if v and v:IsA("Model") and v.Name == "Crate" then
                table.insert(CrateESPtable, v)
            end
        end
        for _, v in pairs(game.workspace.Utility.DropInstances:GetDescendants()) do
            if v and v:IsA("Model") and v.Name == "Crate" then
                table.insert(CrateESPtable, v)
            end
        end
        CrateConnect = game.workspace.Utility.LostCrates.DescendantAdded:Connect(function(v)
            if v and v:IsA("Model") and v.Name == "Crate" then
                table.insert(CrateESPtable, v)
            end
        end)
        CrateConnect2 = game.workspace.Utility.DropInstances.DescendantAdded:Connect(function(v)
            if v and v:IsA("Model") and v.Name == "Crate" then
                table.insert(CrateESPtable, v)
            end
        end)
        while task.wait(0.1) do
            if CrateESP then
                xpcall(function()
                    for i = #CrateESPtable, 1, -1 do
                        local v = CrateESPtable[i]
                        if not v or not v.Parent then
                            table.remove(CrateESPtable, i)
                        else
                            if not v:FindFirstChild("ESPHighlight") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "ESPBillboard"
                                billboard.Size = UDim2.new(0, 50, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 1, 0)
                                billboard.AlwaysOnTop = true
                                billboard.Parent = v

                                local textLabel = Instance.new("TextLabel")
                                textLabel.Size = UDim2.new(1, 0, 0.5, 0)
                                textLabel.Position = UDim2.new(0, 0, 0, 0)
                                textLabel.BackgroundTransparency = 0
                                textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
                                textLabel.TextColor3 = Color3.new(1, 0, 0)
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
                end, function(err)
                    warn("Crate ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif CrateESP == false then
                break
            end
        end
    else
        CrateESP = false
        CrateConnect:Disconnect()
        CrateConnect2:Disconnect()
        CrateESPtable = {}
        for _, v in pairs(game.workspace.Utility.LostCrates:GetDescendants()) do
            if v and v:IsA("Model") and v.Name == "Crate" then
                if v:FindFirstChild("ESPHighlight") then
                    v.ESPHighlight:Destroy()
                    v.ESPBillboard:Destroy()
                end
            end
        end
        for _, v in pairs(game.workspace.Utility.DropInstances:GetDescendants()) do
            if v and v:IsA("Model") and v.Name == "Crate" then
                if v:FindFirstChild("ESPHighlight") then
                    v.ESPHighlight:Destroy()
                    v.ESPBillboard:Destroy()
                end
            end
        end
    end
end)

local Items = window:AddTab("Items")
Items:AddLabel("Mod Items")

Items:AddButton("Mod Flashlight", function()
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

Items:AddSlider("Flashlight Brightness", function(s)
    if game.Players.LocalPlayer.Character:FindFirstChild("FlashLight") then
        game.Players.LocalPlayer.Character.FlashLight.Light.SpotLight.Brightness = s
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("FlashLight") then
        game.Players.LocalPlayer.Backpack.FlashLight.Light.SpotLight.Brightness = s
    end
end, {min = 6, max = 30})

Items:AddButton("Mod HeadLamp", function()
    if game.Players.LocalPlayer.Character:FindFirstChild("HeadLamp") then
        game.Players.LocalPlayer.Character.HeadLamp.Light.SpotLight_02.Angle = 180
        game.Players.LocalPlayer.Character.HeadLamp.Light.SpotLight_02.Shadows = false
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("HeadLamp") then
        game.Players.LocalPlayer.Backpack.HeadLamp.Light.SpotLight_02.Angle = 180
        game.Players.LocalPlayer.Backpack.HeadLamp.Light.SpotLight_02.Shadows = false
    end
end)

Items:AddSlider("HeadLamp Brightness", function(s)
    if game.Players.LocalPlayer.Character:FindFirstChild("HeadLamp") then
        game.Players.LocalPlayer.Character.HeadLamp.Light.SpotLight_02.Brightness = s
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("HeadLamp") then
        game.Players.LocalPlayer.Backpack.HeadLamp.Light.SpotLight_02.Brightness = s
    end
end, {min = 2, max = 30})

local Troll = window:AddTab("Troll")
Troll:AddLabel("Do odd things")

Troll:AddSwitch("Moch Wendigo", function(state)
    if state then
        FastWendigo = true
        while task.wait(0.1) do
            if FastWendigo then
                pcall(function()
                    for _, v in pairs(game.workspace.NPC.Enemy:GetChildren()) do
                        game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, 1000, "Running")
                    end
                end)
            elseif FastWendigo == false then
                break
            end
        end
    else
        FastWendigo = false
    end
end)

Troll:AddSwitch("Freeze Wendigo", function(state)
    if state then
        FreezeWendigo = true
        while task.wait(0.1) do
            if FreezeWendigo then
                pcall(function()
                    for _, v in pairs(game.workspace.NPC.Enemy:GetChildren()) do
                        game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, 0, "Running")
                    end
                end)
            elseif FreezeWendigo == false then
                break
            end
        end
    else
        FreezeWendigo = false
    end
end)

Troll:AddSwitch("Freeze Players", function(state)
    if state then
        FreezePlayers = true
        while task.wait(0.1) do
            if FreezePlayers then
                pcall(function()
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if v.Name ~= game.Players.LocalPlayer.Name then
                            if v:FindFirstChild("Humanoid") then
                                game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, 0, "Running")
                            end
                        end
                    end
                end)
            elseif FreezePlayers == false then
                break
            end
        end
    else
        FreezePlayers = false
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                if v:FindFirstChild("Humanoid") then
                    game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, 16, "Running")
                end
            end
        end
    end
end)

Troll:AddSlider("Players Speed", function(s)
    playerspeed = s
end, {min = 1, max = 1000})

Troll:AddTextBox("Player to Boost", function(txt)
    playername = string.lower(txt)
end)

Troll:AddButton("Boost Player", function()
    pcall(function()
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:FindFirstChild("Humanoid") then
                if string.find(string.lower(v.Name), playername) then
                    game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, playerspeed, "Running")
                end
            end
        end
    end)
end)

Troll:AddSwitch("Boost All Players", function(state)
    if state then
        FastPlayers = true
        while task.wait(0.1) do
            if FastPlayers then
                pcall(function()
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if v.Name ~= game.Players.LocalPlayer.Name then
                            if v:FindFirstChild("Humanoid") then
                                game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, playerspeed, "Running")
                            end
                        end
                    end
                end)
            elseif FastPlayers == false then
                break
            end
        end
    else
        FastPlayers = false
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                if v:FindFirstChild("Humanoid") then
                    game.ReplicatedStorage.RemoteEvents.Player.ChangeSpeed:FireServer(v.Humanoid, 16, "Running")
                end
            end
        end
    end
end)
