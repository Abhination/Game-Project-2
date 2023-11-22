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
draw_sprite_stretched(spr_box,0,x+500,y+570,1420,450);
draw_sprite_stretched(spr_box,0,x,y+570,500,450);

//Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 90
#macro COLUMN_HP 160
#macro COLUMN_MP 220

//Draw Headings
draw_set_font(fnt_text_24);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
draw_text(x+COLUMN_ENEMY+50,y+120+480,"ENEMY");
draw_text(x+COLUMN_NAME+550,y+120+480,"NAME");
draw_text(x+COLUMN_HP+900,y+120+480,"HP");
draw_text(x+COLUMN_MP+1250,y+120+480,"MP");

//Draw Enemy Names
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
		draw_text(x+COLUMN_ENEMY+50,y+150+(i*52)+500,_char.name);
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
	draw_text(x+COLUMN_NAME+550,y+150+(i*52)+500,_char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if(_char.hp<(_char.hpMax*0.5)) draw_set_color(c_orange);
	if(_char.hp<=0) draw_set_color(c_red);
	draw_text(x+COLUMN_HP+900,y+150+(i*52)+500,string(_char.hp)+"/"+string(_char.hpMax));

	draw_set_color(c_white);
	if(_char.mp<(_char.mpMax*0.5)) draw_set_color(c_orange);
	if(_char.mp<=0) draw_set_color(c_red);
	draw_text(x+COLUMN_MP+1250,y+150+(i*52)+500,string(_char.mp)+"/"+string(_char.mpMax));
	
	draw_set_color(c_white);
}