/*//draw textbox
draw_sprite_stretched(spr_box,0,x,y,(850/2)/2,(200/2)/2);

//draw text
draw_set_font(fnt_text_24);
if(charCount<string_length(text[page]))
{
	charCount+=0.5;
}
textPart=string_copy(text[page],1,charCount);
//draw name
draw_set_color(c_yellow);
//draw_set_halign(fa_center);
draw_text(x+400,y,name);
//draw_set_halign(fa_left);
//drawpart of the text
draw_set_color(c_white);
draw_text_ext(x+xBuffer,y+stringHeight+yBuffer,textPart,stringHeight,boxWidth);