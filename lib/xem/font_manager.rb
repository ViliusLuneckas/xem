require 'gl'
require 'glu'
require 'glfw'

require_relative 'helpers'

module Xem
  class FontManager
    include Glfw
    include Gl
    include Glu

    attr_reader :xem, :texture

    def initialize(xem)
      @xem = xem
    end

    def texture=(filename)
      @texture = Xem::Helpers.load_texture(filename, GLFW_ALPHA_BITS)
      raise "Cannot load texture from file: #{filename}" unless texture
    end

    protected

    def build
      @font_base = glGenLists(256)

      lock_configs(GL_TEXTURE_2D, GL_LIGHTING) do

        glEnable(GL_TEXTURE_2D)
        glEnable(GL_LIGHTING)

        (0..256).each do |i|
          cx, cy = i % 16 / 16.0, i/16 / 16.0
          glBindTexture(GL_TEXTURE_2D, texture_id)
          glNewList(font_base + i, GL_COMPILE)
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
        end
      end
    end

    def print(xy, rgb, text, scale = 1.0)
      glMatrixMode(GL_PROJECTION)
      glPushMatrix();
      glLoadIdentity();
      gluOrtho2D(0.0, @xem.video_mode.Width, @xem.video_mode.Height, 0.0)
      glMatrixMode(GL_MODELVIEW);
      glPushMatrix();
      glLoadIdentity();

      set = 1 #???
      glColor4f(*rgb, 1.0)

      lock_configs(GL_LIGHTING, GL_TEXTURE_2D, GL_BLEND) do
        glDisable(GL_LIGHTING)
        glEnable(GL_TEXTURE_2D)

        glBindTexture(GL_TEXTURE_2D, @texture)
        glEnable(GL_BLEND)
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
        glTranslated(*xy, 0)
        glListBase(@font_base - 32 + (128*set))
        glScalef(1.0 * scale, 2.0 * scale, 1.0 * scale)
        glCallLists(GL_BYTE, text.bytes.to_a)
      end

      glPopMatrix()
      glMatrixMode(GL_PROJECTION)
      glPopMatrix()
    end
  end


  class Xem
    def font_manager
      @font_manager ||= FontManager.new(self)
    end

    def print(*args)
      font_manger.print args
    end
  end
end