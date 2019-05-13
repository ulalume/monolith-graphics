local rotateScreen = {}
function rotateScreen:new(w, h)
  return setmetatable({w=w, h=h}, {__index=self})
end

function rotateScreen:beginDraw(r)
  love.graphics.push()
  love.graphics.translate(self.w/2, self.h/2)
	love.graphics.rotate(r)
  love.graphics.translate(-self.h/2, -self.w/2)
end

function rotateScreen:endDraw()
  love.graphics.pop()
end

return rotateScreen
