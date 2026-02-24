--[[ 
    KEV HUB: SUPREME COMBAT & VISUALS SYSTEM (V2.0)
    Signatures: COBRA | KEV | TRAVEX
    Features: Team-Check, Friend-Check, Smooth Aimbot, Box ESP, Tracers.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// نظام الحماية والتهيئة (Signatures)
local Signatures = {"COBRA", "KEV", "TRAVEX"}
print("Authorized by: " .. table.concat(Signatures, " & "))

--// إعدادات النظام (Settings)
local Settings = {
    Aimbot = {Enabled = false, Smoothness = 0.25, FOV = 150, TargetPart = "Head", TeamCheck = true, FriendCheck = true},
    ESP = {Enabled = false, Boxes = true, Tracers = true, TeamCheck = true, Names = true}
}

--// واجهة المستخدم الاحترافية (Animated UI)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 280)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", MainFrame)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 255, 255)
UIStroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "KEV HUB: ELITE"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

--// دالة صنع مفاتيح الـ ON/OFF المتحركة
local function CreateToggle(name, pos, callback)
    local ToggleBtn = Instance.new("TextButton", MainFrame)
    ToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
    ToggleBtn.Position = UDim2.new(0.1, 0, 0, pos)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleBtn.Text = name .. ": OFF"
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.Font = Enum.Font.GothamSemibold
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.Text = name .. (state and ": ON" or ": OFF")
        ToggleBtn.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback(state)
        
        -- أنيميشن بسيط عند الضغط
        ToggleBtn:TweenSize(UDim2.new(0.75, 0, 0, 32), "Out", "Quad", 0.1, true)
        task.wait(0.1)
        ToggleBtn:TweenSize(UDim2.new(0.8, 0, 0, 35), "Out", "Quad", 0.1, true)
    end)
end

--// محرك الـ Aimbot (التمييز بين الفرق والأصدقاء)
local function GetClosestPlayer()
    local target = nil
    local dist = Settings.Aimbot.FOV
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            -- Team Check
            if Settings.Aimbot.TeamCheck and v.Team == LocalPlayer.Team then continue end
            -- Friend Check (Contacts)
            if Settings.Aimbot.FriendCheck and LocalPlayer:IsFriendsWith(v.UserId) then continue end
            
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character[Settings.Aimbot.TargetPart].Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            
            if onScreen and magnitude < dist then
                target = v
                dist = magnitude
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if Settings.Aimbot.Enabled then
        local target = GetClosestPlayer()
        if target then
            local targetPos = target.Character[Settings.Aimbot.TargetPart].Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), Settings.Aimbot.Smoothness)
        end
    end
end)

--// محرك الـ ESP (صناديق وخطوط)
local function CreateESP(plr)
    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.fromRGB(0, 255, 255)
    Box.Thickness = 1
    Box.Filled = false
    
    RunService.RenderStepped:Connect(function()
        if Settings.ESP.Enabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if Settings.ESP.TeamCheck and plr.Team == LocalPlayer.Team then Box.Visible = false return end
            
            local rootPos, onScreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if onScreen then
                Box.Size = Vector2.new(1000/rootPos.Z, 1500/rootPos.Z)
                Box.Position = Vector2.new(rootPos.X - Box.Size.X/2, rootPos.Y - Box.Size.Y/2)
                Box.Visible = true
            else
                Box.Visible = false
            end
        else
            Box.Visible = false
        end
    end)
end

-- تفعيل الـ ESP لكل لاعب يدخل
for _, v in pairs(Players:GetPlayers()) do if v ~= LocalPlayer then CreateESP(v) end end
Players.PlayerAdded:Connect(function(v) CreateESP(v) end)

--// تشغيل الأزرار
CreateToggle("AIMBOT", 50, function(s) Settings.Aimbot.Enabled = s end)
CreateToggle("ESP BOX", 95, function(s) Settings.ESP.Enabled = s end)
CreateToggle("TEAM CHECK", 140, function(s) 
    Settings.Aimbot.TeamCheck = s 
    Settings.ESP.TeamCheck = s 
end)
CreateToggle("FRIEND SAFE", 185, function(s) Settings.Aimbot.FriendCheck = s end)

--// نظام الحماية وتوقيع المطورين
local Watermark = Instance.new("TextLabel", MainFrame)
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -25)
Watermark.Text = "TRAVEX x KEV x COBRA"
Watermark.TextColor3 = Color3.fromRGB(100, 100, 100)
Watermark.TextSize = 10
Watermark.BackgroundTransparency = 1
