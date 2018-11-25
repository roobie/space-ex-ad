require'imgui'

local devui = require'devui'
local impl = require'impl'

local function reload()
  local _require = _G.require
  _G.require = function(name)
    package.loaded[name] = nil
    return _require(name)
  end
  impl = require'impl'
  impl.load()
  _G.require = _require
end

function love.load(arg)
  impl.load()
end

function love.update(dt)
  impl.update(dt)
end

function love.draw()
  impl.draw()
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

function love.keypressed(key, scancode, isrepeat)
  imgui.KeyPressed(key)
  if not imgui.GetWantCaptureKeyboard() then
    -- Pass event to the game
    if key == 'r' then
      reload()
    end
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
