require_relative '../spec_helper.rb'

describe Array do
  describe "Inversion" do
    it "should inverse elements" do
      [0, 1, 2, 3, -2, -3].inverse.should == [0, -1, -2, -3, 2, 3]
    end
  end
end
