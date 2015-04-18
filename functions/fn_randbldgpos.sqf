/*
@filename: fn_findBuildings.sqf

Author:

	BBrown

Last modified:

	4/12/2015

Description:

	Finds a random pos within a building

Returns:

	Array

______________________________________________________*/

private ["_building", "_count", "_position"];

_building = _this select 0;
_count = [_building] call AIO_fnc_getcountbldgpos;

if(_count == 0) then {
	_position = getPos _building;
} else {
	_position = random _count;
	_position = _building buildingPos _position;
};

if((_position select 0) == 0) then {
	_position = getPos _building;
};

_position