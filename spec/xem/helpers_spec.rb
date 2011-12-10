require_relative '../spec_helper'

describe Xem::Helpers do
  subject { Xem::Xem.instance }

  describe "#lock_configs" do
    it "should isolate some given configurations" do
      Gl::glDisable(Gl::GL_TEXTURE_2D)
      subject.lock_configs(Gl::GL_TEXTURE_2D) do
        Gl::glEnable(Gl::GL_TEXTURE_2D)
      end
      Gl::glIsEnabled(Gl::GL_TEXTURE_2D).should be_false
    end

    it "should not isolate not given configurations"

  end

  describe "#color" do
    it "should convert hex to array" do
      subject.color('ff00ff').should == [1.0, 0, 1.0]
    end
  end
end