local Block = require "block"

local blockManager = {}
blockManager.__index = blockManager

local SCREEN_HEIGHT = 600

local blockArray = {}
local counter = nil

local spawnTimer = 0
local spawnIntervalMin = 0.5
local spawnInervalMax = 2.5
local spawnInterval = math.random(spawnIntervalMin, spawnInervalMax)

local function spawnBlock(counterRef)
    local newBlock = Block:new({SCREEN_HEIGHT = SCREEN_HEIGHT, counter = counterRef})
    table.insert(blockArray, newBlock)
end

function blockManager:load(counterClass)
    counter = counterClass
    spawnBlock(counter)
end

function blockManager:updateTimer(dt)
    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        spawnBlock(counter)
        spawnTimer = spawnTimer - spawnInterval
        spawnInterval = math.random(spawnIntervalMin, spawnInervalMax)
    end
end

function blockManager:updateBlockPositions(dt)
    for _, blockInstance in ipairs(blockArray) do
        blockInstance:update(dt)

        if blockInstance.yPosition > SCREEN_HEIGHT then
            blockInstance:markForRemoval()
        end
    end
end

function blockManager:removeMarkedBlocks()
    -- Looping backwards to avoid accidentally skipping an element
    for i = #blockArray, 1, -1 do
        if blockArray[i].isMarkedForRemoval then
            table.remove(blockArray, i)
        end
    end
end

function blockManager:drawBlocks()
    for _, blockInstance in ipairs(blockArray) do
        blockInstance:draw()
    end
end

return blockManager
