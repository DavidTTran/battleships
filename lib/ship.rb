class Ship
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length.to_i
    @health = length.to_i
  end

  def sunk?
    true if @health == 0
  end

  def hit
    @health -= 1
  end
end
