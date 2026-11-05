local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/cooolchillX/ScriptHubSources/refs/heads/main/CrystallineApi.lua"))()
local window = library:AddWindow("Crystalline Hub [Tycoon RNG: Refinery]", ui_options)

local wp = false
local jp = false
local hh = false
local lightingconnects = {}
local FastRoll = false
local limit = 5000
local RemoveItem = false
local CubeESP = false
local CubeESPtable = {}
local CubeESPConnect = nil

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

Main:AddSwitch("FullBright", function(state)
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

local TP = window:AddTab("Teleports")
TP:AddLabel("Teleport to places")

TP:AddButton("Teleport To Your Plot", function()
    for _, v in pairs(game.workspace.ActivePlots:GetChildren()) do
        if v:GetAttribute("OwnerUserId") == game.Players.LocalPlayer.UserId then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:GetPivot() + Vector3.new(0, 50, 0)
        end
    end
end)

local PlotTP = TP:AddDropdown("Teleport To A Plot", function(currentOption)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Plots[currentOption]:GetPivot() + Vector3.new(0, 50, 0)
end)
for i = 1, 6 do
    PlotTP:Add("Plot" .. tostring(i))
end

TP:AddButton("Crafting", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-22.5374432, 17.9905567, 310.994385, 0.550280035, -8.10081815e-08, -0.83498019, 2.82084702e-08, 1, -7.84277603e-08, 0.83498019, 1.9603716e-08, 0.550280035)
end)

TP:AddButton("Tree House", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2.23203063, 99.1277313, 323.886017, 0.692402422, 1.58833835e-10, 0.721511483, -3.01230187e-08, 1, 2.86875785e-08, -0.721511483, -4.15974561e-08, 0.692402422)
end)

TP:AddButton("Luck Block", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(15.5204563, 100.712257, 304.36145, -0.0569952726, -0.00846459996, 0.99833858, -0.0252959803, 0.999655247, 0.00703161303, -0.998053908, -0.0248531848, -0.0571898222)
end)

local AUTO = window:AddTab("Automation")
AUTO:AddLabel("Automate things :)")

AUTO:AddSwitch("Auto Fast Roll", function(state)
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

AUTO:AddTextBox("Edits Unwanted limit", function(txt)
    limit = tonumber(txt)
end)

AUTO:AddSwitch("Auto Remove Unwanted Items", function(state)
    if state then
        RemoveItem = true
        while task.wait(0.1) do
            if RemoveItem then
                xpcall(function()
                    for _, v in pairs(game.Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.ItemContainer:GetChildren()) do
                        if v:IsA("ImageLabel") then
                            local rarity = v.RarityImage.ItemRarity
                            local number, suffix = rarity.Text:match("/%s*([%d%.]+)%s*([kKmMbB]?)")
                            local chance = tonumber(number)
                            if suffix:lower() == "k" then
                                chance *= 1000
                            elseif suffix:lower() == "m" then
                                chance *= 1000000
                            elseif suffix:lower() == "b" then
                                chance *= 1000000000
                            end
                            if chance and chance < limit then
                                local id = v.Name:match("^Item_(.+)$")
                                game.ReplicatedStorage.PlacementEvent:FireServer("RemoveItem", id)
                            end
                        end
                    end
                end, function(err)
                    warn("Cube ESP Error")
                    warn(debug.traceback(err))
                end)
            elseif RemoveItem == false then
                break
            end
        end
    else
        RemoveItem = false
    end
end)

AUTO:AddButton("Get all Cubes on map", function()
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

local ESP = window:AddTab("ESP")
ESP:AddLabel("toggle ESP")

ESP:AddSwitch("Cube ESP", function(state)
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
                                        textLabel.Size = UDim2.new(1.5, 0, 0.5, 0)
                                        textLabel.Position = UDim2.new(0, 0, 0, 0)
                                        textLabel.BackgroundTransparency = 0
                                        textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
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
                                    textLabel.BackgroundTransparency = 0
                                    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
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
