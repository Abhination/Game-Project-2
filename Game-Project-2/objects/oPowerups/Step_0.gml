if(!shopOpen && keyboard_check_pressed(ord("I")))
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
	//show_debug_message(global.items);
	if(keyboard_check_pressed(vk_down))
	{
		selected++;
		if(selected==itemCount1) selected=0;
	}
	
	if(keyboard_check_pressed(vk_up))
	{
		selected--;
		if(selected<0) selected=itemCount1-1;
	}
	
	//Use
	var arr = global.items[| selected];
	var item = arr[0];
	var price = arr[1];
	var quantity = global.inv[selected];
	
	if (keyboard_check_pressed(vk_enter) && global.inv[selected]>0) {
		//Add to inventory
		//ds_list_add(global.inventory, item);
		//updateActions();
		//Reduce money
		//show_debug_message(selected);
		//show_debug_message(global.inv[selected]);
		global.inv[selected]-=1;
		show_debug_message(global.inv);
		//global.player.gold -= price;
	}
}