
draw_sprite_stretched (spr_box, 0, x+700, y+350, widthFull*4, heightFull*1.45);
draw_set_color(c_white);
draw_set_font(fnt_text_24);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _desc= !(description == -1);
var _scrollPush =max(0, hover -(visibleOptionsMax-1));

for (l=0; l<(visibleOptionsMax+_desc);l++)
{
	if(l>=array_length(options)) break;
	draw_set_color(c_white);
	if(l==0) && (_desc)
	{
		draw_text(x+xmargin+700,y+ ymargin+350, description);
	}
	else
	{
		var _optionToShow=l-_desc+_scrollPush;
		var _str = options[_optionToShow][0];
		if(hover==_optionToShow-_desc)
		{
			draw_set_color(c_yellow);
		}
		if(options[_optionToShow][3]==false) draw_set_color(c_grey);
		draw_text(x+xmargin+700,350+y+ymargin+l*heightLine,_str);
	}
}

draw_sprite(spr_pointer,0, 650+x+xmargin+8,325+y+ymargin+((hover-_scrollPush)*heightLine)+7);
if(visibleOptionsMax<array_length(options))&&(hover<array_length(options)-1)
{
	draw_sprite(spr_DownArrow,0,650+x+widthFull*0.5,350+y+heightFull-7);
}
