instance_deactivate_all(true);
units=[];
//turn
turn=0;
unitTurnOrder=[];
unitRenderOrder=[];


//make enemies:
for(var i=0; i<array_length(enemies); i++)
{
	enemyUnits[i]= instance_create_depth(x+1750+(i*10), y+268+(i*120),depth -10, oBattleUnitEnemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//make allies
for(var i=0; i<array_length(global.party); i++)
{
	partyUnits[i]= instance_create_depth(x+250+(i*10), y+268+(i*120),depth -10, oBattleUnitPC, global.party[i]);
	array_push(units, partyUnits[i]);
}

//Shuffle Trun Order
unitTurnOrder=array_shuffle(units);

//Get render order
RefreshRenderOrder=function()
{
	unitRenderOrder=[];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(_1,_2)
	{
		return _1.y- _2.y;
	});
}
RefreshRenderOrder();
