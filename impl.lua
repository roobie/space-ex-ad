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

  local clearColor = game.ui.clearColor
  love.graphics.clear(clearColor[1], clearColor[2], clearColor[3])

  local shader = shaders.lensflareConcentric
  love.graphics.setShader(shader)

  strength = math.sin(time * 2)
  --shader:send("abberationVector", {
                --strength*math.sin(time * 7) / 200,
                --strength*math.cos(time * 7) / 200})
  love.graphics.setColor(0.3, 0.5, 0.2, 0.4)
  love.graphics.polygon('fill', 100, 100, 200, 100, 150, 200)

  love.graphics.setColor(0.3, 1, 0.2, 0.4)
  love.graphics.polygon('fill', 200, 200, 300, 200, 250, 300)

  love.graphics.setColor(0.3, 1, 0.2, 0.4)
  love.graphics.ellipse('fill', 500, 10, 50, 100)

  -- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
  love.graphics.draw(sprites.dude, 250, 250, 0.1, 2, 2)
  love.graphics.setShader()

  love.graphics.setColor(1, 1, 1, 1)
  devui.draw()
  imgui.Render();
end

return mod
