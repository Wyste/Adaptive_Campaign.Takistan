/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: addactionMP.sqf

Author:

	Hazey - Modified by BBrown & Wyste

Last modified:

	4/11/2015

Description:

	Add multiplayer action - I am sure we have a function or cba....
	I made my own though... Deal with it.

______________________________________________________*/

private["_object","_screenMsg"];
_object = _this select 0;
_screenMsg = _this select 1;

if(isNull _object) exitWith {};

//--- Add action to object that calls the intel being picked up function.
_object addaction [_screenMsg,"call AIO_fnc_intelPickup", nil, 6, True, True, "", "(_target distance _this) < 6"];