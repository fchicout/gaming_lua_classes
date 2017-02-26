

function love.load()
  person = {x = 0, y = 0,   -- Coordenadas de posição do personagem
            vx=50, vy =50,  -- Vetor de velocidade do personagem (relembre aula de ontem)
            spritesheet = love.graphics.newImage("assets/char.bmp"),
            quads = {},
            estado = "frente",
            iteracao = 1
          }
  person.quads["frente"] = love.graphics.newQuad(0, 120, 60, 60, person.spritesheet:getDimensions())
  person.quads["tras"] = love.graphics.newQuad(60, 120, 60, 60, person.spritesheet:getDimensions())
  person.quads["direita"] = {} -- Containers básicos pras imagens intermediárias
  person.quads["esquerda"] = {}
  for i=1,8 do -- tenho 8 imagens intermediárias, de 60 pixels.
    person.quads["esquerda"][i]=love.graphics.newQuad(((i-1)*60), 0, 60, 60, person.spritesheet:getDimensions())
    person.quads["direita"][i]=love.graphics.newQuad(((i-1)*60), 60, 60, 60, person.spritesheet:getDimensions())
  end
end

function love.draw()
  if person.estado == "direita" or person.estado == "esquerda" then
    love.graphics.draw(person.spritesheet, person.quads[person.estado][person.iteracao], person.x, person.y)
  end
  if person.estado == "frente" or person.estado == "tras" then
    love.graphics.draw(person.spritesheet, person.quads[person.estado], person.x, person.y)
  end
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    person.estado = "direita";  -- Mudei o estado. agora o quads["direita"] será usado
    person.x=person.x+person.vx*dt --Lembra da equação horária do movimento!!
    person.iteracao = person.iteracao+1
    if person.iteracao == 8 then
      person.iteracao = 1
    end
  end
  if love.keyboard.isDown("left") then
    person.estado = "esquerda";  -- Mudei o estado. agora o quads["direita"] será usado
    person.x=person.x-person.vx*dt --Lembra da equação horária do movimento!!
    person.iteracao = person.iteracao+1;
    if person.iteracao == 8 then
      person.iteracao = 1
    end
  end


end
