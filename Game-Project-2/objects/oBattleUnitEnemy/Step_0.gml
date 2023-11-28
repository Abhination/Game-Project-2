event_inherited();
if(hp<=0)
{
	image_blend=c_red;
	image_alpha-=0.01;
	
	
	
	if(!killed){
		for(var i = 0; i<array_length(global.party); i++){
			if(global.party[i] != noone){
				gain_xp(global.party[i], xpValue);
			}
		}
		killed = true;
	}
	
	
	
	//room_restart();
	//instance_destroy();
	
}