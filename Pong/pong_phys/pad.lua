local Pad = {}

function Pad:new(o)
  o=o or {
    name = "", side = "left",
    offset = {x = 20, y = 0},
    position = {x =10, y = love.graphics.getHeight()/2},
    velocity = {x = 0, y = 70},
    size = {width = 30, height = 120},
    keys = {up = "up", down = "down", start="enter"},
    color = {0,0,255},
    goal = 0
  }
  setmetatable(o, self)
  self.__index=self
  return o
end

function Pad:load(world)
  if self.side == "left" then
    self.color = {0,0,255}
    self.position.x = self.offset.x+self.position.x
  elseif self.side == "right" then
    self.color = {255,0,0}
    self.position.x = love.graphics.getWidth()-(self.offset.x+self.position.x+self.size.width)
  end
  self.body = love.physics.newBody(world, self.position.x, self.position.y, "dynamic")
  self.shape = love.physics.newRectangleShape(self.size.width, self.size.height)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Pad:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.width, self.size.height)
end

function Pad:update(dt)
  if love.keyboard.isDown(self.keys.up) then
    -- self.position.y = self.position.y - self.velocity.y*dt
    self.body:setLinearVelocity(self.velocity.x, -self.velocity.y)
  end
  if love.keyboard.isDown(self.keys.down) then
    -- self.position.y = self.position.y + self.velocity.y*dt
    self.body:setLinearVelocity(self.velocity.x, self.velocity.y)
  end
end


return Pad
