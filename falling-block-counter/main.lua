local blockManager = require "blockManager"
local Counter = require "Counter"

local counter

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    counter = Counter:new()
    blockManager:load(counter)
end

function love.update(dt)
    blockManager:updateTimer(dt)
    blockManager:updateBlockPositions(dt)
    blockManager:removeMarkedBlocks()
end

function love.draw()
    blockManager:drawBlocks()

    counter:draw()
end
