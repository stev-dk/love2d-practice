local Circle = {}
Circle.__index = Circle

local SCREEN_WIDTH = love.graphics.getWidth()
local SCREEN_HEIGHT = love.graphics.getHeight()
local TIME_ALIVE = 1

local types = { good = "good", bad = "bad" }

local function randomPosition(radius)
    local x, y
    x = math.random(radius, SCREEN_WIDTH - radius)
    y = math.random(radius, SCREEN_HEIGHT - radius)
    return x, y
end

local function setRandomType()
    if math.random() > 0.5 then
        return types.good
    else
        return types.bad
    end
end

function Circle:new(o)
    o = o or {}
    o.x, o.y = randomPosition(o.radius)
    o.type = setRandomType()
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
    if self.type == "good" then
        love.graphics.setColor(0,1,0)
    else
        love.graphics.setColor(1,0,0)
    end

    if not self.hasTimedOut then
        love.graphics.circle("fill", self.x, self.y, self.radius)
    end
end

return Circle
