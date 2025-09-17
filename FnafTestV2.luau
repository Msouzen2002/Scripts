-- FNAF TEST ULTRA - GUI Premium, Smooth, Responsiva, Modular, Avançada
-- Feito para Msouzen2002, 2025 - Roblox Studio

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

--[[
    Helper: Fade transitions for frames
--]]
local function fade(frame, show, duration)
    duration = duration or 0.3
    if show then
        frame.Visible = true
        TweenService:Create(frame, TweenInfo.new(duration), {BackgroundTransparency = 0.07}):Play()
        for _,v in pairs(frame:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
                TweenService:Create(v, TweenInfo.new(duration), {TextTransparency = 0}):Play()
            end
        end
    else
        TweenService:Create(frame, TweenInfo.new(duration), {BackgroundTransparency = 1}):Play()
        for _,v in pairs(frame:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
                TweenService:Create(v, TweenInfo.new(duration), {TextTransparency = 1}):Play()
            end
        end
        task.delay(duration, function() frame.Visible = false end)
    end
end

-----------------
-- GUI SETUP   --
-----------------
local gui = Instance.new("ScreenGui")
gui.Name = "FNAF_TEST_ULTRA"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.DisplayOrder = 9999
gui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 720, 0, 480)
MainFrame.Position = UDim2.new(0.5, -360, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 33)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.ZIndex = 100
MainFrame.Parent = gui

local gradient = Instance.new("UIGradient", MainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80,120,220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(24,24,44))
}

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,54)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "FNAF TEST ULTRA"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Color3.fromRGB(255,220,90)
Title.TextSize = 38
Title.TextStrokeTransparency = 0.8
Title.ZIndex = 101

-------------------------
-- ABAS & ANIMAÇÃO
-------------------------
local Tabs = {"História", "Labirinto", "Cheats", "Players", "Config"}
local tabFrames, tabButtons = {}, {}
local activeTab = 1
local tabHeight, tabWidth, tabPad = 54, 140, 9

local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(1, -20, 0, tabHeight)
TabsFrame.Position = UDim2.new(0, 10, 0, 62)
TabsFrame.BackgroundTransparency = 1
TabsFrame.ZIndex = 101

for i, tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton", TabsFrame)
    btn.Size = UDim2.new(0, tabWidth, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*(tabWidth+tabPad), 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,50)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255,220,120)
    btn.TextSize = 22
    btn.AutoButtonColor = true
    btn.ZIndex = 102
    tabButtons[i] = btn

    local frame = Instance.new("Frame", MainFrame)
    frame.Size = UDim2.new(1, -28, 1, -(tabHeight+90))
    frame.Position = UDim2.new(0, 14, 0, tabHeight+88)
    frame.BackgroundTransparency = 1
    frame.BackgroundColor3 = Color3.fromRGB(22,22,32)
    frame.Visible = i == 1
    frame.ZIndex = 103
    tabFrames[i] = frame

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(60,90,160)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if activeTab ~= i then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(30,30,50)}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function()
        for j, f in ipairs(tabFrames) do
            if f.Visible then fade(f, false, 0.22) end
            tabButtons[j].BackgroundColor3 = Color3.fromRGB(30,30,50)
        end
        activeTab = i
        fade(frame, true, 0.22)
        btn.BackgroundColor3 = Color3.fromRGB(80,120,220)
    end)
end

---------------------------
-- NIGHT VISION ULTRA
---------------------------
local nightVisionEnabled = false
local function enableNightVision()
    Lighting.Brightness = 3
    Lighting.Ambient = Color3.fromRGB(180, 180, 200)
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 200)
    Lighting.ColorShift_Bottom = Color3.fromRGB(80,80,160)
    Lighting.ColorShift_Top = Color3.fromRGB(120,120,220)
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

local function AddToggle(parent, text, default, callback, y)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0, 258, 0, 36)
    frame.Position = UDim2.new(0, 24, 0, y)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 106

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextSize = 18
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = Color3.fromRGB(220,220,210)
    lbl.TextTransparency = 0.25
    lbl.ZIndex = 107

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0.3,0,1,0)
    toggle.Position = UDim2.new(0.7,0,0,0)
    toggle.BackgroundColor3 = default and Color3.fromRGB(80,220,140) or Color3.fromRGB(80,80,80)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextSize = 18
    toggle.Font = Enum.Font.GothamBold
    toggle.TextColor3 = Color3.fromRGB(255,255,220)
    toggle.TextTransparency = 0.25
    toggle.ZIndex = 107
    toggle.AutoButtonColor = true

    toggle.MouseButton1Click:Connect(function()
        default = not default
        toggle.BackgroundColor3 = default and Color3.fromRGB(80,220,140) or Color3.fromRGB(80,80,80)
        toggle.Text = default and "ON" or "OFF"
        callback(default)
    end)
    return frame, toggle
end

for i = 1, #Tabs do
    AddToggle(tabFrames[i], "Night Vision", false, function(v)
        nightVisionEnabled = v
        if v then enableNightVision() else disableNightVision() end
    end, 18)
end

------------------------
-- ESPs: Smooth Premium
------------------------
local function applyHighlight(obj, color, enable)
    if obj and obj:IsA("Model") then
        local highlight = obj:FindFirstChildOfClass("Highlight")
        if enable then
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.FillColor = color
                highlight.OutlineColor = color
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillTransparency = 0.32
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

local historiaESP = {
    Freddy = {path = Workspace:FindFirstChild("Freddy"), color = Color3.fromRGB(230, 140, 70)},
    Bonnie = {path = Workspace:FindFirstChild("Bonnie"), color = Color3.fromRGB(100, 70, 230)},
    Chica = {path = Workspace:FindFirstChild("Chica"), color = Color3.fromRGB(255, 220, 50)},
    Foxy = {path = Workspace:FindFirstChild("Foxy"), color = Color3.fromRGB(220, 50, 50)},
    Generator1 = {path = Workspace.WorkspaceUtilities:FindFirstChild("Generator"), color = Color3.fromRGB(60,255,60)},
    Generator2 = {path = Workspace.WorkspaceUtilities:FindFirstChild("Generator"), color = Color3.fromRGB(60,255,60)},
    VentsLever = {path = Workspace.WorkspaceUtilities:FindFirstChild("VentsLever"), color = Color3.fromRGB(60,60,255)}
}
local y = 70
for name, data in pairs(historiaESP) do
    AddToggle(tabFrames[1], "ESP: "..name, false, function(state)
        applyHighlight(data.path, data.color, state)
    end, y)
    y = y + 38
end

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
local y2 = 70
for name, data in pairs(labESP) do
    AddToggle(tabFrames[2], "ESP: "..name, false, function(state)
        applyHighlight(data.path, data.color, state)
    end, y2)
    y2 = y2 + 38
end

-----------------------
-- CHEATS: Smooth/Avançado
-----------------------
local cheatsY = 70
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
waypointBtn.Size = UDim2.new(0, 228, 0, 36)
waypointBtn.Position = UDim2.new(0, 24, 0, cheatsY)
waypointBtn.Text = "Criar Waypoint [B]"
waypointBtn.Font = Enum.Font.GothamBold
waypointBtn.TextColor3 = Color3.fromRGB(255,255,120)
waypointBtn.TextSize = 18
waypointBtn.BackgroundColor3 = Color3.fromRGB(70,70,24)
waypointBtn.AutoButtonColor = true
waypointBtn.ZIndex = 106
waypointBtn.MouseButton1Click:Connect(createWaypoint)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.B then
        createWaypoint()
    end
end)
cheatsY = cheatsY + 44

-- FLY, WALKSPEED, NOCLIP: só mostram controles extra quando ativados!
local flyEnabled, flySpeed, walkspeed, noclipEnabled = false, 40, 32, false
local bodyGyro, bodyVelocity

local function showFlyControls(show)
    flySpeedBox.Visible = show
end

local flyFrame, flyToggle = AddToggle(tabFrames[3], "Fly", false, function(state)
    flyEnabled = state
    showFlyControls(state)
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
end, cheatsY)
cheatsY = cheatsY + 38

local flySpeedBox = Instance.new("TextBox", tabFrames[3])
flySpeedBox.Size = UDim2.new(0, 100, 0, 32)
flySpeedBox.Position = UDim2.new(0, 262, 0, cheatsY-38)
flySpeedBox.Text = tostring(flySpeed)
flySpeedBox.PlaceholderText = "FlySpeed"
flySpeedBox.Font = Enum.Font.GothamBold
flySpeedBox.TextColor3 = Color3.new(0.8,1,0.8)
flySpeedBox.TextSize = 17
flySpeedBox.BackgroundColor3 = Color3.fromRGB(15,30,20)
flySpeedBox.Visible = false
flySpeedBox.ZIndex = 106
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

local function showWSControls(show)
    wsBox.Visible = show
end

local function setWalkSpeed(val)
    walkspeed = val
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = walkspeed end
end

local wsFrame, wsToggle = AddToggle(tabFrames[3], "WalkSpeed", false, function(state)
    showWSControls(state)
    setWalkSpeed(state and walkspeed or 16)
end, cheatsY)
cheatsY = cheatsY + 38

local wsBox = Instance.new("TextBox", tabFrames[3])
wsBox.Size = UDim2.new(0, 100, 0, 32)
wsBox.Position = UDim2.new(0, 262, 0, cheatsY-38)
wsBox.Text = tostring(walkspeed)
wsBox.PlaceholderText = "WalkSpeed"
wsBox.Font = Enum.Font.GothamBold
wsBox.TextColor3 = Color3.new(1,1,0.8)
wsBox.TextSize = 17
wsBox.BackgroundColor3 = Color3.fromRGB(30,30,10)
wsBox.Visible = false
wsBox.ZIndex = 106
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

local noclipConn
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

AddToggle(tabFrames[3], "Noclip", false, setNoclip, cheatsY)

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
            hl.FillTransparency = 0.25
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
playerListFrame.Size = UDim2.new(0, 360, 1, -58)
playerListFrame.Position = UDim2.new(0, 28, 0, 58)
playerListFrame.BackgroundColor3 = Color3.fromRGB(22,22,32)
playerListFrame.BorderSizePixel = 0
playerListFrame.CanvasSize = UDim2.new(0,0,0,0)
playerListFrame.ScrollBarThickness = 8
playerListFrame.Name = "PlayerList"
playerListFrame.ZIndex = 110

local refreshBtn = Instance.new("TextButton", tabFrames[4])
refreshBtn.Size = UDim2.new(0, 140, 0, 32)
refreshBtn.Position = UDim2.new(0, 400, 0, 58)
refreshBtn.Text = "Refresh Players"
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextColor3 = Color3.new(0.8,1,1)
refreshBtn.TextSize = 16
refreshBtn.BackgroundColor3 = Color3.fromRGB(10,30,30)
refreshBtn.AutoButtonColor = true
refreshBtn.ZIndex = 112

local function populatePlayers()
    playerListFrame:ClearAllChildren()
    local y = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 28)
        btn.Position = UDim2.new(0, 5, 0, y)
        btn.Text = plr.Name
        btn.Font = Enum.Font.SourceSansBold
        btn.TextColor3 = Color3.fromRGB(255,255,180)
        btn.TextSize = 17
        btn.BackgroundColor3 = Color3.fromRGB(25,25,50)
        btn.AutoButtonColor = true
        btn.Parent = playerListFrame
        btn.ZIndex = 115

        local espBtn = Instance.new("TextButton")
        espBtn.Size = UDim2.new(0, 60, 0, 22)
        espBtn.Position = UDim2.new(1, -68, 0, 3)
        espBtn.Text = "ESP"
        espBtn.Font = Enum.Font.Code
        espBtn.TextColor3 = Color3.new(1,0.9,0.5)
        espBtn.TextSize = 14
        espBtn.BackgroundColor3 = Color3.fromRGB(50,40,10)
        espBtn.Parent = btn
        espBtn.ZIndex = 116
        espBtn.MouseButton1Click:Connect(function()
            highlightPlayer(plr)
        end)

        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0, 60, 0, 22)
        tpBtn.Position = UDim2.new(1, -134, 0, 3)
        tpBtn.Text = "TP"
        tpBtn.Font = Enum.Font.Code
        tpBtn.TextColor3 = Color3.new(0.7,1,0.9)
        tpBtn.TextSize = 14
        tpBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
        tpBtn.Parent = btn
        tpBtn.ZIndex = 116
        tpBtn.MouseButton1Click:Connect(function()
            teleportToPlayer(plr)
        end)
        y = y + 32
    end
    playerListFrame.CanvasSize = UDim2.new(0,0,0,y)
end
refreshBtn.MouseButton1Click:Connect(populatePlayers)
Players.PlayerAdded:Connect(populatePlayers)
Players.PlayerRemoving:Connect(populatePlayers)
populatePlayers()

--------------------------
-- CONFIG / SHIFTLOCK
--------------------------
AddToggle(tabFrames[5], "Anti ShiftLock [H]", true, function(state)
    if state then
        StarterGui:SetCore("MouseLockEnabled", true)
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    else
        StarterGui:SetCore("MouseLockEnabled", false)
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end, 80)
StarterGui:SetCore("MouseLockEnabled", true)
UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.H then
        local s = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
        if s then
            StarterGui:SetCore("MouseLockEnabled", false)
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        else
            StarterGui:SetCore("MouseLockEnabled", true)
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    end
end)

--------------------------
-- INSTRUÇÕES RODAPÉ
--------------------------
local instruct = Instance.new("TextLabel", MainFrame)
instruct.Size = UDim2.new(1,0,0,28)
instruct.Position = UDim2.new(0,0,1,-32)
instruct.BackgroundTransparency = 1
instruct.Text = "B = Waypoint | ALT = Show/Hide GUI | H = Mouse Lock | TP: Teleporta player | Toggles: smooth/ultra"
instruct.Font = Enum.Font.Code
instruct.TextColor3 = Color3.fromRGB(255,255,160)
instruct.TextScaled = true
instruct.ZIndex = 120

--------------------------
-- HOTKEYS ALT FECHAR
--------------------------
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        guiVisible = not guiVisible
        gui.Enabled = guiVisible
    end
end)

-- Feito para Msouzen2002 2025 | Ultra Premium, modular, smooth, digna de menu de executor pago!
