
//Party data
global.party = 
[
	{
		name: "Ally1",
		hp: 89,
		hpMax: 89,
		mp: 10,
		mpMax: 15,
		strength: 6,
		sprites : { idle: spr_ally1_Idle, attack: spr_ally1_Attack, defend: spr_ally1_Defend, down: spr_ally1_Down},
		actions : []
	}
	,
	{
		name: "Ally2",
		hp: 18,
		hpMax: 44,
		mp: 20,
		mpMax: 30,
		strength: 4,
		sprites : { idle: spr_ally2_Idle, attack: spr_ally2_Attack, defend: spr_ally2_Defend, down: spr_ally2_Down},
		actions : []
	}
]

//Enemy Data
global.enemies =
{
	Enemy1: 
	{
		name: "Enemy 1",
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		strength: 5,
		sprites: { idle: spr_enemy1_Idle, attack: spr_enemy1_Attack},
		actions: [],
		xpValue : 15,
		AIscript : function()
		{
			//enemy turn ai goes here
		}
	}
	,
	Enemy2: 
	{
		name: "Enemy 2",
		hp: 15,
		hpMax: 15,
		mp: 0,
		mpMax: 0,
		strength: 4,
		sprites: { idle: spr_enemy2_Idle, attack: spr_enemy2_Attack},
		actions: [],
		xpValue : 18,
		AIscript : function()
		{
			//enemy turn ai goes here
		}
	}
}





