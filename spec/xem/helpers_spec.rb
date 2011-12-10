require_relative '../spec_helper'

describe Xem::Helpers do
  before do
    #raise "Unable to initialize GLFW" unless Glfw::glfwInit
    #@video_mode = Glfw::glfwGetVideoModes.last #[-7]
    #@screen_type = [Glfw::GLFW_WINDOW, Glfw::GLFW_FULLSCREEN].last
    #params =[@video_mode.Width, @video_mode.Height, @video_mode.RedBits, @video_mode.GreenBits, @video_mode.BlueBits, 0, 0, 0, @screen_type]
    #raise "Unab0le open window" unless Glfw::glfwOpenWindow(*params)
  end

  describe "#lock_configs" do
    it "should isolate some given configurations" do
      Gl::glDisable(Gl::GL_TEXTURE_2D)
      Xem::Helpers.lock_configs(Gl::GL_TEXTURE_2D) do
        Gl::glEnable(Gl::GL_TEXTURE_2D)
      end
      Gl::glIsEnabled(Gl::GL_TEXTURE_2D).should be_false
    end

    it "should not isolate not given configurations"
  end
end