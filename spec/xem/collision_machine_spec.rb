require_relative '../spec_helper.rb'

describe Xem::CollisionMachine do
  before do
    subject { Xem::CollisionMachine.new }
    @box1, @box2, @box3 = mock('box1'), mock('box2'), mock('box3')
    @box1.stubs(rectangle: {top_left: {x: 2, z: 7}, bottom_right: {x: 6, z: 2}})
    @box2.stubs(rectangle: {top_left: {x: 5, z: 3}, bottom_right: {x: 11, z: 0}})
    @box3.stubs(rectangle: {top_left: {x: 6, z: 2}, bottom_right: {x: 11, z: 0}})
  end

  describe "#track" do
    it "should add object if it has rectangle" do
      String.any_instance.stubs(:rectangle)
      expect {
        subject.track("string with rectangle")
      }.to change { subject.objects.count }.by(1)
    end

    it "should add multiple objects" do
      String.any_instance.stubs(:rectangle)
      expect {
        subject.track("string with rectangle", "another string")
      }.to change { subject.objects.count }.by(2)
    end

    it "should not add object if it has no rectangle" do
       expect {
        subject.track("string with rectangle")
      }.not_to change { subject.objects.count }
    end

    it "should not add object twice" do
      String.any_instance.stubs(:rectangle)
      object = "lolcat"
      subject.track object
      expect {
        subject.track object
      }.not_to change { subject.objects.count }
    end
  end
  
  describe "#overlapping?" do
    it "should return true" do
      subject.should be_overlapping(@box1.rectangle, @box2.rectangle)
    end

    it "should not be true" do
      subject.should_not be_overlapping(@box1.rectangle, @box3.rectangle)
    end

    it "should be true" do
      rectangle_1 = {
        top_left: {x: -0.3, z: 0.28},
        bottom_right: {x: 0.24, z: -0.31}
      }

      rectangle_2 = {
        top_left: {x: 0, z: 2},
        bottom_right: {x: 2, z: 0}
      }

      subject.should be_overlapping(rectangle_1, rectangle_2)
    end

    it "should return true" do
       rectangle_1 = {
        top_left: {x: 4, z: 4},
        bottom_right: {x: 3, z: 5}
      }

      rectangle_2 = {
        top_left: {x: 4.52, z: 3.79},
        bottom_right: {x: 2.52, z: 5.79}
      }

      subject.should be_overlapping(rectangle_1, rectangle_2)     
    end
  end

  describe "#touches?" do
    it "should be true for overlapping objects" do
      subject.touches?(@box1, @box2).should be_true
    end
  end

  describe "#collided_with(object)" do
    before do
      subject.track(@box1, @box2, @box3)
    end

    it "should return collided objects with object" do
      subject.collided_with(@box1).should == [@box2]
    end

    it "should return empty array" do
      box4 = mock("Box4")
      box4.stubs(rectangle: {top_left: {x: 90, z: 100}, bottom_right: {x: 100, z: 90}})
      subject.collided_with(box4).should be_empty
    end
  end
end
