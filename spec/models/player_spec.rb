require 'spec_helper'

describe Player do
  before(:each) do
    positions = Position.get_lacrosse_positions_without_alternates
    @goalie = positions.first
    @defense = positions.second
    @attack = positions.last

    quarters = Quarter.all_quarters
    @q1 = quarters[0]
    @q2 = quarters[1]
    @q3 = quarters[2]
    @q4 = quarters[3]
  end

  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#capitalized_name" do
    it "should properly capitalize the player's name" do
      #(name, positions, never, preference=[], strong=[])
      #player = FactoryGirl.create(:player, :name => "oliver ossip (3)", :positions => [], :never => [], :preference => [], :strong => [])
      #player = Player.new("oliver ossip (3)", [], [], [],[])
      player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
      player.capitalized_name.should == "Alex Johnson (11)"
    end
  end

  describe "#is_strong?" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
    end

    it "should return true when a player is strong in the specified position" do
      @player.is_strong?(@goalie).should be_true
    end

    it "should return false when a player is NOT strong in the specified position" do
      @player.is_strong?(@attack).should be_false
    end
  end

  describe "#prefers?" do
    before(:each) do

      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
    end

    it "should return true when a player is strong in the specified position" do
      @player.prefers?(@defense).should be_true
    end

    it "should return false when a player is NOT strong in the specified position" do
      @player.prefers?(@attack).should be_false
    end
  end

  describe "#number" do
    it "should return the right number for the player" do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [:quarter3, :quarter4])
      @player.number.should == 11
    end
  end

  describe "#skip?" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [:quarter3, :quarter4])
    end

    it "should return true when a player has to skip the specified quarter" do
      @player.skip?(@q3).should be_true
      @player.skip?(@q4).should be_true
    end

    it "should return false when a player does not have to skip" do
      @player.skip?(@q1).should be_false
      @player.skip?(@q2).should be_false
    end
  end

  describe "#can_play_position?" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [@q3, @q4])
    end

    it "should return true when a player has to skip the specified quarter" do
      @player.can_play_position?(@goalie).should be_true
      @player.can_play_position?(@defense).should be_true
    end

    it "should return false when a player does not have to skip" do
      @player.can_play_position?(@middie).should be_false
      @player.can_play_position?(@attack).should be_false
    end
  end

  describe "last_quarter_position" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
      @player.quarter1 = @goalie
      @player.quarter2 = @defense
      @player.quarter3 = @middie
      @player.quarter4 = @attack
    end

    it "should return nil when it is quarter1" do
      @player.last_quarter_position(@q1).should be_nil
    end
    it "should return goalie when it is quarter2" do
      @player.last_quarter_position(@q2).should == @goalie
    end
    it "should return defense when it is quarter3" do
      @player.last_quarter_position(@q3).should == @defense
    end
    it "should return middie when it is quarter4" do
      @player.last_quarter_position(@q4).should == @middie
    end
  end
  
  describe "just_played" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
    end

    it "should return true for quarter1 defense when the player hasn't played that role yet" do
      @player.quarter2 = @defense
      @player.just_played(@q2).should == @defense
    end

    it "should return false for quarter2 defense when just played quarter1 defense" do
      @player.quarter1 = @goalie
      @player.just_played(@q1).should == @goalie
    end

  end

  describe "should_play?" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
    end

    it "should return true for quarter1 defense when the player hasn't played that role yet" do
      @player.should_play?(@q1, @defense)
    end

    it "should return false for quarter2 defense when just played quarter1 defense" do
      @player.quarter1 = @defense
      @player.should_play?(@q2, @defense).should be_false
    end

  end

  describe "can_play?" do
    before(:each) do
      @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
    end

    it "should return true for @defense" do
      @player.can_play?(@defense).should be_true
    end
    it "should return true for @goalie" do
      @player.can_play?(@goalie).should be_true
    end
    it "should return false for @attack" do
      @player.can_play?(@attack).should be_false
    end
    it "should return false for @middie" do
      @player.can_play?(@middie).should be_false
    end
  end
end
