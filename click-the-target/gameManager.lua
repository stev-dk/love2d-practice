local Circle = require "circle"
local LM = require "livesManager"
local SM = require "scoreManager"

local GameManager = {}
GameManager.__index = GameManager

local circleArray = {}

local GAME_TITLE = "Circle Shooter"
local background
local parallaxPower = 5

local spawnTimer = 0
local spawnIntervalMin = 0.5
local spawnIntervalMax = 0.95
local spawnInterval = math.random(spawnIntervalMin, spawnIntervalMax)

local livesManager = LM:new()
local scoreManager = SM:new()

local function spawnCircle(o)
    local newCircle = Circle:new()
    o:addCircle(newCircle)
end

local function drawParallaxBackgorund()
    local windowHeight = love.graphics.getHeight()
    local windowWidth = love.graphics.getWidth()

    local backgroundShiftX = (background:getWidth() - windowWidth) / 2
    local backgroundShiftY = (background:getHeight() - windowHeight) / 2

    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    local parallaxX = (mouseX - (windowWidth / 2)) / parallaxPower
    local parallaxY = (mouseY - (windowHeight / 2)) / parallaxPower

    love.graphics.draw(background, -backgroundShiftX - parallaxX, -backgroundShiftY - parallaxY, math.deg(0), 1, 1)

    -- DEBUG
    love.graphics.print(string.format("X: %i, Y: %i", love.mouse.getX(), love.mouse.getY()), 15, 50)
    -- DEBUG
end

function GameManager:new(o)
    o = o or {}
    setmetatable(o, self)
    return o
end

function GameManager:load()
    love.window.setTitle(GAME_TITLE)
    background = love.graphics.newImage('assets/space_background.png')
end

function GameManager:updateAddCircles(dt)
    spawnTimer = spawnTimer + dt
    if spawnTimer >= spawnInterval then
        spawnCircle(self)
        spawnTimer = spawnTimer - math.random(spawnIntervalMin, spawnIntervalMax)
    end
end

function GameManager:updateCircleTimers(dt)
    for _, circle in ipairs(circleArray) do
        circle:update(dt)
    end
end

function GameManager:draw()
    drawParallaxBackgorund()

    for _, circle in ipairs(circleArray) do
        circle:draw()
    end

    livesManager:draw()
    scoreManager:draw()
end

function GameManager:addCircle(newCircle)
    table.insert(circleArray, newCircle)
end

function GameManager:updateRemoveCircles()
    for i = #circleArray, 1, -1 do
        local circle = circleArray[i]

        if circle.hasTimedOut then
            table.remove(circleArray, i)
            if circle.type == "good" then
                livesManager:loseLife()
            end
        end
    end
end

function GameManager:updateClicks(mouseX, mouseY)
    for i = #circleArray, 1, -1 do
        local circle = circleArray[i]

        local dx = mouseX - circle.centerX
        local dy = mouseY - circle.centerY
        local distanceSquared = dx * dx + dy * dy

        -- click was inside the circle...
        if distanceSquared <= circle.radius * circle.radius then
            if circle.type == "good" then
                scoreManager:addScore()
            elseif circle.type == "bad" then
                livesManager:loseLife()
            end

            table.remove(circleArray, i)
        end
    end
end

return GameManager
