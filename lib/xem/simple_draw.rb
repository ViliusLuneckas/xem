module Xem
  class Xem
    def wire_floor(x_n, z_n, options = {})
      square_size = options[:square_size] || 1
      lock_configs(GL_LIGHTING, GL_TEXTURE_2D) do
        glDisable(GL_LIGHTING)
        glDisable(GL_TEXTURE_2D)
        glColor3f(*color(options[:color] || 'ffffff'))
        gl_draw(GL_LINES) do
          (0..x_n).each do |x|
            (0..z_n).each do |z|
              glVertex3f(x, 0, z)
              glVertex3f(x, 0, z + square_size)
              glVertex3f(x, 0, z + square_size)
              glVertex3f(x + square_size, 0, z + square_size)
              glVertex3f(x + square_size, 0, z + square_size)
              glVertex3f(x + square_size, 0, z)
              glVertex3f(x + square_size, 0, z)
              glVertex3f(x, 0, z)
            end
          end
        end
      end
    end

    def axis
      lock_configs(GL_LIGHTING, GL_TEXTURE_2D) do
        glDisable(GL_LIGHTING)
        glDisable(GL_TEXTURE_2D)

        dist = camera.view_distance
        in_separate_matrix do
          glTranslated(0, 0, 0)
          glLineWidth(2)
          gl_draw(GL_LINES) do
            glColor3f(1, 0, 0)
            glVertex3f(dist, 0, 0)
            glVertex3f(0, 0, 0)
            glColor3f(0, 1, 0)
            glVertex3f(0, dist, 0)
            glVertex3f(0, 0, 0)
            glColor3f(0, 0, 1)
            glVertex3f(0, 0, dist)
            glVertex3f(0, 0, 0)
          end
          glLineWidth(1)
        end
      end
    end
  end
end
