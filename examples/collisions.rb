#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance 
xem.clear_color = :_ffffff

xem.font_file = "simple.tga" 

xem.lock_mouse

xem.enable_movement

xem.enable_collisions
xem.camera.rectangle_size = 0.5

cube = Cube.new(1, position: Point.new(3, 0, 4), color: :_abc0ff)


xem.collision_machine.track(cube)

xem.render do

  xem.cache do
    xem.wire_floor 50, 50, color: :_0abc00
  end

  cube.draw

  xem.print([10, 10], :_000000, "Camera angle: #{xem.camera.angle}", 0.7)
  xem.print([10, 40], :_000000, "Camera position: #{xem.camera.position}", 0.7)
  if xem.collided_with(xem.camera).any?
    xem.print([:center, :center], :_FF0000, "2D Collision!")
  end  
end
