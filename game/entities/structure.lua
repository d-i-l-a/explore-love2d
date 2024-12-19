local Structure = {}
Structure.__index = Structure

local world = require('world')

function Structure.new(x, y, size)
    local self = setmetatable({}, Structure)

    self.type = "destroyable"
    self.destroyed = false
    self.size = size

    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(size, size)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.fixture:setCategory(3) -- Category 3: Env

    return self
end

function Structure:draw()
    if not self.destroyed then
        love.graphics.setColor(1, 0, 0) -- Red
        love.graphics.rectangle("fill", self.body:getX(), self.body:getY(), self.size, self.size)
    end
end

function Structure:destroy()
    if not self.destroyed then
        self.body:destroy()
        self.destroyed = true
    end
end

return Structure
