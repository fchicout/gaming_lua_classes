ball = {
  x = math.random(200,500);
  y = math.random(200,500);
  radius = 15;
  vx = math.random(200,500);
  vy = math.random(200,500);
  color = {0,255,0};
  
  
  load = function(self)
    world:add(self, self.x-self.radius, self.y-self.radius, self.radius*2, self.radius*2);
  end;
  
  draw = function(self)
    love.graphics.setColor(self.color);
    love.graphics.circle("fill", self.x, self.y, self.radius);
  end;
  
  update = function(self, dt)
    local dx = 0.0;
    local dy = 0.0;
    
    dx = self.vx*dt;
    dy = self.vy*dt;
    
    if dx ~= 0.0 or dy ~= 0.0 then
      local colisions;
      self.x, self.y, colisions, len = world:move(self, self.x + dx, self.y + dy, "bounce");
    end
  end;
}