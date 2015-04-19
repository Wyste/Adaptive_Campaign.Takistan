/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                           @filename: fn_getenterablehouses.sqf

Author:

    BBrown

Last modified:

    4/19/2015

Description:

    TASK - finds all enterable buildings in a given radius

Returns:

	Array
______________________________________________________________________________*/

private ["_cityPos", "_cityRadA", "_buildings"];

_cityPos = _this select 0;
_cityRadA = _this select 1;

_allbuildings = [_cityPos, _cityRadA] call AIO_fnc_findbuildings;
_enterablebuildings = [];

if(count _allbuildings >= 1) then {
	for "_x" from 0 to (count _allbuildings) do {
		_b = _allbuildings select _x;
		_pos = _b buildingPos 1;

		if(str(_pos) == "[0,0,0]") then {
			_enterablebuildings = _enterablebuildings + [_b];
		};
	};
};

_enterablebuildings