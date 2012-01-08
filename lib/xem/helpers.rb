require 'gl'
require 'glfw'

module Xem
  module Helpers
    def lock_configs(*gl_configs)
      states = gl_configs.collect { |gl_config| Gl::glIsEnabled(gl_config) }
      yield
      gl_configs.zip(states).each { |cfg, state| state ? Gl::glEnable(cfg) : Gl::glDisable(cfg) }
    end

    def in_separate_matrix
      glPushMatrix
      yield
      glPopMatrix
    end

    def gl_draw(method = GL_QUADS)
      glBegin(method)
      yield
      glEnd
    end

    def load_texture(filename, load_options = nil, options = {})
      load_options = load_options ? load_options | Glfw::GLFW_BUILD_MIPMAPS_BIT : Glfw::GLFW_BUILD_MIPMAPS_BIT
      texture_id = Gl::glGenTextures(1).first
      Gl::glBindTexture(Gl::GL_TEXTURE_2D, texture_id)
      if Glfw::glfwLoadTexture2D(filename, load_options)
        unless options[:parameteri]
          Gl::glTexParameteri(Gl::GL_TEXTURE_2D, Gl::GL_TEXTURE_MIN_FILTER, Gl::GL_LINEAR_MIPMAP_LINEAR)
          Gl::glTexParameteri(Gl::GL_TEXTURE_2D, Gl::GL_TEXTURE_MAG_FILTER, Gl::GL_LINEAR)
        else
          options[:parameteri].each { |param| Gl::glTexParameteri(Gl::GL_TEXTURE_2D, *param) }
        end
        texture_id
      else
        raise "Cannot load texture: #{filename}, options=#{options}"
        -1
      end
    end

    def path_for(filename, type)
      paths = case type
                when :image
                  root = Dir.pwd
                  ['', '.tga'].collect do |extension|
                    [File.join(root, filename + extension),
                     File.join(root, "data", "images", filename + extension)]
                  end
                else
                  []
              end.flatten
      paths.detect { |path| File.exists?(path) }
    end

    def gl_textured(texture)
      lock_configs(GL_TEXTURE_2D) do
        glEnable(GL_TEXTURE_2D)
        glBindTexture(GL_TEXTURE_2D, texture)
        yield
      end
    end

    def inverse_box(w, h, l)
      glRotatef(180, 1.0, 0, 0)
      glTranslatef(0, -h, -l)
      gl_draw do
        [:forward, :left, :right, :backward, :down].each do |side|
          glNormal3f(*side.to_n.inverse)
          4.times do |i|
            vertex = ::Xem::Constants::BOX[side][i]
            corrected = [w, h, l].zip(vertex).map { |s, v| s * v }
            glTexCoord2d(*::Xem::Constants::SKY_BOX_TEXTURE_COORDS[side][i])
            glVertex3f(*corrected)
          end
        end
      end
    end
    
    def box(w, h, l, options = {})
      gl_draw do
        [:forward, :left, :right, :backward, :up, :down].each do |side|
          glNormal3f(*side.to_n)
          4.times do |i|
            vertex = ::Xem::Constants::BOX[side][i]
            corrected = [w, h, l].zip(vertex).map { |s, v| s * v }
            glTexCoord2d(*::Xem::Constants::SKY_BOX_TEXTURE_COORDS[side][i]) if options[:texture]
            glVertex3f(*corrected)
          end
        end
      end
    end
  end
end
