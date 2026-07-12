-- =====================================================
-- 🧠 SMART ACTION OBSERVER (MOBILE OPTIMIZED)
-- بيراقب كل حركة بناء وأحداث في الماب
-- تم تحسين السحب ليعمل باللمس (Delta / Executor)
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- =====================================================
-- وظيفة السحب الاحترافية (تعمل 100% على اللمس)
-- =====================================================
local function makeDraggable(topBar, gui)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- =====================================================
-- إنشاء الواجهة
-- =====================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SmartObserver"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 380) -- حجم أنسب للهواتف
mainFrame.Position = UDim2.new(0.5, -180, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true -- مهم جداً للموبايل
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- شريط العنوان (منطقة السحب)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

-- تفعيل السحب
makeDraggable(titleBar, mainFrame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 Smart Observer"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 4)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = titleBar

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 35, 0, 25)
clearBtn.Position = UDim2.new(1, -80, 0.5, -12)
clearBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
clearBtn.Text = "🗑️"
clearBtn.Parent = titleBar
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -55)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
scroll.ScrollBarThickness = 3
scroll.Parent = mainFrame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 10)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = scroll

-- =====================================================
-- وظيفة إضافة حدث
-- =====================================================
local function addEvent(icon, text, details)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -10, 0, 60)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    card.Parent = scroll
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Position = UDim2.new(0, 5, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextSize = 16
    iconLabel.Parent = card

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -80, 0, 20)
    textLabel.Position = UDim2.new(0, 40, 0, 5)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 10
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = card

    local detailLabel = Instance.new("TextLabel")
    detailLabel.Size = UDim2.new(1, -80, 0, 25)
    detailLabel.Position = UDim2.new(0, 40, 0, 25)
    detailLabel.Text = details
    detailLabel.TextColor3 = Color3.fromRGB(160, 180, 200)
    detailLabel.Font = Enum.Font.Gotham
    detailLabel.TextSize = 8
    detailLabel.TextWrapped = true
    detailLabel.TextXAlignment = Enum.TextXAlignment.Left
    detailLabel.BackgroundTransparency = 1
    detailLabel.Parent = card

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 35, 0, 30)
    copyBtn.Position = UDim2.new(1, -40, 0.5, -15)
    copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    copyBtn.Text = "📋"
    copyBtn.Parent = card
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(details)
        copyBtn.Text = "✅"
        task.wait(1)
        copyBtn.Text = "📋"
    end)

    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

-- =====================================================
-- مراقبة الأحداث (معدلة للموبايل والكمبيوتر)
-- =====================================================

-- لمس الشاشة (موبايل)
UserInputService.TouchStarted:Connect(function(input, processed)
    if not processed then
        local ray = Camera:ScreenPointToRay(input.Position.X, input.Position.Y)
        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000)
        if result and result.Instance then
            addEvent("👆", "Touch Detected", result.Instance:GetFullName())
        end
    end
end)

-- ضغط الماوس (كمبيوتر)
Mouse.Button1Down:Connect(function()
    if Mouse.Target then
        addEvent("🖱️", "Mouse Click", Mouse.Target:GetFullName())
    end
end)

-- مراقبة البناء
workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") then
        addEvent("🔨", "Object Added", obj:GetFullName())
    end
end)

workspace.DescendantRemoving:Connect(function(obj)
    if obj:IsA("BasePart") then
        addEvent("💥", "Object Removed", obj:GetFullName())
    end
end)

-- تنظيف وإغلاق
clearBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(scroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

print("🧠 Smart Action Observer Mobile Ready!")
