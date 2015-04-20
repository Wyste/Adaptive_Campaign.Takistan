/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                  @filename: fn_randbldgpos.sqf

Author:

	Wyste
Last modified:

	4/19/2015
Description:

	Finds a random pos within a building
Returns:

	Array
_____________________________________________________________________________*/

private ["_building", "_count", "_position","_z","_posATL"];
_z = 0;
_building = _this select 0;
_count = [_building] call AIO_fnc_getcountbldgpos;

	if(_count == 0) then {
		_position = getPos _building;
		_posATL = getPosATL _building;
		_z = _posATL select 2;
	} else {
		_position = random _count;
		_position = _building buildingPos _position;
		_z = _position select 2;
	};
	if((_position select 0) == 0) then {
		_position = getPos _building;
	};
_position set [2,abs(_position select 2)];
_position;