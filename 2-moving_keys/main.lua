function love.load()
	idle=true
	timer=0.1
	max=8
	iteration=1
	direction="right"
	sprite ={}
	sprite.player=love.graphics.newImage("assets/char.bmp")
	sprite.x = 50
	sprite.y = 50
	quads={}
	quads['left'] ={}
	quads["right"] ={}
	quads["up"] = love.graphics.newQuad(0, 120, 60, 60, sprite.player:getDimensions())
	quads["down"] = love.graphics.newQuad(60, 120, 60, 60, sprite.player:getDimensions())
	for i=1,8 do
		quads["left"][i]=love.graphics.newQuad((i-1)*60, 0, 60, 60, sprite.player:getDimensions())
		quads["right"][i]=love.graphics.newQuad((i-1)*60, 60, 60, 60, sprite.player:getDimensions())
	end
end

function love.draw()
	if direction == "left" or direction == "right" then 
		love.graphics.draw(sprite.player, quads[direction][iteration], sprite.x, sprite.y)
	end
	if direction == "up" or direction == "down" then
		love.graphics.draw(sprite.player, quads[direction], sprite.x, sprite.y)
	end
end

function love.update(dt)
	if idle==false then
		timer = timer + dt
		if (timer > 0.2) then
			timer=0.1
			iteration=iteration+1
			if love.keyboard.isDown('right') then 
				sprite.x = sprite.x+5
			end
			if love.keyboard.isDown("left") then
				sprite.x = sprite.x-5
			end
			if love.keyboard.isDown("down") then
				sprite.y = sprite.y + 5*dt
			end
			if love.keyboard.isDown("up") then
				sprite.y = sprite.y - 5*dt
			end
			if iteration > max then
				iteration = 1
			end
		end
	end
end

function love.keypressed(key)
	if quads[key] then
		direction = key
		idle=false
	end
end

function love.keyreleased(key)
	if quads[key] and direction == key then
		idle=true
		iteration=1
	end
end
