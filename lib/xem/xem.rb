require 'opengl'
require 'glfw'

module Xem
  class Xem
    include Glfw
    include Gl
    include Glu

    attr_reader :alive, :video_mode, :metrics, :camera, :mouse, :keyboard, :settings

    def self.instance(options = {})
      @@single_instance ||= Xem.new(options)
    end

    def show
      raise "Unable to open screen" unless glfw_open_window

      glfwSetWindowTitle(settings.get(:title))
      glfwSetWindowSizeCallback(method(:window_resize_event).to_proc)
      glfwSetKeyCallback(method(:keyboard_event).to_proc)
      glfwSetCharCallback(method(:keyboard_ascii_event).to_proc)
      glfwSetMousePosCallback(method(:mouse_move_event).to_proc)
      enable_3D
      after_show
    end

    def render
      show unless settings.get(:visible)
      glClearColor(*settings.get(:clear_color), 1.0)

      while alive
        begin_rendering
        yield
        end_rendering
      end
    end

    def clear_color=(rgb)
      settings.set(:clear_color, rgb)
    end

    def enable_movement
      settings.set(:movement, true)
    end

    def disable_movement
      settings.set(:movement, false)
    end

    def shutdown
      @alive = false
    end

    def alive
      @alive && glfwGetWindowParam(GLFW_OPENED)
    end

    def toggle_gl_hints
      hints = settings.get(:gl_hints)
      hints = hints == GL_NICEST ? GL_FASTEST : GL_NICEST
      settings.set(:gl_hints, hints)
      ::Xem::Constants::GL_HINTS.each { |hint| glHint(hint, hints) }
    end

    protected

    def initialize(options = {})
      raise "Unable to initialize GLFW" unless glfwInit

      @video_mode = glfwGetVideoModes.last
      @screen_type = [GLFW_WINDOW, GLFW_FULLSCREEN].first

      @metrics = Metrics.new

      @camera = Camera.new(self)

      @settings = Settings.new
      settings.set(:visible, false)
      settings.set(:clear_color, [0.7, 0.8, 0.9])

      @mouse = Mouse.new(self)

      @keyboard = Keyboard.new(self)

      @title = settings.set(:title, options[:title] || "Xem app")

      @alive = true
    end

    def begin_rendering
      metrics.begin_rendering
      clear
      glRotatef(camera.angle.x, 1.0, 0.0, 0.0)
      glRotatef(camera.angle.y, 0.0, 1.0, 0.0)
      glTranslated(-camera.position.x, -camera.position.y, -camera.position.z)
      render_extensions
    end

    # method for chaining
    def render_extensions
    end

    def end_rendering
      glfwSwapBuffers
      keyboard.camera_hooks if keyboard and settings.get(:movement)
      metrics.end_rendering
    end

    def after_show
      fix_configs
    end

    def clear
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
      glMatrixMode(GL_MODELVIEW)
      glLoadIdentity
    end

    def glfw_open_window
      params = [video_mode.Width, video_mode.Height, video_mode.RedBits, video_mode.GreenBits, video_mode.BlueBits, 0, 0, 0, @screen_type]
      glfwOpenWindow(*params)
    end

    def window_resize_event(w, h)
      glViewport(0, 0, w, h)
      glMatrixMode(GL_PROJECTION)
      glLoadIdentity
      gluPerspective(60.0, w.to_f / h.to_f, 0.1, camera.view_distance.to_f)
      glMatrixMode(GL_MODELVIEW)
      glLoadIdentity
      @video_mode.Width, @video_mode.Height = w, h
    end

    def mouse_move_event(x, y)
      mouse.move(x, y)
    end

    def keyboard_event(key, action)
      keyboard.event(key, action) if keyboard
    end

    def keyboard_ascii_event(key, action)
      keyboard.ascii_event(key, action) if keyboard
    end

    def enable_3D(hints = GL_NICEST)
      glEnable(GL_TEXTURE_2D)
      glShadeModel(GL_SMOOTH)
      settings.set(:clear_color, [0, 0, 0]) unless settings.get(:clear_color)
      glClearColor(*settings.get(:clear_color), 1.0)
      glClearDepth(1.0)
      glEnable(GL_DEPTH_TEST)
      glEnable(GL_CULL_FACE)
      glDepthFunc(GL_LEQUAL)
      glEnable(GL_ALPHA_TEST)
      glEnable(GL_NORMALIZE)
      glEnable(GL_LIGHTING)
      settings.set(:gl_hints, hints)
      ::Xem::Constants::GL_HINTS.each { |hint| glHint(hint, hints) }
    end

    def fix_configs
      mouse.ensure_lock
    end
  end
end


