local StatusBar = {}


function StatusBar:new(o)
  o=o or {
    players = {one = {}, two = {}},
    color = {0,255,255},
    height = 100,
    position = {x = 0,
                y}
  }
  setmetatable(o, self)
  self.__index=self
  return o
end

function StatusBar:load(pA, pB)
  self.position.y = love.graphics.getHeight() - self.height
  self.font = love.graphics.newFont("courbd.ttf")
  self.players.one = pA
  self.players.two = pB
end

function StatusBar:draw()
  love.graphics.setColor(self.color)
  love.graphics.setLineWidth(10)
  love.graphics.rectangle("line", self.position.x, self.position.y, love.graphics.getWidth(), self.height)
  love.graphics.setLineWidth(1)
  love.graphics.setFont(self.font)
  love.graphics.print("Player: " .. self.players.one.name, self.position.x + 20, self.position.y+20)
  love.graphics.print("Score: " .. self.players.one.score, self.position.x + 20, self.position.y+30)
  love.graphics.printf("Player: " .. self.players.two.name, self.position.x + 520, self.position.y+20, 200, "right")
  love.graphics.printf("Score: " .. self.players.two.score, self.position.x + 520, self.position.y+30, 200, "right")
end

function StatusBar:update(dt)

end

return StatusBar
