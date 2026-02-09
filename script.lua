local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com')))()
local Window = OrionLib:MakeWindow({Name = "RealHub | Steal a Brainrot", HidePremium = false, SaveConfig = true, ConfigFolder = "BrainrotConfig"})

-- Сервисы
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Вкладка: Фарм
local FarmTab = Window:MakeTab({Name = "Авто-Фарм", Icon = "rbxassetid://4483362458", PremiumOnly = false})

FarmTab:AddToggle({
    Name = "Instant Steal (Авто-кража)",
    Default = false,
    Callback = function(Value)
        _G.AutoSteal = Value
        task.spawn(function()
            while _G.AutoSteal do
                -- Прямое обращение к событиям кражи (основные ивенты SAB)
                local event = ReplicatedStorage:FindFirstChild("StealEvent") or ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("Steal")
                if event then
                    event:FireServer()
                end
                task.wait(0.1)
            end
        end)
    end    
})

-- Вкладка: Игрок
local PlayerTab = Window:MakeTab({Name = "Игрок", Icon = "rbxassetid://4483345998", PremiumOnly = false})

PlayerTab:AddSlider({
    Name = "Скорость бега",
    Min = 16, Max = 300, Default = 16, Color = Color3.fromRGB(0,255,100),
    Increment = 1, ValueName = "Speed",
    Callback = function(Value) 
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = Value 
        end
    end    
})

PlayerTab:AddToggle({
    Name = "Бесконечный прыжок",
    Default = false,
    Callback = function(Value)
        _G.InfJump = Value
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump then
                Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
})

-- Вкладка: Визуалы (ESP)
local VisualTab = Window:MakeTab({Name = "Визуалы", Icon = "rbxassetid://4483345998", PremiumOnly = false})

VisualTab:AddToggle({
    Name = "Подсветка игроков (ESP)",
    Default = false,
    Callback = function(Value)
        _G.ESP = Value
        while _G.ESP do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= Player and v.Character and not v.Character:FindFirstChild("Highlight") then
                    local hi = Instance.new("Highlight", v.Character)
                    hi.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
            task.wait(1)
            if not _G.ESP then
                for _, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("Highlight") then
                        v.Character.Highlight:Destroy()
                    end
                end
            end
        end
    end
})

-- Вкладка: Сервер
local MiscTab = Window:MakeTab({Name = "Разное", Icon = "rbxassetid://4483345998", PremiumOnly = false})

MiscTab:AddButton({
    Name = "Удалить эффекты (Anti-Disco)",
    Callback = function()
        local bg = Player.PlayerGui:FindFirstChild("ScreenEffects")
        if bg then bg:Destroy() end
        print("Эффекты удалены")
    end
})

MiscTab:AddButton({
    Name = "Server Hop",
    Callback = function()
        local ts = game:GetService("TeleportService")
        ts:Teleport(game.PlaceId, Player)
    end
})

OrionLib:Init()
