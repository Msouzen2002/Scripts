--[[
    FNAF TEST (LocalScript) - Five Nights at Freddy's Cheat/Debug Suite
    - Night Vision
    - ESP Animatronics/Levers/Generators/Terminal (Pizzaria/Porão)
    - Waypoints (Teleport/Save)
    - Cheats: Fly, WalkSpeed, Noclip (persistente)
    - GUI com abas: História, Labirinto, Cheats, Players
    - Player List com ESP/Teleport em qualquer player
    - 100% Client-side, modular e personalizável

    Coloque em StarterPlayerScripts ou StarterGui!
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-----------------
-- GUI SETUP   --
-----------------
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "FNAF_TEST"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 530, 0, 340)
MainFrame.Position = UDim2.new(0, 20, 0, 40)
MainFrame.BackgroundTransparency = 0.08
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,32)
Title.BackgroundTransparency = 1
Title.Text = "FNAF TEST - Debug Suite"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 22
Title.TextStrokeTransparency = 0.6

local Tabs = {"Modo História", "Modo Labirinto", "Cheats", "Players"}
local tabFrames = {}
local tabButtons = {}
for i, tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, (i-1)*130, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,40)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 18
    btn.AutoButtonColor = true
    tabButtons[i] = btn

    local frame = Instance.new("Frame", MainFrame)
    frame.Size = UDim2.new(1, -20, 1, -75)
    frame.Position = UDim2.new(0, 10, 0, 75)
    frame.BackgroundTransparency = 0.18
    frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
    frame.Visible = i == 1
    tabFrames[i] = frame

    btn.MouseButton1Click:Connect(function()
        for j, f in pairs(tabFrames) do
            f.Visible = false
            tabButtons[j].BackgroundColor3 = Color3.fromRGB(30,30,40)
        end
        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(50,50,80)
    end)
end

-----------------------------------
-- NIGHT VISION (Todas as Abas)  --
-----------------------------------
local function enableNightVision()
    Lighting.Brightness = 3
    Lighting.Ambient = Color3.fromRGB(180, 180, 200)
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 200)
    Lighting.ColorShift_Bottom = Color3.fromRGB(50,60,80)
    Lighting.ColorShift_Top = Color3.fromRGB(120,120,200)
    Lighting.FogEnd = 900
    Lighting.FogStart = 0
end

local function disableNightVision()
    Lighting.Brightness = 1
    Lighting.Ambient = Color3.fromRGB(40, 40, 40)
    Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 60)
    Lighting.ColorShift_Bottom = Color3.new(0,0,0)
    Lighting.ColorShift_Top = Color3.new(0,0,0)
    Lighting.FogEnd = 200
    Lighting.FogStart = 10
end

local nightVisionEnabled = false
for i=1,#Tabs do
    local btn = Instance.new("TextButton", tabFrames[i])
    btn.Size = UDim2.new(0,150,0,32)
    btn.Position = UDim2.new(0, 10, 0, 10)
    btn.Text = "Night Vision [Off]"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(0.8,1,0.8)
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(15,30,20)
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(function()
        nightVisionEnabled = not nightVisionEnabled
        btn.Text = "Night Vision [" .. (nightVisionEnabled and "On" or "Off") .. "]"
        if nightVisionEnabled then enableNightVision() else disableNightVision() end
    end)
end

--------------------------
-- ESP SYSTEM (Labirinto)
--------------------------
local ESPObjects = {
    -- Pizzaria
    ["Freddy"] = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Freddy"),
    ["Bonnie"] = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Bonnie"),
    ["Lever1"] = Workspace.WorkspaceUtilities.Levers:FindFirstChild("Lever1"),
    ["Lever2"] = Workspace.WorkspaceUtilities.Levers:FindFirstChild("Lever2"),
    ["Generator1"] = Workspace.WorkspaceUtilities.Generators:FindFirstChild("Generator1"),
    ["Generator2"] = Workspace.WorkspaceUtilities.Generators:FindFirstChild("Generator2"),
    ["Generator3"] = Workspace.WorkspaceUtilities.Generators:FindFirstChild("Generator3"),
    ["Terminal"] = Workspace.WorkspaceUtilities:FindFirstChild("Terminal"),
    -- Porão
    ["Chica"] = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Chica"),
    ["Foxy"] = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Foxy"),
}

local ESPColors = {
    Freddy = Color3.fromRGB(230, 140, 70),
    Bonnie = Color3.fromRGB(100, 70, 230),
    Chica = Color3.fromRGB(255, 220, 50),
    Foxy = Color3.fromRGB(220, 50, 50),
    Lever1 = Color3.fromRGB(255,255,255),
    Lever2 = Color3.fromRGB(255,255,255),
    Generator1 = Color3.fromRGB(60,255,60),
    Generator2 = Color3.fromRGB(60,255,60),
    Generator3 = Color3.fromRGB(60,255,60),
    Terminal = Color3.fromRGB(60,60,255),
}

local function applyHighlight(obj, color)
    if obj and obj:IsA("Model") then
        local highlight = obj:FindFirstChildOfClass("Highlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.FillColor = color
            highlight.OutlineColor = color
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.FillTransparency = 0.6
            highlight.OutlineTransparency = 0
            highlight.Parent = obj
        else
            highlight.FillColor = color
            highlight.OutlineColor = color
        end
    end
end

local function showESP()
    for name, obj in pairs(ESPObjects) do
        if obj and obj:IsA("Model") then
            applyHighlight(obj, ESPColors[name] or Color3.new(1,1,1))
        end
    end
    -- Print Terminal properties
    local terminal = ESPObjects["Terminal"]
    if terminal and terminal:FindFirstChild("Properties") then
        print("Terminal Properties:")
        for _, prop in ipairs(terminal.Properties:GetChildren()) do
            print(prop.Name, prop.Value)
        end
    end
end

local ESPBtn = Instance.new("TextButton", tabFrames[2])
ESPBtn.Size = UDim2.new(0,180,0,30)
ESPBtn.Position = UDim2.new(0,210,0,10)
ESPBtn.Text = "Mostrar ESP"
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.TextColor3 = Color3.new(0.7,0.9,1)
ESPBtn.TextSize = 18
ESPBtn.BackgroundColor3 = Color3.fromRGB(30,40,60)
ESPBtn.AutoButtonColor = true
ESPBtn.MouseButton1Click:Connect(showESP)

-----------------------
-- WAYPOINTS SYSTEM  --
-----------------------
local waypointsFolder = Workspace:FindFirstChild("Waypoints") or Instance.new("Folder", Workspace)
waypointsFolder.Name = "Waypoints"
local counter = 0
local colors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255)
}

local function createWaypoint()
    local character = player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    counter += 1
    local name = "Waypoint" .. tostring(counter)

    local part = Instance.new("Part")
    part.Name = name
    part.Size = Vector3.new(1.5, 1.5, 1.5)
    part.Position = hrp.Position + Vector3.new(0, 3, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Color = colors[((counter - 1) % #colors) + 1]
    part.Parent = waypointsFolder

    local mesh = Instance.new("SpecialMesh", part)
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Scale = Vector3.new(0.8, 0.8, 0.8)

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "WaypointLabel"
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.Adornee = part
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 10000
    billboard.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.TextColor3 = part.Color
    label.TextStrokeTransparency = 0
    label.Parent = billboard

    local clickDetector = Instance.new("ClickDetector")
    clickDetector.MaxActivationDistance = 50
    clickDetector.Parent = part

    clickDetector.MouseClick:Connect(function()
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
        end
    end)
end

local waypointBtn = Instance.new("TextButton", tabFrames[3])
waypointBtn.Size = UDim2.new(0, 180, 0, 30)
waypointBtn.Position = UDim2.new(0, 10, 0, 10)
waypointBtn.Text = "Criar Waypoint [B]"
waypointBtn.Font = Enum.Font.GothamBold
waypointBtn.TextColor3 = Color3.new(1,1,0.7)
waypointBtn.TextSize = 17
waypointBtn.BackgroundColor3 = Color3.fromRGB(50,50,20)
waypointBtn.AutoButtonColor = true
waypointBtn.MouseButton1Click:Connect(createWaypoint)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.B then
        createWaypoint()
    end
end)

-----------------------------------
-- FLY, WALKSPEED, NOCLIP SYSTEM --
-----------------------------------
local flyEnabled = false
local flySpeed = 40
local walkspeed = 32
local noclipEnabled = false

local flyBtn = Instance.new("TextButton", tabFrames[3])
flyBtn.Size = UDim2.new(0, 120, 0, 28)
flyBtn.Position = UDim2.new(0, 10, 0, 60)
flyBtn.Text = "Fly [Off]"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextColor3 = Color3.new(0.7,0.9,1)
flyBtn.TextSize = 16
flyBtn.BackgroundColor3 = Color3.fromRGB(30,40,60)
flyBtn.AutoButtonColor = true

local flySpeedBox = Instance.new("TextBox", tabFrames[3])
flySpeedBox.Size = UDim2.new(0, 60, 0, 28)
flySpeedBox.Position = UDim2.new(0, 140, 0, 60)
flySpeedBox.Text = tostring(flySpeed)
flySpeedBox.PlaceholderText = "FlySpeed"
flySpeedBox.Font = Enum.Font.GothamBold
flySpeedBox.TextColor3 = Color3.new(0.8,1,0.8)
flySpeedBox.TextSize = 16
flySpeedBox.BackgroundColor3 = Color3.fromRGB(15,30,20)

local wsBtn = Instance.new("TextButton", tabFrames[3])
wsBtn.Size = UDim2.new(0, 120, 0, 28)
wsBtn.Position = UDim2.new(0, 10, 0, 100)
wsBtn.Text = "WalkSpeed ["..tostring(walkspeed).."]"
wsBtn.Font = Enum.Font.GothamBold
wsBtn.TextColor3 = Color3.new(1,0.8,0.6)
wsBtn.TextSize = 16
wsBtn.BackgroundColor3 = Color3.fromRGB(60,30,10)
wsBtn.AutoButtonColor = true

local wsBox = Instance.new("TextBox", tabFrames[3])
wsBox.Size = UDim2.new(0, 60, 0, 28)
wsBox.Position = UDim2.new(0, 140, 0, 100)
wsBox.Text = tostring(walkspeed)
wsBox.PlaceholderText = "WalkSpeed"
wsBox.Font = Enum.Font.GothamBold
wsBox.TextColor3 = Color3.new(1,1,0.8)
wsBox.TextSize = 16
wsBox.BackgroundColor3 = Color3.fromRGB(30,30,10)

local noclipBtn = Instance.new("TextButton", tabFrames[3])
noclipBtn.Size = UDim2.new(0, 120, 0, 28)
noclipBtn.Position = UDim2.new(0, 10, 0, 140)
noclipBtn.Text = "Noclip [Off]"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextColor3 = Color3.new(1,0.7,1)
noclipBtn.TextSize = 16
noclipBtn.BackgroundColor3 = Color3.fromRGB(60,10,60)
noclipBtn.AutoButtonColor = true

-- FLY SYSTEM
local bodyGyro, bodyVelocity
local function setFly(state)
    flyEnabled = state
    flyBtn.Text = "Fly ["..(flyEnabled and "On" or "Off").."]"
    if flyEnabled then
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            bodyGyro = Instance.new("BodyGyro", hrp)
            bodyGyro.MaxTorque = Vector3.new(400000,400000,400000)
            bodyGyro.P = 100000
            bodyGyro.CFrame = hrp.CFrame

            bodyVelocity = Instance.new("BodyVelocity", hrp)
            bodyVelocity.MaxForce = Vector3.new(400000,400000,400000)
            bodyVelocity.Velocity = Vector3.new(0,0,0)
        end
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

flyBtn.MouseButton1Click:Connect(function()
    setFly(not flyEnabled)
end)
flySpeedBox.FocusLost:Connect(function()
    local val = tonumber(flySpeedBox.Text)
    if val then flySpeed = val end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if flyEnabled and not gp then
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and bodyVelocity then
            if input.KeyCode == Enum.KeyCode.W then
                bodyVelocity.Velocity = hrp.CFrame.LookVector * flySpeed
            elseif input.KeyCode == Enum.KeyCode.S then
                bodyVelocity.Velocity = -hrp.CFrame.LookVector * flySpeed
            elseif input.KeyCode == Enum.KeyCode.A then
                bodyVelocity.Velocity = -hrp.CFrame.RightVector * flySpeed
            elseif input.KeyCode == Enum.KeyCode.D then
                bodyVelocity.Velocity = hrp.CFrame.RightVector * flySpeed
            elseif input.KeyCode == Enum.KeyCode.Space then
                bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftControl then
                bodyVelocity.Velocity = Vector3.new(0, -flySpeed, 0)
            end
        end
    end
end)
UserInputService.InputEnded:Connect(function(input, gp)
    if flyEnabled and not gp then
        if bodyVelocity then bodyVelocity.Velocity = Vector3.new(0,0,0) end
    end
end)

-- WALKSPEED SYSTEM
local function setWalkSpeed(val)
    walkspeed = val
    wsBtn.Text = "WalkSpeed ["..tostring(walkspeed).."]"
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = walkspeed end
end

wsBtn.MouseButton1Click:Connect(function()
    setWalkSpeed(walkspeed == 16 and 32 or 16)
end)
wsBox.FocusLost:Connect(function()
    local val = tonumber(wsBox.Text)
    if val then setWalkSpeed(val) end
end)

player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.Changed:Connect(function()
        if hum.WalkSpeed ~= walkspeed then
            hum.WalkSpeed = walkspeed
        end
    end)
end)

-- NOCLIP SYSTEM
local noclipConn
local function setNoclip(state)
    noclipEnabled = state
    noclipBtn.Text = "Noclip ["..(noclipEnabled and "On" or "Off").."]"
    if noclipEnabled then
        noclipConn = RunService.Stepped:Connect(function()
            if player.Character then
                for _, v in pairs(player.Character:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    elseif noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
        if player.Character then
            for _, v in pairs(player.Character:GetChildren()) do
                if v:IsA("BasePart") then v.CanCollide = true end
            end
        end
    end
end
noclipBtn.MouseButton1Click:Connect(function()
    setNoclip(not noclipEnabled)
end)

--------------------------
-- PLAYER LIST/PLAYER ESP
--------------------------
local function getPlayerRoot(plr)
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
end

local function highlightPlayer(plr)
    local hrp = getPlayerRoot(plr)
    if hrp then
        local hl = hrp:FindFirstChildOfClass("Highlight")
        if not hl then
            hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255,180,60)
            hl.OutlineColor = Color3.fromRGB(255,255,255)
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency = 0.5
            hl.Parent = hrp
        end
    end
end

local function teleportToPlayer(plr)
    local hrp = getPlayerRoot(plr)
    local myhrp = getPlayerRoot(player)
    if hrp and myhrp then
        myhrp.CFrame = hrp.CFrame + Vector3.new(0,3,0)
    end
end

local playerListFrame = Instance.new("ScrollingFrame", tabFrames[4])
playerListFrame.Size = UDim2.new(0, 210, 1, -30)
playerListFrame.Position = UDim2.new(0, 10, 0, 10)
playerListFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
playerListFrame.BorderSizePixel = 0
playerListFrame.CanvasSize = UDim2.new(0,0,0,0)
playerListFrame.ScrollBarThickness = 8
playerListFrame.Name = "PlayerList"

local refreshBtn = Instance.new("TextButton", tabFrames[4])
refreshBtn.Size = UDim2.new(0, 90, 0, 26)
refreshBtn.Position = UDim2.new(0, 230, 0, 10)
refreshBtn.Text = "Refresh Players"
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextColor3 = Color3.new(0.8,1,1)
refreshBtn.TextSize = 16
refreshBtn.BackgroundColor3 = Color3.fromRGB(10,30,30)
refreshBtn.AutoButtonColor = true

local function populatePlayers()
    playerListFrame:ClearAllChildren()
    local y = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 24)
        btn.Position = UDim2.new(0, 5, 0, y)
        btn.Text = plr.Name
        btn.Font = Enum.Font.SourceSansBold
        btn.TextColor3 = Color3.fromRGB(255,255,180)
        btn.TextSize = 17
        btn.BackgroundColor3 = Color3.fromRGB(25,25,50)
        btn.AutoButtonColor = true
        btn.Parent = playerListFrame

        local espBtn = Instance.new("TextButton")
        espBtn.Size = UDim2.new(0, 52, 0, 21)
        espBtn.Position = UDim2.new(1, -60, 0, 2)
        espBtn.Text = "ESP"
        espBtn.Font = Enum.Font.Code
        espBtn.TextColor3 = Color3.new(1,0.9,0.5)
        espBtn.TextSize = 14
        espBtn.BackgroundColor3 = Color3.fromRGB(50,40,10)
        espBtn.Parent = btn
        espBtn.MouseButton1Click:Connect(function()
            highlightPlayer(plr)
        end)

        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0, 52, 0, 21)
        tpBtn.Position = UDim2.new(1, -115, 0, 2)
        tpBtn.Text = "TP"
        tpBtn.Font = Enum.Font.Code
        tpBtn.TextColor3 = Color3.new(0.7,1,0.9)
        tpBtn.TextSize = 14
        tpBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
        tpBtn.Parent = btn
        tpBtn.MouseButton1Click:Connect(function()
            teleportToPlayer(plr)
        end)

        y = y + 27
    end
    playerListFrame.CanvasSize = UDim2.new(0,0,0,y)
end

refreshBtn.MouseButton1Click:Connect(populatePlayers)
Players.PlayerAdded:Connect(populatePlayers)
Players.PlayerRemoving:Connect(populatePlayers)
populatePlayers()

--------------------------
-- INSTRUÇÕES
--------------------------
local instruct = Instance.new("TextLabel", MainFrame)
instruct.Size = UDim2.new(1,0,0,24)
instruct.Position = UDim2.new(0,0,1,-24)
instruct.BackgroundTransparency = 1
instruct.Text = "B = Waypoint | Fly: WASD/Space/Ctrl | Use textboxes for speed | ESP: Animatronics/Players | TP: Teleporta para player"
instruct.Font = Enum.Font.Code
instruct.TextColor3 = Color3.fromRGB(255,255,160)
instruct.TextScaled = true

-- Feito para Msouzen2002 por Copilot 2024/2025. Personalize à vontade!
