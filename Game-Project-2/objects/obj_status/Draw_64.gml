/// @description Insert description here
// You can write your code in this editor

//draw_sprite(spr_status, 0, (room_width/2)-512, (room_height/2)-256);
//draw_text())
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_set_font(fnt_smalldigits);

draw_sprite_ext(sprite_index, image_index, display_get_gui_width()/2, display_get_gui_height()/2, width/sprite_width, height/sprite_height, 0, c_white, image_alpha);

var detailsY = 0;

for(var i = 0; i < party_size; i++){
	detailsY = 0;
	
	for(var j = 0; j < 8; j++){
		if(j == 3){
			detailsY = 77;
		}
		
		draw_text(x + yBuffer + xBuffer*(i), y + detailsY + yBuffer + yBuffer*j, partyInfo[i][j]);
	}
	
}