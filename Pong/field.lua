lower_corner = {
  x = 0;
  y = 595; 
  w = 800;
  h = 5;
  color = {255,255,255};
  
  load = function(self)
    world:add(self, self.x, self.y, self.w, self.h);
  end;
  
  draw = function(self)
    love.graphics.setColor(self.color);
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h);
  end;
  
  
  update = function(self, dt)
    if tableName(self) == 'left_corner' then
      print "Player 1 Did It";
    end
    
    if tableName(self) == 'right_corner' then
      print "Player 2 Did It";
    end
    
  end;
  
};

upper_corner = deepcopy(lower_corner);
upper_corner.y = 0;

left_corner = deepcopy(lower_corner);
left_corner.x = 0;
left_corner.y = 5;
left_corner.w = 590;

