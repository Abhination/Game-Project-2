/// @description Insert description here
// You can write your code in this editor



myTextbox=noone;

global.currentEnemyObject = noone;

if (variable_global_exists("targetX")) && (global.targetX != -1)
{
	x = global.targetX;
	y = global.targetY;
	direction = global.targetDirection;
}

global.shop=false;
global.gold=100;
global.inv=ds_list_create();