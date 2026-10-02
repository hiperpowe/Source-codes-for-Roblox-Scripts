local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Jewelry Empire", "Ocean")

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

local Main = Window:NewTab("Main") --Main Tab
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

MainSection:NewToggle("Loop Walkspeed", "Loop Speed", function(state) --loop WalkSpeed
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

MainSection:NewToggle("Loop JumpPower", "Loop Jump Height", function(state) --loop JumpPower
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

MainSection:NewToggle("Loop HipHeight", "Loop HipHeight", function(state) --Loop HipHeight
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

local Player = Window:NewTab("Player") --Player Tab
local PlayerSection = Player:NewSection("Usual Stuff")

PlayerSection:NewToggle("Noclip", "Clip Through Walls", function(state) --Noclip
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

local Visual = Window:NewTab("Visuals") --Visuals Tab
local VisualSection = Visual:NewSection("Better Visuals")

VisualSection:NewToggle("FullBright", "Brighten The Game", function(state) --FullBright
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

VisualSection:NewToggle("No Fog", "Removes Fog", function(state) --No Fog
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

VisualSection:NewToggle("Show Current Time", "A Free Clock", function(state) --Show Current Time
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

VisualSection:NewToggle("Meteor Notification", "Shows Notification When Meteor Lands", function(state) --Meteor Notification
    if state then
        meteornotifconnect = game.workspace.WorldEvents.ChildAdded:Connect(function(v)
            if v:IsA("Model") and v.Name == "Meteor" then
                game.StarterGui:SetCore("SendNotification", {Title = "Meteor Landed!", Text = "A Meteor has Landed!", Duration = 4,})
            end
        end)
    else
        meteornotifconnect:Disconnect()
    end
end)

local TP = Window:NewTab("Teleports") --Teleports Tab
local TPSection = TP:NewSection("Teleport to places")

TPSection:NewButton("Teleport To Your Plot", "Gets You Back To Your Own Plot", function() -- Teleport to Plot
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

local Waypoint = Window:NewTab("Waypoints") --Waypoints Tab
local WaypointSection = Waypoint:NewSection("Teleport to Waypoints")

WaypointSection:NewButton("Create TP Point", "Make The Point", function() -- Create TP Point
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

WaypointSection:NewButton("TP To Point", "Tp You To The Point", function() -- Teleport to Point
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.TpPoint.CFrame
end)

WaypointSection:NewButton("Delete TP Point", "Remove The Point", function() -- Delete TP Point
    game.workspace.TpPoint:Destroy()
end)

local WaypointSection = Waypoint:NewSection("Extra Point For Quality Of Life")

WaypointSection:NewButton("Create Extra TP Point", "Makes Things Easier", function() -- Create Extra TP Point
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

WaypointSection:NewButton("TP To Extra TP Point", "Makes Things Easier", function() -- Teleport to Extra TP Point
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.ExtraTpPoint.CFrame
end)

WaypointSection:NewButton("Delete Extra TP Point", "Makes Things Easier", function() -- Delete Extra TP Point
    game.workspace.ExtraTpPoint:Destroy()
end)

local ESP = Window:NewTab("ESP") --ESP Tab
local ESPSection = ESP:NewSection("ESP Options")

ESPSection:NewToggle("Player ESP", "See Player Names", function(state) -- Player ESP
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

ESPSection:NewToggle("Meteor ESP", "See Meteor Highlight", function(state) -- Meteor ESP
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

local UI = Window:NewTab("UI Toggle")
local UISection = UI:NewSection("Show/Hide")

UISection:NewKeybind("Show/Hide GUI", "Toggle UI", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)
