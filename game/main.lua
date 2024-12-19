local world = require('world')
local player = require('entities/player')
local boundary = require('entities.boundary')

love.load = function ()
    -- Screen dimensions
    screen_width, screen_height = love.graphics.getDimensions()
end

love.draw = function ()
    local px, py = player.body:getPosition()
    love.graphics.push()
    love.graphics.translate(screen_width / 2 - px, screen_height / 2 - py)


    player:draw()
    boundary:draw()

    love.graphics.pop()
end

local paused = false

local key_map = {
  escape = function()
    love.event.quit()
  end,
  space = function()
    paused = not paused
  end
}

love.keypressed = function(pressed_key)
  if key_map[pressed_key] then
    key_map[pressed_key]()
  end
end

love.update = function(dt)
  if not paused then
    world:update(dt)
    player.update(dt)
  end
end
