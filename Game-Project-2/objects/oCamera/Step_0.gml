/// @description Update camera

if (instance_exists(follow))
{
	xTo = follow.x;
	yTo = follow.y;
}

x += (xTo - x) / 15;
y += (yTo - y) / 15;

x = clamp(x, viewWidthHalf, room_width-viewWidthHalf);
y = clamp(y, viewHeightHalf, room_width-viewHeightHalf);

camera_set_view_pos(camera, x - viewWidthHalf, y - viewHeightHalf);