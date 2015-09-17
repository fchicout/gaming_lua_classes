require 'util'
bump = require 'bump'
--require 'field'
require 'padLeft'
require 'padRight'
require 'ball'


function love.load()
  world = bump.newWorld();
  padL:load();
  padR:load();
  ball:load();
end

function love.draw()
  padL:draw();
  padR:draw();
  ball:draw();
end

function love.update(dt)
  padL:update(dt);
  padR:update(dt);
  ball:update(dt);
end

