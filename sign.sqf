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

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Sign.sqf running..."] call ALiVE_fnc_Dump;};

AIO_TASKS = missionNamespace getVariable "AIO_TASKS";

private ["_tID","_tier","_avl","_aStr","_mStr","_MDStr","_areas","_script","_args","_color"];

{

  _tID    = _x select 0;
  _tier   = _x select 1;
  _avl    = _x select 2;
  _aStr   = _x select 3;
  _args   = _x select 6;
  _script = _x select 7;
  _color  = _x select 8;
     [[AIO_SIGN select 0,_aStr,_script,_args,_tier+5,_color],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;

} forEach AIO_TASKS;

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Sign.sqf finished..."] call ALiVE_fnc_Dump;};