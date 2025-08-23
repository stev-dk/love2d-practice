local ScoreManager = {}
ScoreManager.__index = ScoreManager

function ScoreManager:new(o)
    o = o or {}
    o.score = 0
    setmetatable(o, self)
    return o
end

function ScoreManager:addScore()
    self.score = self.score + 1
end

function ScoreManager:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.print(string.format("Score: %i", self.score), 15, 30)
end

return ScoreManager
