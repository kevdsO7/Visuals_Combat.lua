--[[ 
    KEV HUB: ULTIMATE TROLL & UTILITY MODULE (V3.0)
    Signatures: COBRA | KEV | TRAVEX
    Features: Admin Detector, Player Fling, Walk on Water, Anti-AFK.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

--// 1. نظام "رادار الأدمن" (Admin Detector)
-- بيطردك من الماب أول ما أدمن يدخل عشان حسابك ما يتبندش
local function DetectAdmins()
    for _, v in pairs(Players:GetPlayers()) do
        if v:GetRankInGroup(123456) >= 200 or v.UserId == 12345 then -- غير الأرقام دي لمجموعات أدمن الماب
            LocalPlayer:Kick("KEV HUB PROTECTOR: Admin Detected! (" .. v.Name .. ")")
        end
    end
end
Players.PlayerAdded:Connect(function(v)
    DetectAdmins()
end)

--// 2. نظام "الطرد الجسدي" (The Fling)
-- ده بيخليك تلف بسرعة جنونية، وأول ما تلمس حد بيطير برا الخريطة
local Flinging = false
local function ToggleFling(state)
    Flinging = state
    task.spawn(function()
        while Flinging do
            local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                Root.Velocity = Vector3.new(0, 5000, 0) -- قوة الدفع للأعلى
                Root.RotVelocity = Vector3.new(0, 5000, 0) -- الدوران السريع
            end
            task.wait(0.1)
        end
    end)
end

--// 3. المشي على الماء والجاذبية (Physics Hacks)
local function WalkOnWater()
    local Part = Instance.new("Part", workspace)
    Part.Name = "KevWaterFloor"
    Part.Size = Vector3.new(1000, 1, 1000)
    Part.Transparency = 1
    Part.Anchored = true
    
    RunService.RenderStepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Part.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position.X, 0, LocalPlayer.Character.HumanoidRootPart.Position.Z)
        end
    end)
end

--// 4. واجهة التحكم (Mini Utility UI)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Menu = Instance.new("Frame", ScreenGui)
Menu.Size = UDim2.new(0, 200, 0, 150)
Menu.Position = UDim2.new(0, 50, 0.5, -75)
Menu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local UIStroke = Instance.new("UIStroke", Menu)
UIStroke.Color = Color3.fromRGB(255, 0, 255) -- لون بنفسجي نيون

local function CreateMiniBtn(text, pos, callback)
    local b = Instance.new("TextButton", Menu)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback)
end

CreateMiniBtn("FLING OTHERS", 10, function() ToggleFling(not Flinging) end)
CreateMiniBtn("WATER WALK", 45, function() WalkOnWater() end)
CreateMiniBtn("ANTI-AFK", 80, function()
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    print("KEV: Anti-AFK Active!")
end)

--// 5. نظام "الاختفاء من الرادار" (Invisible Profile)
local function Invisibility()
    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 1
        end
    end
end
CreateMiniBtn("GO INVISIBLE", 115, Invisibility)
