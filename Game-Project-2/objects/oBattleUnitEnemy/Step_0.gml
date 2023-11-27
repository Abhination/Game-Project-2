event_inherited();
if(hp<=0)
{
	image_blend=c_red;
	image_alpha-=0.01;
	global.party[0].hp=999;
	//room_restart();
	//instance_destroy();
	
}