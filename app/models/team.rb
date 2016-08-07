class Team

  # jared -- how avoid nils when we've allocated all the attack players to something else?
  # jared -- how deal with alternates ballooning up to 99 ???

  #
  # Dave's Thoughts
  #
  # Noticed Reid only got 1 quarter in there (2nd).  Can you force system to let everyone play 2 quarters before anyone plays 3?
  #
  # --> Also, somewhere soon, I would like to pick a “power” attack team of Carson, Reid, and maybe Evan and see if we have the ability to score at the sacrifice of some defense.  Not something for the program, but something to think about.
  #
  def self.pick_for_quarter_for_winning_game(players, quarter, position, already_playing = [], return_all = false)
    actually_playing = []
    all_possible_players = []

    # want to really take advantage of the strong attribute -- for q1 and q4

    # Let every play at least 2 quarters before anyone plays 3 quarters -- on player there is a quarters_played attribute
    
    # todo add weighting to add a rule where a player can only play 2 positions then 

    players.each do |player|
      if player.positions.include?(position)
        # 5/12 -- eliminated this if and end to prevent players who've already played a quarter in a position from playing it again in the next quarter; not yet smart on it (needs to add weighting in the future)
        #if !(player.last_quarter_position(quarter) == position) #<== bundle this as a method
          if !quarter.currently_playing.include?(player) # <=== bundle this as a method
            all_possible_players << player
          end
        #end
      end
    end

    # sorted_players = all_possible_players.sort_by(&:quarters_played).reverse.each do |player|
    #
    # end

    position.limit.times do
      player = nil
      case quarter.sym
      when :quarter1
        player = all_possible_players.delete_at(rand(all_possible_players.length))
      else
        0.upto(3) do |i|
          quarter_possibles = all_possible_players.select{|p| p.quarters_played == i }
          next if quarter_possibles.empty?
          player ||= quarter_possibles[rand(quarter_possibles.length)]
          all_possible_players.delete(player)

        end


        # all_possible_players.sort_by(&:quarters_played).group_by(&:quarters_played).each do |num_plays, grouped_players|
        #   puts "num_plays = #{num_plays} | #{grouped_players.size} "
        #   next if grouped_players.size < 1
        #   player = grouped_players.delete_at(rand(grouped_players.length))
        #   all_possible_players.delete(player)
        # end
      end
      if player
        player.send("quarter#{quarter.number}=".to_sym, position) # <== is this modifiying a local instance of the player or a global instance ???
        actually_playing << player
        quarter.currently_playing << player
        player.quarters_played += 1
      else
        puts "Hit nil player -- why???"
      end
    end
    return actually_playing, quarter
  end


  # next quarter needs to move to be a real object and take advantage of the currently_playing attribute

  # FEED argument in for winning versus stretching people

  #
  # strong_defense = players.select { |player| player.can_play?(@defense) && player.is_strong?(@defense) }
  # goalies = players.select { |player| player.can_play?(@defense) && player.is_strong(@defense) && !player.is_currently_playing(quarter) }
  #
  # goalies = players.select { |player| player.can_play?(@defense) && player.is_strong(@defense) && !quarter.currently_playing?(quarter) }

  def self.pick_for_quarter_for_winning_game_afternoon(players, quarter, position, already_playing = [], return_all = false)
    actually_playing = []
    all_possible_players = []
    players.each do |player|
      # logic
      #  add to the list of possible players if
      #    the player plays that position
      #    the player did NOT play that position in the previous quarter
      #    the player is NOT already playing during the quarter
      #    the player does not need to skip the quarter
      #if player.positions.include?(position) && player.last_quarter_position(quarter) != position && !already_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
      if player.positions.include?(position)
        if !(player.last_quarter_position(quarter) == position) #<== bundle this as a method
          if !quarter.currently_playing.include?(player) # <=== bundle this as a method
            all_possible_players << player
            ###quarter.currently_playing << player
          end
        end
      end

     # removed at jared's direction
     #  if player.positions.include?(position) && player.last_quarter_position(quarter) != position && !quarter.currently_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
     # #if player.can_play?(position) && player.last_quarter_position(quarter) != position && !quarter.currently_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
     #  #if player.positions.include?(position) && player.last_quarter_position(quarter) != position && !quarter.currently_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
     #    all_possible_players << player
     #    quarter.currently_playing << player
     #  end
    end

    # allow aborting out early for testing
    return all_possible_players, quarter if return_all

    # special case Q1 and Q4 to bias towards strength and preference

    # now pick the right person for each position
    #puts "Position.name: #{position.name} #{position.limit}"

    #all_possible_players.each do |player|
    position.limit.times do
      if quarter.sym == :quarter1 || quarter.sym == :quarter4
        players.each do |player|
          if player.is_strong?(position)
            actually_playing << player
            quarter.currently_playing << player
            pos_ctr = 0
            pos_to_delete = 0
            all_possible_players.each do |possible_player|
              if possible_player == player
                pos_to_delete = pos_ctr
              end
              pos_ctr = pos_ctr + 1
            end
            all_possible_players.delete_at(pos_to_delete)
          end
        end
        player = all_possible_players.delete_at(rand(all_possible_players.length))
        #player.send(quarter.sym)
        if player
          player.send("quarter#{quarter.number}=".to_sym, position) # <== is this modifiying a local instance of the player or a global instance ???
          actually_playing << player
          quarter.currently_playing << player
        else
          puts "Hit nil player -- why???"
        end
      else
        #player = all_possible_players.shift
        player = all_possible_players.delete_at(rand(all_possible_players.length))
        #player.send(quarter.sym)
        if player
          player.send("quarter#{quarter.number}=".to_sym, position) # <== is this modifiying a local instance of the player or a global instance ???
          actually_playing << player
          quarter.currently_playing << player
        else
          puts "Hit nil player -- why???"
        end
      end

    end
    return actually_playing, quarter


  end

  def self.summary_by_position(players, positions)
    puts ""
    puts "Totals: "
    Team.separator
    positions.each do |position|
      position_ctr = 0
      players.each do |player|
        position_ctr = position_ctr + 1 if player.can_play?(position)
      end
      puts "  #{position.text}: #{position_ctr} people can play this position"
    end
    puts ""

  end


  # * don't play players in the same role back to back (unless they only play one role)
  # * bias towards strength and preferences in q1 and q4 i.e. lead with caden on middie in q1
  # * a player can't play more than one scheduled role per quarter
  # * account for quarters to skip
  # this is a working iteration that doesn't account for a) giving people breaks or for strength
  def self.pick_for_quarter(players, quarter, position, already_playing = [], return_all = false)
    #raise quarter.inspect
    actually_playing = []
    all_possible_players = []
    players.each do |player|
      # logic
      #  add to the list of possible players if
      #    the player plays that position
      #    the player did NOT play that position in the previous quarter
      #    the player is NOT already playing during the quarter
      #    the player does not need to skip the quarter
      #if player.positions.include?(position) && player.last_quarter_position(quarter) != position && !already_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
      if player.positions.include?(position)
        if !(player.last_quarter_position(quarter) == position) #<== bundle this as a method
          if !quarter.currently_playing.include?(player) # <=== bundle this as a method
            all_possible_players << player
            ###quarter.currently_playing << player
          end
        end
      end

     # removed at jared's direction
     #  if player.positions.include?(position) && player.last_quarter_position(quarter) != position && !quarter.currently_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
     # #if player.can_play?(position) && player.last_quarter_position(quarter) != position && !quarter.currently_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
     #  #if player.positions.include?(position) && player.last_quarter_position(quarter) != position && !quarter.currently_playing.include?(player) #&& !player.skip.include?(quarter)#player.skip?(quarter)
     #    all_possible_players << player
     #    quarter.currently_playing << player
     #  end
    end

    # allow aborting out early for testing
    return all_possible_players, quarter if return_all

    # special case Q1 and Q4 to bias towards strength and preference

    # now pick the right person for each position
    #puts "Position.name: #{position.name} #{position.limit}"

    #all_possible_players.each do |player|
    position.limit.times do
      #player = all_possible_players.shift
      player = all_possible_players.delete_at(rand(all_possible_players.length))
      #player.send(quarter.sym)
      if player
        player.send("quarter#{quarter.number}=".to_sym, position) # <== is this modifiying a local instance of the player or a global instance ???
        actually_playing << player
        quarter.currently_playing << player
      else
        puts "Hit nil player -- why???"
      end
    end
    return actually_playing, quarter

    1.upto(position.limit) do
      all_possible_players.each do |player|
        actually_playing << player
        quarter.currently_playing << player
      end
    end

    return actually_playing, quarter
    # after making the decision of who to currently play then need to set quarter.currently_playing to match

    # now exclude the players who played the position last quarter

    # account for preference by adding them to the list 2x if quarter is 1 or 4

    # account for strong by adding them to the list 3x if quarter is 1 or 4

    # pick the players by throwing the dice and limiting it to the number of players the position requires

    quarter.currently_playing = actually_playing

    return actually_playing, quarter
  end

  def self.separator
    puts "========================================================================"
  end

  def self.quick_reference(players, goalie)
    puts "\n\nPlayer Quick Reference:"
    Team.separator
    players.each do |player|
      preference_text = ''
      if player.preference.size > 0
        preference_text = "while PREFERS #{player.preference.map(&:name).join(', ')} "
      end

      strong_text = ''
      if player.strong.size > 0
        strong_text = "but is STRONG at #{player.strong.map(&:name).join(', ')} "
      end

      never_text = ''
      if player.never.size > 0
        never_text = "and should NEVER play #{player.never.map(&:name).join(', ')}"
      end

      text = "    #{player.capitalized_name} CAN play: #{player.positions.map(&:name).join(', ')} #{strong_text} #{preference_text} #{never_text}"
      text = text.gsub(/ +/, ' ')
      puts " " + text

    end

    puts ""
    puts ""
    puts "Available Goalies Are:"
    Team.separator
    players.each do |player|
      if player.positions.include?(goalie)
        puts "  #{player.capitalized_name}"
      end
    end
  end

  def self.build_game_roster_with_history2(players, positions, quarters)
    # get all the available lacrosse positions
    ###positions = Position.get_lacrosse_positions_without_alternates

    # get all the quarters
    ###quarters = Quarter.all_quarters

    quarters.each do |quarter|
      puts "#{quarter.name}"
      Team.separator
      positions.each do |position|
        puts "  #{position.text}"
        # was working wed afternoon
        #players_for_position, quarter = Team.pick_for_quarter(players, quarter, position)
        players_for_position, quarter = Team.pick_for_quarter_for_winning_game(players, quarter, position)
        ###players_for_position, quarter = Team.pick_for_quarter_for_winning_game(players, quarter, position)
        #puts "    #{players_for_position.size} <== size of players_for_position"
        #raise players_for_position.inspect
        players_for_position.each do |player|
          puts "    #{player.try(:capitalized_name)}"
        end
      end
      alternates = []
      players.each do |player|
        #raise player.inspect
        #puts "    #{player.try(:capitalized_name)}" unless player.is_playing_quarter?(quarter)
        alternates << player unless player.is_playing_quarter?(quarter)
      end
      if alternates.size > 0
        puts "  Alternate Players Available:"
        alternates.each do |alternate|
          puts "    #{alternate.try(:capitalized_name)}"
        end
      end
    end
  end

  def self.build_game_roster_with_history(players)
    # get all the available lacrosse positions
    positions = Position.get_lacrosse_positions

    # get all the quarters
    quarters = Quarter.all_quarters

    quarters.each do |quarter|
      puts "#{quarter.name}"
      positions.each do |position|
        puts "  #{position.text}"

        all_possible_players, quarter = Team.pick_for_quarter(players, quarter, position, [], true)

        raise all_possible_players.size.inspect

        if position.name == :alternates
          # output anyone who isn't currently playing during the quarter
          players.each do |player|
            if quarter.currently_playing.include?(player.name)
            else
              puts "    #{player.name} #{player.alternate_positions.join(", ")}"
            end
          end
        else

          raise Team.

          position_ctr = 1
          players.each do |player|
            # available_players_for_position <== really need to do this
            # make sure that he didn't play earlier
            # make sure he isn't currently playing
            # weight it for strength
            # weight it for preference
            #if player.positions.include?(position) && position_ctr <= players_per_position[position]
            #if player.can_play_position?(position) && position_ctr <= players_per_position[position] && !quarters[quarter_sym][:currently_playing].include?(player.name)
            if player.can_play_position?(position.name) && position_ctr <= position.limit && !quarter.currently_playing.include?(player.name) #&& player.quarter_position != need a check here that your last position wasn't the same as this position
              puts "    " + player.name
              position_ctr = position_ctr + 1
              #quarters[quarter_sym] = []
              #quarters[quarter_sym] << player.name
              #raise quarters.inspect
              #quarters[quarter_sym][:currently_playing] << player.name
              quarter.currently_playing << player.name
              #player.send(quarter_position_sym, position.name)
              #player.send("#{quarter_position}=".to_sym, position.name)
              #player.send("#{quarter_sym.to_s}=".to_sym, position.name)
              player.send("quarter#{quarter.number}=".to_sym, position.name)
            end
          end
        end
      end
    end

  end

  # 3 defenders, 3 attack, 3 middie, 1 goalie but optimized for 4 quarters -- need to randomize it so we don't always have the same people and add history so we don't repeat if we can avoid it
  # need to give kids time off also
  def self.build_game_roster(players)

    quarters = {}
    quarters[:quarter1] = {}
    quarters[:quarter2] = {}
    quarters[:quarter3] = {}
    quarters[:quarter4] = {}

    quarters[:quarter1][:goalie] = []
    quarters[:quarter1][:defense] = []
    quarters[:quarter1][:currently_playing] = []

    1.upto(4) do |quarter|
      puts "Quarter: #{quarter}"
      quarter_sym = "quarter#{quarter}".to_sym
      quarter_position = "quarter#{quarter}_position"
      quarters[quarter_sym] = {}
      quarters[quarter_sym][:currently_playing] = []
      #raise quarters[quarter_sym].inspect
      #[:goalie, :defense, :middie, :attack, :alternates].each do |position|
      Position.get_lacrosse_positions.each do |position|
        if position.name == :alternates
          # output anyone not yet assigned
          puts " " + position.text
          players.each do |player|
            if quarters[quarter_sym][:currently_playing].include?(player.name)
              # do nothing
            else
              #puts "    " + player.name + " (#{player.positions.join(", ")})"
              puts "    " + player.name + " (#{player.alternate_positions.join(", ")})"
            end
          end
        else
          # NON ALTERNATE ROLES
          puts "  " + position.text
          position_ctr = 1
          players.each do |player|
            # available_players_for_position <== really need to do this
            # make sure that he didn't play earlier
            # make sure he isn't currently playing
            # weight it for strength
            # weight it for preference
            #if player.positions.include?(position) && position_ctr <= players_per_position[position]
            #if player.can_play_position?(position) && position_ctr <= players_per_position[position] && !quarters[quarter_sym][:currently_playing].include?(player.name)
            if player.can_play_position?(position.name) && position_ctr <= position.limit && !quarters[quarter_sym][:currently_playing].include?(player.name) #&& player.quarter_position != need a check here that your last position wasn't the same as this position
              puts "    " + player.name
              position_ctr = position_ctr + 1
              #quarters[quarter_sym] = []
              #quarters[quarter_sym] << player.name
              #raise quarters.inspect
              quarters[quarter_sym][:currently_playing] << player.name
              #player.send(quarter_position_sym, position.name)
              #player.send("#{quarter_position}=".to_sym, position.name)
              player.send("#{quarter_sym.to_s}=".to_sym, position.name)
            end
          end
        end

      end
    end
  end

  # cut down version of game roster -- 2 defenders, 2 attack, 2 mid, 1 goalie <== per side
  def self.build_scrimmage_roster(players)
  end

  def self.summarize_player_time(players)
    puts "Player Time"
    Team.separator
    players.each do |player|
      puts "  #{player.name} is playing: #{player.quarters_played} quarters"
    end
  end


end
