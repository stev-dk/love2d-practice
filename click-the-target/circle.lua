local Circle = {}
Circle.__index = Circle

local SCREEN_WIDTH = love.graphics.getWidth()
local SCREEN_HEIGHT = love.graphics.getHeight()
local TIME_ALIVE = 1

local types = { good = "good", bad = "bad" }
local cachedSprites = {}

local function randomPosition(radius)
    local x, y
    x = math.random(0, SCREEN_WIDTH - radius*2)
    y = math.random(0, SCREEN_HEIGHT - radius*2)
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
    o.sprite = 'assets/rock.png'

    if cachedSprites[o.sprite] == nil then
        cachedSprites[o.sprite] = love.graphics.newImage(o.sprite)
    end

    local hitboxAdjustment = 35
    local radius = (cachedSprites[o.sprite]:getWidth() - hitboxAdjustment) / 2
    o.size = 0.5 -- random from -0.3 to 0.5?
    o.radius = radius * o.size
    o.x, o.y = randomPosition(o.radius)
    o.type = setRandomType()
    o.hasTimedOut = false
    o.timeLeft = TIME_ALIVE
    o.rotation = 0

    o.centerX = o.x + (cachedSprites[o.sprite]:getWidth() / 2) * o.size
    o.centerY = o.y + (cachedSprites[o.sprite]:getHeight() / 2) * o.size
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
        love.graphics.draw(cachedSprites[self.sprite], self.x, self.y, math.deg(self.rotation), self.size, self.size)
    end
end

return Circle
