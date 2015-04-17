/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                      @filename: spawnintel.sqf

Author:

	Wyste

Last modified:

	4/12/2015

Description:

	TASK - spawns intellegence in a town randomly. Also creates a trigger in which enemies can drop more intel.
_____________________________________________________________________________


target    (_this select 0): Object - the object which the action is assigned to
caller    (_this select 1): Object - the unit that activated the action
ID        (_this select 2): Number - ID of the activated action
arguments (_this select 3): Anything - arguments given to the script
*/

//--- Setup / Gathering Arguments + Mission Parameters

private ["_target","_caller","_aID","_args","_intelItems","_selectedItem","_item","_buildings","_area","_cities","_cityName","_intelactive"];

_target = _this select 0;
_caller = _this select 1;
_aID    = _this select 2;
_args   = _this select 3;
_intelactive = missionNamespace getVariable "AIO_INTEL_ACTIVE";

//--- Do nothing if this is called and 5 of this task are active.

if (_intelactive > 4) exitWith {}; //Max intels spawned - you need to wait.

//--- Selecting an area of operations
if (AIO_DEBUG) then {[" DEBUG| Selecting area for intel spawn..."] call ALiVE_fnc_Dump;};

IF (AIO_DEBUG) then {[_args] call DEBUG_fnc_debugarray;};

{ // Available city groups
  _area = missionNamespace getVariable _x;
  hint _x;
    {
    	[_x] call DEBUG_fnc_debugarray;
	} foreach _area;
} forEach _args;


//--- Spawn the stuff randomly!
if (AIO_DEBUG) then {hint "stuff spawning";};

//--- Did this task throw us over the limit of 5? If so - kill the action.
_intelactive = missionNamespace getVariable "AIO_INTEL_ACTIVE";
if (_intelactive > 4) then { _target removeAction _aID};