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

      puts "\n Setup complete. Game staring now... \n"
      sleep(1)

      until player_ships_sunk? || computer_ships_sunk?
        render_boards
        player_shot_feedback(player_fire_upon)
        computer_shot_feedback(computer_fire_upon)
      end
      if player_ships_sunk?
        puts "\n==========Game over! You lost..==========\n"
        start
      else
        puts "\n==========Game over! You won!!==========\n"
        start
      end

    elsif player_input == "q"
    end
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

  def setup_player_ships(ship)
    puts "\n ==============PLAYER BOARD=============="
    puts @player_board.render(true)

    puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces)"
    print "> "
    coordinates = gets.chomp.upcase.split(" ")
    until @player_board.valid_placement?(ship, coordinates)
        puts "Those are invalid coordinates. Please try again."
        print "> "
        coordinates = gets.chomp.upcase.split(" ")
    end
    @player_board.place(ship, coordinates)
  end

  def setup_computer_submarine(computer_submarine)
    rand_coordinate1 = @computer_board.cells.keys.sample
    rand_coordinate2 = @computer_board.cells.keys.sample
    com_sub_coord = [rand_coordinate1, rand_coordinate2]

    until @computer_board.valid_placement?(computer_submarine, com_sub_coord) && com_sub_coord.all? {|coord| @computer_board.cells[coord].empty? == true}
      rand_coordinate1 = @computer_board.cells.keys.sample
      rand_coordinate2 = @computer_board.cells.keys.sample
      com_sub_coord = [rand_coordinate1, rand_coordinate2]
    end
    @computer_board.place(computer_submarine, com_sub_coord)
  end

  def setup_computer_cruiser(computer_cruiser)
    rand_coordinate3 = @computer_board.cells.keys.sample
    rand_coordinate4 = @computer_board.cells.keys.sample
    rand_coordinate5 = @computer_board.cells.keys.sample
    com_cruiser_coord = [rand_coordinate3, rand_coordinate4, rand_coordinate5]

    until @computer_board.valid_placement?(computer_cruiser, com_cruiser_coord) && com_cruiser_coord.all? {|coord| @computer_board.cells[coord].empty? == true}
      rand_coordinate3 = @computer_board.cells.keys.sample
      rand_coordinate4 = @computer_board.cells.keys.sample
      rand_coordinate5 = @computer_board.cells.keys.sample
      com_cruiser_coord = [rand_coordinate3, rand_coordinate4, rand_coordinate5]
    end
    @computer_board.place(computer_cruiser, com_cruiser_coord)
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
      puts "The enemy shot missed!"
    elsif @player_board.cells[computer_fire].ship.health < 1
      puts "The enemy shot sunk your ship!"
    else
      puts "The enemy shot hit your ship!"
    end
  end
end
