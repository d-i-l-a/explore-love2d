-- Declare circle entity
local circle = {}
local speed = 400 -- Velocity in pixels per second
local angle = math.rad(45) -- Angle in radians (e.g., 45 degrees)

function love.load()
    -- Initialize the circle entity
    circle.x = 400 -- Initial x position
    circle.y = 300 -- Initial y position
    circle.radius = 20 -- Radius of the circle

    -- Calculate the velocity components from the angle and speed
    circle.vx = speed * math.cos(angle) -- Velocity in the x-direction
    circle.vy = speed * math.sin(angle) -- Velocity in the y-direction
end

function love.update(dt)
    -- Update the position of the circle based on its velocity
    circle.x = circle.x + circle.vx * dt
    circle.y = circle.y + circle.vy * dt
end

function love.draw()
    -- Draw the circle at the updated position
    love.graphics.setColor(1, 0, 0) -- Set the color to red
    love.graphics.circle("fill", circle.x, circle.y, circle.radius)
end