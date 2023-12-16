local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera

local function findClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Team ~= player.Team then
            local distance = (otherPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                closestPlayer = otherPlayer
                shortestDistance = distance
            end
        end
    end

    return closestPlayer
end

local function cameraLock()
    local closestPlayer = findClosestPlayer()

    if closestPlayer then
        local targetPosition = closestPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0) -- Adjust the Y component as needed
        player.Character:MoveTo(targetPosition)
        camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Character.HumanoidRootPart.Position)
    end
end

local connection
connection = runService.RenderStepped:Connect(function()
    cameraLock()
end)

player.CharacterAdded:Connect(function()
    connection:Disconnect()
end)
