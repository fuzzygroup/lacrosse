require 'spec_helper'

describe Position do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  describe ".get_lacrosse_positions" do
    it "should give all positions" do
      Position.get_lacrosse_positions.size.should == 5
      
    end
  end
  
  describe "get_lacrosse_positions_without_alternates" do
    it "should skip alternates when specified" do
      Position.get_lacrosse_positions_without_alternates.size.should == 4
    end    
  end
  
  describe "#text" do
    it "should return the right text" do
      positions = Position.get_lacrosse_positions_without_alternates
      position = positions.first
      position.text.should == "Goalie"
    end
    
  end
end
