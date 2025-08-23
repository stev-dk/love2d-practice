local Circle = {}
Circle.__index = Circle

local SCREEN_WIDTH = love.graphics.getWidth()
local SCREEN_HEIGHT = love.graphics.getHeight()
local TIME_ALIVE = 5

local function randomPosition(radius)
    local x, y
    x = math.random(0, SCREEN_WIDTH - radius)
    y = math.random(0, SCREEN_HEIGHT - radius)
    return x, y
end

function Circle:new(o)
    o = o or {}
    o.x, o.y = randomPosition(o.radius)
    o.hasTimedOut = false
    o.timeLeft = TIME_ALIVE
    setmetatable(o, self)
    return o
end

function Circle:update(dt)
    self.timeLeft = self.timeLeft - dt
    if self.timeLeft < 0 then
        self.hasTimedOut = true
    end
end

function Circle:draw()
    if not self.hasTimedOut then
        love.graphics.circle("fill", self.x, self.y, self.radius)
    end
end

return Circle
