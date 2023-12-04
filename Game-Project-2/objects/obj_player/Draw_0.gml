draw_self();

for(var i=0; i<ds_list_size(global.inventory); i++)
{
	draw_text(x,y+(i*30),global.inventory[| i]);
}