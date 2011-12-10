require 'opengl'
require 'glfw'

module Xem
  class Xem
    include Glfw
    include Gl
    include Glu

    attr_reader :alive, :video_mode, :metrics, :camera, :mouse, :settings, :title

    def self.instance(options = {})
      @@single_instance ||= Xem.new(options)
    end

    def show
      #raise "Unable to open screen" unless glfw_open_window
    end

    protected

    def initialize(options = {})
      raise "Unable to initialize GLFW" unless glfwInit

      @video_mode = glfwGetVideoModes.last #[-7]
      @screen_type = [GLFW_WINDOW, GLFW_FULLSCREEN].last

      @metrics = Metrics.new

      @camera = Camera.new(self)

      @mouse = Mouse.new

      @title = options[:title] || "Xem app"

      @alive = true
    end

    def glfw_open_window
      params = [video_mode.Width, video_mode.Height, video_mode.RedBits, video_mode.GreenBits, video_mode.BlueBits, 0, 0, 0, @screen_type]
      glfwOpenWindow(*params)
    end
  end
end
