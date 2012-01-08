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
      a[:top_left][:x] < b[:bottom_right][:x] &&
        a[:bottom_right][:x] > b[:top_left][:x] &&
        a[:top_left][:z] > b[:bottom_right][:z] &&
        a[:bottom_right][:z] < b[:top_left][:z]
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
    end

    def collided_with(object)
      @collision_machine.collided_with(object)
    end
  end

  class Camera
    ACTOR_SIZE = 1

    def rectangle
      {
        top_left: {x: position.x - ACTOR_SIZE, z: position.z + ACTOR_SIZE},
        bottom_right: {x: position.x + ACTOR_SIZE, z: position.z - ACTOR_SIZE}
      }
    end
  end
end
