// Player movement
var move_x = 0;
var move_y = 0;

// Limit player movement within the room boundaries
x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

// Check for arrow key presses
var up_key = keyboard_check(vk_up);
var down_key = keyboard_check(vk_down);
var left_key = keyboard_check(vk_left);
var right_key = keyboard_check(vk_right);

//image_angle=0;
		
if (up_key)
    {
		image_yscale=1;
        move_y -= movement_speed; // Move upward
    }
if (down_key)
    {
		image_yscale=-1;
        move_y += movement_speed; // Move downward
    }
if (left_key)
    {
			//image_angle=0;
        move_x -= movement_speed; // Move left
		image_xscale = -1;
    }
if (right_key)
    {
		//image_angle=0;
        move_x += movement_speed; // Move right
        image_xscale = 1; // Set the sprite to its original direction when moving right
    }
		
// Update the bee's position
x += move_x;
y += move_y;