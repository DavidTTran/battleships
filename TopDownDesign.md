### Battleship Game

### Iteration 1
```
1. Create Ship class (with (name, and size))
  1.1 Attributes/Methods
    1.1.1 Name
    1.1.2 Size
      1.1.3 Health
        1.1.3.1 Health changes when hit
        1.1.3.2 Health updates until it hits 0
          1.1.3.2.1 Sunk? returns true when health = 0
  1.2 Create tests
2. Create cell object (with (coordinate))
  2.1 Attributes/Methods
    2.1.1 Coordinates
    2.1.2 Is empty?
    2.1.3 Has a ship? 
    2.1.4 Has been fired on?
      2.1.4.1 Attribute changes when fired upon
        2.1.4.1.1 Ship health changes when fired upon
    2.1.5 Render cell based on attributes
      2.1.5.1 Empty (".")
      2.1.5.2 Ship ("S")
      2.1.5.3 Ship hit ("H")
      2.1.5.4 Dead ship ("X")
  2.2 Create tests
```
### Iteration 2
```
3. Create Board class (initializes with (name, coordinates))
  3.1 Attributes
    3.1.1 Hash with coordinates (for a 4x4 board)
      3.1.1.1 Validate coordinates - Check against hash
  3.2 Checks the argument coordinates for valid placement
    3.2.1 Number of coordinates given compared to size of ship
    3.2.2 Consecutive letters ("A1", "C1")
    3.2.3 Consecutive numbers ("A1", "A2", "A4")
    3.2.4 Diagonals ("A1", "B2")
    3.2.5 Overlapping ships
  3.3 Place ship if valid placement returns true
  3.4 Render board
    3.4.1   "  1 2 3 4 \n" +
            "A S S S . \n" +
            "B . . . . \n" +
            "C . . . . \n" +
            "D . . . . \n"
      3.4.1.1 Empty if no shots fired
      3.4.1.2 "M" if shot fired but missed
      3.4.1.3 "H" if shot fired and hit
      3.4.1.4 "X" if shot fired and ship has 0 health
  3.5 Create tests
```
### Iteration 3
```
4. Create Game class
  4.1 Ask to start game
    4.1.1 'q' or 'p' if incorrect input, reask
    4.1.2 Guidelines on placing player ship - Show board
      4.1.2.1 Cruiser (3 spaces)
        4.1.2.1.1 Check valid placement?
          4.1.2.1.1.1 Place ship
      4.1.2.2 Submarine (2 spaces)
        4.1.2.1.2 Check valid placement?
          4.1.2.1.1.2 Place ship
    4.1.3 Reask if placements invalid
      
  4.2 Computer method?
    4.2.1 Uses .sample to randomly select cells from the hash to place ship
      4.2.1.1 Check coordinates with valid_placement?
        4.2.1.1.1 If valid? place_ship
      4.1.1.2 Else get more coordinates
    4.2.2 Uses .sample to randomly select cells to fire_upon
      4.1.2.1 Checks if cell @fired_upon is false
        4.1.2.1.1 If true fire_upon
          4.1.2.1.1.1 Else .sample another cell until valid
  4.3 "Take turns"
    4.3.1 Player fires
      4.3.1.1 Text confirmation on result of fire
    4.3.2 Computer fires
      4.3.2.1 Text confirmation on result of fire
    4.3.3 Render boards   =============COMPUTER BOARD=============
                            1 2 3 4
                          A M . . M
                          B . . . .
                          C . . . .
                          D . . . .
                          ==============PLAYER BOARD==============
                            1 2 3 4
                          A S S S .
                          B . M . .
                          C M . S .
                          D . . S .
  4.4 Loops until player_total_ship_health == 0 || computer_total_ship_health == 0
    4.4.1 Game ends with message
  4.5 Test by playing the game
```
