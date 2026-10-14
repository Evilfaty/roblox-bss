
-- CrezHub BSS | v0.1
-- Standalone UI prototype

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local old
pcall(function()
    old = CoreGui:FindFirstChild("CrezHubBSS")
    if old then old:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "CrezHubBSS"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parented = pcall(function()
    gui.Parent = CoreGui
end)

if not parented then
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local C = {
    bg = Color3.fromRGB(15, 16, 21),
    panel = Color3.fromRGB(23, 25, 33),
    item = Color3.fromRGB(33, 36, 47),
    accent = Color3.fromRGB(139, 92, 246),
    text = Color3.fromRGB(240, 240, 248),
    muted = Color3.fromRGB(148, 151, 169),
    red = Color3.fromRGB(235, 85, 100),
}

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, obj)
end

local window = make("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(560, 370),
    Position = UDim2.new(0.5, -280, 0.5, -185),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
}, gui)
round(window, 12)

make("UIStroke", {
    Color = Color3.fromRGB(52, 54, 69),
    Transparency = 0.15,
    Thickness = 1,
}, window)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, window)
round(header, 12)

make("TextLabel", {
    Position = UDim2.fromOffset(16, 0),
    Size = UDim2.new(1, -100, 1, 0),
    BackgroundTransparency = 1,
    Text = "CREZ HUB  /  BEE SWARM",
    TextColor3 = C.text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local close = make("TextButton", {
    Position = UDim2.new(1, -40, 0, 9),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = C.item,
    Text = "X",
    TextColor3 = C.text,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
}, header)
round(close, 8)

local sidebar = make("Frame", {
    Position = UDim2.fromOffset(10, 58),
    Size = UDim2.new(0, 140, 1, -68),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, window)
round(sidebar, 9)

make("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
}, sidebar)

make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)

local content = make("Frame", {
    Position = UDim2.fromOffset(160, 58),
    Size = UDim2.new(1, -170, 1, -68),
    BackgroundTransparency = 1,
}, window)

local title = make("TextLabel", {
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1,
    Text = "Home",
    TextColor3 = C.text,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local subtitle = make("TextLabel", {
    Position = UDim2.fromOffset(0, 30),
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    Text = "BSS module hub initialized.",
    TextColor3 = C.muted,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local body = make("ScrollingFrame", {
    Position = UDim2.fromOffset(0, 60),
    Size = UDim2.new(1, 0, 1, -60),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.accent,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, body)

local function clearBody()
    for _, child in ipairs(body:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function card(name, desc, order)
    local f = make("Frame", {
        Name = name,
        Size = UDim2.new(1, -5, 0, 65),
        BackgroundColor3 = C.panel,
        BorderSizePixel = 0,
        LayoutOrder = order or 1,
    }, body)
    round(f, 8)

    make("TextLabel", {
        Position = UDim2.fromOffset(12, 8),
        Size = UDim2.new(1, -24, 0, 22),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = C.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, f)

    make("TextLabel", {
        Position = UDim2.fromOffset(12, 32),
        Size = UDim2.new(1, -24, 0, 22),
        BackgroundTransparency = 1,
        Text = desc,
        TextColor3 = C.muted,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
    }, f)

    return f
end

local pages = {
    Home = {
        "Overview",
        function()
            card("CrezHub BSS", "Standalone executor UI prototype", 1)
            card("Status", "GUI loaded successfully", 2)
            card("Modules", "Ready for feature integration", 3)
        end,
    },
    Farming = {
        "Farming modules",
        function()
            card("Auto Farm", "Module placeholder — inactive", 1)
            card("Convert Pollen", "Module placeholder — inactive", 2)
            card("Planters", "Module placeholder — inactive", 3)
        end,
    },
    Player = {
        "Player options",
        function()
            card("Movement", "Module placeholder — inactive", 1)
            card("Tools", "Module placeholder — inactive", 2)
        end,
    },
    Settings = {
        "Hub configuration",
        function()
            card("RightShift", "Toggle window visibility", 1)
            card("Version", "0.1.0", 2)
        end,
    },
}

local function openPage(name)
    local page = pages[name]
    if not page then return end

    title.Text = name
    subtitle.Text = page[1]
    clearBody()
    page[2]()

    for _, child in ipairs(sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 =
                child.Name == name and C.accent or C.item
        end
    end
end

for i, name in ipairs({"Home", "Farming", "Player", "Settings"}) do
    local b = make("TextButton", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = C.item,
        Text = name,
        TextColor3 = C.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        LayoutOrder = i,
    }, sidebar)
    round(b, 7)
    b.Activated:Connect(function()
        openPage(name)
    end)
end

-- Drag window
local dragging, dragStart, startPos = false, nil, nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = window.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        window.Visible = not window.Visible
    end
end)

openPage("Home")
