local Bullet = {}
Bullet.__index = Bullet

local world = require('world')

function Bullet.new(x, y, angle, speed, radius, lifetime)
    local self = setmetatable({}, Bullet)

    self.type = "bullet"
    self.destroyed = false

    -- Physics properties
    self.body = love.physics.newBody(world, x, y, "dynamic")      -- Dynamic body
    self.shape = love.physics.newCircleShape(radius or 10)        -- Circle shape
    self.fixture = love.physics.newFixture(self.body, self.shape) -- Attach the shape to the body
    self.fixture:setUserData(self)                                -- Store a reference to the bullet itself in the fixture

    -- Set collision category and mask
    self.fixture:setCategory(2) -- Category 2: Bullets
    self.fixture:setMask(1)     -- Exclude Category 1: Player
    self.fixture:setMask(2)     -- Exclude Category 2: Bullet

    -- Initial velocity
    local vx = speed * math.cos(angle)
    local vy = speed * math.sin(angle)
    self.body:setLinearVelocity(vx, vy)

    -- Entity properties
    self.lifetime = lifetime or 5 -- Lifetime in seconds
    self.age = 0                  -- Current age
    return self
end

function Bullet:update(dt)
    self.age = self.age + dt -- Increment age
end

function Bullet:isExpired()
    return self.age >= self.lifetime
end

function Bullet:draw()
    if not self.destroyed then
        love.graphics.setColor(0, 1, 0) -- Green
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    end
end

function Bullet:destroy()
    if not self.destroyed then
        self.body:destroy()
        self.destroyed = true
    end
end

return Bullet
