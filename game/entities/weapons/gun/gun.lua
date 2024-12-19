-- Gun.lua
local Gun = {}
Gun.__index = Gun

Bullet = require('entities.weapons.gun.bullet')

function Gun.new(cooldown, speed)
    local self = setmetatable({}, Gun)
    self.cooldown_in_sec = cooldown or 1
    self.speed = speed or 100
    self.d_total = 0
    self.bullets = {}
    return self
end

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

function Gun:update(dt, player)
    self.d_total = self.d_total + dt
    if self.d_total >= self.cooldown_in_sec then
        self.d_total = self.d_total - self.cooldown_in_sec
        self:shoot(player)
    end

    for i = #self.bullets, 1, -1 do
        local bullet = self.bullets[i]
        bullet:update(dt)
        if bullet:isExpired() then
            bullet:destroy() -- Clean up physics resources
            table.remove(self.bullets, i)
        end
    end
end

function Gun:shoot(player)
    local px, py = player.body:getPosition()
    local angle = math.rad(orientation_degree_map[player.current_orientation]) -- Direction in radians
    local bullet = Bullet.new(px, py, angle, self.speed)
    table.insert(self.bullets, bullet)
end

function Gun:draw()
    love.graphics.setColor(0, 1, 0) -- Green
    for _, bullet in ipairs(self.bullets) do
        bullet:draw()
    end
end

return Gun
