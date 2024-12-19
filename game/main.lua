local world = require('world')
local player = require('entities/player')
local Structure = require('entities.structure')

structures = {}

love.load = function()
  screen_width, screen_height = love.graphics.getDimensions()
  table.insert(structures, Structure.new(100, 100, 70))
  table.insert(structures, Structure.new(100, 200, 50))
  table.insert(structures, Structure.new(100, 300, 100))
  table.insert(structures, Structure.new(100, 400, 70))
end

love.draw = function()
  love.graphics.clear(1, 1, 1)   -- White background (R=1, G=1, B=1)
  local px, py = player.body:getPosition()
  love.graphics.push()
  love.graphics.translate(screen_width / 2 - px, screen_height / 2 - py)


  player:draw()
  for _, structure in ipairs(structures) do
    structure:draw()
  end
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
