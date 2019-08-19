package = "graphics"
version = "dev-1"
source = {
   url = "git+https://github.com/ulalume/monolith-graphics.git"
}
description = {
   homepage = "https://github.com/ulalume/monolith-graphics",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      ["graphics.color"] = "color.lua",
      ["graphics.rainbow"] = "rainbow.lua",
      ["graphics.rhombus"] = "rhombus.lua",
      ["graphics.rotate_screen"] = "rotate_screen.lua"
   }
}
