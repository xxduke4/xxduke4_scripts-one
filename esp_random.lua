local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Настройки ESP
local espSettings = {
    enabled = false,
    color = Color3.fromRGB(0, 255, 0),
    teamColor = true,
    showName = true,
    showHealth = true,
    showDistance = true,
    boxEsp = true
}

-- Настройки аимбота
local aimbotSettings = {
    enabled = false,
    mode = "Aim Assist", -- Aim Assist, Aimbot, Rage Aimbot
    key = Enum.UserInputType.MouseButton2,
    targetPart = "Head",
    smoothness = 10,
    fov = 100,
    visibleCheck = true,
    teamCheck = true
}

-- Создание основного GUI в стиле читов
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "X-One_Executor"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Тень
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Закругление углов
local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 4)
uICorner.Parent = mainFrame

-- Верхняя панель
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 4)
topBarCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "X-ONE EXECUTOR"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = topBar

-- Разделитель
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 1)
separator.Position = UDim2.new(0, 0, 0, 30)
separator.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
separator.BorderSizePixel = 0
separator.Parent = mainFrame

-- Табы
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, 0, 0, 30)
tabsFrame.Position = UDim2.new(0, 0, 0, 31)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = mainFrame

local visualsTab = Instance.new("TextButton")
visualsTab.Size = UDim2.new(0.5, 0, 1, 0)
visualsTab.Position = UDim2.new(0, 0, 0, 0)
visualsTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
visualsTab.BorderSizePixel = 0
visualsTab.Text = "VISUALS"
visualsTab.TextColor3 = Color3.fromRGB(0, 255, 0)
visualsTab.Font = Enum.Font.GothamBold
visualsTab.TextSize = 12
visualsTab.Parent = tabsFrame

local rageTab = Instance.new("TextButton")
rageTab.Size = UDim2.new(0.5, 0, 1, 0)
rageTab.Position = UDim2.new(0.5, 0, 0, 0)
rageTab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
rageTab.BorderSizePixel = 0
rageTab.Text = "RAGE"
rageTab.TextColor3 = Color3.fromRGB(255, 255, 255)
rageTab.Font = Enum.Font.GothamBold
rageTab.TextSize = 12
rageTab.Parent = tabsFrame

-- Контент
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -100)
contentFrame.Position = UDim2.new(0, 10, 0, 70)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Визуалы
local visualsContent = Instance.new("Frame")
visualsContent.Size = UDim2.new(1, 0, 1, 0)
visualsContent.BackgroundTransparency = 1
visualsContent.Visible = true
visualsContent.Parent = contentFrame

-- Кнопка ESP
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, 0, 0, 30)
espButton.Position = UDim2.new(0, 0, 0, 0)
espButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
espButton.BorderSizePixel = 0
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Font = Enum.Font.Gotham
espButton.TextSize = 12
espButton.Parent = visualsContent

local espButtonCorner = Instance.new("UICorner")
espButtonCorner.CornerRadius = UDim.new(0, 4)
espButtonCorner.Parent = espButton

-- Настройки ESP
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(1, 0, 0, 150)
settingsFrame.Position = UDim2.new(0, 0, 0, 35)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Parent = visualsContent

-- Чекбоксы настроек
local settings = {
    {"Team Color", "teamColor", 0},
    {"Show Name", "showName", 30},
    {"Show Health", "showHealth", 60},
    {"Show Distance", "showDistance", 90},
    {"Box ESP", "boxEsp", 120}
}

local checkboxes = {}

for i, setting in ipairs(settings) do
    local checkboxFrame = Instance.new("Frame")
    checkboxFrame.Size = UDim2.new(1, 0, 0, 20)
    checkboxFrame.Position = UDim2.new(0, 0, 0, setting[3])
    checkboxFrame.BackgroundTransparency = 1
    checkboxFrame.Parent = settingsFrame
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 20, 0, 20)
    checkbox.Position = UDim2.new(0, 0, 0, 0)
    checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    checkbox.BorderSizePixel = 0
    checkbox.Text = espSettings[setting[2]] and "✓" or ""
    checkbox.TextColor3 = Color3.fromRGB(0, 255, 0)
    checkbox.Font = Enum.Font.GothamBold
    checkbox.TextSize = 12
    checkbox.Parent = checkboxFrame
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 4)
    checkboxCorner.Parent = checkbox
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 25, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = setting[1]
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = checkboxFrame
    
    checkboxes[setting[2]] = checkbox
    
    checkbox.MouseButton1Click:Connect(function()
        espSettings[setting[2]] = not espSettings[setting[2]]
        checkbox.Text = espSettings[setting[2]] and "✓" or ""
    end)
end

-- Цветовая палитра
local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1, 0, 0, 30)
colorFrame.Position = UDim2.new(0, 0, 0, 190)
colorFrame.BackgroundTransparency = 1
colorFrame.Parent = visualsContent

local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(0, 100, 1, 0)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "ESP Color:"
colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextSize = 12
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = colorFrame

local colorBox = Instance.new("TextButton")
colorBox.Size = UDim2.new(0, 30, 0, 30)
colorBox.Position = UDim2.new(1, -30, 0, 0)
colorBox.BackgroundColor3 = espSettings.color
colorBox.BorderSizePixel = 0
colorBox.Text = ""
colorBox.Parent = colorFrame

local colorBoxCorner = Instance.new("UICorner")
colorBoxCorner.CornerRadius = UDim.new(0, 4)
colorBoxCorner.Parent = colorBox

-- Rage вкладка
local rageContent = Instance.new("Frame")
rageContent.Size = UDim2.new(1, 0, 1, 0)
rageContent.BackgroundTransparency = 1
rageContent.Visible = false
rageContent.Parent = contentFrame

-- Кнопка аимбота
local aimbotButton = Instance.new("TextButton")
aimbotButton.Size = UDim2.new(1, 0, 0, 30)
aimbotButton.Position = UDim2.new(0, 0, 0, 0)
aimbotButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
aimbotButton.BorderSizePixel = 0
aimbotButton.Text = "AIMBOT: OFF"
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.Font = Enum.Font.Gotham
aimbotButton.TextSize = 12
aimbotButton.Parent = rageContent

local aimbotButtonCorner = Instance.new("UICorner")
aimbotButtonCorner.CornerRadius = UDim.new(0, 4)
aimbotButtonCorner.Parent = aimbotButton

-- Настройки аимбота
local aimbotSettingsFrame = Instance.new("Frame")
aimbotSettingsFrame.Size = UDim2.new(1, 0, 0, 250)
aimbotSettingsFrame.Position = UDim2.new(0, 0, 0, 35)
aimbotSettingsFrame.BackgroundTransparency = 1
aimbotSettingsFrame.Parent = rageContent

-- Выбор режима аимбота
local modeFrame = Instance.new("Frame")
modeFrame.Size = UDim2.new(1, 0, 0, 30)
modeFrame.Position = UDim2.new(0, 0, 0, 0)
modeFrame.BackgroundTransparency = 1
modeFrame.Parent = aimbotSettingsFrame

local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(0, 100, 1, 0)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Mode:"
modeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextSize = 12
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.Parent = modeFrame

local modeDropdown = Instance.new("TextButton")
modeDropdown.Size = UDim2.new(0, 150, 1, 0)
modeDropdown.Position = UDim2.new(1, -150, 0, 0)
modeDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
modeDropdown.BorderSizePixel = 0
modeDropdown.Text = aimbotSettings.mode
modeDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
modeDropdown.Font = Enum.Font.Gotham
modeDropdown.TextSize = 12
modeDropdown.Parent = modeFrame

local modeDropdownCorner = Instance.new("UICorner")
modeDropdownCorner.CornerRadius = UDim.new(0, 4)
modeDropdownCorner.Parent = modeDropdown

-- Выбор части тела
local partFrame = Instance.new("Frame")
partFrame.Size = UDim2.new(1, 0, 0, 30)
partFrame.Position = UDim2.new(0, 0, 0, 35)
partFrame.BackgroundTransparency = 1
partFrame.Parent = aimbotSettingsFrame

local partLabel = Instance.new("TextLabel")
partLabel.Size = UDim2.new(0, 100, 1, 0)
partLabel.BackgroundTransparency = 1
partLabel.Text = "Target Part:"
partLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
partLabel.Font = Enum.Font.Gotham
partLabel.TextSize = 12
partLabel.TextXAlignment = Enum.TextXAlignment.Left
partLabel.Parent = partFrame

local partDropdown = Instance.new("TextButton")
partDropdown.Size = UDim2.new(0, 150, 1, 0)
partDropdown.Position = UDim2.new(1, -150, 0, 0)
partDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
partDropdown.BorderSizePixel = 0
partDropdown.Text = aimbotSettings.targetPart
partDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
partDropdown.Font = Enum.Font.Gotham
partDropdown.TextSize = 12
partDropdown.Parent = partFrame

local partDropdownCorner = Instance.new("UICorner")
partDropdownCorner.CornerRadius = UDim.new(0, 4)
partDropdownCorner.Parent = partDropdown

-- Настройка плавности
local smoothnessFrame = Instance.new("Frame")
smoothnessFrame.Size = UDim2.new(1, 0, 0, 30)
smoothnessFrame.Position = UDim2.new(0, 0, 0, 70)
smoothnessFrame.BackgroundTransparency = 1
smoothnessFrame.Parent = aimbotSettingsFrame

local smoothnessLabel = Instance.new("TextLabel")
smoothnessLabel.Size = UDim2.new(0, 100, 1, 0)
smoothnessLabel.BackgroundTransparency = 1
smoothnessLabel.Text = "Smoothness:"
smoothnessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothnessLabel.Font = Enum.Font.Gotham
smoothnessLabel.TextSize = 12
smoothnessLabel.TextXAlignment = Enum.TextXAlignment.Left
smoothnessLabel.Parent = smoothnessFrame

local smoothnessSlider = Instance.new("Frame")
smoothnessSlider.Size = UDim2.new(0, 150, 0, 20)
smoothnessSlider.Position = UDim2.new(1, -150, 0, 5)
smoothnessSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
smoothnessSlider.BorderSizePixel = 0
smoothnessSlider.Parent = smoothnessFrame

local smoothnessSliderCorner = Instance.new("UICorner")
smoothnessSliderCorner.CornerRadius = UDim.new(0, 4)
smoothnessSliderCorner.Parent = smoothnessSlider

local smoothnessFill = Instance.new("Frame")
smoothnessFill.Size = UDim2.new((aimbotSettings.smoothness - 1) / 19, 0, 1, 0)
smoothnessFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
smoothnessFill.BorderSizePixel = 0
smoothnessFill.Parent = smoothnessSlider

local smoothnessFillCorner = Instance.new("UICorner")
smoothnessFillCorner.CornerRadius = UDim.new(0, 4)
smoothnessFillCorner.Parent = smoothnessFill

local smoothnessValue = Instance.new("TextLabel")
smoothnessValue.Size = UDim2.new(0, 30, 1, 0)
smoothnessValue.Position = UDim2.new(1, 5, 0, 0)
smoothnessValue.BackgroundTransparency = 1
smoothnessValue.Text = tostring(aimbotSettings.smoothness)
smoothnessValue.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothnessValue.Font = Enum.Font.Gotham
smoothnessValue.TextSize = 12
smoothnessValue.Parent = smoothnessSlider

-- Настройка FOV
local fovFrame = Instance.new("Frame")
fovFrame.Size = UDim2.new(1, 0, 0, 30)
fovFrame.Position = UDim2.new(0, 0, 0, 105)
fovFrame.BackgroundTransparency = 1
fovFrame.Parent = aimbotSettingsFrame

local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(0, 100, 1, 0)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV:"
fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fovLabel.Font = Enum.Font.Gotham
fovLabel.TextSize = 12
fovLabel.TextXAlignment = Enum.TextXAlignment.Left
fovLabel.Parent = fovFrame

local fovSlider = Instance.new("Frame")
fovSlider.Size = UDim2.new(0, 150, 0, 20)
fovSlider.Position = UDim2.new(1, -150, 0, 5)
fovSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
fovSlider.BorderSizePixel = 0
fovSlider.Parent = fovFrame

local fovSliderCorner = Instance.new("UICorner")
fovSliderCorner.CornerRadius = UDim.new(0, 4)
fovSliderCorner.Parent = fovSlider

local fovFill = Instance.new("Frame")
fovFill.Size = UDim2.new((aimbotSettings.fov - 50) / 150, 0, 1, 0)
fovFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
fovFill.BorderSizePixel = 0
fovFill.Parent = fovSlider

local fovFillCorner = Instance.new("UICorner")
fovFillCorner.CornerRadius = UDim.new(0, 4)
fovFillCorner.Parent = fovFill

local fovValue = Instance.new("TextLabel")
fovValue.Size = UDim2.new(0, 30, 1, 0)
fovValue.Position = UDim2.new(1, 5, 0, 0)
fovValue.BackgroundTransparency = 1
fovValue.Text = tostring(aimbotSettings.fov)
fovValue.TextColor3 = Color3.fromRGB(255, 255, 255)
fovValue.Font = Enum.Font.Gotham
fovValue.TextSize = 12
fovValue.Parent = fovSlider

-- Чекбоксы настроек аимбота
local aimbotSettingsList = {
    {"Visible Check", "visibleCheck", 140},
    {"Team Check", "teamCheck", 170}
}

local aimbotCheckboxes = {}

for i, setting in ipairs(aimbotSettingsList) do
    local checkboxFrame = Instance.new("Frame")
    checkboxFrame.Size = UDim2.new(1, 0, 0, 20)
    checkboxFrame.Position = UDim2.new(0, 0, 0, setting[3])
    checkboxFrame.BackgroundTransparency = 1
    checkboxFrame.Parent = aimbotSettingsFrame
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 20, 0, 20)
    checkbox.Position = UDim2.new(0, 0, 0, 0)
    checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    checkbox.BorderSizePixel = 0
    checkbox.Text = aimbotSettings[setting[2]] and "✓" or ""
    checkbox.TextColor3 = Color3.fromRGB(0, 255, 0)
    checkbox.Font = Enum.Font.GothamBold
    checkbox.TextSize = 12
    checkbox.Parent = checkboxFrame
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 4)
    checkboxCorner.Parent = checkbox
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 25, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = setting[1]
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = checkboxFrame
    
    aimbotCheckboxes[setting[2]] = checkbox
    
    checkbox.MouseButton1Click:Connect(function()
        aimbotSettings[setting[2]] = not aimbotSettings[setting[2]]
        checkbox.Text = aimbotSettings[setting[2]] and "✓" or ""
    end)
end

-- Словарь для хранения ESP элементов
local espItems = {}

-- Функция создания ESP
local function createEsp(character, player)
    if espItems[player] then return end
    
    -- Бокс ESP
    local box = Drawing.new("Quad")
    box.Visible = false
    box.Color = espSettings.color
    box.Thickness = 1
    box.Filled = false
    
    -- Текст ESP
    local text = Drawing.new("Text")
    text.Visible = false
    text.Color = espSettings.color
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.new(0, 0, 0)
    
    espItems[player] = {
        box = box,
        text = text,
        player = player,
        character = character
    }
end

-- Функция обновления ESP
local function updateEsp()
    for player, esp in pairs(espItems) do
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            -- Получаем позицию на экране
            local head = character:FindFirstChild("Head")
            local camera = workspace.CurrentCamera
            local vector, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            
            if onScreen then
                -- Размер бокса в зависимости от расстояния
                local distance = (camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / distance
                
                -- Бокс ESP
                if espSettings.boxEsp then
                    local headPos = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
                    local feetPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                    
                    local height = (headPos.Y - feetPos.Y)
                    local width = height / 2.5
                    
                    esp.box.PointA = Vector2.new(headPos.X - width, headPos.Y)
                    esp.box.PointB = Vector2.new(headPos.X + width, headPos.Y)
                    esp.box.PointC = Vector2.new(headPos.X + width, feetPos.Y)
                    esp.box.PointD = Vector2.new(headPos.X - width, feetPos.Y)
                    esp.box.Visible = true
                    esp.box.Color = espSettings.teamColor and player.TeamColor.Color or espSettings.color
                else
                    esp.box.Visible = false
                end
                
                -- Текст ESP
                local text = ""
                
                if espSettings.showName then
                    text = player.Name
                end
                
                if espSettings.showHealth then
                    text = text .. "\nHealth: " .. math.floor(humanoid.Health)
                end
                
                if espSettings.showDistance then
                    text = text .. "\nDist: " .. math.floor(distance)
                end
                
                esp.text.Text = text
                esp.text.Position = Vector2.new(vector.X, vector.Y - 100)
                esp.text.Visible = true
  
                mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Тень
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Закругление углов
local uICorner = Instance.new("UICorner")
uICorner.CornerRadius = UDim.new(0, 4)
uICorner.Parent = mainFrame

-- Верхняя панель
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 4)
topBarCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "X-ONE EXECUTOR"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = topBar

-- Разделитель
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 1)
separator.Position = UDim2.new(0, 0, 0, 30)
separator.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
separator.BorderSizePixel = 0
separator.Parent = mainFrame

-- Контент
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -50)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Заголовок секции
local espHeader = Instance.new("TextLabel")
espHeader.Size = UDim2.new(1, 0, 0, 20)
espHeader.BackgroundTransparency = 1
espHeader.Text = "VISUALS"
espHeader.TextColor3 = Color3.fromRGB(0, 255, 0)
espHeader.Font = Enum.Font.GothamBold
espHeader.TextSize = 12
espHeader.TextXAlignment = Enum.TextXAlignment.Left
espHeader.Parent = contentFrame

-- Кнопка ESP
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, 0, 0, 30)
espButton.Position = UDim2.new(0, 0, 0, 25)
espButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
espButton.BorderSizePixel = 0
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Font = Enum.Font.Gotham
espButton.TextSize = 12
espButton.Parent = contentFrame

local espButtonCorner = Instance.new("UICorner")
espButtonCorner.CornerRadius = UDim.new(0, 4)
espButtonCorner.Parent = espButton

-- Настройки ESP
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(1, 0, 0, 200)
settingsFrame.Position = UDim2.new(0, 0, 0, 60)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Parent = contentFrame

-- Чекбоксы настроек
local settings = {
    {"Team Color", "teamColor", 0},
    {"Show Name", "showName", 30},
    {"Show Health", "showHealth", 60},
    {"Show Distance", "showDistance", 90},
    {"Show Weapon", "showWeapon", 120},
    {"Box ESP", "boxEsp", 150},
    {"Skeleton ESP", "skeletonEsp", 180}
}

local checkboxes = {}

for i, setting in ipairs(settings) do
    local checkboxFrame = Instance.new("Frame")
    checkboxFrame.Size = UDim2.new(1, 0, 0, 20)
    checkboxFrame.Position = UDim2.new(0, 0, 0, setting[3])
    checkboxFrame.BackgroundTransparency = 1
    checkboxFrame.Parent = settingsFrame
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 20, 0, 20)
    checkbox.Position = UDim2.new(0, 0, 0, 0)
    checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    checkbox.BorderSizePixel = 0
    checkbox.Text = espSettings[setting[2]] and "✓" or ""
    checkbox.TextColor3 = Color3.fromRGB(0, 255, 0)
    checkbox.Font = Enum.Font.GothamBold
    checkbox.TextSize = 12
    checkbox.Parent = checkboxFrame
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 4)
    checkboxCorner.Parent = checkbox
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 25, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = setting[1]
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = checkboxFrame
    
    checkboxes[setting[2]] = checkbox
    
    checkbox.MouseButton1Click:Connect(function()
        espSettings[setting[2]] = not espSettings[setting[2]]
        checkbox.Text = espSettings[setting[2]] and "✓" or ""
    end)
end

-- Цветовая палитра
local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1, 0, 0, 30)
colorFrame.Position = UDim2.new(0, 0, 0, 270)
colorFrame.BackgroundTransparency = 1
colorFrame.Parent = contentFrame

local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(0, 100, 1, 0)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "ESP Color:"
colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextSize = 12
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = colorFrame

local colorBox = Instance.new("TextButton")
colorBox.Size = UDim2.new(0, 30, 0, 30)
colorBox.Position = UDim2.new(1, -30, 0, 0)
colorBox.BackgroundColor3 = espSettings.color
colorBox.BorderSizePixel = 0
colorBox.Text = ""
colorBox.Parent = colorFrame

local colorBoxCorner = Instance.new("UICorner")
colorBoxCorner.CornerRadius = UDim.new(0, 4)
colorBoxCorner.Parent = colorBox

-- Словарь для хранения ESP элементов
local espItems = {}

-- Функция создания ESP в стиле CS
local function createEsp(character, player)
    if espItems[player] then return end
    
    -- Бокс ESP
    local box = Drawing.new("Quad")
    box.Visible = false
    box.Color = espSettings.color
    box.Thickness = 1
    box.Filled = false
    
    -- Скелет ESP
    local skeleton = {}
    local connections = {}
    
    if espSettings.skeletonEsp then
        local parts = {
            {"Head", "UpperTorso"},
            {"UpperTorso", "LowerTorso"},
            {"LowerTorso", "LeftUpperLeg"},
            {"LowerTorso", "RightUpperLeg"},
            {"LeftUpperLeg", "LeftLowerLeg"},
            {"RightUpperLeg", "RightLowerLeg"},
            {"LeftLowerLeg", "LeftFoot"},
            {"RightLowerLeg", "RightFoot"},
            {"UpperTorso", "LeftUpperArm"},
            {"UpperTorso", "RightUpperArm"},
            {"LeftUpperArm", "LeftLowerArm"},
            {"RightUpperArm", "RightLowerArm"},
            {"LeftLowerArm", "LeftHand"},
            {"RightLowerArm", "RightHand"}
        }
        
        for _, partPair in ipairs(parts) do
            local line = Drawing.new("Line")
            line.Visible = false
            line.Color = espSettings.color
            line.Thickness = 1
            table.insert(skeleton, line)
        end
    end
    
    -- Текст ESP
    local text = Drawing.new("Text")
    text.Visible = false
    text.Color = espSettings.color
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.new(0, 0, 0)
    
    espItems[player] = {
        box = box,
        skeleton = skeleton,
        text = text,
        player = player,
        character = character,
        connections = connections
    }
    
    -- Обработчик обновления персонажа
    local function characterAdded(newCharacter)
        espItems[player].character = newCharacter
    end
    
    table.insert(connections, player.CharacterAdded:Connect(characterAdded))
end

-- Функция обновления ESP
local function updateEsp()
    for player, esp in pairs(espItems) do
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            -- Получаем позицию на экране
            local head = character:FindFirstChild("Head")
            local camera = workspace.CurrentCamera
            local vector, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            
            if onScreen then
                -- Размер бокса в зависимости от расстояния
                local distance = (camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / distance
                
                -- Бокс ESP
                if espSettings.boxEsp then
                    local headPos = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
                    local feetPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                    
                    local height = (headPos.Y - feetPos.Y)
                    local width = height / 2.5
                    
                    esp.box.PointA = Vector2.new(headPos.X - width, headPos.Y)
                    esp.box.PointB = Vector2.new(headPos.X + width, headPos.Y)
                    esp.box.PointC = Vector2.new(headPos.X + width, feetPos.Y)
                    esp.box.PointD = Vector2.new(headPos.X - width, feetPos.Y)
                    esp.box.Visible = true
                    esp.box.Color = espSettings.teamColor and player.TeamColor.Color or espSettings.color
                else
                    esp.box.Visible = false
                end
                
                -- Скелет ESP
                if espSettings.skeletonEsp and #esp.skeleton > 0 then
                    local parts = {
                        Head = character:FindFirstChild("Head"),
                        UpperTorso = character:FindFirstChild("UpperTorso"),
                        LowerTorso = character:FindFirstChild("LowerTorso"),
                        LeftUpperLeg = character:FindFirstChild("LeftUpperLeg"),
                        RightUpperLeg = character:FindFirstChild("RightUpperLeg"),
                        LeftLowerLeg = character:FindFirstChild("LeftLowerLeg"),
                        RightLowerLeg = character:FindFirstChild("RightLowerLeg"),
                        LeftFoot = character:FindFirstChild("LeftFoot"),
                        RightFoot = character:FindFirstChild("RightFoot"),
                        LeftUpperArm = character:FindFirstChild("LeftUpperArm"),
                        RightUpperArm = character:FindFirstChild("RightUpperArm"),
                        LeftLowerArm = character:FindFirstChild("LeftLowerArm"),
                        RightLowerArm = character:FindFirstChild("RightLowerArm"),
                        LeftHand = character:FindFirstChild("LeftHand"),
                        RightHand = character:FindFirstChild("RightHand")
                    }
                    
                    local partConnections = {
                        {"Head", "UpperTorso"},
                        {"UpperTorso", "LowerTorso"},
                        {"LowerTorso", "LeftUpperLeg"},
                        {"LowerTorso", "RightUpperLeg"},
                        {"LeftUpperLeg", "LeftLowerLeg"},
                        {"RightUpperLeg", "RightLowerLeg"},
                        {"LeftLowerLeg", "LeftFoot"},
                        {"RightLowerLeg", "RightFoot"},
                        {"UpperTorso", "LeftUpperArm"},
                        {"UpperTorso", "RightUpperArm"},
                        {"LeftUpperArm", "LeftLowerArm"},
                        {"RightUpperArm", "RightLowerArm"},
                        {"LeftLowerArm", "LeftHand"},
                        {"RightLowerArm", "RightHand"}
                    }
                    
                    for i, partPair in ipairs(partConnections) do
                        if parts[partPair[1]] and parts[partPair[2]] then
                            local pos1 = camera:WorldToViewportPoint(parts[partPair[1]].Position)
                            local pos2 = camera:WorldToViewportPoint(parts[partPair[2]].Position)
                            
                            if pos1.Z > 0 and pos2.Z > 0 then
                                esp.skeleton[i].From = Vector2.new(pos1.X, pos1.Y)
                                esp.skeleton[i].To = Vector2.new(pos2.X, pos2.Y)
                                esp.skeleton[i].Visible = true
                                esp.skeleton[i].Color = espSettings.teamColor and player.TeamColor.Color or espSettings.color
                            else
                                esp.skeleton[i].Visible = false
                            end
                        else
                            esp.skeleton[i].Visible = false
                        end
                    end
                end
                
                -- Текст ESP
                local text = ""
                
                if espSettings.showName then
                    text = player.Name
                end
                
                if espSettings.showHealth then
                    text = text .. "\nHealth: " .. math.floor(humanoid.Health)
                end
                
                if espSettings.showDistance then
                    text = text .. "\nDist: " .. math.floor(distance)
                end
                
                if espSettings.showWeapon then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        text = text .. "\nWeapon: " .. tool.Name
                    end
                end
                
                esp.text.Text = text
                esp.text.Position = Vector2.new(vector.X, vector.Y - 100)
                esp.text.Visible = true
                esp.text.Color = espSettings.teamColor and player.TeamColor.Color or espSettings.color
            else
                esp.box.Visible = false
                for _, line in ipairs(esp.skeleton) do
                    line.Visible = false
                end
                esp.text.Visible = false
            end
        else
            esp.box.Visible = false
            for _, line in ipairs(esp.skeleton) do
                line.Visible = false
            end
            esp.text.Visible = false
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
        espItems[leftPlayer].box:Remove()
        for _, line in ipairs(espItems[leftPlayer].skeleton) do
            line:Remove()
        end
        espItems[leftPlayer].text:Remove()
        
        for _, connection in ipairs(espItems[leftPlayer].connections) do
            connection:Disconnect()
        end
        
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
            esp.box:Remove()
            for _, line in ipairs(esp.skeleton) do
                line:Remove()
            end
            esp.text:Remove()
            
            for _, connection in ipairs(esp.connections) do
                connection:Disconnect()
            end
        end
        espItems = {}
    end
end)

-- Выбор цвета
colorBox.MouseButton1Click:Connect(function()
    espSettings.color = Color3.fromRGB(
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255)
    )
    colorBox.BackgroundColor3 = espSettings.color
end)

-- Закрытие GUI
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    
    -- Отключаем ESP при закрытии
    for _, esp in pairs(espItems) do
        esp.box:Remove()
        for _, line in ipairs(esp.skeleton) do
            line:Remove()
        end
        esp.text:Remove()
        
        for _, connection in ipairs(esp.connections) do
            connection:Disconnect()
        end
    end
    espItems = {}
end)

-- Обновление ESP в реальном времени
RunService.RenderStepped:Connect(function()
    if espSettings.enabled then
        updateEsp()
    end
end)

-- Анимация кнопок
local function setupButtonHover(button)
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
        ):Play()
    end)
end

setupButtonHover(espButton)
setupButtonHover(closeButton)

for _, checkbox in pairs(checkboxes) do
    setupButtonHover(checkbox)
end

setupButtonHover(colorBox)uICorner.CornerRadius = UDim.new(0, 8)
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
