/// @description Insert description here
// You can write your code in this editor
// Define the map boundaries (adjust according to your room size)
var map_width = room_width;  // Use the full room width
var map_height = room_height; // Use the full room height

// Loop to create 100 trees at random positions
for (var i = 0; i < 100; i++) {
    var tree_x = irandom_range(32, map_width - 32); // Random X within the map, avoid edges
    var tree_y = irandom_range(32, map_height - 32); // Random Y within the map, avoid edges

    // Create the tree at the random position
    instance_create_layer(tree_x, tree_y, "Instances", obj_tree);
}