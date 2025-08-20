Block = {}
Block.__index = Block

local GRAVITY = 450
local SCREEN_WIDTH = 800
local WIDTH = 1
local HEIGHT = 1
local blockSprites = {}

local function randomXPos(spriteWidth)
    return math.random(0, SCREEN_WIDTH - spriteWidth)
end

local function randomSprite()
    local i = math.random(1, 15)
    return string.format("assets/%i.png", i)
end

function Block:new(o)
    o = o or {}
    o.yPosition = 0
    o.counter = o.counter
    o.SCREEN_HEIGHT = o.SCREEN_HEIGHT
    o.sprite = o.sprite or randomSprite()

    if not blockSprites[o.sprite] then
        blockSprites[o.sprite] = love.graphics.newImage(o.sprite)
    end

    o.spriteWidth = blockSprites[o.sprite]:getWidth()
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
    love.graphics.draw(blockSprites[self.sprite], self.xPosition, self.yPosition, math.deg(0), WIDTH, HEIGHT)
end

return Block
