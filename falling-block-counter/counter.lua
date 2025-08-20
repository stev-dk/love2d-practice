Counter = {}
Counter.__index = Counter

local count = 0

function Counter:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Counter:addCount()
    count = count +1
end

function Counter:draw()
    love.graphics.print(count, 0, 0)
end

return Counter
