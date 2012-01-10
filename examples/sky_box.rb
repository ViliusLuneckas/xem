#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance 

xem.font_file = "simple.tga" 

xem.sky = "interstellar" # interstellar.tga texture from data/images will be used for sky box

xem.settings.get(:sky) # => true

xem.lock_mouse

xem.enable_movement
xem.camera.speed = 15 # set camera movement speed

xem.render do

  xem.cache do
    xem.wire_floor 50, 50, color: :_0abc00
  end

  xem.print([5, 10], :_000000, "Camera angle: #{xem.camera.angle}", 0.7)
  xem.print([5, 40], :_000000, "Camera position: #{xem.camera.position}", 0.7)

end
