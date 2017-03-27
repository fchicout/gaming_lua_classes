local Stage = {}

local padClass = require "pad"
local ballClass = require "ball"
local statusBarClass = require "statusbar"
local inspect = require "inspect"

function Stage:new(o)
  o=o or {
    world = love.physics.newWorld(0, 0, true),
    playerA = padClass:new(),
    playerB = padClass:new(),
    ball = ballClass:new(),
    statusBar = statusBarClass:new(),
    xBorderHeight=5,
    yBorderWidth=5
  }
  setmetatable(o, self)
  self.__index=self
  return o
end

function Stage:load()
  love.physics.setMeter(32)
  self.playerA.side = "left"
  self.playerA.name = "Jogador A"
  self.playerA.statusBarSize = self.statusBar.height
  self.playerA:load(self.world)
  self.playerB.side = "right"
  self.playerB.name = "Jogador B"
  self.playerB.statusBarSize = self.statusBar.height
  self.playerB:load(self.world)
  self.ball.position.x = love.graphics.getWidth()/2
  self.ball.position.y = (love.graphics.getHeight()-self.statusBar.height)/2
  self.ball:load(self.world)
  self.statusBar:load(self.playerA, self.playerB)


  upBorder = {x = 0, y=0, width=love.graphics.getWidth(), height=self.xBorderHeight, idleColor={255,255,255}, collisionColor={} }
  upBorder.body = love.physics.newBody(self.world, upBorder.x+upBorder.width/2, upBorder.y+upBorder.height/2, "static")
  upBorder.shape = love.physics.newRectangleShape(upBorder.width, upBorder.height)
  upBorder.fixture = love.physics.newFixture(upBorder.body, upBorder.shape)
  upBorder.body:setLinearDamping(0)
  upBorder.fixture:setRestitution(1)
  upBorder.fixture:setFriction(1)

  downBorder = {x = 0, y=love.graphics.getHeight()-self.xBorderHeight-self.statusBar.height, width=love.graphics.getWidth(), height=self.xBorderHeight, idleColor={255,255,255}, collisionColor={}}
  downBorder.body = love.physics.newBody(self.world, downBorder.x+downBorder.width/2, downBorder.y+downBorder.height/2, "static")
  downBorder.shape = love.physics.newRectangleShape(downBorder.width, downBorder.height)
  downBorder.fixture = love.physics.newFixture(downBorder.body, downBorder.shape)
  downBorder.body:setLinearDamping(0)
  downBorder.fixture:setRestitution(1)
  downBorder.fixture:setFriction(1)

  leftBorder = {x = 0, y=self.xBorderHeight, width=self.yBorderWidth, height=love.graphics.getHeight()-2*self.xBorderHeight-self.statusBar.height, idleColor={255,255,255}, collisionColor={}}
  leftBorder.body = love.physics.newBody(self.world, leftBorder.x+leftBorder.width/2, leftBorder.y+leftBorder.height/2, "static")
  leftBorder.shape = love.physics.newRectangleShape(leftBorder.width, leftBorder.height)
  leftBorder.fixture = love.physics.newFixture(leftBorder.body, leftBorder.shape)
  leftBorder.body:setLinearDamping(0)
  leftBorder.fixture:setRestitution(1)
  leftBorder.fixture:setFriction(1)

  rightBorder = {x = love.graphics.getWidth()-self.yBorderWidth, y = self.xBorderHeight, width=self.yBorderWidth, height=love.graphics.getHeight()-2*self.xBorderHeight-self.statusBar.height, idleColor={255,255,255}, collisionColor={}}
  rightBorder.body = love.physics.newBody(self.world, rightBorder.x+rightBorder.width/2, rightBorder.y+rightBorder.height/2, "static")
  rightBorder.shape = love.physics.newRectangleShape(rightBorder.width, rightBorder.height)
  rightBorder.fixture = love.physics.newFixture(rightBorder.body, rightBorder.shape)
  rightBorder.body:setLinearDamping(0)
  rightBorder.fixture:setRestitution(1)
  rightBorder.fixture:setFriction(1)
end

function Stage:draw()
  self.playerA:draw()
  self.playerB:draw()
  self.ball:draw()
  self.statusBar:draw()
  -- self:debug(self.playerA)
  love.graphics.setColor(upBorder.idleColor)
  love.graphics.rectangle("fill", upBorder.x, upBorder.y, upBorder.width, upBorder.height)
  love.graphics.setColor(downBorder.idleColor)
  love.graphics.rectangle("fill", downBorder.x, downBorder.y, downBorder.width, downBorder.height)
  love.graphics.setColor(leftBorder.idleColor)
  love.graphics.rectangle("fill", leftBorder.x, leftBorder.y, leftBorder.width, leftBorder.height)
  love.graphics.setColor(rightBorder.idleColor)
  love.graphics.rectangle("fill", rightBorder.x, rightBorder.y, rightBorder.width, rightBorder.height)
end

function Stage:update(dt)
  self.playerA:update(dt)
  self.playerB:update(dt)
  self.ball:update(dt)
  self.world:update(dt)
end

function Stage:debug(obj)
  love.graphics.setColor({255,255,255})
  love.graphics.print(inspect(obj))
end

return Stage
