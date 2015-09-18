require 'util'
bump = require 'bump'
require 'field'
require 'padLeft'
require 'padRight'
require 'ball'


function love.load()
  world = bump.newWorld();
  padL:load();
  padR:load();
  ball:load();
  lower_corner:load();
  upper_corner:load();
end

function love.draw()
  padL:draw();
  padR:draw();
  ball:draw();
  lower_corner:draw();
  upper_corner:draw();
end

function love.update(dt)
  padL:update(dt);
  padR:update(dt);
  ball:update(dt);
  lower_corner:update(dt);
  upper_corner:update(dt);
end

