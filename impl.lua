require'imgui'

local devui = require'devui'

local shaderPaths = {
  chromaticAbberation = 'shaders/chromatic-abberation/material.fsh',
  lensflareConcentric = 'shaders/lensflare-concentric/material.fsh',
}
local shaders = {}
local loadShaders = function()
  for name, path in pairs(shaderPaths) do
    local shader = love.graphics.newShader(path)
    print(shader:getWarnings())
    shaders[name] = shader
  end
end

local spritePaths = {
  dude = 'sprites/dude1.png'
}
local sprites = {}
local loadSprites = function()
  for name, path in pairs(spritePaths) do
    local sprite = love.graphics.newImage(path)
    sprites[name] = sprite
  end
end

local game = {
  world = {
    entities = {},
  },
  ui = {
    -- clearColor = {0.9, 0.9, 0.9},
    clearColor = {0.1, 0.1, 0.1},
  },
}

local mod = {}

function mod.load()
  loadShaders()
  loadSprites()
end

function mod.update(dt)
  if dt < 1/30 then
    love.timer.sleep(1/30 - dt)
  end
  devui.update(dt)

  imgui.NewFrame()
end

function mod.draw()
  local time = love.timer.getTime()
  local width, height = love.graphics.getDimensions( )

  local clearColor = game.ui.clearColor
  love.graphics.clear(clearColor[1], clearColor[2], clearColor[3])

  love.graphics.setColor(0.3, 0.5, 0.2, 0.4)
  love.graphics.rectangle('fill', 50, 50, 50, 50)
  love.graphics.rectangle('fill', width - 100, 50, 50, 50)
  love.graphics.rectangle('fill', 50, height - 100, 50, 50)
  love.graphics.rectangle('fill', width - 100, height - 100, 50, 50)
  local shader = shaders.chromaticAbberation
  love.graphics.setShader(shader)

  strength = math.sin(time *100)
  shader:send("abberationVector", {strength*math.sin(time * 7) / 200, strength*math.cos(time * 7) / 200})

  -- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
  -- love.graphics.draw(sprites.dude, 250, 250, math.sin(time), 3, 3, 32, 32, math.cos(time) / 5, math.sin(time) / 3)
  love.graphics.draw(sprites.dude, 250, 250, 0, 13, 13, 32, 32, 0, 0)
  love.graphics.setShader()

  love.graphics.setColor(1, 1, 1, 1)
  devui.draw()
  imgui.Render();
end

return mod
