
loader = require("atl/Loader")
loader.path = "maps/"

function love.load()
	map= loader.load("map.tmx")
end


function love.draw()
	map:draw()
end
