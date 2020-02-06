require './lib/ship'
require './lib/board'

class PlayGame

  attr_reader :player_board, :computer_board, :cruiser, :submarine

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter 'p' to play. Enter 'q' to quit."

    player_input = gets.chomp.downcase

    if player_input == "p"
      setup_player_cruiser
      setup_player_submarine
    elsif player_input == "q"

    end
  end

    def setup_player_cruiser
      puts "You need to place your two ships on the board."
      puts "The Cruiser is three units long and the Submarine is two units long."
      puts "==============PLAYER BOARD=============="
      puts @player_board.render

      puts "Enter the coordinates for the Cruiser (3 spaces):"
      print "> "
      cruiser_coordinates = gets.chomp.upcase.split(" ")
      until @player_board.valid_placement?(@cruiser, cruiser_coordinates)
          puts "Those are invalid coordinates. Please try again:"
          print "> "
          cruiser_coordinates = gets.chomp.upcase.split(" ")
       end
       @player_board.valid_placement?(@cruiser, cruiser_coordinates)
       @player_board.place(@cruiser, cruiser_coordinates)
       puts "==============PLAYER BOARD=============="
       puts @player_board.render(true)
    end

    def setup_player_submarine
      puts "\n The Submarine is two units long."
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)

      puts "Enter the coordinates for the Submarine (2 spaces):"
      print "> "
      submarine_coordinates = gets.chomp.upcase.split(" ")
      until @player_board.valid_placement?(@submarine, submarine_coordinates)
          puts "Those are invalid coordinates. Please try again:"
          print "> "
          submarine_coordinates = gets.chomp.upcase.split(" ")
       end
       @player_board.valid_placement?(@submarine, submarine_coordinates)
       @player_board.place(@submarine, submarine_coordinates)
       puts "==============PLAYER BOARD=============="
       puts @player_board.render(true)
    end


  end





#sample from cell hash


# I have laid out my ships on the grid.
# You now need to lay out your two ships.
# The Cruiser is three units long and the Submarine is two units long.
#   1 2 3 4
# A . . . .
# B . . . .
# C . . . .
# D . . . .
# Enter the squares for the Cruiser (3 spaces):
# > A1 A2 A3
# When the user enters a valid sequence of spaces, the ship should be placed on the board, the new board with the ship should be shown to the user, and then the user should be asked to place the other ship.
# Enter the squares for the Submarine (2 spaces):
# > C1 C3
# Those are invalid coordinates. Please try again:
# > A1 B1
# A single turn consists of:
#
# Displaying the boards
# Player choosing a coordinate to fire on
# Computer choosing a coordinate to fire on
# Reporting the result of the Player’s shot
# Reporting the result of the Computer’s shot
# =============COMPUTER BOARD=============
#   1 2 3 4
# A M . . M
# B . . . .
# C . . . .
# D . . . .
# ==============PLAYER BOARD==============
#   1 2 3 4
# A S S S .
# B . M . .
# C M . S .
# D . . S .
# Enter the coordinate for your shot:
# > D5
# Please enter a valid coordinate:
# > Z1
# Please enter a valid coordinate:
# > A4
# Your shot on A4 was a miss.
# My shot on C1 was a miss.
# The game needs to handle all of the following results:
#
# A shot missed
# A shot hit a ship
# A shot sunk a ship
# It is possible that the user enters a coordinate they have already fired upon. You need to add something that informs the user that this is the case. You may choose to either prompt them again for a coordinate they haven’t fired on, or let them choose it again and inform them in the results phase that they selected this coordinate again.
