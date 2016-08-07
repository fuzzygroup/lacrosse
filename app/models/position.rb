class Position


  attr_reader :name
  attr_writer :name

  attr_reader :limit
  attr_writer :limit

  def initialize(name, limit = nil)
    @name = name
    @limit = limit
  end

  def text
    return self.name.to_s.capitalize
  end

  # NOTE -- ORDER MATTERS HERE; do not blindly change or will break tests
  def self.get_lacrosse_positions
    positions = []
    positions << Position.new(:goalie, 1)
    positions << Position.new(:defense, 3)
    positions << Position.new(:middie, 3)
    positions << Position.new(:attack, 3)
    positions << Position.new(:alternates, 99)

    positions
  end

  # NOTE -- ORDER MATTERS HERE; do not blindly change or will break tests
  def self.get_lacrosse_positions_without_alternates
    # positions = self.get_lacrosse_positions
    # return positions[0..positions.size -]
    positions = []
    positions << Position.new(:goalie, 1)
    positions << Position.new(:defense, 3)
    positions << Position.new(:middie, 3)
    positions << Position.new(:attack, 3)
  end


end
