#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.font_file = "simple.tga" # equals to xem.font_file = File.join("data", "fonts", "simple.tga")

xem.lock_mouse

xem.enable_movement

xem.render do

  xem.cache do
    xem.axis
  end

  xem.cache do
    xem.wire_floor 50, 50
  end

  xem.print([10, 10], :_000000, "Camera angle: #{xem.camera.angle}", 0.7)
  xem.print([10, 40], :_000000, "Camera position: #{xem.camera.position}", 0.7)
end
