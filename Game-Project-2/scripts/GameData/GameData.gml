//Action Library
global.actionLibrary =
{
	attack :
	{
		name : "Attack",
		description : "{0} attacks!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : spr_attackBonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user,_targets)
		{
			var _damage=ceil(_user.strength+random_range(-_user.strength*0.25,_user.strength*0.25));
			//with(_targets[0]) hp=max(0,hp-_damage);
			BattleChangeHP(_targets[0],-_damage,0);
		}
	},
	ice :
	{
		name : "Ice",
		description : "{0} casts Ice!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired : true,
		targetEnemyByDefault : true,//0:party 1:enemy
		targetAll: MODE.VARIES,
		userAnimation:"cast",
		effectSprite: spr_attackIce,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user,_targets)
		{
			var _damage = irandom_range(10,15);
			BattleChangeHP(_targets[0], -_damage);
			//BattleChangeMP(_user,_mpCost)
		}
	}
}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

//Party data
global.party = 
[
	{
		name: "Ally1",
		hp: 89,
		hpMax: 9000,
		mp: 10,
		mpMax: 15,
		strength: 6,
		sprites : { idle: spr_ally1_Idle, attack: spr_ally1_Attack, defend: spr_ally1_Defend, down: spr_ally1_Down},
		actions : [global.actionLibrary.attack]
	}
	,
	{
		name: "Ally2",
		hp: 28,
		hpMax: 44,
		mp: 20,
		mpMax: 30,
		strength: 4,
		sprites : { idle: spr_ally2_Idle, attack: spr_ally2_Attack, defend: spr_ally2_Defend, down: spr_ally2_Down},
		actions : [global.actionLibrary.attack,	global.actionLibrary.ice]
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
		actions: [global.actionLibrary.attack],
		xpValue : 15,
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets=array_filter(oBattle.partyUnits, function(_unit,_index)
			{
				return(_unit.hp>0);
			});
			var _target=_possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action,_target];
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
		actions: [global.actionLibrary.attack],
		xpValue : 18,
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets=array_filter(oBattle.partyUnits, function(_unit,_index)
			{
				return(_unit.hp>0);
			});
			var _target=_possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action,_target];
		}
	}
}





