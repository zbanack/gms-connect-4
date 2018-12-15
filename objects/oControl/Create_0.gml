/*
    Connect 4 Game Engine in GameMaker: Studio
    
    Zack Banack
        http://zackbanack.com/
        @zackbanack
    
    November 17, 2017
        v1.0
    
    Associated Tutorial/Walkthrough
        http://zackbanack.com/blog/connect4
        
    End User License Agreement (EULA)
        http://zackbanack.com/EULA
        
    Notes
        - This asset was created for GameMaker: Studio, so non-documented adjustments may be required to get it working with GameMaker: Studio 2.
        - Because this is a free asset, support will be limited.
*/

// define the board
rows = 7;                                           // horizontal slots
cols = 6;                                           // vertical slots
grid = ds_grid_create(rows, cols);                  // create grid
empty = 2;                                          // player 0 = 0, player 1 = 1, empty = 2
ds_grid_set_region(grid, 0, 0,
    rows - 1, cols - 1, empty);                     // make the grid empty
board_x = 64;                                       // x-coordinate in room to draw board (grid)
board_y = 0;                                        // y-coordinate in room to draw board (grid)
slot_size = 128;                                    // size of each node in the grid
slot_radius = 48;                                   // radius of the circle, either a chip or empty
board_width = rows * slot_size;                     // total width of board (px)
board_height = cols * slot_size;                    // total height of board (px)

// this is Connect *4*, so we need four same-colored chips in a row to win
needed = 4;

// define colors
__background_set_colour( c_black );
slot_color[0]   = make_colour_rgb(241, 196, 15);    // empty
slot_color[1]   = make_colour_rgb(231, 76, 60);     // player 0
slot_color[2]   = make_colour_rgb(18, 151, 224);    // player 1
container_color = make_colour_rgb(41, 197, 255);    // color of board
line_color      = make_colour_rgb(28, 42, 57);      // color of winning line

highlight_color = c_white;                          // color of highlighted column
highlight_alpha = 0.25;                             // transparency of highlight

// define player names and who goes first
player_name[0] = "Yellow";
player_name[1] = "Red";
turn = 0;

// win/lose conditions
game_over = false;  // game has ended
nobody_wins = false; // game ends in a draw

// winning sequence start and end x and y grid position to draw line
line_start_x    = -1;
line_start_y    = -1;
line_end_x      = -1;
line_end_y      = -1;
line_thickness  = 8;

/* */
/*  */
