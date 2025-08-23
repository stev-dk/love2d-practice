local ScoreManager = {}
ScoreManager.__index = ScoreManager

local score = 0

function ScoreManager:addScore()
    score = score + 1
end

function ScoreManager:draw()
    love.graphics.print(string.format("Score: %i", score), 15, 30)
end

return ScoreManager
