/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                   @filename: addactionsign.sqf

Author:

	Wyste
Last modified:

	4/19/2015
Description:

	adds action to intellegence sign at base to handle mission assignment.
  ______________________________________*/

  private ["_task","_tID","_tier","_avl","_aStr","_mStr","_MDStr","_areas","_script","_args","_color"];

  _task = _this select 0;

  _tID    = _task select 0;
  _tier   = _task select 1;
  _avl    = _task select 2;
  _aStr   = _task select 3;
  _args   = _task select 6;
  _script = _task select 7;
  _color  = _task select 8;

  if (_avl) then {
     [[AIO_SIGN select 0,_aStr,_script,_args,_tier+5,_color],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
  };

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - addtoSign.sqf finished..."] call ALiVE_fnc_Dump;};