require_relative '../spec_helper.rb'

describe Xem do
  describe "#print" do
    before do
      @xem.font_file = File.join(File.expand_path("."), "spec", "fixtures", "simple.tga")
    end
    
    describe "color" do
      it "should allow to specify as array" do
        @xem.print([0, 0], [1.0, 1.0, 0], "Text").should be_true
      end
      
      it "should allow to specify as hex_code string" do
        @xem.print([0, 0], 'ffff00', "Text").should be_true
      end

      it "should allow to specify as hex_code symbol" do
        @xem.print([0, 0], :_ffff00, "Text").should be_true
      end
    end
  end
end
