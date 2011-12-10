require 'gl'
require 'glfw'

module Xem
  module Helpers
    def self.lock_configs(*gl_configs)
      states = gl_configs.collect { |gl_config| Gl::glIsEnabled(gl_config) }
      yield
      states = gl_configs.collect { |gl_config| Gl::glIsEnabled(gl_config) }
      #gl_configs.zip(states).each { |gl_config, state| state ? Gl::glEnable(gl_config) : Gl::glDisable(gl_config) }
    end

    def self.load_texture(filename, load_options = nil, options = {})
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
  end
end