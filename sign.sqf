/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/20/2015 | Sets up the intellegence sign at base to handle mission assignment.
_____________________________________________________________________________*/

//-Look at Global Variables for Available Missions and Unavailable Missions

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Sign.sqf running..."] call ALiVE_fnc_Dump;};

//AIO_TASKS = missionNamespace getVariable "AIO_TASKS";

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