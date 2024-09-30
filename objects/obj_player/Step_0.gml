//// Horizontal movement
//if (keyboard_check(vk_right)) {
//    x += 1;
//    sprite_index = spr_walk; // Use the walking sprite
//    image_speed = 0.2; // Adjust the animation speed
//    direction = 0; // Facing right
//	if (image_index < 49 || image_index > 53) {
//      image_index = 49; // Start at frame 51 for walking left
//    }
//} else if (keyboard_check(vk_left)) {
//    x -= 1;
//    sprite_index = spr_walk;
//    image_speed = 0.2;
//    direction = 180; // Facing left
//	if (image_index < 145 || image_index > 149) {
//      image_index = 145; // Start at frame 51 for walking left
//    }
//} else if (keyboard_check(vk_up)) {
//    y -= 1;
//    sprite_index = spr_walk;
//    image_speed = 0.2;
//    direction = 0;
//	if (image_index < 97 || image_index > 101) {
//      image_index = 97; // Start at frame 51 for walking left
//    }
//} else if (keyboard_check(vk_down)) {
//     y += 1;
//    sprite_index = spr_walk;
//    image_speed = 0.2;
//    direction = 0; // Facing left
	
//	if (image_index < 1 || image_index > 5) {
//      image_index = 1; // Start at frame 51 for walking left
//    }
	
//} else {
//    image_index = 0; // Set to the idle frame (frame 0)
//    image_speed = 0; // Stop animation when idle
//}

// Variables to store the target position for mouse control
if (!position_exists) {
    target_x = x;
    target_y = y;
    position_exists = true;
}

// Mouse input: Move towards the clicked target
if (mouse_check_button_pressed(mb_left)) {
    target_x = mouse_x;
    target_y = mouse_y;
}

// Calculate direction towards the target position for mouse-based movement
var dist_x = target_x - x;
var dist_y = target_y - y;
var distance_to_target = point_distance(x, y, target_x, target_y);

// Keyboard input: Horizontal movement
var key_pressed = false;

if (keyboard_check(vk_right)) {
    x += 1;
    sprite_index = spr_walk; // Use the walking sprite
    image_speed = 0.2; // Adjust the animation speed
    direction = 0; // Facing right
    if (image_index < 49 || image_index > 53) {
        image_index = 49; // Start at frame 49 for walking right
    }
    key_pressed = true;
} else if (keyboard_check(vk_left)) {
    x -= 1;
    sprite_index = spr_walk;
    image_speed = 0.2;
    direction = 180; // Facing left
    if (image_index < 145 || image_index > 149) {
        image_index = 145; // Start at frame 145 for walking left
    }
    key_pressed = true;
} else if (keyboard_check(vk_up)) {
    y -= 1;
    sprite_index = spr_walk;
    image_speed = 0.2;
    direction = 0;
    if (image_index < 97 || image_index > 101) {
        image_index = 97; // Start at frame 97 for walking up
    }
    key_pressed = true;
} else if (keyboard_check(vk_down)) {
    y += 1;
    sprite_index = spr_walk;
    image_speed = 0.2;
    direction = 0;
    if (image_index < 1 || image_index > 5) {
        image_index = 1; // Start at frame 1 for walking down
    }
    key_pressed = true;
}

// Mouse movement: Move the character toward the target if no keys are pressed
if (!key_pressed && distance_to_target > 2) {
    var direction_to_target = point_direction(x, y, target_x, target_y);
    var move_speed = 1; // Set the movement speed

    // Move the character towards the target
    x += lengthdir_x(move_speed, direction_to_target);
    y += lengthdir_y(move_speed, direction_to_target);

    // Set the walking animation based on direction
    sprite_index = spr_walk;
    image_speed = 0.2;

    // Determine the proper animation frames based on direction
    if (abs(dist_x) > abs(dist_y)) {
        // Moving horizontally
        if (dist_x > 0) {
            direction = 0; // Moving right
            if (image_index < 49 || image_index > 53) {
                image_index = 49; // Walking right
            }
        } else {
            direction = 180; // Moving left
            if (image_index < 145 || image_index > 149) {
                image_index = 145; // Walking left
            }
        }
    } else {
        // Moving vertically
        if (dist_y > 0) {
            if (image_index < 1 || image_index > 5) {
                image_index = 1; // Walking down
            }
        } else {
            if (image_index < 97 || image_index > 101) {
                image_index = 97; // Walking up
            }
        }
    }
} else if (!key_pressed) {
    // If no input and target is reached, set idle frame
    image_index = 0;
    image_speed = 0;
}


// Detect the nearest tree
var tree = instance_nearest(x, y, obj_tree);

// Check if the player is near the tree and not already chopping
if (tree != noone && point_distance(x, y, tree.x, tree.y) < 32 && !chopping) {
    // If the player presses the interaction key (e.g., spacebar), start chopping
    if (keyboard_check_pressed(vk_space)) {
        chopping = true;              // Start chopping
        chop_timer = 2 * room_speed;  // Set chop time to 2 seconds
        target_tree = tree;           // Store the tree being chopped
        show_debug_message("Started chopping tree.");
    }
}


if (chopping) {
	
    // Play chopping animation using frames 149 to 153
    sprite_index = spr_walk;  // Set the sprite (assuming the same walking sprite)
    image_speed = 0.5;
    if (image_index < 149 || image_index > 153) {
        image_index = 149;    // Start at frame 149
    }
    chop_timer -= 1; // Decrease the timer

    // If the timer reaches zero, the tree is chopped
    if (chop_timer <= 0) {
        chopping = false; // Stop chopping
        chop_timer = 0;   // Reset the timer

        // Remove the chopped tree
        with (target_tree) {
            instance_destroy(); // Destroy the tree
        }

        // Increase the player's tree count
        tree_count += 1;
        show_debug_message("Tree chopped! Total trees: " + string(tree_count));

        // Reset target_tree
        target_tree = noone;

        // If 5 or more trees are collected, notify the player
        if (tree_count >= 5) {
            show_message("You have collected enough trees to build a house!");
        }
    }
}




// If player has 5 or more trees, allow them to build a house
if (tree_count >= 5 && keyboard_check_pressed(ord("H"))) {
    // Build the house at the player's current position
    instance_create_layer(x, y, "Instances", obj_house);

    // Reset the tree count
    tree_count = 0;
    show_message("House built!");
}