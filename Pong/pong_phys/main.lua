local stg = require "../stage1"
function love.load()
  stage = stg:new()
  stage:load()
end

function love.draw()
  stage:draw()
end

function love.update(dt)
  stage:update(dt)
end
