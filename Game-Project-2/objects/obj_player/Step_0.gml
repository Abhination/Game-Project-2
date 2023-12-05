if(global.shop) exit;

// Player movement
var move_x = 0;
var move_y = 0;

// Limit player movement within the room boundaries
x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

// Check for arrow key presses
var up_key = keyboard_check(ord("W"));
var down_key = keyboard_check(ord("S"));
var left_key = keyboard_check(ord("A"));
var right_key = keyboard_check(ord("D"));

//image_angle=0;
		
if (up_key)
    {
		image_yscale=1;
        move_y -= movement_speed; // Move upward
    }
if (down_key)
    {
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


if(keyboard_check_pressed(ord("E")))
{
	if(myTextbox==noone)
	{
		myTextbox=instance_create_layer(x, y,"Text",obj_status);
		//myTextbox.text=myText;
		myTextbox.creator=self;
		//myTextbox.name=myName;
	}
	else {
		instance_destroy(myTextbox);
		myTextbox=noone;
	}
}

//show_debug_message(global.inv);
