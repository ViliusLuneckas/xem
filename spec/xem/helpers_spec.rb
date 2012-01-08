require_relative '../spec_helper'

describe Xem::Helpers do
  describe "#lock_configs" do
    it "should isolate some given configurations" do
      Gl::glDisable(Gl::GL_TEXTURE_2D)
      @xem.lock_configs(Gl::GL_TEXTURE_2D) do
        Gl::glEnable(Gl::GL_TEXTURE_2D)
      end
      Gl::glIsEnabled(Gl::GL_TEXTURE_2D).should be_false
    end

    it "should not isolate not given configurations" do
      Gl::glDisable(Gl::GL_TEXTURE_2D)
      @xem.lock_configs do
        Gl::glEnable(Gl::GL_TEXTURE_2D)
      end
      Gl::glIsEnabled(Gl::GL_TEXTURE_2D).should be_true
    end
  end
end

