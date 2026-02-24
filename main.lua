--[[
    KEV HUB OFFICIAL LOADER (V1.0)
    Developed by: KEV | COBRA | TRAVEX
    Description: Modular Script Loader for Elite Features.
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local LoadingBar = Instance.new("Frame")
local Fill = Instance.new("Frame")

-- إعدادات واجهة التحميل (Intro)
ScreenGui.Parent = game.CoreGui
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 255, 255)
UIStroke.Thickness = 2

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "KEV HUB IS LOADING..."
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

Status.Parent = MainFrame
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 50)
Status.Text = "Initializing Modules..."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextSize = 14
Status.BackgroundTransparency = 1

LoadingBar.Parent = MainFrame
LoadingBar.Size = UDim2.new(0.8, 0, 0, 10)
LoadingBar.Position = UDim2.new(0.1, 0, 0, 90)
LoadingBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

Fill.Parent = LoadingBar
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)

-- دالة التحميل الوهمية (لأعطاء شكل احترافي)
local function LoadProgress(percent, text)
    Status.Text = text
    Fill:TweenSize(UDim2.new(percent, 0, 1, 0), "Out", "Quad", 0.5, true)
    task.wait(0.7)
end

-- [[ عملية سحب السكربتات الفرعية ]] --
LoadProgress(0.3, "Fetching Visuals & Combat...")
-- استدعاء ملف الأيمبوت والـ ESP
loadstring(game:HttpGet("رابط_ملف_Visuals_Combat.lua_الخام_هنا"))()

LoadProgress(0.7, "Fetching Troll & Utilities...")
-- استدعاء ملف المقالب والأدوات
loadstring(game:HttpGet("رابط_ملف_Troll_Utils.lua_الخام_هنا"))()

LoadProgress(1, "Kev Hub Ready!")

task.wait(0.5)
MainFrame:TweenPosition(UDim2.new(0.5, -150, -0.5, 0), "In", "Back", 0.5, true)
task.wait(0.5)
ScreenGui:Destroy()

-- رسالة ترحيب نهائية
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Successfully Loaded!";
    Text = "Kev Hub V1.0 - Use it wisely!";
    Duration = 5;
})
