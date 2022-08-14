local p = require "graphics.color"

local Rainbow = {}
local startTime = love.timer.getTime()
function Rainbow:new(timePerFrame, colors)
  return setmetatable({
    timePerFrame = timePerFrame or (1 / 60),
    colors = colors or { p.black, p.blue, p.red, p.magenta, p.green, p.cyan, p.yellow, p.white },
    d = 0
  }, { __index = self })
end

function Rainbow:goZeroFrame()
  self.d = love.timer.getTime() - startTime
end

function Rainbow:useGameTime()
  self.d = 0
end

function Rainbow:getFrame(gap)
  gap = gap or 0
  return math.floor((love.timer.getTime() - startTime + self.d) / self.timePerFrame + gap)
end

function Rainbow:color(gap)
  gap = gap or 0
  local len = #self.colors
  local index = (self:getFrame(gap) % len) + 1
  return self.colors[index]
end

return Rainbow
