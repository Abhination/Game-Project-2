width = 1024;
height = 512;

xBuffer = 257;
yBuffer = 33;

image_alpha = 1
x = (room_width/2)-512
y = (room_height/2)-256

party_size = 0;

for(var i = 0; i < 4; i++){
	if(global.party[i] != noone){
		switch(global.party[i].class){
			case 0:
				partyInfo[i][0] = string_concat("ADVENTURER " , global.party[i].name)
				break;
			case 1:
				partyInfo[i][0] = string_concat("GUARDIAN " , global.party[i].name)
				break;
			case 2:
				partyInfo[i][0] = string_concat("WARRIOR " , global.party[i].name)
				break;
			case 3:
				partyInfo[i][0] = string_concat("KNIGHT " , global.party[i].name)
				break;
			case 4:
				partyInfo[i][0] = string_concat("MAGE " , global.party[i].name)
				break;
			case 5:
				partyInfo[i][0] = string_concat("ROUGE " , global.party[i].name)
				break;
			case 6:
				partyInfo[i][0] = string_concat("HEALER " , global.party[i].name)
				break;
			}
		
		partyInfo[i][1] = string_concat("LVL ", global.party[i].level)
		var statSum = global.party[i].constitution + global.party[i].strength + global.party[i].defense + global.party[i].intelligence + global.party[i].agility;
		partyInfo[i][2] = string_concat("XP to Next LVL: ", (statSum + global.party[i].level + 5) - global.party[i].experiencePoints)
		partyInfo[i][3] = string_concat("Constitution: ", global.party[i].constitution)
		partyInfo[i][4] = string_concat("Strength: ", global.party[i].strength)
		partyInfo[i][5] = string_concat("Defense: ", global.party[i].defense)
		partyInfo[i][6] = string_concat("Intelligence: ", global.party[i].intelligence)
		partyInfo[i][7] = string_concat("Agility: ", global.party[i].agility)
		
			
		party_size++;
	}
}

