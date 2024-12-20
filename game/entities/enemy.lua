local Enemy = {}

Enemy.__index = Enemy

local world = require('world')
local player = require('entities/player')

function Enemy.new(x, y, size, onDestroy)
    local self = setmetatable({}, Enemy
   )

    self.type = "destroyable"
    self.destroyed = false
    self.size = size
    self.onDestroy = onDestroy

    self.body = love.physics.newBody(world, x, y, 'dynamic')

    self.shape = love.physics.newRectangleShape(size, size)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.fixture:setCategory(3) -- Category 3: Env

    return self
end



function Enemy:update()
    local px, py = player.body:getPosition()
    local vx, vy = calculateLinearVelocity(px, py, self.body:getX(), self.body:getY(), 10);
    self.body:setLinearVelocity(vx, vy)
end

function Enemy:draw()
    if not self.destroyed then
        love.graphics.setColor(1, 0, 0) -- Red
        love.graphics.rectangle("fill", self.body:getX(), self.body:getY(), self.size, self.size)
    end
end

function Enemy:destroy()
    if not self.destroyed then
        self.body:destroy()
        self.destroyed = true
        self.onDestroy(self)
    end
end

function calculateLinearVelocity(x, y, x1, y1, speed)
    -- Calculate the difference in positions
    local dx = x - x1
    local dy = y - y1

    -- Calculate the distance between the points
    local distance = math.sqrt(dx^2 + dy^2)

    -- If the distance is very small, return zero velocity
    if distance < 0.001 then
        return 0, 0
    end

    -- Normalize the direction and scale by speed
    local vx = (dx / distance) * speed
    local vy = (dy / distance) * speed

    return vx, vy
end

return Enemy
