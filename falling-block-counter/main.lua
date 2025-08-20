local Block = require "block"
local Counter = require "Counter"

local SCREEN_HEIGHT = 600

local blockArray = {}
local counter

local spawnTimer = 0
local spawnIntervalMin = 0.5
local spawnInervalMax = 2.5
local spawnInterval = math.random(spawnIntervalMin, spawnInervalMax)

local function spawnBlock()
    local newBlock = Block:new({SCREEN_HEIGHT = SCREEN_HEIGHT, counter = counter})
    table.insert(blockArray, newBlock)
end

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    counter = Counter:new()
    spawnBlock()
end

function love.update(dt)
    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        spawnBlock()
        spawnTimer = spawnTimer - spawnInterval
        spawnInterval = math.random(spawnIntervalMin, spawnInervalMax)
    end

    for index, blockInstance in ipairs(blockArray) do
        blockInstance:update(dt)

        if blockInstance.yPosition > SCREEN_HEIGHT then
            table.remove(blockArray, index)
        end
    end
end

function love.draw()
    for _, blockInstance in ipairs(blockArray) do
        blockInstance:draw()
    end

    counter:draw()
end
