local function begin_contact_callback(a, b, coll)
    local objectA = a:getUserData()
    local objectB = b:getUserData()
    print(objectA.type, objectB.type)

    -- Check if a bullet hits a structure
    if objectA and objectB then
        if objectA.type == "bullet" and objectB.type == "destroyable" then
            objectA:destroy()
            objectB:destroy()
        elseif objectA.type == "destroyable" and objectB.type == "bullet" then
            objectB:destroy()
            objectA:destroy()
        end
    end
end

local end_contact_callback = function()
end

local pre_solve_callback = function()
end

local post_solve_callback = function()
end


local world = love.physics.newWorld(0, 0)

world:setCallbacks(
    begin_contact_callback,
    end_contact_callback,
    pre_solve_callback,
    post_solve_callback
)

return world
