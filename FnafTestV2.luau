-- FNAF TEST - Suite Premium
-- Feito para Msouzen2002 | GUI Complexa/Completa | Roblox Studio

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-----------------
-- GUI SETUP   --
-----------------
local gui = Instance.new("ScreenGui")
gui.Name = "FNAF_TEST"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.DisplayOrder = 9999 -- Fica em cima de tudo, inclusive menu do Roblox
gui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 420)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 33)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.ZIndex = 100
MainFrame.Parent = gui

local gradient = Instance.new("UIGradient", MainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50,60,100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18,18,33))
}

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "FNAF TEST - Suite Premium"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Color3.fromRGB(255,220,90)
Title.TextSize = 32
Title.TextStrokeTransparency = 0.6
Title.ZIndex = 100

-------------------------
-- ABAS E MENU AVANÇADO
-------------------------
local Tabs = {"História", "Labirinto", "Cheats", "Players"}
local tabFrames, tabButtons = {}, {}
local tabHeight, tabWidth = 44, 140

local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(1, -20, 0, tabHeight)
TabsFrame.Position = UDim2.new(0, 10, 0, 48)
TabsFrame.BackgroundTransparency = 1
TabsFrame.ZIndex = 100

for i,tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton", TabsFrame)
    btn.Size = UDim2.new(0, tabWidth, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*tabWidth, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255,220,90)
    btn.TextSize = 20
    btn.AutoButtonColor = true
    btn.ZIndex = 101
    tabButtons[i] = btn

    local frame = Instance.new("Frame", MainFrame)
    frame.Size = UDim2.new(1, -20, 1, -(tabHeight+80))
    frame.Position = UDim2.new(0, 10, 0, tabHeight+70)
    frame.BackgroundTransparency = 0.09
    frame.BackgroundColor3 = Color3.fromRGB(22,22,32)
    frame.Visible = i == 1
    frame.ZIndex = 101
    tabFrames[i] = frame

    btn.MouseButton1Click:Connect(function()
        for j, f in ipairs(tabFrames) do
            f.Visible = false
            tabButtons[j].BackgroundColor3 = Color3.fromRGB(35,35,50)
        end
        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(60,60,100)
    end)
end

--------------------------------------------------
-- FUNÇÃO TOGGLE PREMIUM (Switch com cor e label)
--------------------------------------------------
local function AddToggle(parent, text, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0, 240, 0, 32)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 102

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextSize = 16
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = Color3.fromRGB(220,220,210)
    lbl.ZIndex = 103

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0.3,0,1,0)
    toggle.Position = UDim2.new(0.7,0,0,0)
    toggle.BackgroundColor3 = default and Color3.fromRGB(60,220,90) or Color3.fromRGB(90,90,90)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextSize = 16
    toggle.Font = Enum.Font.GothamBold
    toggle.TextColor3 = Color3.fromRGB(255,255,220)
    toggle.ZIndex = 104
    toggle.AutoButtonColor = true

    toggle.MouseButton1Click:Connect(function()
        default = not default
        toggle.BackgroundColor3 = default and Color3.fromRGB(60,220,90) or Color3.fromRGB(90,90,90)
        toggle.Text = default and "ON" or "OFF"
        callback(default)
    end)
    return frame, toggle
end

-----------------------------------
-- NIGHT VISION (Todas as Abas)
-----------------------------------
local nightVisionEnabled = false
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

for i = 1, #Tabs do
    local frame = tabFrames[i]
    local nightFrame, _ = AddToggle(frame, "Night Vision", false, function(v)
        nightVisionEnabled = v
        if v then enableNightVision() else disableNightVision() end
    end)
    nightFrame.Position = UDim2.new(0, 10, 0, 10)
end

------------------------
-- ESP HISTÓRIA
------------------------
local historiaESP = {
    Freddy = {path = Workspace:FindFirstChild("Freddy"), color = Color3.fromRGB(230, 140, 70)},
    Bonnie = {path = Workspace:FindFirstChild("Bonnie"), color = Color3.fromRGB(100, 70, 230)},
    Chica = {path = Workspace:FindFirstChild("Chica"), color = Color3.fromRGB(255, 220, 50)},
    Foxy = {path = Workspace:FindFirstChild("Foxy"), color = Color3.fromRGB(220, 50, 50)},
    Generator1 = {path = Workspace.WorkspaceUtilities.Generator, color = Color3.fromRGB(60,255,60)},
    Generator2 = {path = Workspace.WorkspaceUtilities:FindFirstChild("Generator"), color = Color3.fromRGB(60,255,60)},
    VentsLever = {path = Workspace.WorkspaceUtilities:FindFirstChild("VentsLever"), color = Color3.fromRGB(60,60,255)}
}

local historiaToggles = {}
local function applyHighlight(obj, color, enable)
    if obj and obj:IsA("Model") then
        local highlight = obj:FindFirstChildOfClass("Highlight")
        if enable then
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
        elseif highlight then
            highlight:Destroy()
        end
    end
end

local y = 52
for name, data in pairs(historiaESP) do
    local frame, toggle = AddToggle(tabFrames[1], "ESP: "..name, false, function(state)
        historiaToggles[name] = state
        applyHighlight(data.path, data.color, state)
    end)
    frame.Position = UDim2.new(0, 10, 0, y)
    y = y + 36
end

-------------------------------
-- ESP LABIRINTO (igual antes)
-------------------------------
local labESP = {
    Freddy = {path = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Freddy"), color = Color3.fromRGB(230, 140, 70)},
    Bonnie = {path = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Bonnie"), color = Color3.fromRGB(100, 70, 230)},
    Chica = {path = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Chica"), color = Color3.fromRGB(255, 220, 50)},
    Foxy = {path = Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Foxy"), color = Color3.fromRGB(220, 50, 50)},
    Lever1 = {path = Workspace.WorkspaceUtilities.Levers:FindFirstChild("Lever1"), color = Color3.fromRGB(255,255,255)},
    Lever2 = {path = Workspace.WorkspaceUtilities.Levers:FindFirstChild("Lever2"), color = Color3.fromRGB(255,255,255)},
    Generator1 = {path = Workspace.WorkspaceUtilities.Generators:FindFirstChild("Generator1"), color = Color3.fromRGB(60,255,60)},
    Generator2 = {path = Workspace.WorkspaceUtilities.Generators:FindFirstChild("Generator2"), color = Color3.fromRGB(60,255,60)},
    Generator3 = {path = Workspace.WorkspaceUtilities.Generators:FindFirstChild("Generator3"), color = Color3.fromRGB(60,255,60)},
    Terminal = {path = Workspace.WorkspaceUtilities:FindFirstChild("Terminal"), color = Color3.fromRGB(60,60,255)}
}
local labToggles = {}
local y2 = 52
for name, data in pairs(labESP) do
    local frame, toggle = AddToggle(tabFrames[2], "ESP: "..name, false, function(state)
        labToggles[name] = state
        applyHighlight(data.path, data.color, state)
    end)
    frame.Position = UDim2.new(0, 10, 0, y2)
    y2 = y2 + 36
end

-----------------------
-- CHEATS + WAYPOINTS
-----------------------
local cheatY = 52

local waypointsFolder = Workspace:FindFirstChild("Waypoints") or Instance.new("Folder", Workspace)
waypointsFolder.Name = "Waypoints"
local counter = 0
local colorTable = {
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
    part.Color = colorTable[((counter - 1) % #colorTable) + 1]
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
waypointBtn.Position = UDim2.new(0, 10, 0, cheatY)
waypointBtn.Text = "Criar Waypoint [B]"
waypointBtn.Font = Enum.Font.GothamBold
waypointBtn.TextColor3 = Color3.new(1,1,0.7)
waypointBtn.TextSize = 17
waypointBtn.BackgroundColor3 = Color3.fromRGB(50,50,20)
waypointBtn.AutoButtonColor = true
waypointBtn.ZIndex = 103
waypointBtn.MouseButton1Click:Connect(createWaypoint)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.B then
        createWaypoint()
    end
end)

cheatY = cheatY + 40

-- FLY, WALKSPEED, NOCLIP
local flyEnabled, flySpeed, walkspeed, noclipEnabled = false, 40, 32, false
local bodyGyro, bodyVelocity

local function setFly(state)
    flyEnabled = state
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

local flyFrame, flyToggle = AddToggle(tabFrames[3], "Fly", false, setFly)
flyFrame.Position = UDim2.new(0, 10, 0, cheatY)
cheatY = cheatY + 36

local flySpeedBox = Instance.new("TextBox", tabFrames[3])
flySpeedBox.Size = UDim2.new(0, 80, 0, 28)
flySpeedBox.Position = UDim2.new(0, 260, 0, cheatY-36)
flySpeedBox.Text = tostring(flySpeed)
flySpeedBox.PlaceholderText = "FlySpeed"
flySpeedBox.Font = Enum.Font.GothamBold
flySpeedBox.TextColor3 = Color3.new(0.8,1,0.8)
flySpeedBox.TextSize = 16
flySpeedBox.BackgroundColor3 = Color3.fromRGB(15,30,20)
flySpeedBox.ZIndex = 103
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

local function setWalkSpeed(val)
    walkspeed = val
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = walkspeed end
end

local wsFrame, wsToggle = AddToggle(tabFrames[3], "WalkSpeed", false, function(state)
    setWalkSpeed(state and walkspeed or 16)
end)
wsFrame.Position = UDim2.new(0, 10, 0, cheatY)
cheatY = cheatY + 36

local wsBox = Instance.new("TextBox", tabFrames[3])
wsBox.Size = UDim2.new(0, 80, 0, 28)
wsBox.Position = UDim2.new(0, 260, 0, cheatY-36)
wsBox.Text = tostring(walkspeed)
wsBox.PlaceholderText = "WalkSpeed"
wsBox.Font = Enum.Font.GothamBold
wsBox.TextColor3 = Color3.new(1,1,0.8)
wsBox.TextSize = 16
wsBox.BackgroundColor3 = Color3.fromRGB(30,30,10)
wsBox.ZIndex = 103
wsBox.FocusLost:Connect(function()
    local val = tonumber(wsBox.Text)
    if val then
        walkspeed = val
        setWalkSpeed(walkspeed)
    end
end)

player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.Changed:Connect(function()
        if hum.WalkSpeed ~= walkspeed then
            hum.WalkSpeed = walkspeed
        end
    end)
end)

local function setNoclip(state)
    noclipEnabled = state
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

local noclipConn
local noclipFrame, noclipToggle = AddToggle(tabFrames[3], "Noclip", false, setNoclip)
noclipFrame.Position = UDim2.new(0, 10, 0, cheatY)
cheatY = cheatY + 36

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
playerListFrame.Size = UDim2.new(0, 270, 1, -34)
playerListFrame.Position = UDim2.new(0, 10, 0, 10)
playerListFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
playerListFrame.BorderSizePixel = 0
playerListFrame.CanvasSize = UDim2.new(0,0,0,0)
playerListFrame.ScrollBarThickness = 8
playerListFrame.Name = "PlayerList"
playerListFrame.ZIndex = 102

local refreshBtn = Instance.new("TextButton", tabFrames[4])
refreshBtn.Size = UDim2.new(0, 120, 0, 26)
refreshBtn.Position = UDim2.new(0, 290, 0, 10)
refreshBtn.Text = "Refresh Players"
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextColor3 = Color3.new(0.8,1,1)
refreshBtn.TextSize = 16
refreshBtn.BackgroundColor3 = Color3.fromRGB(10,30,30)
refreshBtn.AutoButtonColor = true
refreshBtn.ZIndex = 103

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
        btn.ZIndex = 104

        local espBtn = Instance.new("TextButton")
        espBtn.Size = UDim2.new(0, 52, 0, 21)
        espBtn.Position = UDim2.new(1, -60, 0, 2)
        espBtn.Text = "ESP"
        espBtn.Font = Enum.Font.Code
        espBtn.TextColor3 = Color3.new(1,0.9,0.5)
        espBtn.TextSize = 14
        espBtn.BackgroundColor3 = Color3.fromRGB(50,40,10)
        espBtn.Parent = btn
        espBtn.ZIndex = 105
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
        tpBtn.ZIndex = 105
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
instruct.Text = "B = Waypoint | ALT = Show/Hide GUI | Fly: WASD/Space/Ctrl | ESPs premium | TP: Teleporta para player"
instruct.Font = Enum.Font.Code
instruct.TextColor3 = Color3.fromRGB(255,255,160)
instruct.TextScaled = true
instruct.ZIndex = 110

--------------------------
-- HOTKEYS E ALT FECHAR --
--------------------------
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        guiVisible = not guiVisible
        gui.Enabled = guiVisible
    end
end)

-- Feito para Msouzen2002 2024/2025 | Vende esse menu por R$1200 fácil
