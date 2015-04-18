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


private ["_building", "_count"];

_building = _this select 0;
_count = 0;
while {str(_building buildingPos _count) != "[0,0,0]"} do
{
	_count = _count + 1;
};

_count