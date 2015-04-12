/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                            @filename: sign.sqf

Author:

	Wyste
Last modified:

	4/11/2015
Description:

	Sets up the intellegence sign at base to handle mission assignment.

_____________________________________________________________________________*/

//-Look at Global Variables for Available Missions and Unavailable Missions

sleep 10;

["Adaptive Intel | AlivE - Sign.sqf running..."] call ALiVE_fnc_Dump;
private ["_item","_tasks","_nme","_ids","_script","_args","_tier"];
_item = _this select 0;
_tier = 1;
//--- T1 missions
{
hint format ["%1",_x select 0];
_ids    = [AIO_T1TASKS, [_x select 0], 0] call AIO_fnc_gettaskdetail;
_nme    = [AIO_T1TASKS, [_x select 0], 1] call AIO_fnc_gettaskdetail;
_script = [AIO_T1TASKS, [_x select 0], 4] call AIO_fnc_gettaskdetail;
_args   = [_ids,_tier];
_pri = _tier;

[[_item,_nme,_script,_args,_pri,"green"],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;

} foreach AIO_T1TASKS_AVL;
