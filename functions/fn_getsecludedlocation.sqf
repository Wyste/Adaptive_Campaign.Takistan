/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                      @filename: fn_getflatsecludedlocation.sqf

Author:

    BBrown

Last modified:

    4/12/2015

Description:

    TASK - finds location that has the specified distance of open space on all sides

Returns:

    No return value

USAGE:
    //first arg is centerpoint, second arg is radius, third arg is minimum amount of space on all sides

    [Position, Number, Number] call AIO_fnc_getsecludedlocation;
______________________________________________________________________________*/

private ["_centerPoint", "_radiusA", "_dir", "_minDistance", "_orgX", "_orgY", "_posX", "_posY", "_randPos", "_loc"];

_centerPoint = _this select 0;
_radius = _this select 1;
_minDistance = _this select 2;

fn_RandomPosInRadius = {
        _dir = random 360;
        _orgX = _centerPoint select 0;
        _orgY = _centerPoint select 1;
        _posX = _orgX + (_radius * sin _dir);
        _posY = _orgY + (_radius * cos _dir);
        _randPos = [_posX, _posY, 0];
        _randPos;
};

_p = call fn_RandomPosInRadius;
_loc = _p nearObjects _minDistance;

while {(count _loc) >= 1} do {
  _p = call fn_RandomPosInRadius;
  _loc = _p nearObjects _minDistance;
};

if (AIO_DEBUG) then {[format [" DEBUG | fn_getflatsecludedlocation | Found suitable location: %1", _p]] call ALiVE_fnc_Dump;};