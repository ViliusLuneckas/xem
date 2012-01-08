require_relative '../spec_helper.rb'

describe Symbol do
  describe "convertion to vector" do
    it "should convert :up, :y" do
      :up.to_v.should == [0, 1, 0]
      :y.to_v.should == [0, 1, 0]
    end

    it "should convert :down" do
      :down.to_v.should == [0, -1, 0]
    end

    it "should convert :left, :west" do
      :left.to_v.should == [-1, 0, 0]
      :west.to_v.should == [-1, 0, 0]
    end

    it "should convert :right, :east, :x" do
      :right.to_v.should == [1, 0, 0]
      :east.to_v.should == [1, 0, 0]
      :x.to_v.should == [1, 0, 0]
    end

    it "should convert :forward, :north" do
      :forward.to_v.should == [0, 0, -1]
      :north.to_v.should == [0, 0, -1]
    end

    it "should convert :zero" do
      :zero.to_v.should == [0, 0, 0]
    end

    it "should convert return [0, 0, 0] for others" do
      :any_random_symbol.to_v.should == [0, 0, 0]
    end
  end
  
  describe "convertion to normal vector" do
    it "should convert :up, :y" do
      :up.to_n.should == [0, 1, 0]
      :y.to_n.should == [0, 1, 0]
    end

    it "should convert :down" do
      :down.to_n.should == [0, -1, 0]
    end

    it "should convert :left, :west" do
      :left.to_n.should == [-1, 0, 0]
      :west.to_n.should == [-1, 0, 0]
    end

    it "should convert :right, :east, :x" do
      :right.to_n.should == [1, 0, 0]
      :east.to_n.should == [1, 0, 0]
      :x.to_n.should == [1, 0, 0]
    end

    it "should convert :forward, :north" do
      :forward.to_n.should == [0, 0, -1]
      :north.to_n.should == [0, 0, -1]
    end

    it "should convert :zero" do
      :zero.to_n.should == [0, 0, 0]
    end

    it "should convert return [0, 0, 0] for others" do
      :any_random_symbol.to_n.should == [0, 0, 0]
    end
  end
end
