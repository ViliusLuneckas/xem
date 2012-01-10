#!/usr/bin/env ruby

require_relative '../lib/xem'

xem = Xem::Xem.instance 
xem.clear_color = :_ffffff

xem.font_file = "simple.tga" 

xem.lock_mouse

xem.enable_movement
xem.enable_console

xem.enable_collisions
xem.camera.check_collisions = true
xem.camera.fly_mode = false

cubes = 10.times.collect do 
  color = "_#{"%06d" % rand(999999)}".to_sym
  color = "_0#{rand(10)}f0#{rand(10)}ff#{rand(10)}".to_sym
  Cube.new(rand(3) + 1, position: Point.new(rand(20), 0, rand(20)), color: color)
end

xem.collision_machine.track(*cubes)
xem.camera.rectangle_size = 0.5

xem.render do

  xem.cache do
    xem.wire_floor 25, 25, color: :_000000
    cubes.each(&:draw)
  end


  xem.print([:center, 10], :_000000, "%.2f" % xem.fps, 0.7)
end
