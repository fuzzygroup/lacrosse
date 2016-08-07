class Player

  # todo
  #attr_accessor

  attr_reader :name
  attr_reader :positions
  attr_reader :never
  attr_reader :preference
  attr_reader :strong
  attr_reader :quarter1
  attr_reader :quarter2
  attr_reader :quarter3
  attr_reader :quarter4
  attr_reader :skip
  attr_reader :quarters_played

  attr_writer :name
  attr_writer :positions
  attr_writer :never
  attr_writer :preference
  attr_writer :strong
  attr_writer :quarter1
  attr_writer :quarter2
  attr_writer :quarter3
  attr_writer :quarter4
  attr_writer :skip
  attr_writer :quarters_played

  def is_playing_quarter?(quarter)
    return true if self.send(quarter.sym).is_a?(Position)
    return false
  end

  # tested
  def number
    parts = self.name.split("(")
    return parts.last.sub(/\)/,'').to_i
  end

  def can_play_position?(position)
    return true if self.positions.include?(position)
    return false
  end

  def played_position_last_quarter?(position, quarter_position)
    #return true if self.last_quarter_position
  end

  # return what position the player played in the specified quarter
  def just_played(quarter)
    return self.send(quarter.sym)
  end

  # return true if the player did not play the position the last quarter
  def should_play?(quarter, position)
    #return true if self.send(quarter) != position
    #raise self.last_quarter_position(quarter()
    return true if self.last_quarter_position(quarter) != position
    return false
  end

  # tested
  def can_play?(position)
    return true if self.positions.include?(position)
    return false
  end

  # tested
  def capitalized_name
    output = []
    parts = self.name.split(" ")
    parts.each do |part|
      if part =~ /^[A-Za-z]/
        output << part.capitalize
      else
        output << part
      end
    end
    return parts.join(' ')
  end

  # need a way to

  # tested
  def last_quarter_position(current_quarter)
    # return nil if current_quarter == "quarter1".to_sym
    # return self.quarter1 if current_quarter == "quarter2".to_sym
    # return self.quarter3 if current_quarter == "quarter3".to_sym
    # return self.quarter4 if current_quarter == "quarter2".to_sym
    # return nil

    case current_quarter.sym
    when :quarter1
      return nil
    when :quarter2
      return self.quarter1
    when :quarter3
      return self.quarter2
    when :quarter4
      return self.quarter3
    else
      return nil
    end
  end

  # tested
  def skip?(quarter)
    return true if self.skip.include?(quarter.sym)
    return false
  end

  # tested
  def is_strong?(position)
    return true if self.strong.include?(position)
    return false
  end

  # tested
  def prefers?(position)
    return true if self.preference.include?(position)
    return false
  end

  # can't make this work -- lacrosse.rb:52:in `initialize': wrong number of arguments (1 for 0) (ArgumentError)
  def initialize(name, positions, never, preference=[], strong=[], skip=nil)
    @name = name
    @positions = positions
    @never = never
    @preference = preference
    @strong = strong
    @skip = skip
    @quarters_played = 0
  end

  def alternate_positions
    alternates = []
    self.positions.each do |player_position|
      if self.strong.size > 0
        self.strong.each do |s|
          alternates << "**#{player_position}**" if s == player_position
        end
      elsif self.preference.size > 0
        self.preference.each do |p|
          alternates << "*#{player_position}*" if p == player_position
        end
      #end
      #
      # if self.strong == player_position
      #   alternates << "**#{player_position}**"
      # elsif self.preference == player_position
      #   alternates << "*#{player_position}*"
      else
        alternates << player_position
      end
    end
    #puts "#{indent}"
    alternates
  end


end
