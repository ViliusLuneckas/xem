module Xem
  class Sky
    attr_reader :texture, :xem, :filename

    def initialize(filename, xem)
      @filename, @xem = filename, xem
    end

    def load
      file_path = xem.path_for(filename, :image)
      hints = [
          [Gl::GL_TEXTURE_MIN_FILTER, Gl::GL_NEAREST],
          [Gl::GL_TEXTURE_MAG_FILTER, Gl::GL_LINEAR]
      ]
      @texture = xem.load_texture(file_path, nil, :parameteri => hints)
    end

    def draw
      scale = 0.25
      xem.in_separate_matrix do
        xem.lock_configs(GL_LIGHTING, GL_TEXTURE_2D, GL_CULL_FACE) do
          glDisable(GL_CULL_FACE)
          glDisable(GL_LIGHTING)
          glEnable(GL_TEXTURE_2D)
          glBindTexture(GL_TEXTURE_2D, texture)
          glColor3f(*:_eeeeee.color)
          w = h = l = 512 * scale
          sky_position = [xem.camera.position.x - w/2, xem.camera.position.y - h/2, xem.camera.position.z - l/2]
          glTranslated(*sky_position)
          xem.inverse_box(w, h, l)
        end
      end
    end
  end

  class Xem
    attr_reader :sky

    def sky=(filename)
      @sky = Sky.new(filename, self)
      settings.set(:sky, true)
    end


    def render_sky
      sky.draw if settings.get(:sky)
    end

    chain :render_sky, :render_extensions

    def load_sky
      sky.load if sky
    end

    chain :load_sky, :after_show
  end
end
