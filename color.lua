local color = {}
color.__index = color

function map(value, srcMin, srcMax, dstMin, dstMax)
  return dstMin + (dstMax - dstMin) * ((value - srcMin) / (srcMax - srcMin))
end

function fromHex(...)
  local values = { ... }
  for i, v in ipairs(values) do
    values[i] = v / 0xff
  end
  return unpack(values)
end

function toHex(...)
  local values = { ... }
  for i, v in ipairs(values) do
    values[i] = math.floor(v * 0xff)
  end
  return unpack(values)
end

function color.new(r, g, b, a)
  return setmetatable({r = r, g = g, b = b, a = a}, color)
end

function color.withRgb(r, g, b)
  return color.new(r, g, b, 1.0)
end

function color.withRgba(r, g, b, a)
  return color.new(r, g, b, a)
end

function color.withRgbHex(r, g, b)
  return color.withRgb(fromHex(r, g, b))
end

function color.withRgbaHex(r, g, b, a)
  return color.withRgba(fromHex(r, g, b, a))
end

function color.withGray(gray)
  return color.withRgb(gray, gray, gray)
end

function color.withGrayHex(gray)
  return color.withRgb(fromHex(gray, gray, gray))
end

function color.lerp(a, b, t)
  return color.new(
    a.r + (b.r - a.r) * t,
    a.g + (b.g - a.g) * t,
    a.b + (b.r - a.b) * t,
  a.a + (b.a - a.a) * t)
end

function color.gradient(posAndColors, numShades)
  local result = {}

  if numShades <= 0 then
    return result
  end
  if #posAndColors <= 1 then
    for i = 1, numShades do
      table.insert(result, posAndColors[1][1])
    end
    return result
  end

  local posAndColor0 = posAndColors[1]
  local posAndColor1 = posAndColors[2]
  local index = 2

  for i = 1, numShades do
    local pos = (i - 1) / (numShades - 1)

    -- find next color
    local thresh = map(pos, posAndColor0[1], posAndColor1[1], 0, 1)
    while thresh > 0.5
      and index < #posAndColors do

        index = index + 1
        posAndColor0 = posAndColor1
        posAndColor1 = posAndColors[index]
        thresh = map(pos, posAndColor0[1], posAndColor1[1], 0, 1)
      end

      local t = map(pos, posAndColor0[1], posAndColor1[1], 0.0, 1.0)
      local c = color.lerp(
        posAndColor0[2],
        posAndColor1[2],
      t)
      table.insert(result, c)
    end
    return result
  end

  function color:__tostring()
    return string.format(
      "color { r:%.1f, g: %.1f, b: %.1f, a: %.1f }",
      self.r,
      self.g,
      self.b,
    self.a)
  end

  function color:rgb()
    return self.r, self.g, self.b
  end

  function color:rgbHex()
    return toHex(self:rgb())
  end

  function color:rgba()
    return self.r, self.g, self.b, self.a
  end

  function color:rgbaHex()
    return toHex(self:rgba())
  end


  function color.swapImageDataColor(srcImageData, targetColor, swapColor)
    local dstImageData = srcImageData:clone()
    local w, h = dstImageData:getDimensions()

    for col = 1, w - 1 do
      for row = 1, h - 1 do
        local r, g, b, a = dstImageData:getPixel(col, row)
        if r == targetColor.r
        and g == targetColor.g
        and b == targetColor.b
        and a == targetColor.a then
          dstImageData:setPixel(
            col,
            row,
          swapColor:rgba())
        end
      end
    end
    return dstImageData
  end

  color.white = color.withRgb(1, 1, 1)
  color.black = color.withRgb(0, 0, 0)
  color.red = color.withRgb(1, 0, 0)
  color.green = color.withRgb(0, 1, 0)
  color.blue = color.withRgb(0, 0, 1)
  color.yellow = color.withRgb(1, 1, 0)
  color.cyan = color.withRgb(0, 1, 1)
  color.magenta = color.withRgb(1, 0, 1)

  return color
