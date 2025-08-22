local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Настройки ESP
local espSettings = {
    enabled = false,
    color = Color3.fromRGB(255, 0, 0),
    showName = true,
    showHealth = true,
    showDistance = true
}

-- Создание основного GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaExecutorGUI"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Закругление углов
local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 8)
uICorner.Parent = mainFrame

-- Верхняя панель
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Delta Executor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.Parent = topBar

-- Кнопка ESP
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0, 100, 0, 40)
espButton.Position = UDim2.new(0.5, -50, 0.5, -20)
espButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Font = Enum.Font.Gotham
espButton.Parent = mainFrame

-- Словарь для хранения ESP элементов
local espItems = {}

-- Функция создания ESP
local function createEsp(character, player)
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "ESP"
    highlight.FillColor = espSettings.color
    highlight.OutlineColor = espSettings.color
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = character

    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "Billboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Parent = character
    billboard.Adornee = character:WaitForChild("Head")

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = ""
    textLabel.TextColor3 = espSettings.color
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard

    espItems[player] = {highlight = highlight, billboard = billboard, label = textLabel}
end

-- Функция обновления ESP
local function updateEsp()
    for player, esp in pairs(espItems) do
        if player.Character and esp then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart then
                local text = ""
                if espSettings.showName then
                    text = player.Name
                end
                
                if espSettings.showHealth then
                    text = text .. "\nHealth: " .. math.floor(humanoid.Health)
                end
                
                if espSettings.showDistance then
                    local distance = (player.Character.HumanoidRootPart.Position - 
                                    Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    text = text .. "\nDistance: " .. math.floor(distance)
                end
                
                esp.label.Text = text
                esp.highlight.FillColor = espSettings.color
                esp.highlight.OutlineColor = espSettings.color
                esp.label.TextColor3 = espSettings.color
            end
        end
    end
end

-- Обработчик игроков
local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        if espSettings.enabled then
            createEsp(character, player)
        end
    end)
    
    if player.Character and espSettings.enabled then
        createEsp(player.Character, player)
    end
end

-- Инициализация игроков
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= player then
        onPlayerAdded(plr)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

Players.PlayerRemoving:Connect(function(leftPlayer)
    if espItems[leftPlayer] then
        espItems[leftPlayer].highlight:Destroy()
        espItems[leftPlayer].billboard:Destroy()
        espItems[leftPlayer] = nil
    end
end)

-- Переключение ESP
espButton.MouseButton1Click:Connect(function()
    espSettings.enabled = not espSettings.enabled
    espButton.Text = "ESP: " .. (espSettings.enabled and "ON" or "OFF")
    
    if espSettings.enabled then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                createEsp(plr.Character, plr)
            end
        end
    else
        for _, esp in pairs(espItems) do
            esp.highlight:Destroy()
            esp.billboard:Destroy()
        end
        espItems = {}
    end
end)

-- Обновление ESP в реальном времени
RunService.RenderStepped:Connect(function()
    if espSettings.enabled then
        updateEsp()
    end
end)

-- Анимация кнопки
espButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(
        espButton,
        TweenInfo.new(0.2),
        {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
    )
    tween:Play()
end)

espButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(
        espButton,
        TweenInfo.new(0.2),
        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
    )
    tween:Play()
end)
