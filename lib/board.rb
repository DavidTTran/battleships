require './lib/cell.rb'

class Board

  attr_reader :cells, :size

  def initialize(size)
    @size = size
    @cells = {}
  end

  def create_cells
    ("A".."Z").to_a.first(@size).each do |letter|
      (1..@size).to_a.each do |number|
        @cells["#{letter}#{number}"] = Cell.new("#{letter}#{number}")
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def is_occupied?(coordinates)
    coordinates.one? {|coordinate| @cells[coordinate].empty?}
  end

  def horizontal_check(coordinates)
    consecutive_number = (1..26).to_a
    consecutive_letter = ("A".."Z").to_a
    letter_arr = coordinates.map {|coordinate| coordinate.slice(0)}
    number_arr = coordinates.map {|coordinate| coordinate.slice(1..2).to_i}

    (letter_arr.uniq.size == 1) && (number_arr.max - number_arr.min == coordinates.size - 1) &&
      (number_arr.last - number_arr.first == coordinates.size - 1)
  end

  def vertical_check(coordinates)
    consecutive_letter = ("A".."Z").to_a.join
    number_arr = coordinates.map {|coordinate| coordinate.slice(1..2).to_i}.uniq
    letter_arr = coordinates.map {|coordinate| coordinate.slice(0)}.join

    (number_arr.size == 1 && consecutive_letter.include?(letter_arr))
  end

  def valid_placement?(ship_object, coordinates)
    (coordinates.size == ship_object.length) && (horizontal_check(coordinates) ||
      vertical_check(coordinates)) && (is_occupied?(coordinates) == false)
  end

  def place(ship_object, coordinates)
    if (valid_placement?(ship_object, coordinates))
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship_object)
      end
    end
  end

  def render_top_row
    top_row = "  "

    @size.times do |column|
      if column > 8
        top_row += (column + 1).to_s + " "
      else
        top_row += (column + 1).to_s + "  "
      end
    end
    top_row += "\n"
    puts top_row
  end

  def render(show_ship = false)
    starting_letter = "A"
    grid = ""

    if show_ship == true
      render = @cells.map {|coordinate, cell| cell.render(true)}
      render_row = render.each_slice(@size).to_a
    else
      render = @cells.map {|coordinate, cell| cell.render}
      render_row = render.each_slice(@size).to_a
    end

    @size.times do |row|
      grid << "#{starting_letter}" + " " + render_row.first.each_slice(1).to_a.join("  ") + "\n"
      render_row.rotate!
      starting_letter = starting_letter.next
    end
    render_top_row
    grid
  end
end
