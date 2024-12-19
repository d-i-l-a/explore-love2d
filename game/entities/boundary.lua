local world = require('world')

local boundary = {}
boundary.body = love.physics.newBody(world, 10, 10, 'static')
boundary.body.setMass(boundary.body, 1000)
boundary.shape = love.physics.newRectangleShape(500, 500)
boundary.fixture = love.physics.newFixture(boundary.body, boundary.shape)


boundary.draw = function()
  love.graphics.polygon('line', boundary.body:getWorldPoints(boundary.shape:getPoints()))
end

return boundary