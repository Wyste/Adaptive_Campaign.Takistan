/*
@filename: fn_findBuildings.sqf

Author:

	BBrown

Last modified:

	4/12/2015

Description:

	Finds all buildings in given radius

Returns:

	Array

______________________________________________________*/

private ["_centerPos","_radius","_buildingList","_house"];
_buildingList = [];

_centerPos = _this select 0;
_radius = _this select 1;
_buildingList = nearestObjects [_centerPos, ["house"], _radius];
_buildingList