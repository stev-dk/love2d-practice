local LivesManager = {}
LivesManager.__index = LivesManager

local lives = 100

local function loseLife()
    lives = lives - 1
end

function LivesManager:loseLife()
    loseLife()
end

function LivesManager:draw()
    love.graphics.print(string.format("Lives: %i", lives), 15, 15)
end

return LivesManager
