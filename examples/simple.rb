#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.font_file = "simple.tga" # equals to xem.font_file = File.join("data", "fonts", "simple.tga")

xem.unlock_mouse

xem.render do
  xem.print([:center, :center], :_ff0000, "- simple app -", 1.0)
end

