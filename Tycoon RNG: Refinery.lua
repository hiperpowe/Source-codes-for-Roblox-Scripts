local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Tycoon RNG: Refinery", "Ocean")

local lightingconnects = {}
local FastRoll = false
local CubeESP = false
local CubeESPtable = {}
local CubeESPConnect = nil

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
        a = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
        i = true
        while wait() do
            if i == true then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
            elseif i == false then
                break
            end
        end
    else
        i = false
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

MainSection:NewToggle("Loop JumpPower", "Loop Jump Height", function(state)
    if state then
        a = game.Players.LocalPlayer.Character.Humanoid.JumpPower
        i = true
        while wait() do
            if i == true then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
            elseif i == false then
                break
            end
        end
    else
        i = false
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

MainSection:NewToggle("Loop HipHeight", "Loop HipHeight", function(state)
    if state then
        a = game.Players.LocalPlayer.Character.Humanoid.HipHeight
        i = true
        while wait() do
            if i == true then
                game.Players.LocalPlayer.Character.Humanoid.HipHeight = a
            elseif i == false then
                break
            end
        end
    else
        i = false
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = 0
    end
end)

MainSection:NewToggle("FullBright", "Brighten The Game", function(state)
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

local TP = Window:NewTab("Teleports")
local TPSection = TP:NewSection("Teleport to places")

TPSection:NewButton("Teleport To Your Plot", "Gets You Back To Your Own Plot", function()
    for _, v in pairs(game.workspace.ActivePlots:GetChildren()) do
        if v:GetAttribute("OwnerUserId") == game.Players.LocalPlayer.UserId then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:GetPivot() + Vector3.new(0, 50, 0)
        end
    end
end)

TPSection:NewDropdown("Teleport To A Plot", "Select A Plot To Teleport To", {"Plot1", "Plot2", "Plot3", "Plot4", "Plot5", "Plot6"}, function(currentOption)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Plots[currentOption]:GetPivot() + Vector3.new(0, 50, 0)
end)

TPSection:NewButton("Crafting", "Teloport to Crafting", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-22.5374432, 17.9905567, 310.994385, 0.550280035, -8.10081815e-08, -0.83498019, 2.82084702e-08, 1, -7.84277603e-08, 0.83498019, 1.9603716e-08, 0.550280035)
end)

TPSection:NewButton("Tree House", "Teloport to Tree House", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2.23203063, 99.1277313, 323.886017, 0.692402422, 1.58833835e-10, 0.721511483, -3.01230187e-08, 1, 2.86875785e-08, -0.721511483, -4.15974561e-08, 0.692402422)
end)

TPSection:NewButton("More Luck Area", "Teloport to More Luck Area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(15.5204563, 100.712257, 304.36145, -0.0569952726, -0.00846459996, 0.99833858, -0.0252959803, 0.999655247, 0.00703161303, -0.998053908, -0.0248531848, -0.0571898222)
end)

local AUTO = Window:NewTab("Automation")
local AUTOSection = AUTO:NewSection("Automate things :)")

AUTOSection:NewToggle("Auto Fast Roll", "Rolls for you every second", function(state)
    if state then
        FastRoll = true 
        while task.wait(1) do
            if FastRoll then
                local r = game:GetService("ReplicatedStorage").RequestRollFunction:InvokeServer()
                for i, v in pairs(r) do
                    if i == "items" then
                        for i2, v2 in pairs(v) do
                            game.StarterGui:SetCore("SendNotification", {Title = "Rolled", Text = v2, Duration = 1,})
                        end
                    end
                end
                game:GetService("ReplicatedStorage").AcceptPendingItemFunction:InvokeServer(1)
            elseif FastRoll == false then
                break
            end
        end
    else
        FastRoll = false
    end
end)

AUTOSection:NewButton("Get all Cubes on map", "Gets all cube on map", function()
    for _, v in pairs(game.workspace.SpawnedCubes:GetChildren()) do
        if v.Name == "SpeedCube" then
            if v.PrimaryPart ~= nil then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.PrimaryPart, 1)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.PrimaryPart, 0)
            end
        else
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
        end
    end
end)

local ESP = Window:NewTab("ESP")
local ESPSection = ESP:NewSection("toggle ESP")

ESPSection:NewToggle("Cube ESP", "See Ore Names", function(state)
    if state then
        CubeESP = true
        for _, v in pairs(game.workspace.SpawnedCubes:GetChildren()) do
            table.insert(CubeESPtable, v)
        end
        CubeESPConnect = game.workspace.SpawnedCubes.ChildAdded:Connect(function(v)
            table.insert(CubeESPtable, v)
        end)
        while task.wait(0.1) do 
            if CubeESP then 
                xpcall(function()
                    for i = #CubeESPtable, 1, -1 do 
                        local v = CubeESPtable[i]
                        if not v or not v.Parent then
                            table.remove(CubeESPtable, i)
                        else
                            if not v:FindFirstChild("ESPBillboard") then
                                if v.Name == "SpeedCube" then
                                    if v.PrimaryPart ~= nil then
                                        local billboard = Instance.new("BillboardGui")
                                        billboard.Name = "ESPBillboard"
                                        billboard.Size = UDim2.new(0, 50, 0, 50)
                                        billboard.StudsOffset = Vector3.new(0, 1, 0)
                                        billboard.AlwaysOnTop = true
                                        billboard.Parent = v

                                        local textLabel = Instance.new("TextLabel")
                                        textLabel.Size = UDim2.new(1, 0, 0.5, 0)
                                        textLabel.Position = UDim2.new(0, 0, 0, 0)
                                        textLabel.BackgroundTransparency = 1
                                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                                        textLabel.Text = v.Name
                                        textLabel.Parent = billboard
                                    end
                                else
                                    local billboard = Instance.new("BillboardGui")
                                    billboard.Name = "ESPBillboard"
                                    billboard.Size = UDim2.new(0, 50, 0, 50)
                                    billboard.StudsOffset = Vector3.new(0, 1, 0)
                                    billboard.AlwaysOnTop = true
                                    billboard.Parent = v

                                    local textLabel = Instance.new("TextLabel")
                                    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
                                    textLabel.Position = UDim2.new(0, 0, 0, 0)
                                    textLabel.BackgroundTransparency = 1
                                    textLabel.TextColor3 = Color3.new(1, 1, 1)
                                    textLabel.Text = v.Name
                                    textLabel.Parent = billboard
                                end
                            elseif v:FindFirstChild("ESPBillboard") then
                                if v.Name == "SpeedCube" then
                                    if v.PrimaryPart == nil then
                                        v.ESPBillboard:Destroy()
                                    end
                                end
                            end
                        end
                    end
                end, function(err)
                    warn("Cube ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif CubeESP == false then
                break
            end
        end
    else
        CubeESP = false
        CubeESPConnect:Disconnect()
        CubeESPtable = {}
        for _, v in pairs(game.workspace.SpawnedCubes:GetChildren()) do
            if v:FindFirstChild("ESPBillboard") then
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
