module Xem
  class Settings

    def initialize
      @storage = {}
    end

    def set(key, value)
      @storage[key] = value
    end

    def get(key)
      @storage[key]
    end
    #glfwOpenWindowHint(GLFW_FSAA_SAMPLES, 4)
  end
end