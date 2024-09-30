// Set the camera size (original resolution)
var camera_width = 640;
var camera_height = 480;

// Directly create the camera and assign it to the view (no need to check existence)
view_camera[0] = camera_create_view(0, 0, camera_width, camera_height, 0, obj_player, -1, -1, camera_width, camera_height);

// Set the camera view size (logical resolution)
camera_set_view_size(view_camera[0], camera_width, camera_height);

// Enable the first viewport and set its size to double the camera size (scaling)
view_set_visible(0, true);
view_set_wport(0, camera_width * 2); // Double the width
view_set_hport(0, camera_height * 2); // Double the height

// Attach the camera to the view
view_set_camera(0, view_camera[0]);

// Optional: Adjust GUI scaling if needed
display_set_gui_size(camera_width * 2, camera_height * 2);

