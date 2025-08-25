local MouseManager = {}
MouseManager.__index = MouseManager

local mouseClicked = false
local mouseClickedX = 0
local mouseClickedY = 0
local crosshair, clickSound
local crosshairWidth, crosshairHeight = 64, 64

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

function MouseManager:new(o)
    o = o or {}
    setmetatable(o, self)
    return o
end

function MouseManager:load()
    love.mouse.setVisible(false)
    clickSound = love.audio.newSource('assets/laser.mp3', 'static')
    crosshair = love.graphics.newImage('assets/crosshair.png')
end

function MouseManager:update()
    if mouseClicked then
        self.gameManager:updateClicks(mouseClickedX, mouseClickedY)
    end
end

function MouseManager:draw()
    local x = love.mouse.getX()
    local y = love.mouse.getY()

    love.graphics.setColor(1,1,0)
    love.graphics.draw(crosshair, x - crosshairWidth / 2, y - crosshairHeight / 2, math.deg(0), 1, 1)
end

return MouseManager
