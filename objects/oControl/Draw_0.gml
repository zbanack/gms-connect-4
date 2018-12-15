var offset, occupied_tops;
offset = (slot_size * 0.5);     // center the circle
occupied_tops = 0;              // how many columns are open; used to determine a full board

// draw the board container
draw_set_color(container_color);
draw_rectangle(board_x, board_y, board_x + board_width, board_y + board_height, false);

// game rendering and logic
for (var i = 0; i < rows; i++) { // cycle through rows
    var _x, _y; // temp positioning vars
    _x = board_x + (i * slot_size); // x-coordinate for slot
    
    // if the top space in each column is not free, increase the counter
    if (ds_grid_get(grid, i, 0) != empty) {
        occupied_tops++;
    }
    
    for (var j = 0; j < cols; j++) { // cycle through columns
        _y = board_y + (j * slot_size); // y-coordinate for slot

        // set slot color based on grid node value (0, 1, or 2) and draw the circle
        draw_set_color(slot_color[ds_grid_get(grid, i, j)]);
        draw_circle(_x + offset, _y + offset, slot_radius, false);
    }

    // check if the cursor is in the column
    if (point_in_rectangle(mouse_x, mouse_y, _x, board_y, _x + slot_size - 1, board_y + board_height)) {
    
        // condition to place a chip
        if (ds_grid_get(grid, i, 0) == empty && !game_over) {
        
            // draw the highlight
            draw_set_color(highlight_color);
            draw_set_alpha(highlight_alpha);
            draw_rectangle(_x, board_y, _x + slot_size, board_y + board_height, false);
            draw_set_alpha(1);
            
            // draw a chip ready to be dropped; indicates player's turn
            draw_set_color(slot_color[turn]);
            draw_circle(_x + offset, board_y, slot_radius, false);

            // player places a chip by pressing the left mouse button
            if (mouse_check_button_pressed(mb_left)) {
                // iterate through column from the bottom until we find an empty space
                var pos_y = cols;

                do {
                    pos_y--;
                }
                until(ds_grid_get(grid, i, pos_y) == empty);

                // update the empty position to the player number (0 or 1)
                ds_grid_set(grid, i, pos_y, turn);

                // check if the move resulted in a win
                var check = check_win(turn);

                // either end the game in success or change players
                if (check) {
                    game_over = true;
                } else {
                    turn = !turn;
                }
            }
        }
    }
    
    // if no columns are open, the entire board is full - end the game and nobody wins
    if (occupied_tops == rows && !game_over) {
        game_over = true;
        nobody_wins = true;
    }
}

// only execute the following code when the game ends
if (game_over) {

    // drawing winning line
    draw_set_color(line_color);
    draw_line_width(board_x + offset + (line_start_x * slot_size), board_y + offset + (line_start_y * slot_size),
        board_x + offset + (line_end_x * slot_size), board_y + offset + (line_end_y * slot_size), line_thickness);
    
    // prepare the text drawing
    draw_set_font(fnt32);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    
    // a string to show which player won
    var winner = "Player " + string(player_name[turn]) + " wins!";
    
    // change the string in the event neither player won
    if (nobody_wins) {
        winner = "Draw!";
    }
    
    // draw the text
    draw_text(room_width * 0.5, room_height * 0.5, string_hash_to_newline(string(winner) + "#Press space to play again."));

    // restart the game when the player presses space
    if (keyboard_check_pressed(vk_space)) {
        room_restart();
    }
}

