-- FNAF TEST CORRIGIDO - EXECUTOR STYLE - Todas as teclas funcionando
-- Feito para Msouzen2002

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Garantir que não existe GUI duplicada
if playerGui:FindFirstChild("FNAF_TEST_CORRIGIDO") then
    playerGui:FindFirstChild("FNAF_TEST_CORRIGIDO"):Destroy()
end

-- Criar ScreenGui principal
local gui = Instance.new("ScreenGui")
gui.Name = "FNAF_TEST_CORRIGIDO"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999
gui.Parent = playerGui

-- Variáveis globais
local moveStep = 25
local guiVisible = false -- Começa fechada
local mouseLocked = true
local nightVision = false

-- BOTÃO DE ABERTURA (substitui botão de pulo mobile)
local openButton = Instance.new("TextButton")
openButton.Name = "OpenFNAFScript"
openButton.Size = UDim2.new(0, 60, 0, 60)
openButton.Position = UDim2.new(1, -80, 1, -80) -- Canto inferior direito
openButton.Text = "FNAF"
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14
openButton.TextColor3 = Color3.fromRGB(255, 220, 90)
openButton.BackgroundColor3 = Color3.fromRGB(30, 33, 46)
openButton.BorderSizePixel = 2
openButton.BorderColor3 = Color3.fromRGB(255, 220, 90)
openButton.BackgroundTransparency = 0.1
openButton.ZIndex = 10
openButton.Parent = gui

-- Efeito de hover no botão
openButton.MouseEnter:Connect(function()
    openButton.BackgroundColor3 = Color3.fromRGB(50, 53, 66)
end)
openButton.MouseLeave:Connect(function()
    openButton.BackgroundColor3 = Color3.fromRGB(30, 33, 46)
end)

-- Frame principal (começa invisível)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 440)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 33, 46)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ZIndex = 5
mainFrame.Parent = gui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FNAF TEST EXECUTOR"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 220, 90)
title.TextSize = 24
title.ZIndex = 6
title.Parent = mainFrame

-- Botão fechar (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "✕"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
closeButton.BorderSizePixel = 0
closeButton.ZIndex = 6
closeButton.Parent = mainFrame

-- Info
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, -20, 0, 25)
info.Position = UDim2.new(0, 10, 1, -30)
info.BackgroundTransparency = 1
info.Text = "Executor Style | Clique nos botões para usar as funções"
info.Font = Enum.Font.Code
info.TextColor3 = Color3.fromRGB(255, 255, 160)
info.TextScaled = true
info.ZIndex = 6
info.Parent = mainFrame

-- FUNÇÕES PRINCIPAIS
local function movePlayerStuds(deltaY)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, deltaY, 0)
        print("Player movido " .. deltaY .. " studs")
    end
end

local function toggleMouseLock()
    mouseLocked = not mouseLocked
    UserInputService.MouseBehavior = mouseLocked and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
    print("Mouse " .. (mouseLocked and "travado" or "livre"))
end

local function toggleNightVision()
    nightVision = not nightVision
    if nightVision then
        Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(180, 180, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 200)
        Lighting.FogEnd = 900
        Lighting.FogStart = 0
    else
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(40, 40, 40)
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 60)
        Lighting.FogEnd = 200
        Lighting.FogStart = 10
    end
    print("Night Vision " .. (nightVision and "ON" or "OFF"))
end

local function createWaypoint()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local waypointsFolder = Workspace:FindFirstChild("Waypoints") or Instance.new("Folder")
    waypointsFolder.Name = "Waypoints"
    waypointsFolder.Parent = Workspace
    
    local counter = #waypointsFolder:GetChildren() + 1
    local colors = {
        Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0)
    }
    
    local part = Instance.new("Part")
    part.Name = "Waypoint" .. counter
    part.Size = Vector3.new(2, 2, 2)
    part.Position = char.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Color = colors[((counter - 1) % #colors) + 1]
    part.Parent = waypointsFolder
    
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Parent = part
    
    print("Waypoint " .. counter .. " criado!")
end

-- BOTÕES DA GUI
local buttonData = {
    {text = "Night Vision", pos = {0, 12, 0, 50}, color = Color3.fromRGB(180, 255, 200), func = function()
        toggleNightVision()
        return "Night Vision [" .. (nightVision and "ON" or "OFF") .. "]"
    end},
    
    {text = "Move UP (+25)", pos = {0, 140, 0, 50}, color = Color3.fromRGB(100, 255, 100), func = function()
        movePlayerStuds(moveStep)
        return "Move UP (+25)"
    end},
    
    {text = "Move DOWN (-25)", pos = {0, 140, 0, 85}, color = Color3.fromRGB(255, 100, 100), func = function()
        movePlayerStuds(-moveStep)
        return "Move DOWN (-25)"
    end},
    
    {text = "Create Waypoint", pos = {0, 270, 0, 50}, color = Color3.fromRGB(255, 255, 120), func = function()
        createWaypoint()
        return "Create Waypoint"
    end},
    
    {text = "Toggle Mouse", pos = {0, 270, 0, 85}, color = Color3.fromRGB(120, 200, 255), func = function()
        toggleMouseLock()
        return "Mouse [" .. (mouseLocked and "LOCKED" or "FREE") .. "]"
    end}
}

-- Criar botões
local buttons = {}
for i, data in ipairs(buttonData) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, data.pos[2], 0, data.pos[4])
    btn.Text = data.text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = data.color
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = data.color
    btn.ZIndex = 6
    btn.Parent = mainFrame
    
    -- Efeito hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    end)
    
    -- Função do botão
    btn.MouseButton1Click:Connect(function()
        local newText = data.func()
        if newText then
            btn.Text = newText
        end
    end)
    
    buttons[i] = btn
end

-- ESP SIMPLES
local function createESPButton(name, targetPath, color, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 0, 25)
    btn.Position = UDim2.new(0, position[1], 0, position[2])
    btn.Text = "ESP " .. name .. " [OFF]"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextColor3 = color
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = color
    btn.ZIndex = 6
    btn.Parent = mainFrame
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = "ESP " .. name .. " [" .. (state and "ON" or "OFF") .. "]"
        
        local target = targetPath()
        if target and target:IsA("Model") then
            local highlight = target:FindFirstChildOfClass("Highlight")
            if state and not highlight then
                highlight = Instance.new("Highlight")
                highlight.FillColor = color
                highlight.OutlineColor = color
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillTransparency = 0.5
                highlight.Parent = target
            elseif not state and highlight then
                highlight:Destroy()
            end
        end
    end)
end

-- Criar ESPs
local espData = {
    {"Freddy", function() return Workspace:FindFirstChild("Freddy") end, Color3.fromRGB(230, 140, 70), {400, 50}},
    {"Bonnie", function() return Workspace:FindFirstChild("Bonnie") end, Color3.fromRGB(100, 70, 230), {400, 80}},
    {"Chica", function() return Workspace:FindFirstChild("Chica") end, Color3.fromRGB(255, 220, 50), {400, 110}},
    {"Foxy", function() return Workspace:FindFirstChild("Foxy") end, Color3.fromRGB(220, 50, 50), {400, 140}}
}

for _, data in ipairs(espData) do
    createESPButton(data[1], data[2], data[3], data[4])
end

-- PLAYER LIST SIMPLES
local playerLabel = Instance.new("TextLabel")
playerLabel.Size = UDim2.new(0, 100, 0, 20)
playerLabel.Position = UDim2.new(0, 400, 0, 180)
playerLabel.Text = "Players:"
playerLabel.Font = Enum.Font.GothamBold
playerLabel.TextSize = 14
playerLabel.TextColor3 = Color3.fromRGB(255, 255, 160)
playerLabel.BackgroundTransparency = 1
playerLabel.ZIndex = 6
playerLabel.Parent = mainFrame

local playerFrame = Instance.new("ScrollingFrame")
playerFrame.Size = UDim2.new(0, 100, 0, 150)
playerFrame.Position = UDim2.new(0, 400, 0, 200)
playerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
playerFrame.BorderSizePixel = 0
playerFrame.ScrollBarThickness = 4
playerFrame.ZIndex = 6
playerFrame.Parent = mainFrame

local function updatePlayerList()
    playerFrame:ClearAllChildren()
    local yPos = 0
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -5, 0, 20)
            btn.Position = UDim2.new(0, 0, 0, yPos)
            btn.Text = plr.Name
            btn.Font = Enum.Font.Code
            btn.TextSize = 10
            btn.TextColor3 = Color3.fromRGB(255, 255, 180)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            btn.BorderSizePixel = 0
            btn.ZIndex = 7
            btn.Parent = playerFrame
            
            btn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and 
                   player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    print("Teleportado para " .. plr.Name)
                end
            end)
            
            yPos = yPos + 22
        end
    end
    
    playerFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Atualizar lista de players
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- EVENTOS DOS BOTÕES PRINCIPAIS
openButton.MouseButton1Click:Connect(function()
    guiVisible = true
    mainFrame.Visible = true
    openButton.Visible = false
    print("GUI Aberta")
end)

closeButton.MouseButton1Click:Connect(function()
    guiVisible = false
    mainFrame.Visible = false
    openButton.Visible = true
    print("GUI Fechada")
end)

-- SISTEMA DE INPUT (FUNCIONA EM EXECUTORS)
spawn(function()
    local inputService = UserInputService
    inputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        local key = input.KeyCode
        
        -- M para abrir/fechar
        if key == Enum.KeyCode.M then
            if guiVisible then
                closeButton.MouseButton1Click:Fire()
            else
                openButton.MouseButton1Click:Fire()
            end
        end
        
        -- Outras teclas só funcionam com GUI aberta
        if guiVisible then
            if key == Enum.KeyCode.P then
                movePlayerStuds(moveStep)
            elseif key == Enum.KeyCode.L then
                movePlayerStuds(-moveStep)
            elseif key == Enum.KeyCode.B then
                createWaypoint()
            elseif key == Enum.KeyCode.G then
                toggleMouseLock()
            elseif key == Enum.KeyCode.N then
                toggleNightVision()
            end
        end
    end)
end)

-- Inicialização
UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
print("FNAF Executor Script Carregado! Clique no botão FNAF para abrir.")
print("Teclas: M=Menu | P=Cima | L=Baixo | B=Waypoint | G=Mouse | N=NightVision")
