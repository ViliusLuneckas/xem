#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.clear_color = :_abcabc

xem.font_file = "simple.tga"

xem.enable_console

xem.lock_mouse

xem.enable_movement

xem.render do

  xem.cache do
    xem.axis
    xem.wire_floor 50, 50
  end

  xem.print([:center, :center], :_000000, "Type ` to open console", 0.65)
end
