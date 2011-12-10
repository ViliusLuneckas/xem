module Xem
  class Metrics
    FPS_RECALCULATE_INTERVAL = 0.4

    attr_reader :frames, :fps

    def initialize
      @last_time_frames = @frames = 0
      @fps = 60
      @last_time = Glfw::glfwGetTime
    end

    def begin_rendering
    end

    def end_rendering
      @frames += 1
      now = Glfw::glfwGetTime
      if now - @last_time > FPS_RECALCULATE_INTERVAL
        @fps = (frames - @last_time_frames) / (now - @last_time)
        @last_time_frames, @last_time = frames, now
      end
    end
  end

  class Xem
    def fps
      metrics.fps
    end
  end
end