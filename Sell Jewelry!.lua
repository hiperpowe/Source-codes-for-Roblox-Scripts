local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cooolchillX/ScriptHubSources/refs/heads/main/CrystallineApi.lua"))()
local window = library:AddWindow("Crystalline Hub [Sell Jewelry!]", ui_options)

local wp = false
local jp = false
local hh = false
local noclip = false
local nocliptable = {}
local fb = false
local lightingconnects = {}
local NoFogConnect = nil
local showtime = false
local meteornotifconnect
local playertable = {}
local player = false
local playerconnect
local MeteorESP = false
local MeteorESPtable = {}
local MeteorESPConnect = nil

local Main = window:AddTab("Main")

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

Main:AddSlider("WalkSpeed", function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end, {min = 16, max = 500})

Main:AddSlider("JumpPower", function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end, {min = 50, max = 500})

Main:AddSlider("HipHeight", function(s)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = s
end, {min = 2, max = 50})

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
Player:AddLabel("Usual Stuff")

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

Visuals:AddSwitch("FullBright", function(state)
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

Visuals:AddSwitch("Show Current Time", function(state)
    if state then
        local gui = Instance.new("ScreenGui")
        gui.Name = "ShowTime"
        gui.Parent = game.Players.LocalPlayer.PlayerGui
        local namelabel = Instance.new("TextLabel")
        namelabel.Name = "Time"
        namelabel.Text = "Time: "
        namelabel.TextScaled = true
        namelabel.Position = UDim2.new(0, 0, 0, 0)
        namelabel.Size = UDim2.new(0, 200, 0, 50)
        namelabel.Parent = gui
        showtime = true
        while task.wait(0.1) do
            if showtime then
                game.Players.LocalPlayer.PlayerGui.ShowTime.Time.Text = "Time: " .. tostring(game.Lighting.TimeOfDay)
            elseif showtime == false then
                break
            end
        end
    else
        showtime = false
        game.Players.LocalPlayer.PlayerGui.ShowTime:Destroy()
    end
end)

Visuals:AddSwitch("Meteor Notification", function(state)
if state then
        meteornotifconnect = game.workspace.WorldEvents.ChildAdded:Connect(function(v)
            if v:IsA("Model") and v.Name == "Meteor" then
                game.StarterGui:SetCore("SendNotification", {Title = "Meteor Landing!", Text = "A Meteor has Landing!", Duration = 4,})
            end
        end)
    else
        meteornotifconnect:Disconnect()
    end
end)

local TP = window:AddTab("Teleport")
TP:AddLabel("Teleport to Places")

TP:AddButton("Teleport to your plot", function()
    local plotid = nil
    for _, v in pairs(game.workspace.GameWorld:GetChildren()) do
        if v:IsA("Folder") and string.find(string.lower(v.Name), "plot") then
            if v:GetAttribute("OwnerUserId") == game.Players.LocalPlayer.UserId then
                plotid = v:GetAttribute("PlotIndex")
            end
        end
    end
    if plotid ~= nil then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Map.Plots[plotid].PlayerSpawn.CFrame
    else
        game.StarterGui:SetCore("SendNotification", {Title = "Error", Text = "Can't Detect Plot", Duration = 4,})
    end
end)

TP:AddLabel("")

TP:AddLabel("TP Waypoints")

TP:AddButton("Create TP Waypoint", function()
    local waitforclick
    game.StarterGui:SetCore("SendNotification", {Title = "Waiting", Text = "Click Where You Want The Point", Duration = 4,})
    waitforclick = game.UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local point = Instance.new("Part")
            point.Name = "TpPoint"
            point.Size = Vector3.new(1, 1, 1)
            point.Position = game.Players.LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0)
            point.Anchored = true
            point.Color = Color3.new(1, 1, 1)
            point.CanCollide = false
            point.Parent = game.workspace
            local highlight = Instance.new("Highlight")
            highlight.Name = "Highlight"
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.Parent = point

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPBillboard"
            billboard.Size = UDim2.new(0, 50, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 0, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = point

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0.25, 0)
            label.Position = UDim2.new(0, 0, 0, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(0, 1, 0)
            label.TextScaled = true
            label.Text = "TP Point"
            label.Parent = billboard
            game.StarterGui:SetCore("SendNotification", {Title = "Point Set", Text = "TP Point Has Been Set", Duration = 4,})
            waitforclick:Disconnect()
        end
    end)
end)

TP:AddButton("TP to point", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.TpPoint.CFrame
end)

TP:AddButton("Delete TP Point", function()
    game.workspace.TpPoint:Destroy()
end)

TP:AddLabel("")

TP:AddLabel("Extra Point For Quality Of Life")

TP:AddButton("Create Extra TP Point", function()
    local waitforclick
    game.StarterGui:SetCore("SendNotification", {Title = "Waiting", Text = "Click Where You Want The Point", Duration = 4,})
    waitforclick = game.UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local point = Instance.new("Part")
            point.Name = "ExtraTpPoint"
            point.Size = Vector3.new(1, 1, 1)
            point.Position = game.Players.LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0)
            point.Anchored = true
            point.Color = Color3.new(1, 1, 1)
            point.CanCollide = false
            point.Parent = game.workspace
            local highlight = Instance.new("Highlight")
            highlight.Name = "Highlight"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.Parent = point

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPBillboard"
            billboard.Size = UDim2.new(0, 50, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 0, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = point

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0.25, 0)
            label.Position = UDim2.new(0, 0, 0, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1, 0, 0)
            label.TextScaled = true
            label.Text = "Extra TP Point"
            label.Parent = billboard
            game.StarterGui:SetCore("SendNotification", {Title = "Extra Point Set", Text = "Extra TP Point Has Been Set", Duration = 4,})
            waitforclick:Disconnect()
        end
    end)
end)

TP:AddButton("TP to Extra TP Point", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.ExtraTpPoint.CFrame
end)

TP:AddButton("Delete Extra TP Point", function()
    game.workspace.ExtraTpPoint:Destroy()
end)

local ESP = window:AddTab("ESP")
ESP:AddLabel("ESP Options")

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

ESP:AddSwitch("Meteor ESP", function(state)
    if state then
        MeteorESP = true
        for _, v in pairs(game.workspace.WorldEvents:GetDescendants()) do
            if v and v:IsA("Model") and v.Name == "MeteoriteNode" then
                table.insert(MeteorESPtable, v)
            end
        end
        MeteorESPConnect = game.workspace.WorldEvents.DescendantAdded:Connect(function(v)
            if v and v:IsA("Model") and v.Name == "MeteoriteNode" then
                table.insert(MeteorESPtable, v)
            end
        end)
        while task.wait(0.1) do
            if MeteorESP then
                xpcall(function()
                    for i = #MeteorESPtable, 1, -1 do
                        local v = MeteorESPtable[i]
                        if not v or not v.Parent then
                            table.remove(MeteorESPtable, i)
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
                                highlight.FillColor = Color3.new(1, 0, 0)
                                highlight.OutlineTransparency = 0
                                highlight.Parent = v
                            end
                        end
                    end
                end, function(err)
                    warn("Meteor ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif MeteorESP == false then
                break
            end
        end
    else
        MeteorESP = false
        MeteorESPConnect:Disconnect()
        MeteorESPtable = {}
        for _, v in pairs(game.workspace.WorldEvents:GetDescendants()) do
            if v:FindFirstChild("ESPHighlight") then
                v.ESPHighlight:Destroy()
                v.ESPBillboard:Destroy()
            end
        end
    end
end)
