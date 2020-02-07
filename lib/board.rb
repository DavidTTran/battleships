require './lib/cell'
require 'pry'

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

  def is_occupied?(coordinates)
    coordinates.one? {|coordinate| @cells[coordinate].empty?}
  end


  def valid_placement?(ship_object, coordinates)
    consecutive_num = (1..4).to_a.join
    consecutive_letter = ("A".."D").to_a.join

    letter_arr = coordinates.map {|coordinate| coordinate.slice(0)}.join
    number_arr = coordinates.map {|coordinate| coordinate.slice(1).to_i}.join

    horizontal_check = (letter_arr.squeeze.size == 1 && consecutive_num.include?(number_arr))

    vertical_check = (number_arr.squeeze.size == 1 && consecutive_letter.include?(letter_arr))

    if (coordinates.size == ship_object.length) && (horizontal_check || vertical_check) && (is_occupied?(coordinates) == false)
      true
    else
      false
    end
  end

  def place(ship_object, coordinates)
      if (valid_placement?(ship_object, coordinates))
        coordinates.each do |coordinate|
          @cells[coordinate].place_ship(ship_object)
        end
      end
  end

  def render(test_ship = false)
    column1 = []
    column2 = []
    column3 = []
    column4 = []

    if test_ship == true
      @cells.map do |coordinate, cell|
        # binding.pry
        if coordinate[1].to_i == 1
          column1 << cell.render(true)
        elsif coordinate[1].to_i == 2
          column2 << cell.render(true)
        elsif coordinate[1].to_i == 3
          column3 << cell.render(true)
        elsif coordinate[1].to_i == 4
          column4 << cell.render(true)
        end
      end
    else
      @cells.map do |coordinate, cell|
        if coordinate[1].to_i == 1
          column1 << cell.render
        elsif coordinate[1].to_i == 2
          column2 << cell.render
        elsif coordinate[1].to_i == 3
          column3 << cell.render
        elsif coordinate[1].to_i == 4
          column4 << cell.render
        end
      end
    end
    "  1 2 3 4 \n" +
    "A #{column1[0]} #{column2[0]} #{column3[0]} #{column4[0]} \n" +
    "B #{column1[1]} #{column2[1]} #{column3[1]} #{column4[1]} \n" +
    "C #{column1[2]} #{column2[2]} #{column3[2]} #{column4[2]} \n" +
    "D #{column1[3]} #{column2[3]} #{column3[3]} #{column4[3]} \n"
  end
end
