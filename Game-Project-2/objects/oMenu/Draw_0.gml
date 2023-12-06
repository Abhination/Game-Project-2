
draw_sprite_stretched (spr_box, 0, x+620, y+290,549, 350);
draw_set_color(c_white);
draw_set_font(fnt_text_24);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _desc= !(description == -1);
var _scrollPush =max(0, hover -(visibleOptionsMax-1));

//Draw Heading
draw_set_color(c_gray);
draw_text(x+675,y+290,"ACTIONS");


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
		draw_text(x+xmargin+665,330+y+ymargin+l*heightLine,_str);
	}
}
draw_sprite(spr_pointer,0, 615+x+xmargin+8,305+y+ymargin+((hover-_scrollPush)*heightLine)+7);
if(visibleOptionsMax<array_length(options))&&(hover<array_length(options)-1)
{
	draw_sprite(spr_DownArrow,0,550+x+widthFull*0.5,280+y+heightFull);
}
