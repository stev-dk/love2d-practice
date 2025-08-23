local LivesManager = {}
LivesManager.__index = LivesManager

function LivesManager:new(o)
    o = o or {}
    o.lives = 100
    setmetatable(o, self)
    return o
end

function LivesManager:loseLife()
    self.lives = self.lives - 1
end

function LivesManager:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.print(string.format("Lives: %i", self.lives), 15, 15)
end

return LivesManager
