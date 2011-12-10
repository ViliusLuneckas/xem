#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.clear_color = xem.color('abcabc')

xem.font_file = "simple.tga"

xem.enable_console

xem.unlock_mouse

xem.render do
  xem.print([:center, :center], xem.color('000000'), "Type ` to open console", 0.65)
end
