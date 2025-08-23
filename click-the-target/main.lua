local GM = require "gameManager"

local gameManager

local mouseClicked = false
local mouseClickedX = 0
local mouseClickedY = 0
local crosshair, clickSound
local crosshairWidth, crosshairHeight = 64, 64

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    gameManager = GM:new()

    -- hide default mouse cursor
    love.mouse.setVisible(false)
    clickSound = love.audio.newSource('laser.mp3', 'static')
    crosshair = love.graphics.newImage('crosshair.png')
end

function love.update(dt)
    gameManager:updateAddCircles(dt)
    gameManager:updateCircleTimers(dt)
    gameManager:updateRemoveCircles()
    if mouseClicked then gameManager:updateClicks(mouseClickedX, mouseClickedY) end
end

function love.draw()
    gameManager:draw()
    love.graphics.setColor(1,1,0)
    love.graphics.draw(crosshair, love.mouse.getX() - crosshairWidth / 2, love.mouse.getY() - crosshairHeight / 2, math.deg(0), 1, 1)
end

function love.mousepressed(x,y, button)
    if button == 1 then
        mouseClicked = true
        mouseClickedX = x
        mouseClickedY = y
        clickSound:stop()
        clickSound:play()
    end
end

function love.mousereleased(_,_, button)
    if button == 1 then
        mouseClicked = false
    end
end
