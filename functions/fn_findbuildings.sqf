/*
@filename: fn_findBuildings.sqf

Author:

	BBrown & Wyste

Last modified:

	4/12/2015

Description:

	Find buildings in given radius

TODO:

	Add comment lines so people can get a better understand of how and why it works.

______________________________________________________*/
//hint "Firing AIO_fnc_findbuildings";
//sleep 1;
private ["_centerPos","_radius","_buildingList","_house"];
_buildingList = [];

_centerPos = _this select 0;
_radius = _this select 1;
_buildingList = nearestObjects [_centerPos, ["house"], _radius];
_buildingList