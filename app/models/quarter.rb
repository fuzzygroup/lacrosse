class Quarter

  attr_reader :name
  attr_reader :number
  attr_reader :defense
  attr_reader :middie
  attr_reader :attack
  attr_reader :currently_playing
  attr_reader :sym

  attr_writer :name
  attr_writer :number
  attr_writer :defense
  attr_writer :middie
  attr_writer :attack
  attr_writer :currently_playing
  attr_writer :sym


  def initialize(name, number, goalie = [], defense = [], middie = [], attack = [], currently_playing = [], sym)
    @name = name
    @number = number
    @defense = defense
    @middie = middie
    @attack = attack
    @currently_playing = currently_playing
    @sym = sym
  end

  def self.all_quarters
    quarters = []
    quarters << Quarter.new("Quarter 1", 1, [], [], [], [], [], :quarter1)
    quarters << Quarter.new("Quarter 2", 2, [], [], [], [], [], :quarter2)
    quarters << Quarter.new("Quarter 3", 3, [], [], [], [], [], :quarter3)
    quarters << Quarter.new("Quarter 4", 4, [], [], [], [], [], :quarter4)

    return quarters

  end

  def currently_playing?(player)
    return true if self.currently_playing.include?(player)
    return false
  end

  # def not_playing?(player_name)
  #   return true if !self.currently_playing.include?(player)
  #   return false
  # end
  
  # def self.previous_quarter(quarter)
  #   cahse
  #   return nil if quarter == :quarter1
  #   return nil if quarter == :quarter1
  #   return nil if quarter == :quarter1
  #   return nil if quarter == :quarter1
  # end

end
