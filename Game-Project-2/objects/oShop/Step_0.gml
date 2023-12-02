if(!shopOpen && place_meeting(x,y+10,obj_player) && keyboard_check_pressed(ord("Z")))
{
	shopOpen=true;
	global.shop=true;
}
else if(shopOpen && keyboard_check_pressed(vk_escape))
{
	shopOpen=false;
	global.shop=false;
}

//if shop is open
if(shopOpen)
{
	if(keyboard_check_pressed(vk_down))
	{
		selected++;
		if(selected==itemCount) selected=0;
	}
	
	if(keyboard_check_pressed(vk_up))
	{
		selected--;
		if(selected<0) selected=itemCount-1;
	}
	
	//Buy
	var arr = items[| selected];
	var item = arr[0];
	var price = arr[1];
	
	if (keyboard_check_pressed(vk_enter) && global.gold >= price) {
		//Add to inventory
		ds_list_add(global.inv, item);
		
		//Reduce money
		global.gold -= price;
	}
}