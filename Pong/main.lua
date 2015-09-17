require 'util'
bump = require 'bump'
require 'padLeft'
require 'padRight'



ball = {
  x = 300;
  y = 300;
  radius = 15;
  
  }



function love.load()
  world = bump.newWorld();
  world:add(padL, padL.x, padL.y, padL.w, padL.h);
  world:add(padR, padR.x, padR.y, padR.w, padR.h);
  world:add(ball, ball.x-ball.radius, ball.y-ball.radius, ball.radius*2, ball.radius*2);
end

function love.draw()
  love.graphics.setColor(padL.color);
  love.graphics.rectangle("fill", padL.x, padL.y, padL.w, padL.h);
  love.graphics.setColor(padR.color);
  love.graphics.rectangle("fill", padR.x, padR.y, padR.w, padR.h);
  love.graphics.setColor(0,255,0);
  love.graphics.circle("fill", ball.x, ball.y, ball.radius);
end

function love.update(dt)
  padL:update(dt);
  padR:update(dt);
end

