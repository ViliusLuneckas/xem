require_relative '../spec_helper.rb'

describe Xem::Camera do
  describe "#rectangle" do
    subject { @xem.camera }
    it "should return rectangle around camera position" do
      subject.rectangle.should == {
        top_left: {z: -1, x: 1},
        bottom_right: {z: 1, x: -1}
      }
    end
  end
end
