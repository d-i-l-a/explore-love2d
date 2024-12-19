-- entities/triangle.lua

local world = require('world')

local player = {}
player.body = love.physics.newBody(world, 200, 200, 'dynamic')
player.body.setMass(player.body, 0)
player.body:setFixedRotation(true)
player.shape = love.physics.newPolygonShape(100, 100, 200, 100, 100, 200, 200, 200)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.fixture:setRestitution(0.00)

rate_of_change = 20000

player.draw = function()
  love.graphics.polygon('line', player.body:getWorldPoints(player.shape:getPoints()))
end

player.update = function(dt)
    local vx, vy = 0, 0
     speed = dt * rate_of_change
    if love.keyboard.isDown("w") then
       vy = vy - speed
    end
    if love.keyboard.isDown("a") then
        vx = vx - speed
    end
    if love.keyboard.isDown("s") then
        vy = vy + speed
    end
    if love.keyboard.isDown("d") then
        vx = vx + speed
    end
    player.body:setLinearVelocity(vx, vy)
end

return player
