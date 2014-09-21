
function love.draw()
	fullImg = love.graphics.newImage("assets/char.bmp")
	sprite = love.graphics.newQuad(0, 0, 60, 60, fullImg:getDimensions())
	love.graphics.draw(fullImg, sprite, 50, 50)
end
