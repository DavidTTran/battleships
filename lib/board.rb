require './lib/cell'

class Board

  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship_object, coordinates)
    consecutive_num = [(1..4).to_a, (1..3).to_a, (2..4).to_a, [1,2], [2,3], [3,4]]
    consecutive_letter = [("A".."D").to_a, ("A".."C").to_a, ("B".."D").to_a, ["A", "B"], ["B", "C"], ["C", "D"]]

    letter_arr = coordinates.map {|coordinate| coordinate.slice(0)}
    number_arr = coordinates.map {|coordinate| coordinate.slice(1).to_i}

    letter_compare = (consecutive_letter.include?(letter_arr) || letter_arr.uniq.size == 1)

    number_compare = (consecutive_num.include?(number_arr) || number_arr.uniq.size == 1)

    if coordinates.size == ship_object.length && letter_compare && number_compare
      true
    else
      false
    end
  end

end

# pry(main)> board.valid_placement?(cruiser, ["A1", "A2"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["A2", "A3", "A4"])
# # => false
#Next, make sure the coordinates are consecutive:
# pry(main)> board.valid_placement?(cruiser, ["A1", "A2", "A4"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["A1", "C1"])
# # => false
#
# pry(main)> board.valid_placement?(cruiser, ["A3", "A2", "A1"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["C1", "B1"])
# # => false
