class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    if @ship == nil then true else false end
  end

  def place_ship(ship_object)
    @ship = ship_object
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(test_ship = false)
    if test_ship == true && @ship != nil && @fired_upon == false
      "S"
    elsif @fired_upon == false
      "."
    elsif @fired_upon == true && @ship == nil
      "M"
    elsif @fired_upon == true && @ship.health == 0
      "X"
    elsif @fired_upon == true && @ship != nil
      "H"
    end
  end
end
