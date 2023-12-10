/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

//If spot available Recruit party member
var specificAlly = global.allies.MageAzialt;
for(var i = 0; i < array_length(global.party); i++){
    if(global.party[i] == noone){
        global.party[i] = specificAlly;
    }
}

//Kicks out specific party member
var specificAlly = global.allies.HealerThea;
for(var i = 0; i < array_length(global.party); i++){
    if(global.party[i] == specificAlly){
        global.party[i] = noone;
    }
}

