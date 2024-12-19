local current_color = { 1, 1, 1, 1 }
local current_x = 0
local current_y = 0

local up = false
local left = false
local down = false
local right = false

local speed = 500

love.draw = function()
    -- Initialize the square with the default color (white)
    love.graphics.setColor(current_color)
    -- Draw the square
    love.graphics.rectangle('fill', 100 + current_x, 100 + current_y, 40, 40)
end


love.keypressed = function(pressed_key)
    if pressed_key == 'escape' then
        love.event.quit()
    end
end

love.update = function(dt)
    if love.keyboard.isDown("w") then
        current_y = current_y - (dt * speed)
    end
    if love.keyboard.isDown("a") then
        current_x = current_x - (dt * speed)
    end
    if love.keyboard.isDown("s") then
        current_y = current_y + (dt * speed)
    end
    if love.keyboard.isDown("d") then
        current_x = current_x + (dt * speed)
    end
end
