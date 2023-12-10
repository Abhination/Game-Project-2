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
	if(keyboard_check_pressed(ord("S")))
	{
		selected++;
		if(selected==itemCount) selected=0;
	}
	
	if(keyboard_check_pressed(ord("W")))
	{
		selected--;
		if(selected<0) selected=itemCount-1;
	}
	
	//Buy
	var arr = global.items[| selected];
	var item = arr[0];
	var price = arr[1];
	
	if (keyboard_check_pressed(ord("Z")) && global.player.gold >= price) {
		//Add to inventory
		//ds_list_add(global.inventory, item);
		//updateActions();
		//Reduce money
		//show_debug_message(selected);
		//show_debug_message(global.inv[selected]);
		global.inv[selected]+=1;
		show_debug_message(global.inv);
		global.player.gold -= price;
		updateActions();
	}
}