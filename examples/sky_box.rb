#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance # gets instance of xem 3D engine

xem.font_file = "simple.tga" # equals to xem.font_file = File.join("data", "fonts", "simple.tga")
#
xem.sky = "interstellar" # interstellar.tga texture from data/images will be used for sky box

xem.lock_mouse

xem.enable_movement

xem.render do

  xem.cache do
    xem.wire_floor 50, 50, :color => '0abc00'
  end
  xem.sky.draw


  xem.print([10, 10], xem.color('ff0000'), "Fps: #{"%.2f" % xem.fps}", 1.0)

  xem.print([10, 40], xem.color('000000'), "Camera angle: #{xem.camera.angle}", 0.7)
  xem.print([10, 60], xem.color('000000'), "Camera position: #{xem.camera.position}", 0.7)

end
