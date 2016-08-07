namespace :roster do

  # bialous: Lots of stats here.  I can not wait to see the game report and ground balls, etc!

  #
  # TODO -- add alternate display by whoever is not playing the current quarter
  # TODO -- add some blank lines for writing in
  # TODO -- add starting middie by looking at strongest

  task :generate2 => :environment do
    positions = Position.get_lacrosse_positions_without_alternates
    @goalie = positions[0]
    @defense = positions[1]
    @middie = positions[2]
    @attack = positions[3]

    quarters = Quarter.all_quarters
    @quarter1 = quarters[0]
    @quarter2 = quarters[1]
    @quarter3 = quarters[2]
    @quarter4 = quarters[3]

    # strong attack:
    # Carson, Reid, and maybe Evan

    players = []
    # players << Player.new("Evan Latham (12)",      [@attack, @defense, @goalie], [@middie], [@defense], [@attack, @middie])
    # players << Player.new("Bradley Bundurant (8)", [@attack, @middie, @goalie, @defense], [])
    # players << Player.new("Dawson Bichey (1)",[@attack, @middie, @goalie], [@defense])
    # ##players << Player.new("Gavin Hamman (2)", [@attack, @middie, @goalie, @defense], [])
    # players << Player.new("Gavin Hamman (2)", [@attack, @middie], [])
    #
    # players << Player.new("Oliver Ossip (3)", [@attack, @middie, @defense], [@defense]) #pulled goalie
    # players << Player.new("Reid Gerig (4)",   [@attack, @middie, @defense], [@goalie], [], [@attack])
    # players << Player.new("Trent Platt (6)",  [@attack, @middie], [@defense, @goalie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Zack West (7)",    [@attack, @middie,], [@goalie, @defense])
    # players << Player.new("Garrien Sharp (10)",    [@attack, @middie, @defense], [@goalie])
    # #players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [@quarter3, @quarter4])
    # # alex out on 4/17
    # #players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie]) unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Elijah Choi (14)",      [@attack, @middie, @defense], []) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Caleb Pallekonda (15)", [@attack, @middie, @defense], [@goalie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Carson Wiley (16)",     [@attack, @defense], [@goalie], [@defense],[@defense, @attack])
    # players << Player.new("Caden Clinger (9)",     [@attack, @middie], [@goalie], [@middie], [@middie])
    # players << Player.new("Jason Lewis (5)",  [@attack, @middie, @defense], [@goalie], [@quarter3, @quarter4])

    #players << Player.new("Ethan Lowry (EL)", [@attack, @middie, @defense], [])
    ####

    # 5/12 game
    # players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie]) unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Bradley Bundurant (8)", [@attack, @goalie], [@middie, @defense])
    # players << Player.new("Dawson Bichey (1)",[@middie, @goalie], [@defense, @attack])
    # players << Player.new("Evan Latham (12)",      [@defense, @goalie], [@middie, @attack], [@defense], [@attack, @middie])
    #
    # players << Player.new("Elijah Choi (14)",      [@defense], [@attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    # #players << Player.new("Caleb Pallekonda (15)", [@defense], [@goalie, @attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Garrien Sharp (10)",    [@defense], [@goalie, @attack, @middie])
    #
    # #players << Player.new("Caden Clinger (9)",     [ @middie], [@goalie, @attack], [@middie], [@middie])
    # players << Player.new("Reid Gerig (4)",   [@middie], [@goalie, @attack, @defense], [], [@attack])
    # #players << Player.new("Jason Lewis (5)",  [@middie], [@goalie, @attack, @defense], [@quarter3, @quarter4])
    # players << Player.new("Gavin Hamman (2)", [@middie], [@attack])
    # players << Player.new("Oliver Ossip (3)", [@middie], [@defense, @attack, @defense]) #pulled goalie
    #
    #
    # ##players << Player.new("Gavin Hamman (2)", [@attack, @middie, @goalie, @defense], [])
    #
    # players << Player.new("Trent Platt (6)",  [@attack], [@defense, @goalie, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Zack West (7)",    [@attack], [@goalie, @defense, @middie])
    # players << Player.new("Carson Wiley (16)",     [@attack], [@goalie, @defense], [@defense],[@defense, @attack])
    # #players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [@quarter3, @quarter4])
    # # alex out on 4/17
    #
    # Team.build_game_roster_with_history2(players, positions, quarters)
    #
    # Team.quick_reference(players, @goalie)
    #
    # Team.summary_by_position(players, positions)
    #
    # Team.summarize_player_time(players)

    #Zack
    #Alex
    #Evan
    #Gavin
    #Bradley
    #Caden
    #Dawson
    #Elijah
    #Carson
    #Trent
    #Oliver
    #Ethan

    # 5/18 game
    # players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie]) unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Bradley Bundurant (8)", [@attack, @goalie], [@middie, @defense])
    # players << Player.new("Dawson Bichey (1)",[@middie, @goalie], [@defense, @attack])
    # players << Player.new("Evan Latham (12)",      [@defense, @goalie], [@middie, @attack], [@defense], [@attack, @middie])
    #
    # players << Player.new("Elijah Choi (14)",      [@defense], [@attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Caleb Pallekonda (15)", [@defense], [@goalie, @attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    # #players << Player.new("Garrien Sharp (10)",    [@defense], [@goalie, @attack, @middie])
    #
    # players << Player.new("Caden Clinger (9)",     [ @middie], [@goalie, @attack], [@middie], [@middie])
    # players << Player.new("Ethan Lowry (99)",     [ @middie, @attack], [@goalie, @attack], [@middie], [@middie])
    # #players << Player.new("Reid Gerig (4)",   [@middie], [@goalie, @attack, @defense], [], [@attack])
    # players << Player.new("Jason Lewis (5)",  [@middie], [@goalie, @attack, @defense], [@quarter3, @quarter4])
    # players << Player.new("Gavin Hamman (2)", [@middie], [@attack])
    # players << Player.new("Oliver Ossip (3)", [@middie], [@defense, @attack, @defense]) #pulled goalie
    #
    #
    # ##players << Player.new("Gavin Hamman (2)", [@attack, @middie, @goalie, @defense], [])
    #
    # players << Player.new("Trent Platt (6)",  [@attack], [@defense, @goalie, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Zack West (7)",    [@attack], [@goalie, @defense, @middie])
    # players << Player.new("Carson Wiley (16)",     [@attack], [@goalie, @defense], [@defense],[@defense, @attack])
    # #players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [@quarter3, @quarter4])
    #
    #
    # Team.build_game_roster_with_history2(players, positions, quarters)
    #
    # Team.quick_reference(players, @goalie)
    #
    # Team.summary_by_position(players, positions)
    #
    # Team.summarize_player_time(players)


    #5/20 game

    # players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie]) unless Date.today == Date.new(2014,4,21)
    # #players << Player.new("Bradley Bundurant (8)", [@attack, @goalie], [@middie, @defense])
    # players << Player.new("Dawson Bichey (1)",[@middie, @goalie], [@defense, @attack])
    # #players << Player.new("Evan Latham (12)",      [@defense, @goalie], [@middie, @attack], [@defense], [@attack, @middie])
    # 
    # players << Player.new("Elijah Choi (14)",      [@defense], [@attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Caleb Pallekonda (15)", [@defense], [@goalie, @attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Garrien Sharp (10)",    [@defense], [@goalie, @attack, @middie])
    # 
    # players << Player.new("Caden Clinger (9)",     [ @middie], [@goalie, @attack], [@middie], [@middie])
    # players << Player.new("Aidan Craig (99)",     [ @middie], [@goalie, @attack], [@middie], [@middie])
    # players << Player.new("Reid Gerig (4)",   [@middie], [@goalie, @attack, @defense], [], [@attack])
    # players << Player.new("Jason Lewis (5)",  [@middie], [@goalie, @attack, @defense], [@quarter3, @quarter4])
    # players << Player.new("Gavin Hamman (2)", [@middie], [@attack])
    # players << Player.new("Oliver Ossip (3)", [@middie], [@defense, @attack, @defense]) #pulled goalie
    # 
    # 
    # players << Player.new("Trent Platt (6)",  [@attack], [@defense, @goalie, @middie]) #unless Date.today == Date.new(2014,4,21)
    # players << Player.new("Zack West (7)",    [@attack], [@goalie, @defense, @middie])
    # players << Player.new("Carson Wiley (16)",     [@attack], [@goalie, @defense], [@defense],[@defense, @attack])
    # #players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [@quarter3, @quarter4])
    # 
    # 
    # Team.build_game_roster_with_history2(players, positions, quarters)
    # 
    # Team.quick_reference(players, @goalie)
    # 
    # Team.summary_by_position(players, positions)
    # 
    # Team.summarize_player_time(players)
    
    # 5/22 game
    
    players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie]) unless Date.today == Date.new(2014,4,21)
    players << Player.new("Bradley Bundurant (8)", [@attack, @goalie], [@middie, @defense])
    players << Player.new("Dawson Bichey (1)",[@middie, @goalie], [@defense, @attack])
    players << Player.new("Evan Latham (12)",      [@defense, @goalie], [@middie, @attack], [@defense], [@attack, @middie])

    players << Player.new("Elijah Choi (14)",      [@defense], [@attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    #players << Player.new("Caleb Pallekonda (15)", [@defense], [@goalie, @attack, @middie]) #unless Date.today == Date.new(2014,4,21)
    players << Player.new("Garrien Sharp (10)",    [@defense], [@goalie, @attack, @middie])

    players << Player.new("Caden Clinger (9)",     [ @middie], [@goalie, @attack], [@middie], [@middie])
    #players << Player.new("Aidan Craig (99)",     [ @middie], [@goalie, @attack], [@middie], [@middie])
    players << Player.new("Reid Gerig (4)",   [@middie], [@goalie, @attack, @defense], [], [@attack])
    players << Player.new("Jason Lewis (5)",  [@middie], [@goalie, @attack, @defense], [@quarter3, @quarter4])
    players << Player.new("Gavin Hamman (2)", [@middie], [@attack])
    players << Player.new("Oliver Ossip (3)", [@middie], [@defense, @attack, @defense]) #pulled goalie


    players << Player.new("Trent Platt (6)",  [@attack], [@defense, @goalie, @middie]) #unless Date.today == Date.new(2014,4,21)
    players << Player.new("Zack West (7)",    [@attack], [@goalie, @defense, @middie])
    players << Player.new("Carson Wiley (16)",     [@attack], [@goalie, @defense], [@defense],[@defense, @attack])
    #players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie], [@quarter3, @quarter4])


    Team.build_game_roster_with_history2(players, positions, quarters)

    Team.quick_reference(players, @goalie)

    Team.summary_by_position(players, positions)

    Team.summarize_player_time(players)

  end

  task :generate => :environment do

    players = []
    #(name, positions, never, preference=[], strong=[])
    players << Player.new("Dawson Bichey (1)",[@attack, @middie, @goalie], [@defense])
    players << Player.new("Gavin Hamman (2)", [@attack, @middie, @goalie, @defense], [])
    players << Player.new("Oliver Ossip (3)", [@attack, @middie, @goalie], [@defense])
    players << Player.new("Reid Gerig (4)",   [@attack, @middie, @defense], [@goalie])
    players << Player.new("Jason Lewis (5)",  [@attack, @middie, @defense], [@goalie])
    players << Player.new("Trent Platt (6)",  [@attack, @middie], [@defense, @goalie])
    players << Player.new("Zack West (7)",    [@attack, @middie,], [@goalie, @defense])
    players << Player.new("Bradley Bundurant (8)", [@attack, @middie, @goalie, @defense], [])
    players << Player.new("Caden Clinger (9)",     [@attack, @middie], [@goalie], [@middie], [@middie])
    players << Player.new("Garrien Sharp (10)",    [@attack, @middie, @defense], [@goalie])
    players << Player.new("Alex Johnson (11)",     [@defense, @goalie], [@middie, @attack], [@defense], [@goalie])
    players << Player.new("Evan Latham (12)",      [@attack, @defense], [@goalie, @middie], [@defense])
    players << Player.new("Elijah Choi (14)",      [@attack, @middie, @defense], [])
    players << Player.new("Caleb Pallekonda (15)", [@attack, @middie, @defense], [@goalie])
    players << Player.new("Carson Wiley (16)",     [@attack, @defense], [@goalie], [@defense],[@defense])

    Team.build_game_roster(players)
    #raise players.last.quarter1.inspect


  end
end