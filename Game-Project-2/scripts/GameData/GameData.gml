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
	,
	hp_potion:
	{
		name : "Health Potion",
		description : "{0} uses a health potion!",
		subMenu : "Item",
		targetRequired : false,
		targetEnemyByDefault : false,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : spr_attackBonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user,_targets)
		{
			updateActions();
			var _amount = _user.hpMax * 0.5;
			BattleChangeHP(_user, _amount);
			for(var i = 0; i < ds_list_size(global.inventory)){
				if( ds_list_find_value(global.inventory, i)[0] == "HealthPotion"){
					ds_list_delete(global.inventory, i);
				}
			}
			updateActions();
		}
	}
	,
	mp_potion:
	{
		name : "Magic Potion",
		description : "{0} uses a magic potion!",
		subMenu : "Item",
		targetRequired : false,
		targetEnemyByDefault : false,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : spr_attackBonk,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user,_targets)
		{
			updateActions();
			var _amount = _user.mpMax * 0.5;
			_user.mp = min(_user.mpMax, _user.mp+_amount);
			for(var i = 0; i < ds_list_size(global.inventory)){
				if(ds_list_find_value(global.inventory, i)[0] == "MagicPotion"){
					ds_list_delete(global.inventory, i);
				}
			}
			updateActions();
		}
	}
}

global.itemLibrary = ds_list_create();
ds_list_add(global.itemLibrary, ["HealthPotion", 15, "itemDescription", 0]);
ds_list_add(global.itemLibrary, ["MagicPotion", 15, "itemDescription", 0]);
//ds_list_add(global.itemLibrary, ["Health Potion", 15, "itemDescription"]);
//ds_list_add(global.itemLibrary, ["Health Potion", 15, "itemDescription"]);
//ds_list_add(global.itemLibrary, ["Health Potion", 15, "itemDescription"]);

global.healthPotion = ["HealthPotion", 15, "itemDescription"];
global.magicPotion = ["MagicPotion", 15, "itemDescription"];

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

enum CLASS {
	
	ADVENTURER = 0,
	GUARDIAN = 1,
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
	gold: 100,
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
	GuardianEric: {
		name: "Eric",
		class: CLASS.GUARDIAN,
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
	WarriorBaal: {
		name: "Baal",
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
	KnightAki: {
		name: "Aki",
		class: CLASS.KNIGHT,
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
	MageAzialt: {
		name: "Azialt",
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
		actions: [global.actionLibrary.attack, global.actionLibrary.ice]
	}
	,
	RougeLee: {
		name: "Lee",
		class: CLASS.ROUGE,
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
	HealerThea: {
		name: "Thea",
		class: CLASS.HEALER,
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

global.party = [global.player, global.allies.HealerThea, noone, noone];

//Enemy Data
global.enemies =
{
	Slime:
	{
		name: "Slime",
		level: 1,
		hp: 70,
		hpMax: 70,
		mp: 10,
		mpMax: 10,
		constitution: 7,
		strength: 5,
		defense: 5,
		intelligence: 1,
		agility: 5,
	}
	,
	BlueSlime: 
	{
		name: "Blue Slime",
		level: 1,
		hp: 30,
		hpMax: 30,
		mp: 70,
		mpMax: 70,
		constitution: 5,
		strength: 5,
		defense: 5,
		intelligence: 7,
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
	RedSlime: 
	{
		name: "Red Slime",
		level: 1,
		hp: 50,
		hpMax: 50,
		mp: 50,
		mpMax: 50,
		constitution: 5,
		strength: 7,
		defense: 5,
		intelligence: 5,
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
	BrownSlime: 
	{
		name: "Brown Slime",
		level: 1,
		hp: 50,
		hpMax: 50,
		mp: 50,
		mpMax: 50,
		constitution: 5,
		strength: 5,
		defense: 7,
		intelligence: 5,
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
	GiantCrab: 
	{
		name: "Giant Crab",
		level: 1,
		hp: 100,
		hpMax: 30,
		mp: 30,
		mpMax: 30,
		constitution: 10,
		strength: 10,
		defense: 10,
		intelligence: 3,
		agility: 6,
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
	Treant: 
	{
		name: "Treant",
		level: 1,
		hp: 100,
		hpMax: 100,
		mp: 60,
		mpMax: 60,
		constitution: 10,
		strength: 3,
		defense: 10,
		intelligence: 6,
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
	WaterDemonGeneral: 
	{
		name: "Aquarius",
		level: 1,
		hp: 150,
		hpMax: 150,
		mp: 150,
		mpMax: 150,
		constitution: 15,
		strength: 10,
		defense: 10,
		intelligence: 15,
		agility: 10,
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
	FireDemonGeneral: 
	{
		name: "Aries",
		level: 1,
		hp: 100,
		hpMax: 100,
		mp: 100,
		mpMax: 100,
		constitution: 10,
		strength: 15,
		defense: 10,
		intelligence: 10,
		agility: 15,
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
	EarthDemonGeneral: 
	{
		name: "Taurus",
		level: 1,
		hp: 200,
		hpMax: 200,
		mp: 100,
		mpMax: 100,
		constitution: 15,
		strength: 10,
		defense: 15,
		intelligence: 10,
		agility: 10,
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
	DemonKing: 
	{
		name: "Demon King Eidolon",
		level: 1,
		hp: 200,
		hpMax: 150,
		mp: 150,
		mpMax: 150,
		constitution: 20,
		strength: 15,
		defense: 10,
		intelligence: 15,
		agility: 10,
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
				_character.class = CLASS.GUARDIAN;	
			}
		case CLASS.ADVENTURER: 
			_character.class = random_range(CLASS.ADVENTURER+1, CLASS.ROUGE)
			break;
		case CLASS.GUARDIAN:
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
	global.count+=0.5;
	if(global.count==global.noof)
	{
		with(all)
				{
					instance_destroy();
				}	
				instance_activate_all();
				instance_destroy(global.currentEnemyObject);
	}
	var statSum = _character.constitution + _character.strength + _character.defense + _character.intelligence + _character.agility;
	_character.experiencePoints += _xp;
	if(_character.experiencePoints >= (statSum + _character.level + 5)){
		level_up(_character);
	}

}

function updateActions(){
	var hasHPPotion = false;
	var hasMPPotion = false;
	var HPActionThere = false;
	var MPActionThere = false;
	/*
	for( var i = 0; i < ds_list_size(global.inventory); i++){
		var ITEM = ds_list_find_value(global.inventory, i);
		if(array_equals(ITEM, global.healthPotion)){
			hasHPPotion = true;
		}
		else if(array_equals(ITEM, global.magicPotion)){
			hasMPPotion = true;
		}
	}*/
	
	for(var i = 0; i < array_length(global.party); i++){
		if(global.party[i] != noone){
			for(var j = 0; j < array_length(global.party[i].actions)-1; j++){
				
				if(global.party[i].actions[j].name == global.actionLibrary.hp_potion.name and hasHPPotion == false){
					array_delete(global.party[i].actions, j, 1);
				}
				if(global.party[i].actions[j].name == global.actionLibrary.mp_potion.name and hasMPPotion == false){
					array_delete(global.party[i].actions, j, 1);
				}
				if(global.party[i].actions[j].name  == global.actionLibrary.hp_potion.name){
					HPActionThere = true;
				}
				if(global.party[i].actions[j].name == global.actionLibrary.mp_potion.name){
					MPActionThere = true;
				}
			}
		}
		
	}
	
	if(HPActionThere == false and hasHPPotion == true){
		for(var i = 0; i < array_length(global.party); i++){
			if(global.party[i] != noone){
				array_push(global.party[i].actions, global.actionLibrary.hp_potion);
			}
		}
	}
	if(MPActionThere == false and hasMPPotion == true){
		for(var i = 0; i < array_length(global.party); i++){
			if(global.party[i] != noone){
				array_push(global.party[i].actions, global.actionLibrary.mp_potion);
			}
		}
	}
	
}

