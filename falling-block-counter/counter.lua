local Counter = {}
Counter.__index = Counter

function Counter:new(o)
    o = o or {}
    o.count = o.count or 0
    setmetatable(o, self)
    return o
end

function Counter:addCount()
    self.count = self.count +1
end

function Counter:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.print(self.count, 0, 0)
end

return Counter
