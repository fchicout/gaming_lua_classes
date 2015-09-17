padL = {
  x = 10;
  y = 10;
  w = 40;
  h = 150;
  color = {255,255,255};
  key_up = "up";
  key_down = "down";
  speed = 300;
  update = function(self, dt)
    local dy = 0.0;
    if love.keyboard.isDown(self.key_up) then
      dy = -self.speed*dt;
    end
    if love.keyboard.isDown(self.key_down) then
      dy = self.speed*dt;
    end
    
    if dy ~= 0 then
      --self.y = (self.y + dy);
      local colisions;
      self.x, self.y, colisions, len = world:move(self, self.x, self.y + dy);
    end
  end
  
};