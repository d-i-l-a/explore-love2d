local Enemy = require('entities.enemy')
local player = require('entities/player')

local enemy_manager = {}
enemy_manager.enemies = {}


enemy_manager.update = function ()
    local px, py = player.body:getPosition()
    if #enemy_manager.enemies < 5 then
        local x, y = randomPositionWithinAnnulus(px, py, 10, 200)
        table.insert(enemy_manager.enemies, Enemy.new(x, y, 50, on_destroy))
    end
    for _, enemy in ipairs(enemy_manager.enemies ) do
    enemy:update()
    end
end

enemy_manager.draw = function()
  for _, enemy in ipairs(enemy_manager.enemies ) do
    enemy:draw()
  end
end

function on_destroy(enemy)
    local position = nil
    for i, v in ipairs(enemy_manager.enemies) do
        if v == enemy then
            position = i
            break
        end
    end

    -- Remove the element if found
    if position then
        table.remove(enemy_manager.enemies, position)
    else
        print("Value not found!")
    end
end


-- Function to generate a random position within a min and max radius
function randomPositionWithinAnnulus(x, y, minRadius, maxRadius)
    -- Generate a random angle in radians (0 to 2 * PI)
    local angle = math.random() * 2 * math.pi
    -- Generate a random distance within the range [minRadius, maxRadius]
    local distance = math.sqrt(math.random() * (maxRadius^2 - minRadius^2) + minRadius^2)
    -- Calculate the new position
    local newX = x + distance * math.cos(angle)
    local newY = y + distance * math.sin(angle)
    return newX, newY
end



return enemy_manager

