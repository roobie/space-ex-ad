require'imgui'

local devui = require'devui'

local shaderPaths = {
  chromaticAbberation = 'shaders/chromatic-abberation.fsh',
}
local shaders = {}

local loadShaders = function()
  for name, path in pairs(shaderPaths) do
    local shader = love.graphics.newShader(path)
    print(shader:getWarnings())
    shaders[name] = shader
  end
end

local sprite = nil

local game = {
  world = {
    entities = {}
  },
  ui = {
    clearColor = {0.9, 0.9, 0.9}
  }
}

function love.load(arg)
  loadShaders()
  sprite = love.graphics.newImage('sprites/dude1.png')
end

function love.update(dt)
  devui.update(dt)

  imgui.NewFrame()
end

function love.draw()

  local clearColor = game.ui.clearColor
  love.graphics.clear(clearColor[1], clearColor[2], clearColor[3])

  local shader = shaders.chromaticAbberation
  love.graphics.setShader(shader)
  shader:send('abberationVector', {0.1, 0.1})

  strength = 1--math.sin(love.timer.getTime()*2)
  shader:send("abberationVector", {
                strength*math.sin(love.timer.getTime()*7)/200,
                strength*math.cos(love.timer.getTime()*7)/200})
  --love.graphics.setColor(0.3, 0.5, 0.2, 0.4)
  --love.graphics.polygon('fill', 100, 100, 200, 100, 150, 200)

  --love.graphics.setColor(0.3, 1, 0.2, 0.4)
  --love.graphics.polygon('fill', 200, 200, 300, 200, 250, 300)

  -- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
  love.graphics.draw(sprite, 250, 250, 0.1, 2, 2)
  love.graphics.setShader()

  love.graphics.setColor(1, 1, 1, 1)
  devui.draw()
  imgui.Render();
end

function love.quit()
  imgui.ShutDown();
end

function love.textinput(t)
  imgui.TextInput(t)
  if not imgui.GetWantCaptureKeyboard() then
    -- Pass event to the game
  end
end

function love.keypressed(key)
  imgui.KeyPressed(key)
  if not imgui.GetWantCaptureKeyboard() then
    -- Pass event to the game
  end
end

function love.keyreleased(key)
  imgui.KeyReleased(key)
  if not imgui.GetWantCaptureKeyboard() then
    -- Pass event to the game
  end
end

function love.mousemoved(x, y)
  imgui.MouseMoved(x, y)
  if not imgui.GetWantCaptureMouse() then
    -- Pass event to the game
  end
end

function love.mousepressed(x, y, button)
  imgui.MousePressed(button)
  if not imgui.GetWantCaptureMouse() then
    -- Pass event to the game
  end
end

function love.mousereleased(x, y, button)
  imgui.MouseReleased(button)
  if not imgui.GetWantCaptureMouse() then
    -- Pass event to the game
  end
end

function love.wheelmoved(x, y)
  imgui.WheelMoved(y)
  if not imgui.GetWantCaptureMouse() then
    -- Pass event to the game
  end
end
