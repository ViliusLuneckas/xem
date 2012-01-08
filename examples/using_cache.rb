#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.font_file = "simple.tga"

xem.unlock_mouse

xem.render do

  xem.print([10, 10], :_ff0000, "Fps: #{"%.2f" % xem.fps}", 1.0)

  xem.print([10, 40], :_000000, "Time without cache: #{Time.now}", 0.7)

  xem.cache do
    xem.print([10, 70], :_000000, "Time with cache: #{Time.now}", 0.7)
    xem.print([10, 120], :_FF0000, "Cache is for static objects only.", 0.7)
  end
end
