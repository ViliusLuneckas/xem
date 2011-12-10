module Xem
  class Mouse
    attr_reader :xem

    def initialize(xem)
      @xem = xem
      @locked = false
    end

    def move(x, y)
    end

    def lock
      unless @locked
        lock!
      end
    end

    def lock!
      @locked = true
      Glfw::glfwDisable(Glfw::GLFW_MOUSE_CURSOR)
    end

    def unlock
      if @locked
        unlock!
      end
    end

    def unlock!
      @locked = false
      Glfw::glfwEnable(Glfw::GLFW_MOUSE_CURSOR)
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