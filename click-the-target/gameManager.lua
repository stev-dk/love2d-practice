local Circle = require "circle"
local LM = require "livesManager"
local SM = require "scoreManager"

local GameManager = {}
GameManager.__index = GameManager

local circleArray = {}

local CIRCLE_RADIUS = 15

local spawnTimer = 0
local spawnIntervalMin = 0.25
local spawnIntervalMax = 0.85
local spawnInterval = math.random(spawnIntervalMin, spawnIntervalMax)

local livesManager = LM:new()
local scoreManager = SM:new()

local function spawnCircle(o)
    local radius = CIRCLE_RADIUS
    local newCircle = Circle:new({radius = radius})
    o:addCircle(newCircle)
end

function GameManager:new(o)
    o = o or {}
    setmetatable(o, self)
    return o
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

        local dx = mouseX - circle.x
        local dy = mouseY - circle.y
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
