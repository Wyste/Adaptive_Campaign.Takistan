/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/20/2015 | T1 TASK - Destroy weapons cache
_____________________________________________________________________________*/
if (AIO_DEBUG) then {["SCRIPT STARTING| fn_T1_spawncache.sqf"] call ALiVE_fnc_Dump;};

	private ["_target","_caller","_ID"];
	_target = _this select 0;
	_caller = _this select 1;
	_ID		= _this select 2;

	_target removeAction _ID; //--- Remove action from sign.

	//--- Tasking completed!
	AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_spawncache.sqf"] call ALiVE_fnc_Dump;};