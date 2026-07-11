-- =====================================================
-- 🧠 SMART ACTION OBSERVER
-- بيراقب كل حركة بناء وأحداث في الماب
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- =====================================================
-- واجهة سوداء بسيطة
-- =====================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SmartObserver"
screenGui.Parent = LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 400)
mainFrame.Position = UDim2.new(0.5, -210, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- شريط العنوان
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.8, 0, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 Smart Action Observer"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 3)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = titleBar

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 40, 0, 28)
clearBtn.Position = UDim2.new(1, -85, 0, 5)
clearBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
clearBtn.Text = "🗑️"
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 14
clearBtn.Parent = titleBar
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -55)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
scroll.ScrollBarThickness = 4
scroll.Parent = mainFrame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 10)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = scroll

-- =====================================================
-- وظيفة إضافة حدث للقائمة
-- =====================================================
local function addEvent(icon, text, details)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -10, 0, 65)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    card.Parent = scroll
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 0, 30)
    iconLabel.Position = UDim2.new(0, 6, 0, 6)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 18
    iconLabel.Parent = card

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -50, 0, 22)
    textLabel.Position = UDim2.new(0, 42, 0, 4)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 11
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = card

    local detailLabel = Instance.new("TextLabel")
    detailLabel.Size = UDim2.new(1, -50, 0, 28)
    detailLabel.Position = UDim2.new(0, 42, 0, 26)
    detailLabel.BackgroundTransparency = 1
    detailLabel.Text = details
    detailLabel.TextColor3 = Color3.fromRGB(160, 180, 200)
    detailLabel.Font = Enum.Font.Gotham
    detailLabel.TextSize = 9
    detailLabel.TextWrapped = true
    detailLabel.TextXAlignment = Enum.TextXAlignment.Left
    detailLabel.Parent = card

    -- زر نسخ
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 40, 0, 26)
    copyBtn.Position = UDim2.new(1, -48, 0, 20)
    copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    copyBtn.Text = "📋"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextSize = 14
    copyBtn.Parent = card
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(details)
        copyBtn.Text = "✅"
        copyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        task.delay(1, function()
            if copyBtn and copyBtn.Parent then
                copyBtn.Text = "📋"
                copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            end
        end)
    end)

    task.defer(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
end

-- =====================================================
-- مراقبة ضغطات الفأرة/اللمس
-- =====================================================
Mouse.Button1Down:Connect(function()
    local target = Mouse.Target
    if target then
        addEvent("🖱️", "Mouse Click", "Target: " .. target:GetFullName())
    end
end)

-- =====================================================
-- مراقبة اللمس (للجوال)
-- =====================================================
UserInputService.TouchStarted:Connect(function(input, processed)
    if not processed then
        local pos = input.Position
        local ray = Camera:ScreenPointToRay(pos.X, pos.Y)
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {LocalPlayer.Character}
        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
        if result and result.Instance then
            addEvent("👆", "Touch", "Target: " .. result.Instance:GetFullName())
        end
    end
end)

-- =====================================================
-- مراقبة تغييرات الـ Workspace (البناء)
-- =====================================================
workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Part") or obj:IsA("Model") or obj:IsA("Tool") then
        addEvent("🔨", "Object Added", obj:GetFullName() .. " (" .. obj.ClassName .. ")")
    end
end)

workspace.DescendantRemoving:Connect(function(obj)
    if obj:IsA("Part") or obj:IsA("Model") then
        addEvent("💥", "Object Removed", obj:GetFullName())
    end
end)

-- =====================================================
-- مراقبة الـ Tools (اختيار أدوات)
-- =====================================================
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").EquippedTool:Connect(function(tool)
        if tool then
            addEvent("🔧", "Tool Equipped", tool:GetFullName())
        end
    end)
end)

-- =====================================================
-- مراقبة RemoteEvents (اللي بتتسمى)
-- =====================================================
for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        local old = obj.FireServer
        obj.FireServer = function(self, ...)
            addEvent("📡", "RemoteEvent Fired", self:GetFullName())
            return old(self, ...)
        end
    end
end

-- =====================================================
-- تنظيف
-- =====================================================
clearBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(scroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, 10)
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- =====================================================
-- السحب
-- =====================================================
local dragData = {dragging = false, startPos = nil, startMouse = nil}

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragData.dragging = true
        dragData.startPos = mainFrame.Position
        dragData.startMouse = Vector2.new(input.Position.X, input.Position.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragData.dragging then
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - dragData.startMouse
            mainFrame.Position = UDim2.new(0, dragData.startPos.X.Offset + delta.X, 0, dragData.startPos.Y.Offset + delta.Y)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragData.dragging = false
    end
end)

print("🧠 Smart Action Observer is running!")
