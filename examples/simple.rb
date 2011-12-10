# !/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.clear_color = xem.color('abcabc')

xem.font_file = "simple.tga" # equals to xem.font_file = File.join("data", "fonts", "simple.tga")

xem.unlock_mouse

xem.render do

  xem.print([10, 10], xem.color('ff0000'), "Fps: #{"%.2f" % xem.fps}", 1.0)

  xem.print([10, :center], xem.color('ff0000'), "- simple app -", 1.0)

end