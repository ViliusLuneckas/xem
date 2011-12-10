module Xem
  class Mouse
    attr_reader :xem, :position, :old_position

    def initialize(xem)
      @xem = xem
      @locked = false
      @position = Point.new(0, 0)
    end

    def move(x, y)
      @old_position = @position
      @position = Point.new(x, y)
      camera_hooks if xem.settings.get(:movement)
    end

    def lock
      unless @locked
        lock!
      end
    end

    def unlock
      if @locked
        unlock!
      end
    end


    def ensure_lock
      @locked ? lock! : unlock!
    end

    protected

    def lock!
      @locked = true
      Glfw::glfwDisable(Glfw::GLFW_MOUSE_CURSOR)
    end

    def unlock!
      @locked = false
      Glfw::glfwEnable(Glfw::GLFW_MOUSE_CURSOR)
    end

    def camera_hooks
      diff = position - old_position
      xem.camera.look_around Point.new(diff.y, diff.x, 0)
    end
  end


  class Xem
    def lock_mouse
      mouse.lock
    end

    def unlock_mouse
      mouse.unlock
    end
  end
end