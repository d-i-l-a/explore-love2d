local current_color = { 1, 1, 1, 1 }
local current_x = 0
local current_y = 0

local up = false
local left = false
local down = false
local right = false

love.draw = function()
    update_coords()
    -- Initialize the square with the default color (white)
    love.graphics.setColor(current_color)
    -- Draw the square
    love.graphics.rectangle('fill', 100 + current_x, 100 + current_y, 100, 100)
end

update_coords = function()
    if up then
        current_y = current_y - 10
    end
    if left then
        current_x = current_x - 10
    end
    if down then
        current_y = current_y + 10
    end
    if right then
        current_x = current_x + 10
    end
end

love.keypressed = function(pressed_key)
    print('key was pressed:', pressed_key)

    if pressed_key == 'w' then
        up = true
    elseif pressed_key == 'a' then
        left = true
    elseif pressed_key == 's' then
        down = true
    elseif pressed_key == 'd' then
        right = true
    elseif pressed_key == 'escape' then
        love.event.quit()
    end
end

love.keyreleased = function(released_key)
    print('key was release:', released_key)

    if released_key == 'w' then
        up = false
    elseif released_key == 'a' then
        left = false
    elseif released_key == 's' then
        down = false
    elseif released_key == 'd' then
        right = false
    end
end
