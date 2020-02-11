require './lib/cell'
require './lib/ship'

require 'pry'

class Board

  attr_reader :cells, :size

  def initialize(size)
    @size = size
    @cells = create_cells
  end

  def create_cells
    cells = cell_rows.zip(cell_columns).map(&:join)

    cells.reduce({}) do |hash, cell|
      hash[cell] = Cell.new("#{cell}")
      hash
    end
  end

  def cell_rows
    starting_letter = "A"
    letter_array = []

    @size.times do
      letter_array << starting_letter
      starting_letter = starting_letter.next
    end

    letters = []
    @size.times do
      letter_array.each do |letter|
        letters << "#{letter}"
      end
    end
    letters
  end

  def cell_columns
    starting_column_number = 0
    column_number_array = []

    until starting_column_number == @size
      starting_column_number += 1
      column_number_array << starting_column_number
    end

    numbers = []
    column_number_array.each do |number|
      numbers << ("#{number}" * @size).split('')
    end
    numbers = numbers.join.split('')
    numbers
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def is_occupied?(coordinates)
    coordinates.one? {|coordinate| @cells[coordinate].empty?}
  end

  def horizontal_consec_numbers
    starting_column_number = 0
    column_number_array = []

    until starting_column_number == @size
      starting_column_number += 1
      column_number_array << starting_column_number
    end
    column_number_array
  end

  def horizontal_check(coordinates)
    consecutive_num = horizontal_consec_numbers.join
    letter_arr = coordinates.map {|coordinate| coordinate.slice(0)}.join
    number_arr = coordinates.map {|coordinate| coordinate.slice(1).to_i}.join

    letter_arr.squeeze.size == 1 && consecutive_num.include?(number_arr)
  end

  def vertical_consec_letters
    starting_letter = "A"
    letters = []

    @size.times do
      letters << starting_letter
      starting_letter = starting_letter.next
    end
    letters
  end

  def vertical_check(coordinates)
    consecutive_letter = vertical_consec_letters.join
    number_arr = coordinates.map {|coordinate| coordinate.slice(1).to_i}.join
    letter_arr = coordinates.map {|coordinate| coordinate.slice(0)}.join

    number_arr.squeeze.size == 1 && consecutive_letter.include?(letter_arr)
  end

  def valid_placement?(ship_object, coordinates)
    (coordinates.size == ship_object.length) && (horizontal_check(coordinates) || vertical_check(coordinates)) && (is_occupied?(coordinates) == false)
  end

  def place(ship_object, coordinates)
      if (valid_placement?(ship_object, coordinates))
        coordinates.each do |coordinate|
          @cells[coordinate].place_ship(ship_object)
        end
      end
  end

  def create_rows
    rendered_cells = []
    @cells.values.each { |cell| rendered_cells << cell.render }
    sorted_cells = rendered_cells.sort
    sorted = sorted_cells.each_slice(@size).to_a
    sorted
  end

  def render_board
    rows = create_rows
     rows.each do |row|
       row
     end


  end

  # "  " + horizontal_consec_numbers.join(" ")
  # vertical_consec_letters.map { |letter| letter + "\n"}

#   def render(show_ship = false)
#     column1 = []
#     column2 = []
#     column3 = []
#     column4 = []
#
#     if show_ship == true
#       @cells.map do |coordinate, cell|
#         if coordinate[1].to_i == 1
#           column1 << cell.render(true)
#         elsif coordinate[1].to_i == 2
#           column2 << cell.render(true)
#         elsif coordinate[1].to_i == 3
#           column3 << cell.render(true)
#         elsif coordinate[1].to_i == 4
#           column4 << cell.render(true)
#         end
#       end
#     else
#       @cells.map do |coordinate, cell|
#         if coordinate[1].to_i == 1
#           column1 << cell.render
#         elsif coordinate[1].to_i == 2
#           column2 << cell.render
#         elsif coordinate[1].to_i == 3
#           column3 << cell.render
#         elsif coordinate[1].to_i == 4
#           column4 << cell.render
#         end
#       end
#     end
#     "  1 2 3 4 \n" +
#     "A #{column1[0]} #{column2[0]} #{column3[0]} #{column4[0]} \n" +
#     "B #{column1[1]} #{column2[1]} #{column3[1]} #{column4[1]} \n" +
#     "C #{column1[2]} #{column2[2]} #{column3[2]} #{column4[2]} \n" +
#     "D #{column1[3]} #{column2[3]} #{column3[3]} #{column4[3]} \n"
#   end
end

board = Board.new(6)
# p board.cells["A1"].render
board.create_rows
board.render_board
