/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_text_12); // Set the default font for the GUI

var headingFont = fnt_text_12; // Set the font for headings
var contentFont = fnt_text_12; // Set the font for content

// Center the text in the room
var centerX = display_get_gui_width() / 3;
var centerY = display_get_gui_height() / 3;

// Display game instructions
var instructions = "Welcome to Our Game!";
var instructions = "Game Title: EIDOLON";
var instructions = "Group Name: E-MAG Studios";
draw_set_font(headingFont);
draw_text( centerX-200, centerY - 25, instructions);

var contentX = centerX - 200;
var contentY = centerY - 200;

draw_set_font(contentFont);
var instructionsText = "Instructions:\n";
instructionsText += "- Walk and move cursor with WASD.\n";
instructionsText += "- E for Status Screen\n";
instructionsText += "- I for Inventory\n";
instructionsText += "- Z to select menu option in battle or talk with NPC\n";

draw_text( contentX, contentY, instructionsText );

// Adjust spacing for cheat codes
contentY += 200;

// Display cheat codes
var cheats = "Cheat Codes:";
draw_set_font(headingFont);
draw_text( centerX-200, contentY, cheats );

contentY += 40;
draw_set_font(contentFont);
var cheatText = "R: Restart the room\n";
cheatText += "V Teleport to Village\n";
cheatText += "L Goes to Win Screen\n";
cheatText += "G Gives Gold\n";
cheatText += "X Adds XP to Player\n";

draw_text( contentX, contentY, cheatText );

// Adjust spacing for team information
contentY += 190;

// Display team member names and roles
var teamInfo = "Meet the Team:";
draw_set_font(headingFont);
draw_text( centerX-200, contentY, teamInfo );

contentY += 40;
draw_set_font(contentFont);
var teamText = "Phani Kiran Reddy D - Programmer\n";
teamText += "Abhinav Sharma - Game Producer\n";
teamText += "Kiet Mai - Game Designer/Artist\n";
teamText += "Jean Toribio - Programmer\n";
draw_text( contentX, contentY, teamText );

draw_set_font(fnt_text_12); // Reset the font to the default font





