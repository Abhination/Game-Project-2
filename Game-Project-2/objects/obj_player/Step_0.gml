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
var left_key_release = (keyboard_check_released(ord("A")));
var right_key_release = (keyboard_check_released(ord("D")));
var down_key_release = keyboard_check_released(ord("S"));
var up_key_release = keyboard_check_released(ord("W"));

//image_angle=0;
		
if (up_key)
    {
		sprite_index = spr_player_WDown;
        move_y -= movement_speed; // Move upward
    }
if (up_key_release)
	{
		sprite_index = spr_player_Idling;	
	}
if (down_key)
    {
		sprite_index = spr_player_WDown;
        move_y += movement_speed; // Move downward
    }
if (down_key_release)
	{
		sprite_index = spr_player_Idling;
	}
if (left_key)
    {
		sprite_index = spr_player_WLeft;
        move_x -= movement_speed; // Move left
		
    }
	if (left_key_release)
	{
		sprite_index = spr_player_LLeft;
	}
if (right_key)
    {
		
		sprite_index = spr_player_WRight;
        move_x += movement_speed; // Move right
		
    }
if (right_key_release)
	{
		sprite_index = spr_player_LRight;
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
