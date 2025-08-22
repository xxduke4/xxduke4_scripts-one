local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Настройки ESP
local espSettings = {
    enabled = false,
    color = Color3.fromRGB(0, 255, 0), -- Зеленый как в CS
    teamColor = true,
    showName = true,
    showHealth = true,
    showDistance = true,
    showWeapon = true,
    boxEsp = true,
    skeletonEsp = true
}

-- Создание основного GUI в стиле читов
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "X-One_Executor"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 400)
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
