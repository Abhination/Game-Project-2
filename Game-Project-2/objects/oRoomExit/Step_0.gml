/// @description Room transitions

if (instance_exists(obj_player)) && (position_meeting(obj_player.x,obj_player.y,id))
{
	global.targetRoom = targetRoom;
	global.targetX = targetX;
	global.targetY = targetY;
	global.targetDirection = obj_player.direction;
	room_goto(targetRoom);
	instance_destroy();
}

