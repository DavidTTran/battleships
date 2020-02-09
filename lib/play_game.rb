require './lib/ship'
require './lib/board'

class PlayGame

  attr_reader :player_board,
              :computer_board,
              # :player_cruiser,
              # :player_submarine,
              :computer_cruiser,
              :computer_submarine

  def initialize
    # @player_board = Board.new
    # @computer_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    # @computer_cruiser = Ship.new("Cruiser", 3)
    # @computer_submarine = Ship.new("Submarine", 2)
  end

  def game_menu
    puts "Welcome to BATTLESHIP!"
    puts "Enter 'p' to play. Enter 'q' to quit."
    print "> "

    player_input = gets.chomp.downcase

    while player_input != "p" || "q"
      if player_input == "p"
        game_setup
      elsif player_input == "q"
      else
        puts "Invalid input. Please enter 'p' or 'q'."
        print "> "
        player_input = gets.chomp.downcase
      end
    end
  end

  def game_setup
    puts "You need to place your two ships on the board."
    puts "The Cruiser is three units long and the Submarine is two units long."

    @player_board = Board.new
    @computer_board = Board.new

    place_player_ships(@player_cruiser)
    place_player_ships(@player_submarine)

    place_computer_cruiser
    place_computer_submarine

    puts "\n Setup complete. Game staring now... \n"
    sleep(1)
    game_start
  end

  def game_start
    until player_ships_sunk? || computer_ships_sunk?
      render_boards
      player_shot_feedback(player_fire_upon)
      computer_shot_feedback(computer_fire_upon)
    end
    game_end
  end

  def game_end
    if player_ships_sunk?
      puts "\n==========Game over! You lost..==========\n\n"
    else
      puts "\n==========Game over! You won!!==========\n\n"
    end
    game_menu
  end

  def player_ships_sunk?
    @player_submarine.sunk? && @player_cruiser.sunk?
  end

  def computer_ships_sunk?
    @computer_submarine.sunk? && @computer_cruiser.sunk?
  end

  def render_boards
    puts "\n=============COMPUTER BOARD============= \n"
    puts @computer_board.render(true)
    puts "==============PLAYER BOARD============== \n"
    puts @player_board.render(true)
    puts "========================================"
  end

  def player_ship_coords(ship)
    puts "\n ==============PLAYER BOARD=============="
    puts @player_board.render(true)

    puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces)"
    print "> "
    coordinates = gets.chomp.upcase.gsub(/[^0-9a-z ]/i, '').split(" ")
    until @player_board.valid_placement?(ship, coordinates)
        puts "Those are invalid coordinates. Please try again."
        print "> "
        coordinates = gets.chomp.upcase.gsub(/[^0-9a-z ]/i, '').split(" ")
    end
    coordinates
  end

  def place_player_ships(ship)
    @player_board.place(ship, player_ship_coords(ship))
  end

  def computer_submarine_coord(computer_submarine)
    com_sub_coord = @computer_board.cells.keys.sample(2)

    until @computer_board.valid_placement?(computer_submarine, com_sub_coord) && (com_sub_coord.all? {|coord| @computer_board.cells[coord].empty? == true})
      com_sub_coord = @computer_board.cells.keys.sample(2)
    end
    com_sub_coord
  end

  def computer_cruiser_coord(computer_cruiser)
    com_cruiser_coord = @computer_board.cells.keys.sample(3)

    until @computer_board.valid_placement?(computer_cruiser, com_cruiser_coord) && com_cruiser_coord.all? {|coord| @computer_board.cells[coord].empty? == true}
      com_cruiser_coord = @computer_board.cells.keys.sample(3)
    end
    com_cruiser_coord
  end

  def place_computer_cruiser
    @computer_cruiser = Ship.new("cruiser", 3)
    @computer_board.place(computer_cruiser, computer_cruiser_coord(computer_cruiser))
  end

  def place_computer_submarine
    @computer_submarine = Ship.new("submarine", 2)
    @computer_board.place(computer_submarine, computer_submarine_coord(computer_submarine))
  end

  def player_fire_upon
    puts "Enter the coordinate for your shot"
    print "> "

    player_shot = gets.chomp.upcase

    until @computer_board.valid_coordinate?(player_shot) && @computer_board.cells[player_shot].fired_upon? == false
      puts "Invalid. Please enter a valid coordinate for your shot"
      print "> "
      player_shot = gets.chomp.upcase
    end

    @computer_board.cells[player_shot].fire_upon
    player_shot
  end

  def computer_fire_upon
    computer_shot = @player_board.cells.keys.sample

    until @player_board.cells[computer_shot].fired_upon? == false
      computer_shot = @player_board.cells.keys.sample
    end

    @player_board.cells[computer_shot].fire_upon
    computer_shot
  end

  def player_shot_feedback(player_fire)
    if @computer_board.cells[player_fire].empty?
      puts "\nYour shot missed!"
    elsif @computer_board.cells[player_fire].ship.health < 1
      puts "\nYour shot sunk an enemy ship!"
    else
      puts "\nYour shot hit an enemy ship!"
    end
  end

  def computer_shot_feedback(computer_fire)
    if @player_board.cells[computer_fire].empty?
      puts "\nThe enemy shot missed!"
    elsif @player_board.cells[computer_fire].ship.health < 1
      puts "\nThe enemy shot sunk your ship!"
    else
      puts "\nThe enemy shot hit your ship!"
    end
  end
end
