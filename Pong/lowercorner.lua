lower_corner = {
  x = 0;
  y = 595; 
  w = 800;
  h = 5;
  color = {255,0,0};
  
  load = function(self)
    world:add(self, self.x, self.y, self.w, self.h);
  end;
  
  draw = function(self)
    love.graphics.setColor(self.color);
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h);
  end;
  
  
  update = function(self, dt)
   
  end;
  
};