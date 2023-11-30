if (active)
{
	//Control menu with keyboard
	hover += keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
	if (hover > array_length(options)-1) hover = 0; 
	if (hover < 0) hover = array_length(options)-1;
	//Execute selected option
	if (keyboard_check_pressed((ord("Z"))))
	{
		if (array_length(options[hover]) > 1) && (options[hover][3] == true)
		{
			if (options[hover][1] != -1)
			{
				var _func = options[hover][1];
				if (options[hover][2] != -1) script_execute_ext(_func,options[hover][2]); else _func();
			}
		}
	}
	
	if (keyboard_check_pressed(ord("X")))
	{
		if (subMenuLevel > 0) MenuGoBack();
	}
}