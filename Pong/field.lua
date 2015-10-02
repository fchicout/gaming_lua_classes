require 'util'
bump = require 'bump'
require 'padLeft'
require 'padRight'
require 'ball'
require 'lowercorner'
require 'uppercorner'
require 'leftcorner'
require 'rightcorner'
--require 'surprises' TOBEDONE
--require 'score'  TOBEDONE

field={
  
  load = function ()
    world = bump.newWorld();
    padL:load();
    padR:load();
    ball:load();
    lower_corner:load();
    upper_corner:load();
    left_corner:load();
    right_corner:load();
  end;
  
  draw = function()
    padL:draw();
    padR:draw();
    ball:draw();
    lower_corner:draw();
    upper_corner:draw();
    left_corner:draw();
    right_corner:draw();
  end;
  
  update = function(dt)
    padL:update(dt);
    padR:update(dt);
    ball:update(dt);
    lower_corner:update(dt);
    upper_corner:update(dt);
    left_corner:update(dt);
    right_corner:update(dt);
  end;
  
}

