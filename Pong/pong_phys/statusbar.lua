local StatusBar = {}


function StatusBar:new(o)
  o=o or {
    color = {0,255,255},
    height = 100,
    position = {x = 0,
                y}
  }
  setmetatable(o, self)
  self.__index=self
  return o
end

function StatusBar:load()
  self.position.y = love.graphics.getHeight() - self.height
end

function StatusBar:draw()
  love.graphics.setColor(self.color)
  love.graphics.setLineWidth(10)
  love.graphics.rectangle("line", self.position.x, self.position.y, love.graphics.getWidth(), self.height)
  love.graphics.setLineWidth(1)
end

function StatusBar:update(dt)

end

return StatusBar
