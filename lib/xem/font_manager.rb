require 'gl'
require 'glu'
require 'glfw'

require_relative 'helpers'

module Xem
  class FontManager
    include Glfw
    include Gl
    include Glu

    attr_reader :xem, :texture, :filename

    def initialize(xem)
      @xem = xem
      @built = false
    end

    def filename=(filename)
      @filename = filename
      @built = false
    end

    def print(xy, rgb, text, scale = 1.0)
      build unless @built
      rgb = rgb.to_sym.color if rgb.is_a?(String)
      rgb = rgb.color if rgb.is_a?(Symbol)
      glMatrixMode(GL_PROJECTION)
      glPushMatrix();
      glLoadIdentity();
      gluOrtho2D(0.0, @xem.video_mode.Width, @xem.video_mode.Height, 0.0)
      glMatrixMode(GL_MODELVIEW);
      glPushMatrix();
      glLoadIdentity();

      set = 1 #???
    
      glColor4f(*rgb, 1.0)

      xem.lock_configs(GL_LIGHTING, GL_TEXTURE_2D, GL_BLEND) do
        glDisable(GL_LIGHTING)
        glEnable(GL_TEXTURE_2D)

        glBindTexture(GL_TEXTURE_2D, texture)
        glEnable(GL_BLEND)
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
        glTranslated(*location(*xy), 0)
        glListBase(@font_base - 32 + (128*set))
        glScalef(1.0 * scale, 2.0 * scale, 1.0 * scale)
        glCallLists(GL_BYTE, text.bytes.to_a)
      end

      glPopMatrix()
      glMatrixMode(GL_PROJECTION)
      glPopMatrix()
      true
    end

    protected

    def location(x, y)
      x = xem.video_mode.Width / 2 if x == :center
      y = xem.video_mode.Height / 2 if y == :center
      [x, y]
    end

    def load_texture
      @texture = xem.load_texture(filename, GLFW_ALPHA_BITS)
      raise "Cannot load texture from file: #{filename}" unless texture
      @built = false
    end

    def build
      load_texture unless texture
      @font_base = glGenLists(256)

      xem.lock_configs(GL_TEXTURE_2D, GL_LIGHTING) do

        glEnable(GL_TEXTURE_2D)
        glEnable(GL_LIGHTING)

        (0..256).each do |i|
          cx, cy = i % 16 / 16.0, i/16 / 16.0
          glBindTexture(GL_TEXTURE_2D, texture)
          glNewList(@font_base + i, GL_COMPILE)
          glBegin(GL_QUADS)
          glTexCoord2f(cx, 1.0 - cy - 0.0625)
          glVertex2d(0, 16)
          glTexCoord2f(cx + 0.0625, 1.0 - cy - 0.0625)
          glVertex2d(16, 16)
          glTexCoord2f(cx + 0.0625, 1.0 - cy - 0.001)
          glVertex2d(16, 0)
          glTexCoord2f(cx, 1.0 - cy - 0.001)
          glVertex2d(0, 0)
          glEnd
          glTranslated(14, 0, 0)
          glEndList
          @built = true
        end
      end
    end
  end


  class Xem
    def font_file=(filename)
      if File.exists?(file_path = File.expand_path(filename, '.'))
        font_manager.filename = file_path
      elsif File.exists?(file_path = File.expand_path(filename, 'data/fonts'))
        font_manager.filename = file_path
      else
        font_manager.filename = filename
      end
    end

    def print(*args)
      font_manager.print *args
    end

    protected

    def font_manager
      @font_manager ||= FontManager.new(self)
    end
  end
end
