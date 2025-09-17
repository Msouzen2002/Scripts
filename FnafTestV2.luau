-- FNAF TEST - Simples, funcional, com cheats, ALT fecha/abre, setas movem GUI
-- Feito para Msouzen2002

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "FNAF_TEST_SIMPLES_COMPLETO"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.DisplayOrder = 9999
gui.Parent = player:WaitForChild("PlayerGui")

local moveStep = 25
local guiVisible = true

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 520, 0, 440)
frame.Position = UDim2.new(0.5, -260, 0.5, -220)
frame.BackgroundColor3 = Color3.fromRGB(30,33,46)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Parent = gui

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "FNAF TEST"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,220,90)
title.TextSize = 26

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1, -20, 0, 28)
info.Position = UDim2.new(0, 10, 1, -36)
info.BackgroundTransparency = 1
info.Text = "ALT: Fecha/Abre | Setas: Move GUI | B: Waypoint | TP/ESP Players"
info.Font = Enum.Font.Code
info.TextColor3 = Color3.fromRGB(255,255,160)
info.TextScaled = true

-- Night Vision
local nightVision = false
local nightBtn = Instance.new("TextButton", frame)
nightBtn.Size = UDim2.new(0,120,0,28)
nightBtn.Position = UDim2.new(0,12,0,48)
nightBtn.Text = "Night Vision [OFF]"
nightBtn.Font = Enum.Font.GothamBold
nightBtn.TextSize = 16
nightBtn.BackgroundColor3 = Color3.fromRGB(45,45,60)
nightBtn.TextColor3 = Color3.fromRGB(180,255,200)
nightBtn.MouseButton1Click:Connect(function()
    nightVision = not nightVision
    nightBtn.Text = "Night Vision [" .. (nightVision and "ON" or "OFF") .. "]"
    if nightVision then
        Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(180, 180, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 200)
        Lighting.ColorShift_Bottom = Color3.fromRGB(50,60,80)
        Lighting.ColorShift_Top = Color3.fromRGB(120,120,200)
        Lighting.FogEnd = 900
        Lighting.FogStart = 0
    else
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(40, 40, 40)
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 60)
        Lighting.ColorShift_Bottom = Color3.new(0,0,0)
        Lighting.ColorShift_Top = Color3.new(0,0,0)
        Lighting.FogEnd = 200
        Lighting.FogStart = 10
    end
end)

-- ESPs simples (História e Labirinto)
local function simpleToggleESP(labeltxt, object, color, posY)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0,148,0,28)
    btn.Position = UDim2.new(0,12,0,posY)
    btn.Text = labeltxt .. " [OFF]"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 15
    btn.BackgroundColor3 = Color3.fromRGB(40,40,70)
    btn.TextColor3 = color
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = labeltxt .. (state and " [ON]" or " [OFF]")
        if object and object:IsA("Model") then
            local hl = object:FindFirstChildOfClass("Highlight")
            if state then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.FillColor = color
                    hl.OutlineColor = color
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillTransparency = 0.5
                    hl.Parent = object
                end
            elseif hl then
                hl:Destroy()
            end
        end
    end)
end

-- ESPs História
simpleToggleESP("ESP Freddy", Workspace:FindFirstChild("Freddy"), Color3.fromRGB(230,140,70), 88)
simpleToggleESP("ESP Bonnie", Workspace:FindFirstChild("Bonnie"), Color3.fromRGB(100,70,230), 118)
simpleToggleESP("ESP Chica", Workspace:FindFirstChild("Chica"), Color3.fromRGB(255,220,50), 148)
simpleToggleESP("ESP Foxy", Workspace:FindFirstChild("Foxy"), Color3.fromRGB(220,50,50), 178)
simpleToggleESP("ESP Gen1", Workspace.WorkspaceUtilities:FindFirstChild("Generator"), Color3.fromRGB(60,255,60), 208)
simpleToggleESP("ESP Gen2", Workspace.WorkspaceUtilities:FindFirstChild("Generator"), Color3.fromRGB(60,255,60), 238)
simpleToggleESP("ESP VentsLever", Workspace.WorkspaceUtilities:FindFirstChild("VentsLever"), Color3.fromRGB(60,60,255), 268)

-- ESPs Labirinto
simpleToggleESP("ESP Freddy (Lab)", Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Freddy"), Color3.fromRGB(230,140,70), 298)
simpleToggleESP("ESP Bonnie (Lab)", Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Bonnie"), Color3.fromRGB(100,70,230), 328)
simpleToggleESP("ESP Chica (Lab)", Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Chica"), Color3.fromRGB(255,220,50), 358)
simpleToggleESP("ESP Foxy (Lab)", Workspace.WorkspaceUtilities.Animatronics:FindFirstChild("Foxy"), Color3.fromRGB(220,50,50), 388)

-- Waypoints
local waypointsFolder = Workspace:FindFirstChild("Waypoints") or Instance.new("Folder", Workspace)
waypointsFolder.Name = "Waypoints"
local counter = 0
local colorTable = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255)
}
local waypointBtn = Instance.new("TextButton", frame)
waypointBtn.Size = UDim2.new(0,140,0,28)
waypointBtn.Position = UDim2.new(0,180,0,48)
waypointBtn.Text = "Criar Waypoint [B]"
waypointBtn.Font = Enum.Font.GothamBold
waypointBtn.TextSize = 15
waypointBtn.BackgroundColor3 = Color3.fromRGB(60,60,24)
waypointBtn.TextColor3 = Color3.fromRGB(255,255,120)
waypointBtn.MouseButton1Click:Connect(function()
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
end)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.B then
        waypointBtn.MouseButton1Click:Fire()
    end
end)

-- Cheats: Fly, WalkSpeed, Noclip
local flyEnabled, flySpeed, walkspeed, noclipEnabled = false, 40, 32, false
local bodyGyro, bodyVelocity

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0,100,0,26)
flyBtn.Position = UDim2.new(0,180,0,88)
flyBtn.Text = "Fly [OFF]"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 15
flyBtn.BackgroundColor3 = Color3.fromRGB(40,60,60)
flyBtn.TextColor3 = Color3.fromRGB(180,255,200)
flyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyBtn.Text = "Fly ["..(flyEnabled and "ON" or "OFF").."]"
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
end)

local flySpeedBox = Instance.new("TextBox", frame)
flySpeedBox.Size = UDim2.new(0,60,0,26)
flySpeedBox.Position = UDim2.new(0,290,0,88)
flySpeedBox.Text = tostring(flySpeed)
flySpeedBox.PlaceholderText = "FlySpeed"
flySpeedBox.Font = Enum.Font.GothamBold
flySpeedBox.TextColor3 = Color3.fromRGB(180,255,200)
flySpeedBox.TextSize = 15
flySpeedBox.BackgroundColor3 = Color3.fromRGB(15,30,20)
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

local wsBtn = Instance.new("TextButton", frame)
wsBtn.Size = UDim2.new(0,100,0,26)
wsBtn.Position = UDim2.new(0,180,0,118)
wsBtn.Text = "WalkSpeed [OFF]"
wsBtn.Font = Enum.Font.GothamBold
wsBtn.TextSize = 15
wsBtn.BackgroundColor3 = Color3.fromRGB(60,40,10)
wsBtn.TextColor3 = Color3.fromRGB(255,220,120)
wsBtn.MouseButton1Click:Connect(function()
    walkspeed = tonumber(wsSpeedBox.Text) or 32
    wsBtn.Text = "WalkSpeed ["..walkspeed.."]"
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = walkspeed end
end)

local wsSpeedBox = Instance.new("TextBox", frame)
wsSpeedBox.Size = UDim2.new(0,60,0,26)
wsSpeedBox.Position = UDim2.new(0,290,0,118)
wsSpeedBox.Text = tostring(walkspeed)
wsSpeedBox.PlaceholderText = "WalkSpeed"
wsSpeedBox.Font = Enum.Font.GothamBold
wsSpeedBox.TextColor3 = Color3.fromRGB(255,255,200)
wsSpeedBox.TextSize = 15
wsSpeedBox.BackgroundColor3 = Color3.fromRGB(30,30,10)
wsSpeedBox.FocusLost:Connect(function()
    local val = tonumber(wsSpeedBox.Text)
    if val then
        walkspeed = val
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = walkspeed end
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

local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Size = UDim2.new(0,100,0,26)
noclipBtn.Position = UDim2.new(0,180,0,148)
noclipBtn.Text = "Noclip [OFF]"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 15
noclipBtn.BackgroundColor3 = Color3.fromRGB(60,10,60)
noclipBtn.TextColor3 = Color3.fromRGB(255,220,255)
local noclipConn
noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = "Noclip ["..(noclipEnabled and "ON" or "OFF").."]"
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
end)

-- Player List (ESP/TP)
local playerListLbl = Instance.new("TextLabel", frame)
playerListLbl.Size = UDim2.new(0,120,0,22)
playerListLbl.Position = UDim2.new(0,370,0,48)
playerListLbl.Text = "Players Online:"
playerListLbl.Font = Enum.Font.GothamBold
playerListLbl.TextSize = 14
playerListLbl.TextColor3 = Color3.fromRGB(255,255,160)
playerListLbl.BackgroundTransparency = 1

local playerListFrame = Instance.new("ScrollingFrame", frame)
playerListFrame.Size = UDim2.new(0,120,0,180)
playerListFrame.Position = UDim2.new(0,370,0,70)
playerListFrame.BackgroundColor3 = Color3.fromRGB(35,35,40)
playerListFrame.BorderSizePixel = 0
playerListFrame.CanvasSize = UDim2.new(0,0,0,0)
playerListFrame.ScrollBarThickness = 6
playerListFrame.Name = "PlayerList"

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

local function populatePlayers()
    playerListFrame:ClearAllChildren()
    local y = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 22)
        btn.Position = UDim2.new(0, 5, 0, y)
        btn.Text = plr.Name
        btn.Font = Enum.Font.SourceSansBold
        btn.TextColor3 = Color3.fromRGB(255,255,180)
        btn.TextSize = 14
        btn.BackgroundColor3 = Color3.fromRGB(25,25,50)
        btn.AutoButtonColor = true
        btn.Parent = playerListFrame

        local espBtn = Instance.new("TextButton")
        espBtn.Size = UDim2.new(0, 38, 0, 19)
        espBtn.Position = UDim2.new(1, -80, 0, 1)
        espBtn.Text = "ESP"
        espBtn.Font = Enum.Font.Code
        espBtn.TextColor3 = Color3.new(1,0.9,0.5)
        espBtn.TextSize = 12
        espBtn.BackgroundColor3 = Color3.fromRGB(50,40,10)
        espBtn.Parent = btn
        espBtn.MouseButton1Click:Connect(function()
            highlightPlayer(plr)
        end)

        local tpBtn = Instance.new("TextButton")
        tpBtn.Size = UDim2.new(0, 38, 0, 19)
        tpBtn.Position = UDim2.new(1, -38, 0, 1)
        tpBtn.Text = "TP"
        tpBtn.Font = Enum.Font.Code
        tpBtn.TextColor3 = Color3.new(0.7,1,0.9)
        tpBtn.TextSize = 12
        tpBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
        tpBtn.Parent = btn
        tpBtn.MouseButton1Click:Connect(function()
            teleportToPlayer(plr)
        end)
        y = y + 22
    end
    playerListFrame.CanvasSize = UDim2.new(0,0,0,y)
end
Players.PlayerAdded:Connect(populatePlayers)
Players.PlayerRemoving:Connect(populatePlayers)
populatePlayers()

-- ALT fecha/abre GUI e setas movem GUI
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        guiVisible = not guiVisible
        gui.Enabled = guiVisible
    end

    if gui.Enabled then
        local pos = frame.Position
        if input.KeyCode == Enum.KeyCode.Left then
            frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset - moveStep, pos.Y.Scale, pos.Y.Offset)
        elseif input.KeyCode == Enum.KeyCode.Right then
            frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset + moveStep, pos.Y.Scale, pos.Y.Offset)
        elseif input.KeyCode == Enum.KeyCode.Up then
            frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset - moveStep)
        elseif input.KeyCode == Enum.KeyCode.Down then
            frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset + moveStep)
        end
    end
end)
