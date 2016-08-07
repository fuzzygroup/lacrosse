require 'spec_helper'

describe Quarter do
  before(:each) do
    @quarters = Quarter.all_quarters
    @q1 = @quarters[0]
    @q2 = @quarters[1]
    @q3 = @quarters[2]
    @q4 = @quarters[3]

    @player = Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
  end

  #pending "add some examples to (or delete) #{__FILE__}"
  describe "#currently_playing?" do
    it "should return false when the player is not currently playing" do
      @q1.currently_playing?(@player).should be_false
    end

    it "should return true when the player is currently_playing" do
      @q1.currently_playing << @player
      @q1.currently_playing?(@player).should be_true
    end
  end
end
