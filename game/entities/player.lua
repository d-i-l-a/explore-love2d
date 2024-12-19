-- entities/triangle.lua

local world = require('world')

local player = {}
player.body = love.physics.newBody(world, 200, 200, 'dynamic')
player.body.setMass(player.body, 0)
player.shape = love.physics.newPolygonShape(100, 100, 200, 100, 100, 200, 200, 200)
player.fixture = love.physics.newFixture(player.body, player.shape)
--triangle.fixture:setRestitution(0.75)

speed = 200


player.update = function(dt)
    local new_x = player.body:getX()
    local new_y = player.body:getY()
    if love.keyboard.isDown("w") then
        new_y = new_y - (dt * speed)
    end
    if love.keyboard.isDown("a") then
        new_x = new_x - (dt * speed)
    end
    if love.keyboard.isDown("s") then
        new_y = new_y + (dt * speed)
    end
    if love.keyboard.isDown("d") then
        new_x = new_x + (dt * speed)
    end

    player.body:setPosition(new_x, new_y)
end

return player
