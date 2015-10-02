ball = {
  x = 400; -- TODO: It must start in a true random fashion into a defined square centered at the center of the field;
  y = 300; -- TODO: It must start in a true random fashion into a defined square centered at the center of the field;
  radius = 15;
  vx = 100;
  vy = 100;
  bounciness = 1;
  color = {0,255,0};
  
  
  load = function(self)
    world:add(self, self.x-self.radius, self.y-self.radius, self.radius*2, self.radius*2);
  end;
  
  draw = function(self)
    love.graphics.setColor(self.color);
    love.graphics.circle("fill", self.x+self.radius, self.y+self.radius, self.radius);
--    love.graphics.rectangle("line", self.x, self.y, self.radius*2, self.radius*2); -- DEBUG mark
  end;
  
  update = function(self, dt)
    
    if dx ~= 0.0 or dy ~= 0.0 then
      local colisions;
      self.x, self.y, colisions, len = world:move(self, self.x + self.vx*dt, self.y + self.vy*dt, colisionFilter);
      if len > 0 then
        if (colisions[1].normal.x < 0 and self.vx > 0) or (colisions[1].normal.x > 0 and self.vx < 0) then
          self.vx = -self.vx * self.bounciness
        end;
        if (colisions[1].normal.y < 0 and self.vy > 0) or (colisions[1].normal.y > 0 and self.vy < 0) then
          self.vy = -self.vy * self.bounciness
        end;
      end;
    end;
  end;
}