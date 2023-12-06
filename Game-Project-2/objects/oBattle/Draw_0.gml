draw_sprite(battleBackground,0,x,y);//draw background

//draw units in depth order
var _unitWithCurrentTurn=unitTurnOrder[turn].id;
for(var i=0; i< array_length(unitRenderOrder);i++)
{
	with(unitRenderOrder[i])
	{
		draw_self();
	}
}

//draw ui boxes
draw_sprite_stretched(spr_box,0,x,y+700,1000,350); //Ally Info
draw_sprite_stretched(spr_box,0,x+700,y+700,675,350); //Enemy Info

//Positions
#macro COLUMN_ENEMY 750
#macro COLUMN_ENEMY_HP 1200
#macro COLUMN_NAME 50
#macro COLUMN_HP 275
#macro COLUMN_MP 525

//Draw Headings
draw_set_font(fnt_text_24);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
draw_text(x+COLUMN_ENEMY,y+120+580,"ENEMY");
draw_text(x+COLUMN_ENEMY_HP,y+120+580,"HP");
draw_text(x+COLUMN_NAME,y+120+580,"NAME");
draw_text(x+COLUMN_HP,y+120+580,"HP");
draw_text(x+COLUMN_MP,y+120+580,"MP");

//Draw Enemy Names And HP
draw_set_font(fnt_text_24);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
var _drawLimit=3;
var _drawn=0;
for( var i=0; (i<array_length(enemyUnits)) && (_drawn< _drawLimit); i++)
{
	var _char= enemyUnits[i];
	if(_char.hp>0)
	{
		_drawn++;
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		if(_char.id==_unitWithCurrentTurn) draw_set_color(c_yellow);
		draw_text(x+COLUMN_ENEMY,y+150+(i*52)+600,_char.name);
	}
	
	if(_char.hp>0)
	{
	draw_set_color(c_white);
	if(_char.hp<(_char.hpMax*0.5)) draw_set_color(c_orange);
	if(_char.hp<=0) draw_set_color(c_red);
	draw_text(x+COLUMN_ENEMY_HP,y+150+(i*52)+600,string(_char.hp)+"/"+string(_char.hpMax));
	}
}


//Draw Party  Info
for( var i=0; (i<array_length(partyUnits)); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var _char=partyUnits[i];
	if(_char.id==_unitWithCurrentTurn) draw_set_color(c_yellow);
	if(_char.hp<=0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME,y+150+(i*52)+600,_char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if(_char.hp<(_char.hpMax*0.5)) draw_set_color(c_orange);
	if(_char.hp<=0) draw_set_color(c_red);
	draw_text(x+COLUMN_HP+125,y+150+(i*52)+600,string(_char.hp)+"/"+string(_char.hpMax));

	draw_set_color(c_white);
	if(_char.mp<(_char.mpMax*0.5)) draw_set_color(c_orange);
	if(_char.mp<=0) draw_set_color(c_red);
	draw_text(x+COLUMN_MP+125,y+150+(i*52)+600,string(_char.mp)+"/"+string(_char.mpMax));
	
	draw_set_color(c_white);
}


//Draw Target Cursor
if(cursor.active)
{
	with(cursor)
	{
		if(activeTarget!=noone)
		{
			if(!is_array(activeTarget))
			{
				draw_sprite(spr_pointer,0,activeTarget.x,activeTarget.y);
			}
			else
			{
				//draw_set_alpha(sin(get_timer()/50000)+1);
				draw_set_alpha(sin((get_timer() + 1000) / 100000) + 1);
				for(var i=0;i<array_length(activeTarget);i++)
				{
					draw_sprite(spr_pointer,0,activeTarget[i].x,activeTarget[i].y);
				}
				draw_set_alpha(1.0);
			}
		}
	}
}


if(battleText!="")
{
	var _w=string_width(battleText)+20;
	draw_sprite_stretched(spr_box,0,x+960-(_w*0.5),y+5,_w,70);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(x+960,y+10,battleText);
}