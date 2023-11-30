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
			var _attack = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25))
			var _defense = (_user.strength / (_targets[0].defense + random_range(-_targets[0].defense * 0.125, _targets[0].defense * 0.125)))
			var _damage = ceil(_attack * _defense)
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
			var _attack = ceil(_user.intelligence + random_range(-mpCost, mpCost))
			var _defense = (_attack / (_targets[0].defense + random_range(-_targets[0].defense * 0.125, _targets[0].defense * 0.125)))
			var _damage = ceil(_attack * _defense)
			BattleChangeHP(_targets[0], -_damage);
			//BattleChangeMP(_user,_mpCost)
		}
	},
	flee:
	{
		name: "Flee",
		description: "{0} trys to run away!",
		subMenu: -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : spr_attackBonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var othersInPartySpeed= 0;
			var enemySpeed = 0;
			
			for(var i = 0; i < array_length(global.party); i++){
				if(global.party[i] != noone){
					othersInPartySpeed += global.party[i].agility;
				}
			}
			
			for(var i = 0; i < array_length(_targets); i++){
				enemySpeed += _targets[i].agility;
			}
			
			var partySpeed = _user.agility + (0.8 * othersInPartySpeed);
			enemySpeed *= 0.8;
			
			if(partySpeed > enemySpeed){
				with(all){
					instance_destroy();
				}
				instance_activate_all();
				obj_player.x = obj_player.xprevious;
				obj_player.y = obj_player.yprevious;
			}
		}
	}
	,
	heal:
	{
		name : "Heal",
		description : "{0} casts Heal!",
		subMenu : "Magic",
		mpCost : 10,
		targetRequired : true,
		targetEnemyByDefault : false,//0:party 1:enemy
		targetAll: MODE.NEVER,
		userAnimation:"cast",
		effectSprite: spr_attackIce,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user,_targets)
		{
			var _healAmount = ceil(_user.intelligence + random_range(-mpCost, mpCost) + 2*_targets[0].constitution)
			BattleChangeHP(_targets[0], _healAmount);
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

enum CLASS {
	
	ADVENTURER = 0,
	GAURDIAN = 1,
	WARRIOR = 2,
	KNIGHT = 3,
	MAGE = 4,
	ROUGE = 5,
	HEALER = 6
}


global.player = {
	name: "Player",
	class: CLASS.ADVENTURER,
	level: 1,
	experiencePoints: 0,
	hp: 100,
	hpMax: 100,
	mp: 100,
	mpMax: 100,
	constitution: 10,
	strength: 10,
	defense: 10,
	intelligence: 10,
	agility: 10,
	sprites: {idle: spr_ally1_Idle, attack: spr_ally1_Attack, defend: spr_ally1_Defend, down: spr_ally1_Down},
	actions: [global.actionLibrary.attack, global.actionLibrary.flee]
}

global.allies = {
	Warrior1: {
		name: "Warrior",
		class: CLASS.WARRIOR,
		level: 1,
		experiencePoints: 0,
		hp: 100,
		hpMax: 100,
		mp: 100,
		mpMax: 100,
		constitution: 10,
		strength: 10,
		defense: 10,
		intelligence: 10,
		agility: 10,
		sprites: {idle: spr_ally2_Idle, attack: spr_ally2_Attack, defend: spr_ally2_Defend, down: spr_ally2_Down},
		actions: [global.actionLibrary.attack]
	}
	,
	Mage1: {
		name: "Mage",
		class: CLASS.MAGE,
		level: 1,
		experiencePoints: 0,
		hp: 100,
		hpMax: 100,
		mp: 100,
		mpMax: 100,
		constitution: 10,
		strength: 10,
		defense: 10,
		intelligence: 10,
		agility: 10,
		sprites: {idle: spr_ally2_Idle, attack: spr_ally2_Attack, defend: spr_ally2_Defend, down: spr_ally2_Down},
		actions: [global.actionLibrary.attack, global.actionLibrary.ice, global.actionLibrary.heal]
	}
}

global.party = [global.player, global.allies.Mage1, noone, noone]

//Enemy Data
global.enemies =
{
	Enemy1: 
	{
		name: "Blue Slime",
		level: 1,
		hp: 30,
		hpMax: 30,
		mp: 0,
		mpMax: 0,
		constitution: 10,
		strength: 8,
		defense: 10,
		intelligence: 2,
		agility: 5,
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
		level: 1,
		hp: 100,
		hpMax: 100,
		mp: 0,
		mpMax: 0,
		constitution: 10,
		strength: 10,
		defense: 10, 
		intelligence: 10,
		agility: 10,
		sprites: { idle: spr_enemy2_Idle, attack: spr_enemy2_Attack},
		actions: [global.actionLibrary.attack],
		xpValue : 50,
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


function level_up(_character){
	_character.constitution++;
	_character.strength++;
	_character.defense++;
	_character.intelligence++;
	_character.agility++;
	var currentClass = _character.class;
	switch(_character.class){
		case CLASS.HEALER:
			var i = random_range(0, 100)
			if(i <= 50){
				_character.class = CLASS.MAGE;
			} else {
				_character.class = CLASS.GAURDIAN;	
			}
		case CLASS.ADVENTURER: 
			_character.class = random_range(CLASS.ADVENTURER+1, CLASS.ROUGE)
			break;
		case CLASS.GAURDIAN:
			_character.constitution++;
			break;
		case CLASS.WARRIOR:
			_character.strength++;
			break;
		case CLASS.KNIGHT:
			_character.defense++;
			break;
		case CLASS.MAGE:
			_character.intelligence++;
			break;
		case CLASS.ROUGE:
			_character.agility++;
			break;
	}
	
	_character.class = currentClass;
	
	_character.hpMax = 50 + (5 * _character.constitution);
	_character.mpMax = _character.level + _character.intelligence;
	_character.level++;
	
}

function gain_xp(_character, _xp){
	show_debug_message("XP Gained");
	var statSum = _character.constitution + _character.strength + _character.defense + _character.intelligence + _character.agility;
	_character.experiencePoints += _xp;
	if(_character.experiencePoints >= (statSum + _character.level + 5)){
		level_up(_character);
	}

}



