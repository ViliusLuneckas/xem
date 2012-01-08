require_relative '../spec_helper.rb'

describe Cube do
  describe "#rectangle" do
    it "should return rectangle" do
      cube = Cube.new(3, position: Point.new(5, 0, 5))
      cube.rectangle.should == {
        top_left: {z: 5, x: 8},
        bottom_right: {z: 8, x: 5}
      }
    end
    it "should return rectangle #2" do
      cube = Cube.new(1, position: Point.new(3, 0, 4))
      cube.rectangle.should == {
        top_left: {z: 4, x: 4},
        bottom_right: {z: 5, x: 3}
      }
    end
  end
end
