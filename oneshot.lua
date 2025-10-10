spawn(function()
    local killQueue = {} -- keeps track of mobs waiting to die

    while task.wait() do
        pcall(function()
            if getgenv().Config["Instant Kill"] then
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                sethiddenproperty(player, "SimulationRadius", 112412400000)
                sethiddenproperty(player, "MaxSimulationRadius", 112412400000)

                local Den
                if getgenv().Config["Folder Mon"] == "nil" then
                    Den = game.Workspace:GetDescendants()
                else
                    Den = game.Workspace[getgenv().Config["Folder Mon"]]:GetDescendants()
                end

                for _, v in pairs(Den) do
                    if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
                        local hrp = v.Parent:FindFirstChild("HumanoidRootPart")
                        local plrhrp = character:FindFirstChild("HumanoidRootPart")

                        if hrp and plrhrp and (hrp.Position - plrhrp.Position).Magnitude <= getgenv().Config["Radius"] then
                            -- If mob has been damaged but not already queued for death
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
            end
        end)
    end
end)
