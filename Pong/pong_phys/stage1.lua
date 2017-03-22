local Stage = {}

local padClass = require "pad"
local inspect = require "inspect"

function Stage:new(o)
  o=o or {
    world = love.physics.newWorld(0, 0, true),
    playerA = padClass:new(),
    playerB = padClass:new()
  }
  setmetatable(o, self)
  self.__index=self
  return o
end

function Stage:load()
  self.playerA.side = "left"
  self.playerA:load(self.world)
  self.playerB.side = "right"
  self.playerB:load(self.world)
end

function Stage:draw()
  self.playerA:draw()
  love.graphics.setColor({255,255,255})
  love.graphics.print(inspect(self.playerA))
  love.graphics.print(self.playerA.body:getY(), 400, 0)
  self.playerB:draw()
end

function Stage:update(dt)
  self.playerA:update(dt)
  self.playerB:update(dt)
end

return Stage
