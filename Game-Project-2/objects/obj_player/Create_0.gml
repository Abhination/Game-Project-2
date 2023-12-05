/// @description Insert description here
// You can write your code in this editor
instance_create_layer()
global.inv=[0,0,0,0,0];

myTextbox=noone;

global.currentEnemyObject = noone;

if (variable_global_exists("targetX")) && (global.targetX != -1)
{
	x = global.targetX;
	y = global.targetY;
	direction = global.targetDirection;
}

global.shop=false;
global.inventory =ds_list_create();
//global.inventory =ds_list_create();