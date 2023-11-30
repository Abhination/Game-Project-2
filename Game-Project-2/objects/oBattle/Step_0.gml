

//Run State Machines
battleState();

//cursor control
if(cursor.active)
{
	with(cursor)
	{
		//input
		var _keyUp=keyboard_check_pressed(ord("W"));
		var _keyDown=keyboard_check_pressed(ord("S"));
		var _keyLeft=keyboard_check_pressed(ord("A"));
		var _keyRight=keyboard_check_pressed(ord("D"));
		var _keyToggle=false;
		var _keyConfirm=false;
		var _keyCancel=false;
		confirmDelay++;
		if(confirmDelay>1)
		{
			_keyConfirm=keyboard_check_pressed(vk_enter);
			_keyCancel=keyboard_check_pressed(vk_escape);
			_keyToggle=keyboard_check_pressed(vk_shift);
		}
		var _moveH=_keyRight-_keyLeft;
		var _moveV=_keyDown-_keyUp;
		
		if(_moveH==-1) targetSide=oBattle.partyUnits;
		if(_moveH==1) targetSide=oBattle.partyUnits;	
		
		//verify target list
		if(targetSide==oBattle.enemyUnits)
		{
			targetSide= array_filter(targetSide, function(_element,_index)
			{
				return _element.hp>0;
			});
		}
		
		//move between targets
		if(targetAll==false)//single target mode
		{
			if(_moveV==1) targetIndex++;
			if(_moveV==-1) targetIndex--;		
			
			//warp
			var _targets=array_length(targetSide);
			
//			if(targetIndex==-1)
//{
	
//	with(all)
//		{
			
//			if(object_index!=oBattle.object_index)
//			{
//				instance_destroy();
//			//	instance_activate_all();
//			}
//		}
//		instance_activate_all();
//		instance_destroy();
//}

			//show_debug_message(_targets);
			if(targetIndex<0) targetIndex=_targets-1;
			if(targetIndex>(_targets-1)) targetIndex=0;
			
			//identify targets
			try 
			{
				activeTarget = targetSide[targetIndex];
			}
			catch (err) 
			{
				with(all)
				{
					instance_destroy();
				}	
				instance_activate_all();
				instance_destroy(global.currentEnemyObject);
				
			}
			
			//toggle all mode
			if(activeAction.targetAll==MODE.VARIES)&&(_keyToggle)//switch to all mode
			{
				targetAll=true;
			}
		}
		else//toggle all mode
		{
			activeTarget=targetSide;
			if(activeAction.targetAll==MODE.VARIES)&&(_keyToggle)//switch to single mode
			{
				targetAll=false;
			}
		}
		//Confirm action
		if(_keyConfirm)
		{
			with(oBattle) BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
			with(oMenu) instance_destroy();
			active=false;
			confirmDelay=0;
		}
		
		//Cancel & return to menu
		if(_keyCancel) && (_keyConfirm)
		{
			with(oMenu) active=true;
			active =false;
			confirmDelay=0;
		}
	}
	
	
}


