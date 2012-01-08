module Xem
  class CollisionMachine
    attr_reader :objects
    
    def initialize
      @objects = []
    end

    def track(*new_objects)
      new_objects.each { |object| add_to_list(object) }
    end

    def touches?(obj1, obj2)
      overlapping?(obj1.rectangle, obj2.rectangle)
    end

    def overlapping?(a, b)
      a[:top_left][:z] < b[:bottom_right][:z] &&
        a[:bottom_right][:z] > b[:top_left][:z] &&
        a[:top_left][:x] > b[:bottom_right][:x] &&
        a[:bottom_right][:x] < b[:top_left][:x]
    end

    def collided_with(object)
      (objects - [object]).select do |another|
        touches?(object, another)
      end
    end

    protected

    def add_to_list(object)
      objects << object if object.respond_to?(:rectangle) and not objects.include?(object)
    end
  end

  class Xem
    attr_reader :collision_machine
  
    def enable_collisions
      settings.set(:collisions, true)
      @collision_machine ||= CollisionMachine.new
      camera.check_collisions = true
    end

    def collided_with(object)
      @collision_machine.collided_with(object)
    end
  end

  class Camera
    attr_accessor :rectangle_size, :check_collisions, :actor_height

    def rectangle
      self.rectangle_size ||= 0.1
      {
        bottom_right: {x: position.x - rectangle_size, z: position.z + rectangle_size},
        top_left: {x: position.x + rectangle_size, z: position.z - rectangle_size}
      }
    end

    def make_move(diff)
      if check_collisions
        @actor_height ||= 1.8
        @position.y = actor_height

        @position.x += diff.x
        @position.x -= diff.x if xem.collided_with(self).any?
        
        @position.z += diff.z
        @position.z -= diff.z if xem.collided_with(self).any?
      else
        @position += diff
      end
    end
  end
end
