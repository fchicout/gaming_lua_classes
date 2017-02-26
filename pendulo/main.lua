function love.load()
  spikeBall = {
    cx = 200, cy = 200, --chain coords
    angle = 0,
    state = "forward",
    ballImage = love.graphics.newImage("assets/SpikeBall.png"),
    chainImage = love.graphics.newImage("assets/Chain.png")
  }
  spikeBall.bx = spikeBall.cx-(spikeBall.ballImage:getWidth()*0.2)/2
  spikeBall.by = spikeBall.cy+(spikeBall.chainImage:getHeight() - (spikeBall.ballImage:getHeight()*0.2)/2)--ball coords
  spikeBall.radius = spikeBall.chainImage:getHeight() - (spikeBall.ballImage:getHeight()*0.2)/2
end

function love.draw()
  love.graphics.draw(spikeBall.chainImage, spikeBall.cx, spikeBall.cy, spikeBall.angle, 1 , 1, spikeBall.chainImage:getWidth()/2, 0)
  love.graphics.draw(spikeBall.ballImage, spikeBall.bx, spikeBall.by, spikeBall.angle , 0.2, 0.2)
end

function love.update(dt)
  spikeBall.bx = (spikeBall.cx)+(spikeBall.radius*math.cos(spikeBall.angle+math.rad(120)))
  spikeBall.by = (spikeBall.cy)+(spikeBall.radius*math.sin(spikeBall.angle+math.rad(120)))
  if spikeBall.state == "forward" then
    spikeBall.angle = spikeBall.angle - dt
    if spikeBall.angle < -math.pi/3 then
      spikeBall.state = "backward"
    end
  elseif spikeBall.state == "backward" then
    spikeBall.angle = spikeBall.angle + dt
    if spikeBall.angle > math.pi/3 then
      spikeBall.state = "forward"
    end
  end
end
