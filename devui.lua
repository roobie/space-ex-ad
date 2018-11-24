require 'imgui'

local mod = {}

local showTestWindow = false

local delts = 0

function mod.update(dt)
  delta = dt
end

function mod.draw()
  -- Menu
  if imgui.BeginMainMenuBar() then
    if imgui.BeginMenu("File") then
      imgui.MenuItem("Test")
      imgui.EndMenu()
    end
    imgui.EndMainMenuBar()
  end

  if imgui.Button("Test Window") then
    showTestWindow = not showTestWindow;
  end

  imgui.Text(string.format('%.4f - %.4f', delta, 1 / delta))

  if showTestWindow then
    showTestWindow = imgui.ShowDemoWindow(true)
  end
end

return mod
