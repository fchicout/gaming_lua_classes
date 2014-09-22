
loader = require("atl/Loader")
loader.path = "maps/"

function love.load()
	map= loader.load("tilemap.tmx")
end


function love.draw()
	map:draw()
end
