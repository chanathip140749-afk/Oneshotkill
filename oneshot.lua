spawn(function()
    local killQueue = {}

    while task.wait() do
        pcall(function()
            if getgenv().Config["Instant Kill"] then
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                sethiddenproperty(player, "SimulationRadius", 112412400000)
                sethiddenproperty(player, "MaxSimulationRadius", 112412400000)

                local Den = {}

                if getgenv().Config["Folder Mon"] == "nil" then
                    -- only get models directly under workspace
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
                            table.insert(Den, v:FindFirstChildOfClass("Humanoid"))
                        end
                    end
                else
                    -- search inside the folder
                    local folder = game.Workspace:FindFirstChild(getgenv().Config["Folder Mon"])
                    if folder then
                        for _, v in pairs(folder:GetDescendants()) do
                            if v:IsA("Humanoid") then
                                table.insert(Den, v)
                            end
                        end
                    end
                end

                for _, v in pairs(Den) do
                    local hrp = v.Parent:FindFirstChild("HumanoidRootPart")
                    local plrhrp = character:FindFirstChild("HumanoidRootPart")

                    if hrp and plrhrp and (hrp.Position - plrhrp.Position).Magnitude <= getgenv().Config["Radius"] then
                        if v.Health < v.MaxHealth and not killQueue[v] then
                            killQueue[v] = true
                            task.delay(3, function()
                                if v and v.Health > 0 then
                                    v.Health = 0
                                end
                                killQueue[v] = nil
                            end)
                        end
                    end
                end
            end
        end)
    end
end)
