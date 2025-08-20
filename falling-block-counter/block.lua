Block = {}
Block.__index = Block

local GRAVITY = 128
local SCREEN_WIDTH = 800
local WIDTH = 1
local HEIGHT = 1
local RGB_MIN = 50 -- higher value will results in more vibrant colours
local RGB_MAX = 255

local blockSprites = {}

local function randomXPos(spriteWidth)
    return math.random(0, SCREEN_WIDTH - spriteWidth)
end

local function randomSprite()
    local i = math.random(1, 15)
    return string.format("assets/%i.png", i)
end

local function randomColors()
    return {math.random(RGB_MIN,RGB_MAX), math.random(RGB_MIN,RGB_MAX), math.random(RGB_MIN,RGB_MAX)}
end

function Block:new(o)
    o = o or {}
    o.counter = o.counter
    o.SCREEN_HEIGHT = o.SCREEN_HEIGHT
    o.sprite = o.sprite or randomSprite()
    o.colors = randomColors()

    if not blockSprites[o.sprite] then
        blockSprites[o.sprite] = love.graphics.newImage(o.sprite)
    end

    o.spriteHeight = -blockSprites[o.sprite]:getHeight()
    o.spriteWidth = blockSprites[o.sprite]:getWidth()

    o.yPosition = o.spriteHeight
    o.xPosition = randomXPos(o.spriteWidth)

    setmetatable(o, self)
    return o
end

function Block:update(dt)
    self.yPosition = self.yPosition + (GRAVITY * dt)
    if self.yPosition > self.SCREEN_HEIGHT then
        self.counter:addCount()
    end
end

function Block:draw()
    love.graphics.setColor(love.math.colorFromBytes(self.colors))
    love.graphics.draw(blockSprites[self.sprite], self.xPosition, self.yPosition, math.deg(0), WIDTH, HEIGHT)

    -- DEBUG
    love.graphics.print(string.format('R: %i, G: %i, B: %i', self.colors[1], self.colors[2], self.colors[3]), self.xPosition, self.yPosition - 32)
    -- DEBUG
end

return Block
