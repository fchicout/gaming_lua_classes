--platformer with TILED
---fetch the audio file from source

BgSound = love.audio.newSource("bgsound.mp3")
--set the volume of the sound
BgSound:setVolume(0.75)
--set the pitch level

--play the sound, you can also use shorthand BgSound:play()
love.audio.play(BgSound)

--here we make the sound static
HitSound = love.audio.newSource("hit.wav", "static")
--set volume and pitch
HitSound:setVolume(0.75)



PickupSound = love.audio.newSource("pickup.wav", "static")
PickupSound:setVolume(0.75)



local loader = require ("Advanced-Tiled-Loader/Loader")


bg = love.graphics.newImage("morebise.png")
bump = require "bump"
anim8 = require "anim8"


loader.path = "maps/"

bump.initialize(50)
local lifebar = 3
local score = 100
drawCollideboxes = false

function love.load()
	gamestate = "menu"
	love.graphics.setBackgroundColor(252, 252, 252)
	ButtonSpawn(200, 200, "START GAME", "start")
	ButtonSpawn(200, 300, "QUIT GAME", "quit")
	GameoverSpawn(70, 150, "GAME OVER")
	medium = love.graphics.newFont(30)
-- load the level and bind the variable map

	LoadTileMap("tilemap.tmx")
end

button = {}
playbutton = {}
function ButtonSpawn(x, y, text, id)
	table.insert(button, {x=x, y=y, text=text, id=id, mouseover=false})
end
function GameoverSpawn(x, y, text)
	table.insert(playbutton, {x=x, y=y, text=text, mouseover=false})
end
function playbuttonDraw()
	for i, v in ipairs(playbutton) do
---if mouse is not on button, the color should be black
if v.mousover == false then
	love.graphics.setColor(252,252,252)
end
---if mouse is on button

if v.mousover == true then
	love.graphics.setColor(0,252,252)
end

	love.graphics.setFont(medium)
	love.graphics.print(v.text, v.x, v.y)
end
end
function ButtonDraw()
	for i, v in ipairs(button) do
---if mouse is not on button, the color should be black

	love.graphics.setColor(0,0,0)

---if mouse is on button



	love.graphics.setFont(medium)
	love.graphics.print(v.text, v.x, v.y)
end
end

function ButtonClick(x, y)
	for i, v in ipairs(button) do
---if the mouse is within the button
	if x > v.x and x < v.x +  medium:getWidth(v.text) and y > v.y and y < v.y+medium:getHeight() then
---if the id of the button clicked is quit, then exit game

	if v.id == "quit" then
		love.event.push("quit")
	end
---if the id of the button clicked is Start, set gamestate = “playing”
	if v.id == "start" then
		gamestate = "isplaying"
	end
	end
	end
end
function playbuttonClick(x,y)
	for i, v in ipairs(playbutton) do
---if the mouse is within the button
	if x > v.x and x < v.x +  medium:getWidth(v.text) and y > v.y and y < v.y+medium:getHeight() then
---if the id of the button clicked is quit, then exit game

		gamestate = "isplaying"

	end
	end
end
----if the mouse is clicked at certain coordinates x,y

function love.mousepressed(x,y)
---be sure we are in the menu game state

if gamestate == "menu" then

		ButtonClick(x,y)

elseif gamestate == "gameover" then

		playbuttonClick(x,y)

end
end
function MouseCheck()
	for i, v in ipairs(button) do
---if the mouse is within the button
	if mousex > v.x and mousex < v.x + medium:getWidth(v.text) and mousey > v.y and mousey < v.y + medium:getHeight() then
v.mouseover = true
else
v.mouseover = false
	end
	end
	for i, v in ipairs(playbutton) do
---if the mouse is within the button
	if mousex > v.x and mousex < v.x + medium:getWidth(v.text) and mousey > v.y and mousey < v.y + medium:getHeight() then
v.mouseover = true
else
v.mouseover = false
	end
	end
end



function love.update(dt)
mousex = love.mouse.getX()
mousey = love.mouse.getY()
	if gamestate == "menu" then
		MouseCheck()
	end
	if gamestate == "gameover" then
		MouseCheck()
	end
	
if gamestate == "isplaying" then
dt = math.min(dt, 0.025)
bump.collide()
PlayerMovement(dt)
EnemyUpdate(dt)
CoinUpdate(dt)

DiamondUpdate(dt)
LifeUpdate(dt)
game()
end
end
function game()
if lifebar == 0 or lifebar < 0 then
		gamestate = "gameover"	
end
end


function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(bg)
	if gamestate == "menu" then
		ButtonDraw()
	end
	if gamestate == "gameover" then
		playbuttonDraw()
		
	end
	if gamestate == "isplaying" then
	map:draw()
	
	DrawPlayer()

	DrawEnemy()
	CoinDraw()
	DiamondDraw()
	LifeDraw()
	
	love.graphics.print("Life:"..lifebar, 32, 32)
	love.graphics.print("Score:"..score, 320, 32)
	
	end
	
end

--Bump configuration


function bump.collision(obj1, obj2, dx, dy)
	if obj1 == player then
		collidePlayerWithPlatform(dx,dy,obj2)
	elseif obj2 == player then
		collidePlayerWithPlatform(-dx,-dy,obj1)
	end
	
	for i,v in ipairs(enemy) do
		if obj1 == v then
			collideEnemyWithPlatform(dx,dy,v,obj2)
		elseif obj2 == v then
			collideEnemyWithPlatform(-dx,-dy,v,obj1)
		end
	end
	for i,v in ipairs(CoinTable) do
		if obj1 == v then
			collideCoinWithPlatform(dx,dy,v,obj2)
		elseif obj2 == v then
			collideCoinWithPlatform(-dx,-dy,v,obj1)
		end
	end
	for i,v in ipairs(DiamondTable) do
		if obj1 == v then
			collideDiamondWithPlatform(dx,dy,v,obj2)
		elseif obj2 == v then
			collideDiamondWithPlatform(-dx,-dy,v,obj1)
		end
	end
	for i,v in ipairs(LifeTable) do
		if obj1 == v then
			collideLifeWithPlatform(dx,dy,v,obj2)
		elseif obj2 == v then
			collideLifeWithPlatform(-dx,-dy,v,obj1)
		end
	end
end

function bump.shouldCollide(obj1, obj2)
		for i,v in ipairs(enemy) do
			local ret = (obj1 == v or obj2 == v)
			if (ret == true) then return ret end
		end
		
		return	obj1 == player or obj2 == player 
end

function bump.getBBox(obj)
	return obj.l, obj.t, obj.w, obj.h
end



function LoadTileMap(levelFile)
	map = loader.load(levelFile)
	
	gravity = map.properties.gravity
	if (gravity == "") then gravity = DEFAULT_GRAVITY end
	
	--love.graphics.setBackgroundColor(map.properties.bgR, map.properties.bgG, map.properties.bgB)
	
	FindSolidTiles(map)
	
	for i, obj in pairs( map("Characters").objects ) do
		if obj.type == "player" then PlayerSpawn(obj.x,obj.y-8) end
		if obj.type == "enemy" then EnemySpawn(obj.x,obj.y-16,obj.properties.dir) end
		if obj.type == "diamond" then DiamondSpawn(obj.x,obj.y-16) end
		if obj.type == "coin" then CoinSpawn(obj.x,obj.y-16) end
		if obj.type == "life" then LifeSpawn(obj.x,obj.y-16) end
		
	end

	
	map.drawObjects = false
	
end
DEFAULT_GRAVITY = 912.8
blocks = {}
local tWidth = 16
local tHeight = 16
-- Block functions
function FindSolidTiles(map)
    layer = map.layers["platform"]

    for tileX=1,map.width do
        for tileY=1,map.height do

			local tile = layer(tileX-1, tileY-1)
			
			if tile then
				local tile
                local block = {l=(tileX-1)*16,t=(tileY-1)*16,w=tWidth,h=tHeight}
				blocks[#blocks+1] = block
				bump.addStatic(block)
			end
        end
    end
end


playerCollideboxL = 8

playerCollideboxR = 8

playerCollideboxY = 4


function PlayerSpawn(x,y)
	local left = x + playerCollideboxL
	local right = 16 
	local height = 32 - playerCollideboxY
player = {} 
player.name="player"
player.l=x
player.t=y+playerCollideboxY
player.w=right
player.h=height
player.vY=0
player.dir=1
	
	
bump.add(player)

	--cameraActive = true
	
	IsOnGround = false
	IsJumping = false
	JumpRel = true
	JumpMax = gravity * -0.3812445223488168273444347063979
	JumpAccel = JumpMax * 0.0459770114942528735632183908046 * 20
	JumpForce = 0
	JumpTimer = 0
end




 
playerSprite = love.graphics.newImage("maps/sprite.png")






local a8 = anim8.newGrid(32, 32, playerSprite:getWidth(), playerSprite:getHeight())

playerWalkRight = anim8.newAnimation('loop', a8('1-8,1'), 0.1)
playerJumpRight = anim8.newAnimation('loop', a8('4,1'), 0.1)
playerIdleRight = anim8.newAnimation('loop', a8('1,1'), 0.1)

playerWalkLeft = anim8.newAnimation('loop', a8('1-8,1'),0.1,nil,true)

playerJumpLeft = anim8.newAnimation('loop', a8('4,1'), 0.1,nil,true)

playerIdleLeft = anim8.newAnimation('loop', a8('1,1'), 0.1,nil,true)

local playAnimation = playerIdleRight	



function PlayerMovement(dt)

	local speed = 100
	
	if (love.keyboard.isDown("up") or love.keyboard.isDown("x")) then
			--is player on the ground?
		if (IsOnGround == true) then
			--be sure the the jump Coin is not being held down

				if JumpRel then
				--set initial jump force to jump accelleration 
					JumpForce = JumpAccel
					--set y velocity to jump force
					player.vY = JumpForce
					--player is jumping
					IsJumping = true
					--jump Coin is held down
					JumpRel = false
					JumpTimer = 0.065
				end
			else
		--is the player jumping and is the jump Coin being held down

			if (IsJumping) and (JumpRel == false) then
				if (JumpTimer > 0) then
					JumpForce = JumpForce + JumpAccel * dt
					player.vY = JumpForce
				end
			end
		end
	end
	if love.keyboard.isDown('left') then
	
		player.l = player.l - speed * dt
		playAnimation = playerWalkLeft
		player.dir = -1
	elseif love.keyboard.isDown('right') then
		player.l = player.l + speed * dt
		playAnimation = playerWalkRight
		player.dir = 1
	else
		if (player.dir > 0) then playAnimation = playerIdleRight

		else playAnimation = playerIdleLeft end
	end
	if IsJumping then

		if (player.dir > 0) then playAnimation = playerJumpRight

		else playAnimation = playerJumpLeft end
	end
	
	playAnimation:update(dt)

---the gravitational pull

	player.vY = player.vY + gravity*dt/2

	player.t = player.t + (player.vY * dt)

	player.vY = player.vY + gravity*dt/2
	
	if not IsJumping then
		JumpForce = 0
	end
	IsOnGround = false
	if (player.t > map.height*16) then Die() end

	if (JumpTimer > 0) then
		JumpTimer = JumpTimer - dt
	end
end

function love.keypressed(k)
	if k=="escape" then love.event.quit() end
	if k=="h" then
		if drawCollideboxes then drawCollideboxes = false
		else drawCollideboxes = true end
	end
end

function love.keyreleased(k)
	if k=="up" then JumpRel = true end
	if k=="x" then JumpRel = true end
end
--Make player collide with platform

	function collidePlayerWithPlatform(dx,dy,obj)

	local block = obj
	
		if ((dy < 0) and (obj.t > player.t)) then 

		IsOnGround = true
 
		IsJumping = false

		player.vY = 0

		elseif (dy > 0) then

		player.vY = 0
		end


	player.l = player.l + dx
	player.t = player.t + dy

	end


function DrawPlayer()
---draw the player sprite and the collide box 
	playAnimation:draw(playerSprite, player.l-playerCollideboxL, player.t-playerCollideboxY)

---the collide box is a rectacngle, and the world should collide on the rectangle collider of the player 

	if drawCollideboxes then love.graphics.rectangle("line", bump.getBBox(player)) 
end

end
function Die()
	player.l = 32
	player.t = 32
	
	lifebar = lifebar - 1
	
end

function drawBox(box, r,g,b)
	love.graphics.setColor(r,g,b,70)
	love.graphics.rectangle("fill", box.l, box.t, box.w, box.h)
	love.graphics.setColor(r,g,b)
	love.graphics.rectangle("line", box.l, box.t, box.w, box.h)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ENEMY



	
local EnemySpeed = 20

local EnemyDied = false

--EnemyDeathSound = love.audio.newSource("jump.ogg", "static")
--uardDeathSound:setVolume(0.25)
	
local enemyImage = love.graphics.newImage("maps/wheelie_right.png") 

local a8 = anim8.newGrid(32, 32, enemyImage:getWidth(), enemyImage:getHeight())
local EnemyRight = anim8.newAnimation('loop', a8('1-4,1'), 0.2)
local EnemyLeft = anim8.newAnimation('loop', a8('1-4,1'),0.2,nil,true)
enemy = { 
		l=0,
		t=0,
		w=32,
		h=32,
		dir=-1,
		vX = 0,
		animation=EnemyLeft,
	}
function EnemySpawn(x,y,dir)
	local id = #enemy+1
	
	enemy[id] = { 
			name="enemy",
			l=x,
			t=math.floor(y/16)*16+4,
			w=18,
			h=32,
			dir=dir,
			vX=0,
			animation=EnemyLeft,
			dead = false
	}
	bump.add(enemy[id])
end

function EnemyUpdate(dt)
	if EnemyDied then
		EnemyDied = false
		--remove entities marked for removal
		for i = #enemy, 1, -1 do
			if (enemy[i].dead == true) then
				bump.remove(enemy[i])
				table.remove(enemy, i)
				--love.audio.play(EnemyDeathSound)
			end
		end
	end

	for i,v in ipairs(enemy) do
		v.vX = (EnemySpeed * v.dir) * dt
		
		
		local vXtile = math.floor((v.l + v.vX) / 16)
		
		local yTile = math.floor(v.t / 16)+1
		
		local tile = layer(vXtile, yTile)
		
		if (tile == nil) then 
			v.dir = v.dir * -1
		else
			v.l = v.l + v.vX
		end
		
		if (v.dir == 1) then v.animation = EnemyRight
		else v.animation = EnemyLeft end
		
		v.animation:update(dt)
	end
end

function DrawEnemy()
	for i,v in ipairs(enemy) do
		v.animation:draw(enemyImage, v.l-8,  v.t-16) 
		if drawCollideboxes then love.graphics.rectangle("line", bump.getBBox(v)) end
	end
end

function collideEnemyWithPlatform(dx,dy,v,obj)
	if obj == player then 
		if (player.t + player.h < v.t+8) then
			EnemyDie(v)
			score = score + 100
			love.audio.play(PickupSound)
			v.t = v.t + dy
		else
			Die() 
			score = score - 100
			love.audio.play(HitSound)
		end
	end
	
	
end

function EnemyDie(v)
	v.dead = true
	EnemyDied = true
end


-------------------------------------------------------------------------------------------------------------------------------------------Coin
CoinTable = { 
		l=x,
		t=y,
		w=16,
		h=16
	}

local CoinPicked = false
local CoinImage = love.graphics.newImage("maps/coins.png")
local a8 = anim8.newGrid(16, 16, CoinImage:getWidth(), CoinImage:getHeight())
local CoinGlit = anim8.newAnimation('loop', a8('1-8,1'), 0.1)


function CoinSpawn(x,y)
	local id = #CoinTable+1
	
	CoinTable[id] = {
			name="coin",
			l=x,
			t=math.floor(y/16)*16+2,
			w=16,
			h=16,
			picked = false
			
	} 
	bump.addStatic(CoinTable[id])
end
--local coinQ = love.graphics.newQuad(32,0,16,16,128,16)
function CoinDraw()
	for i,v in ipairs(CoinTable) do
		CoinGlit:draw(CoinImage, v.l, v.t)	
	end
end
function collideCoinWithPlatform(dx,dy,v,obj)
	if obj == player then 
		CoinPick(v)
		
	end
	
	
end
function CoinUpdate(dt)
	if CoinPicked then
		CoinPicked = false
		--remove entities marked for removal
		for i = #CoinTable, 1, -1 do
			if (CoinTable[i].picked == true) then
				bump.remove(CoinTable[i])
				table.remove(CoinTable, i)
				love.audio.play(PickupSound)
			end
		end
	end
	CoinGlit:update(dt)
end

function CoinPick(v)
	score = score + 50
	v.picked = true
	CoinPicked = true
end
------------------------------------------------------------------------------------------------------------------------------------Diamonds
DiamondTable = { 
		l=x,
		t=y,
		w=16,
		h=16
	}

local DiamondPicked = false
local DiamondImage = love.graphics.newImage("maps/diamonds.png")
local a8 = anim8.newGrid(16, 16, DiamondImage:getWidth(), DiamondImage:getHeight())
local DiamondGlit = anim8.newAnimation('loop', a8('1-4,1'), 0.1)
function DiamondSpawn(x,y)
	local id = #DiamondTable+1
	
	DiamondTable[id] = {
			name="diamond",
			l=x,
			t=math.floor(y/16)*16+2,
			w=16,
			h=16,
			picked = false
			
	} 
	bump.addStatic(DiamondTable[id])
end
local diamondQ = love.graphics.newQuad(32,0,16,16,64,16)
function DiamondDraw()
	for i,v in ipairs(DiamondTable) do
		DiamondGlit:draw(DiamondImage, v.l, v.t) 	
	end
end
function collideDiamondWithPlatform(dx,dy,v,obj)
	if obj == player then 
		DiamondPick(v)
		
	end
	
	
end
function DiamondUpdate(dt)
	if DiamondPicked then
		DiamondPicked = false
		--remove entities marked for removal
		for i = #DiamondTable, 1, -1 do
			if (DiamondTable[i].picked == true) then
				bump.remove(DiamondTable[i])
				table.remove(DiamondTable, i)
				love.audio.play(PickupSound)
			end
		end
	end
	DiamondGlit:update(dt)
end

function DiamondPick(v)
	score = score + 50
	v.picked = true
	DiamondPicked = true
end
-----------------------------------------------------------LIFE
LifeTable = { 
		l=x,
		t=y,
		w=16,
		h=16
	}

local LifePicked = false
local LifeImage = love.graphics.newImage("maps/life.png")
function LifeSpawn(x,y)
	local id = #LifeTable+1
	
	LifeTable[id] = {
			name="life",
			l=x,
			t=math.floor(y/16)*16+2,
			w=16,
			h=16,
			picked = false
			
	} 
	bump.addStatic(LifeTable[id])
end

function LifeDraw()
	for i,v in ipairs(LifeTable) do
		love.graphics.draw(LifeImage, v.l, v.t) 	
	end
end
function collideLifeWithPlatform(dx,dy,v,obj)
	if obj == player then 
		LifePick(v)
		
	end
	
	
end
function LifeUpdate(dt)
	if LifePicked then
		LifePicked = false
		--remove entities marked for removal
		for i = #LifeTable, 1, -1 do
			if (LifeTable[i].picked == true) then
				bump.remove(LifeTable[i])
				table.remove(LifeTable, i)
				love.audio.play(PickupSound)
			end
		end
	end
end

function LifePick(v)
	v.picked = true
	LifePicked = true
	
	lifebar = lifebar + 1
	
end
