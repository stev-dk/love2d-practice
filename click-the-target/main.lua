local GM = require "gameManager"

local gameManager

local mouseClicked = false
local mouseClickedX = 0
local mouseClickedY = 0

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    gameManager = GM:new()
end

function love.update(dt)
    gameManager:updateAddCircles(dt)
    gameManager:updateCircleTimers(dt)
    gameManager:updateRemoveCircles()
    if mouseClicked then gameManager:updateClicks(mouseClickedX, mouseClickedY) end
end

function love.draw()
    gameManager:draw()
end

function love.mousepressed(x,y, button)
    if button == 1 then
        mouseClicked = true
        mouseClickedX = x
        mouseClickedY = y
    end
end

function love.mousereleased(_,_, button)
    if button == 1 then
        mouseClicked = false
    end
end
