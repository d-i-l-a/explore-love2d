-- entities/triangle.lua

local world = require('world')

local player = {}
local screen_width, screen_height = love.graphics.getDimensions()

player.body = love.physics.newBody(world, screen_width / 2, screen_height / 2, 'dynamic')
player.body:setMass(0)
player.body:setFixedRotation(true)
player.shape = love.physics.newRectangleShape(50, 50)
player.fixture = love.physics.newFixture(player.body, player.shape)

UP = 0
UP_RIGHT = 1
UP_LEFT = 2
LEFT = 3
RIGHT = 4
DOWN = 5
DOWN_RIGHT = 6
DOWN_LEFT =  7


local up_texture = love.graphics.newImage("pngs/up.png")
local left_texture = love.graphics.newImage("pngs/left.png")
local right_texture = love.graphics.newImage("pngs/right.png")
local down_texture = love.graphics.newImage("pngs/down.png")

local rate_of_change = 10000
player.current_orientation = RIGHT


local orientation_map = {
    [UP] = up_texture,
    [UP_RIGHT] = right_texture,
    [UP_LEFT] = left_texture,
    [LEFT] = left_texture,
    [RIGHT] = right_texture,
    [DOWN] = down_texture,
    [DOWN_RIGHT] = right_texture,
    [DOWN_LEFT] = left_texture
}

local orientation_string_map = {
    [UP] = "UP",
    [UP_RIGHT] = "UP_RIGHT",
    [UP_LEFT] = "UP_LEFT",
    [LEFT] = "LEFT",
    [RIGHT] = "RIGHT",
    [DOWN] = "DOWN",
    [DOWN_RIGHT] = "DOWN_RIGHT",
    [DOWN_LEFT] = "DOWN_LEFT"
}

local gun = require('entities.weapons.gun.gun')
player.weapons = {
    gun
}

player.draw = function()
    love.graphics.draw(orientation_map[player.current_orientation], player.body:getPosition())
    player.weapons[1].draw()
end



player.update = function(dt)
    player.move(dt)
    player.update_orientation()
    player.update_weapons(dt)
end

player.move = function(dt)
   local vx, vy = 0, 0
    local speed = dt * rate_of_change
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

player.update_orientation = function()
    if love.keyboard.isDown("w") and not love.keyboard.isDown("a") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") then
        player.current_orientation = UP
    end
    if love.keyboard.isDown("w") and love.keyboard.isDown("a") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") then
        player.current_orientation = UP_LEFT
    end
    if love.keyboard.isDown("w") and love.keyboard.isDown("d") and not love.keyboard.isDown("s") and not love.keyboard.isDown("a") then
        player.current_orientation = UP_RIGHT
    end
    if love.keyboard.isDown("a") and not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") then
        player.current_orientation = LEFT
    end
    if love.keyboard.isDown("s") and not love.keyboard.isDown("w") and not love.keyboard.isDown("a") and not love.keyboard.isDown("d") then
        player.current_orientation = DOWN
    end
    if love.keyboard.isDown("s") and love.keyboard.isDown("a") and not love.keyboard.isDown("w") and not love.keyboard.isDown("d") then
        player.current_orientation = DOWN_LEFT
    end
    if love.keyboard.isDown("s") and love.keyboard.isDown("d") and not love.keyboard.isDown("a") and not love.keyboard.isDown("w") then
        player.current_orientation = DOWN_RIGHT
    end
    if love.keyboard.isDown("d") and not love.keyboard.isDown("w") and not love.keyboard.isDown("a") and not love.keyboard.isDown("s") then
        player.current_orientation = RIGHT
    end
end

player.update_weapons = function(dt)
    player.weapons[1].update(dt, player)
end

return player