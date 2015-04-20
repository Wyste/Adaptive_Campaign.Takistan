/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
       									         @filename: fn_findbuildings.sqf

Author:

	BBrown

Last modified:

	4/12/2015

Description:

	Finds all buildings in given radius

Returns:

	Array

USAGE:

  [Position, Number] call AIO_fnc_findbuildings;
______________________________________________________*/

private ["_centerPos","_radius","_buildingList","_house"];

_buildingList = [];
_centerPos = _this select 0;
_radius = _this select 1;
_buildingList = nearestObjects [_centerPos, ["house"], _radius];

_buildingList