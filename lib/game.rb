require './lib/ship'
require './lib/board'

class Game

  attr_reader :player_board,
              :computer_board,
              :player_ships,
              :computer_ships

  def initialize
    @player_ships = []
    @computer_ships = []
    @player_board = nil
    @computer_board = nil
  end

  def user_input
    gets.chomp
  end

  def game_menu
    puts "Welcome to BATTLESHIP!"
    print "Enter 'p' to play. Enter 'q' to quit.\n> "

    player_input = user_input.downcase

    while player_input != "p" || player_input != "q"
      if player_input == "p"
        game_setup
      elsif player_input == "q"
        puts "You've left the battlefield.."
        exit
      else
        print "Invalid input. Please enter 'p' or 'q'.\n> "
        player_input = user_input.downcase
      end
    end
  end

  def game_setup
    board_setup
    create_ships

    puts "You need to place your ships on the board."

    player_ships
    computer_ships

    print "\n Setup complete. Game staring now... \n"
    sleep(1)
    game_start
  end

  def board_setup
    print "Enter the size of the board you'd like to play with, it must be between 4 and 26.\n> "
    board_size = user_input.to_i
    until board_size < 27 && board_size > 3
      print "Invalid size.\n> "
      board_size = user_input.to_i
    end

    @player_board = Board.new(board_size)
    @computer_board = Board.new(board_size)
    @player_board.create_cells
    @computer_board.create_cells
  end

  def ship_setup
    puts "Now lets create the ships for you and me. You need at least 1 ship and can have a maximum of #{@player_board.size/2} ships."
    print "How many ships would you like to create?\n> "
    ship_count = user_input.to_i
    until ship_count > 0 && ship_count <= @player_board.size/2
      print "Invalid number of ships.\n> "
      ship_count = user_input.to_i
    end
    ship_count
  end

  def create_ships
    ship_count = ship_setup
    until @player_ships.size == ship_count
      print "Enter the name of your ship\n> "
      ship_name = user_input
      print "Enter the size of your ship. Your ship must be at least 2 cells in length\n> "
      ship_size = user_input.to_i
      until ship_size > 1 && ship_size <= @player_board.size
        print "Invalid size.\n> "
        ship_size = user_input.to_i
      end

      player_ship = Ship.new(ship_name, ship_size)
      computer_ship = Ship.new(ship_name, ship_size)
      @player_ships << player_ship
      @computer_ships << computer_ship
    end
  end

  def player_ship_coords(ship)
    puts "\n ==============PLAYER BOARD=============="
    puts @player_board.render(true)

    print "Enter the coordinates for the #{(ship.name).capitalize} (#{ship.length} spaces)\n> "
    coordinates = user_input.upcase.gsub(/[^0-9a-z ]/i, "").split(" ")
    until @player_board.valid_placement?(ship, coordinates)
      print "Those are invalid coordinates. Please try again.\n> "
      coordinates = user_input.upcase.gsub(/[^0-9a-z ]/i, "").split(" ")
    end
    coordinates
  end

  def place_player_ships(ship)
    @player_board.place(ship, player_ship_coords(ship))
  end

  def player_ships
    @player_ships.each do |ship|
      place_player_ships(ship)
    end
  end

  def computer_ship_coord(computer_ship)
    com_ship_coord = @computer_board.cells.keys.sample(computer_ship.length)

    until @computer_board.valid_placement?(computer_ship, com_ship_coord)
      com_ship_coord = @computer_board.cells.keys.sample(computer_ship.length)
    end
    com_ship_coord
  end

  def place_computer_ships(computer_ship)
    @computer_board.place(computer_ship, computer_ship_coord(computer_ship))
  end

  def computer_ships
    @computer_ships.each do |computer_ship|
      place_computer_ships(computer_ship)
    end
  end

  def game_start
    until player_ships_sunk? || computer_ships_sunk?
      render_boards
      player_shot_feedback(player_fire_upon)
      computer_shot_feedback(computer_fire_upon)
    end
    game_end
  end

  def player_ships_sunk?
    lose = @player_ships.all? { |player_ship| player_ship.sunk? }
    lose
  end

  def computer_ships_sunk?
    win = @computer_ships.all? { |computer_ship| computer_ship.sunk? }
    win
  end

  def render_boards
    puts "\n=============COMPUTER BOARD============= \n"
    puts @computer_board.render
    puts "==============PLAYER BOARD============== \n"
    puts @player_board.render(true)
    puts "========================================"
  end

  def player_fire_upon
    print "Enter the coordinate for your shot.\n> "
    player_shot = user_input.upcase

    until @computer_board.valid_coordinate?(player_shot) &&
      @computer_board.cells[player_shot].fired_upon? == false
        puts "Invalid. Please enter a valid coordinate for your shot.\n> "
        player_shot = user_input.upcase
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
    elsif @computer_board.cells[player_fire].ship.sunk?
      puts "\nYour shot sunk an enemy ship!"
    else
      puts "\nYour shot hit an enemy ship!"
    end
  end

  def computer_shot_feedback(computer_fire)
    if @player_board.cells[computer_fire].empty?
      puts "\nThe enemy shot missed!"
    elsif @player_board.cells[computer_fire].ship.sunk?
      puts "\nThe enemy shot sunk your ship!"
    else
      puts "\nThe enemy shot hit your ship!"
    end
  end

  def remove_ships
    @player_ships = []
    @computer_ships = []
  end

  def game_end
    render_boards
    if player_ships_sunk?
      puts "\n==========Game over! You lost..==========\n\n"
    else
      puts "\n==========Game over! You won!!==========\n\n"
    end
    remove_ships
    game_menu
  end
end
