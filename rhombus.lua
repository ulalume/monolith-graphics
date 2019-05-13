return function ( mode, x, y, width, height )
  love.graphics.polygon(
    mode,
    x, y-height / 2,
    x-width / 2, y,
    x, y + height /2,
    x+width /2, y,
    x, y-height / 2
  )
end
