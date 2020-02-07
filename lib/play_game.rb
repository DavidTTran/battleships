require './lib/ship'
require './lib/board'

class PlayGame

  attr_reader :player_board,
              :computer_board,
              :player_cruiser,
              :player_submarine,
              :computer_cruiser,
              :computer_submarine

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter 'p' to play. Enter 'q' to quit."

    player_input = gets.chomp.downcase

    if player_input == "p"
      puts "You need to place your two ships on the board."
      puts "The Cruiser is three units long and the Submarine is two units long."
      setup_player_ships(@player_cruiser)
      setup_player_ships(@player_submarine)

      setup_computer_submarine(@computer_submarine)
      setup_computer_cruiser(@computer_cruiser)
      puts @computer_board.render(true)

      puts "\n\n Setup complete. Game staring now... \n\n"

      until player_ships_sunk? || computer_ships_sunk?
        player_fire_upon
        computer_fire_upon
      end
      puts "Game over!"

    elsif player_input == "q"
    end
  end

  def player_ships_sunk?
    @player_submarine.sunk? && @player_cruiser.sunk?
  end

  def computer_ships_sunk?
    @computer_submarine.sunk? && @computer_cruiser.sunk?
  end

  def setup_player_ships(ship)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render

    puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
    print "> "
    coordinates = gets.chomp.upcase.split(" ")
    until @player_board.valid_placement?(ship, coordinates)
        puts "Those are invalid coordinates. Please try again."
        print "> "
        coordinates = gets.chomp.upcase.split(" ")
     end
     @player_board.valid_placement?(ship, coordinates)
     @player_board.place(ship, coordinates)
     puts "==============PLAYER BOARD=============="
     puts @player_board.render(true)
  end

  def setup_computer_submarine(computer_submarine)
    rand_coordinate1 = @computer_board.cells.keys.sample
    rand_coordinate2 = @computer_board.cells.keys.sample

    until @computer_board.valid_placement?(computer_submarine, [rand_coordinate1, rand_coordinate2])
      rand_coordinate1 = @computer_board.cells.keys.sample
      rand_coordinate2 = @computer_board.cells.keys.sample
    end
    @computer_board.place(computer_submarine, [rand_coordinate1, rand_coordinate2])
  end

  def setup_computer_cruiser(computer_cruiser)
    rand_coordinate3 = @computer_board.cells.keys.sample
    rand_coordinate4 = @computer_board.cells.keys.sample
    rand_coordinate5 = @computer_board.cells.keys.sample

    until @computer_board.valid_placement?(computer_cruiser, [rand_coordinate3, rand_coordinate4, rand_coordinate5])
      rand_coordinate3 = @computer_board.cells.keys.sample
      rand_coordinate4 = @computer_board.cells.keys.sample
      rand_coordinate5 = @computer_board.cells.keys.sample
    end
    @computer_board.place(computer_cruiser, [rand_coordinate3, rand_coordinate4, rand_coordinate5])
  end

  def player_fire_upon
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(true)

    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)

    puts "Enter the coordinate for your shot"
    print "> "

    player_fire = gets.chomp.upcase

    until @computer_board.valid_coordinate?(player_fire)
      puts "Invalid. Please enter a valid coordinate for your shot"
      print "> "
    end

    @computer_board.cells[player_fire].fire_upon
  end

  def computer_fire_upon
    rand_coordinate = @computer_board.cells.keys.sample

    until @computer_board.valid_coordinate?(rand_coordinate)
      rand_coordinate = @computer_board.cells.keys.sample
    end

    @player_board.cells[rand_coordinate].fire_upon
  end
end
