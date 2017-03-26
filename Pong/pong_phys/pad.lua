local Pad = {}

function Pad:new(o)
  o=o or {
    name = "", side = "left",
    offset = {x = 20, y = 0},
    statusBarSize = 0,
    position = {x = 10, y = 0},
    velocity = {x = 0, y = 100},
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
    self.keys = {up = "w", down="s", start="p"}
  end
  self.position.y = (love.graphics.getHeight()-self.statusBarSize)/2
  self.body = love.physics.newBody(world, self.position.x+(self.size.width/2), self.position.y+(self.size.height/2), "static")
  self.shape = love.physics.newRectangleShape(self.size.width, self.size.height)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.body:setFixedRotation(true)
  self.fixture:setRestitution(1)
end

function Pad:draw()
  love.graphics.setColor(self.color)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Pad:update(dt)
  if love.keyboard.isDown(self.keys.up) then
    self.position.y = self.position.y - self.velocity.y*dt
    self.body:setLinearVelocity(self.velocity.x, -self.velocity.y)
  end
  if love.keyboard.isDown(self.keys.down) then
    self.position.y = self.position.y + self.velocity.y*dt
    self.body:setLinearVelocity(self.velocity.x, self.velocity.y)
  end
  self.body:setY(self.position.y)
  self.body:setLinearVelocity(0,0)
end


return Pad
