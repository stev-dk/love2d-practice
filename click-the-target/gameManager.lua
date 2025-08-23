local Circle = require "circle"
local LivesManager = require "livesManager"
local ScoreManager = require "scoreManager"

local GameManager = {}
GameManager.__index = GameManager

local circleArray = {}

local CIRCLE_RADIUS = 15

local spawnTimer = 0
local spawnIntervalMin = 1.5
local spawnIntervalMax = 2.5
local spawnInterval = math.random(spawnIntervalMin, spawnIntervalMax)

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

    LivesManager:draw()
    ScoreManager:draw()
end

function GameManager:addCircle(newCircle)
    table.insert(circleArray, newCircle)
end

function GameManager:updateRemoveCircles()
    for i = #circleArray, 1, -1 do
        if circleArray[i].hasTimedOut then
            table.remove(circleArray, i)
            LivesManager:loseLife()
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
            ScoreManager:addScore()
            table.remove(circleArray, i)
        end
    end
end

return GameManager
