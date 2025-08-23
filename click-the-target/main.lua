local GM = require "gameManager"
local MM = require "mouseManager"
local gameManager
local mouseManager

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    gameManager = GM:new()
    mouseManager = MM:new({gameManager = gameManager})
    mouseManager:load()
    gameManager:load()
end

function love.update(dt)
    gameManager:updateAddCircles(dt)
    gameManager:updateCircleTimers(dt)
    gameManager:updateRemoveCircles()
    mouseManager:update()
end

function love.draw()
    gameManager:draw()
    mouseManager:draw()
end
