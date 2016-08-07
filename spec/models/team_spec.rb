require 'spec_helper'

describe Team do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  before(:each) do
    @positions = Position.get_lacrosse_positions_without_alternates
    @goalie = @positions[0]
    @defense = @positions[1]
    @middie = @positions[2]
    @attack = @positions[3]
    
    @quarters = Quarter.all_quarters
    @quarter1 = @quarters[0]
    @quarter2 = @quarters[1]
    @quarter3 = @quarters[2]
    @quarter4 = @quarters[3]
  end

  describe ".pick_for_quarter" do
    before(:each) do
      @players = []
      #(name, positions, never, preference=[], strong=[], skip=nil)
      @dawson = Player.new("Dawson Bichey (1)",[@attack, @middie, @goalie], [@defense], [], [], [])


      @gavin = Player.new("Gavin Hamman (2)", [@attack, @middie, @goalie, @defense], [], [], [])
      @oliver = Player.new("Oliver Ossip (3)", [@attack, @middie, @goalie], [@defense], [], [], [])
      @reid = Player.new("Reid Gerig (4)",   [@attack, @middie, @defense], [@goalie], [], [], [])

      @players << @dawson
      @players << @gavin
      @players << @oliver
      @players << @reid
      

    end

    describe "for quarter 1" do
      it "should return dawson, gavin, oliver for goalie" do
        all_possible_players, @quarter1 = Team.pick_for_quarter(@players, @quarter1, @goalie, @quarter1, true)
        all_possible_players.include?(@dawson).should be_true
        all_possible_players.include?(@gavin).should be_true
        all_possible_players.include?(@oliver).should be_true
        all_possible_players.include?(@reid).should be_false
        @quarter1.currently_playing.size.should == 3
      end

      it "should return dawson, gavin, oliver, reid for attack" do
        #raise @attack.inspect
        all_possible_players, @quarter1 = Team.pick_for_quarter(@players, @quarter1, @attack, [], true)

        all_possible_players.include?(@dawson).should be_true
        all_possible_players.include?(@gavin).should be_true
        all_possible_players.include?(@oliver).should be_true
        all_possible_players.include?(@reid).should be_true
      end

      it "should return dawson, gavin, oliver, reid for middie" do
        #Team.pick_for_quarter(@players, :quarter1, @middie, true).should == [@dawson, @gavin, @oliver, @return]

        all_possible_players, @quarter1 = Team.pick_for_quarter(@players, @quarter1, @middie, [], true)
        all_possible_players.include?(@dawson).should be_true
        all_possible_players.include?(@gavin).should be_true
        all_possible_players.include?(@oliver).should be_true
        all_possible_players.include?(@reid).should be_true
      end

      it "should return reid for defense" do
        #Team.pick_for_quarter(@players, :quarter1, @defense, true).should == [@reid]
        all_possible_players, @quarter1 = Team.pick_for_quarter(@players, @quarter1, @defense, [], true)
        all_possible_players.include?(@reid).should be_true
        all_possible_players.include?(@dawson).should be_false
        all_possible_players.include?(@gavin).should be_true
        all_possible_players.include?(@oliver).should be_false
      end
    end

    describe "for quarter 2" do
      it "should return gavin, oliver for goalie BECAUSE dawson already played goalie in q1" do
        @dawson.quarter1 = @goalie
        all_possible_players, @quarter2 = Team.pick_for_quarter(@players, @quarter2, @goalie, [], true)
        all_possible_players.include?(@dawson).should be_false
        all_possible_players.include?(@gavin).should be_true
        all_possible_players.include?(@oliver).should be_true
        all_possible_players.include?(@reid).should be_false
      end
    end

    describe "for quarter 3" do
      it "should return gavin, oliver for goalie BECAUSE dawson already played goalie in q1" do
        @dawson.quarter2 = @goalie
        @gavin.quarter2 = @goalie
        #raise @quarter3.inspect
        all_possible_players, @quarter3 = Team.pick_for_quarter(@players, @quarter3, @goalie, [], true)
        #raise all_possible_players.inspect
        all_possible_players.include?(@dawson).should be_false
        all_possible_players.include?(@gavin).should be_false
        all_possible_players.include?(@oliver).should be_true
        all_possible_players.include?(@reid).should be_false
      end
    end

    describe "for quarter 4" do
    end

  end
end
