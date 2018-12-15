/// @description check_win(player);
/// @param player

/*
    Return true if the ds_grid, grid, contains a strand of n length of the
    same values (arg0) either horizontally, vertically, or diagonally.
*/

var player, count;
player = argument0;

// check horizontally
for (var i = 0; i < rows; i++) {
    for (var j = 0; j < cols - (needed - 1); j++) {
        count = 0;
        // define line start coordinate (for win)
        line_start_x = i;
        line_start_y = j;
        for (var k = 0; k < needed; k++) {
            if (ds_grid_get(grid, i, j + k) == player) {
                count++;
                // define line end coordinate (for win)
                line_end_x = i;
                line_end_y = j + k;
            }
        }
        if (count == needed) return true;
    }
}

// check vertically
for (var i = 0; i < rows - (needed - 1); i++) {
    for (var j = 0; j < cols; j++) {
        count = 0;
        line_start_x = i;
        line_start_y = j;
        for (var k = 0; k < needed; k++) {
            if (ds_grid_get(grid, i + k, j) == player) {
                count++;
                line_end_x = i + k;
                line_end_y = j;
            }
        }
        if (count == needed) return true;
    }
}

// check diagonal (top right to bottom left)
for (var i = needed - 1; i < rows; i++) {
    for (var j = needed - 1; j < cols; j++) {
        count = 0;
        line_start_x = i;
        line_start_y = j;
        for (var k = 0; k < needed; k++) {
            if (ds_grid_get(grid, i - k, j - k) == player) {
                count++;
                line_end_x = i - k;
                line_end_y = j - k;
            }
        }
        if (count == needed) return true;
    }
}

// check diagonal (top left to bottom right)
for (var i = needed - 1; i < rows; i++) {
    for (var j = 0; j < cols - (needed - 1); j++) {
        count = 0;
        line_start_x = i;
        line_start_y = j;
        for (var k = 0; k < needed; k++) {
            if (ds_grid_get(grid, i - k, j + k) == player) {
                count++;
                line_end_x = i - k;
                line_end_y = j + k;
            }
        }
        if (count == needed) return true;
    }
}

return false;
