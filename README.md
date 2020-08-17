# Battleships
- Guidelines - https://backend.turing.io/module1/projects/battleship/
- Developed with Ruby 2.5.3

# Setup

`$ git clone git@github.com:DavidTTran/battleships.git`

# Playing the game

`$ ruby runner.rb`

- The game prompts the user to enter `p` to start the game
- Decide the size of the board (4 - 26 square board)
- Decide the number of ships you and the computer will have - the maximum is determined as half of the size of board
  - Each ship has a name and a length. Each ship has a minimum length of 2, and a default width of 1.
  - When placing each ship enter in a valid set of coordinates
     - Valid
       - `a1, a2, a3`
       - `b4, b5`
     - Invalid
       - `a3, a2, a1`
       - `b3, c4`
- The computer automatically generates its ships and placements
- The player and computer take turns firing shots
  - If a shot hits a ship, it's reflected as a message in the terminal, and a `H` on the corresponding board.
  - If a shot misses, it's reflected as a message in the terminal and a `M` on the corresponding board.
  - If a shot sinks a ship, it's reflected as a message in the terminal and all previous `H` are updated to an `X`
- The game proceeds until either the player's or computer's ships have all been sunk. (health reduced to 0)
  - The game can be ended forcefully with `control + c`
  
# Developers
- [David Tran](https://github.com/DavidTTran)
- [Kelsha Darby](https://github.com/kelshadarby)
