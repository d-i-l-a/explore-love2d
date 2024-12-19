local gun = {}

cooldown_in_sec = 1
d_total = 0
gun.update = function(dt, player)
    d_total = d_total + dt
    if d_total >= cooldown_in_sec then
        d_total = d_total - cooldown_in_sec
        gun.shoot(player)
    end

    -- Update the position of each circle
    for _, circle in ipairs(circles) do
        circle.x = circle.x + circle.vx * dt
        circle.y = circle.y + circle.vy * dt
    end
end

circles = {}

-- Parameters for velocity and angle
speed = 100

local orientation_degree_map = {
    [UP] = 270,
    [UP_RIGHT] = 315,
    [UP_LEFT] = 225,
    [LEFT] = 180,
    [RIGHT] = 0,
    [DOWN] = 90,
    [DOWN_RIGHT] = 45,
    [DOWN_LEFT] = 135
}





gun.shoot = function(player)
    print('shoot')
    local circle = {}
    local px, py = player.body:getPosition()
    circle.x = px -- Starting x position (center of the screen)
    circle.y = py -- Starting y position (center of the screen)
    circle.radius = 10 -- Radius of the circle
    local angle = math.rad(orientation_degree_map[player.current_orientation]) -- 45 degrees in radians
    circle.vx = speed * math.cos(angle) -- Velocity in the x-direction
    circle.vy = speed * math.sin(angle) -- Velocity in the y-direction

    -- Add the new circle to the circles table
    table.insert(circles, circle)
end


gun.draw = function()
    love.graphics.setColor(0, 1, 0) -- Green
    for _, circle in ipairs(circles) do
        love.graphics.circle("fill", circle.x, circle.y, circle.radius)
    end
end


return gun