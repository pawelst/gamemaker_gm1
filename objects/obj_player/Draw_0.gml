// Draw the player sprite (default drawing)
draw_self();

// Set the drawing color and font (optional)
draw_set_color(c_white);   // Set text color to white
draw_set_font(fnt_default); // Optional: Set a specific font

// Draw the wood count in the top-right corner of the screen
var wood_text = "Wood: " + string(tree_count); // Create the text to display
var text_x = display_get_width() - 100; // 100px padding from the right
var text_y = 10; // 10px from the top

// Draw the text on the screen
draw_text(text_x, text_y, wood_text);