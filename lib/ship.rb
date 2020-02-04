class Ship

  attr_reader :name, :length, :health

  def initialize(name_parameter, length_parameter)
    @name = name_parameter
    @length = length_parameter
    @health = length
  end

  def sunk?
    if hit == 0
      true
    else
      false
    end
  end

  def hit
    @health -= 1
  end

end
