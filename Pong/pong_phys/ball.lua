local Ball = {}


function Ball:new(o)
  o=o or {
    position = {x = 0,
                y = 0 },
    velocity = {x = 5*math.random(-150, 150),
                y = 5*math.random(-150, 150)},
    radius=20
  }
  setmetatable(o, self)
  self.__index=self
  return o
end


function Ball:load(world)
  self.body = love.physics.newBody(world, self.position.x, self.position.y, "dynamic")
  self.shape = love.physics.newCircleShape(self.radius)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.body:setLinearVelocity(self.velocity.x, self.velocity.y)
  self.body:setFixedRotation(false)
  self.body:setLinearDamping(0)
  self.fixture:setRestitution(1)
end

function Ball:draw()
  love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
  love.graphics.print("v=" .. self.velocity.x .. ", " .. self.velocity.y, 100,100)
  love.graphics.print("||v||=" .. (math.sqrt(math.pow(self.velocity.x, 2) + math.pow(self.velocity.y, 2))), 100,200)
end

function Ball:update(dt)
  local x, y = self.body:getLinearVelocity()
  self.velocity.x = x
  self.velocity.y = y
end

return Ball
