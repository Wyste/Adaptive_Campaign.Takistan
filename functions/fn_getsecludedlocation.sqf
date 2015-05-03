/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/03/2015    | Finds location that has the specified distance of open space on all sides
______________________________________________________________________________________________________________________*/
// RETURN: Position
// USAGE : [Position, Radius, MinDistancefromEverything] call AIO_fnc_getsecludedlocation;

if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_getsecludedlocation.sqf"] call ALiVE_fnc_Dump;
  ["fn_getsecludedlocation.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_centerPoint", "_radiusA", "_dir", "_minDistance", "_orgX", "_orgY", "_posX", "_posY", "_randPos", "_loc"];

_centerPoint  = _this select 0;
_radius       = _this select 1;
_minDistance  = _this select 2;

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

if (AIO_DEBUG) then {
  [format [" DEBUG | fn_getsecludedlocation| Found suitable location: %1", _p]] call ALiVE_fnc_Dump;
  ["SCRIPT FINISHED| fn_getsecludedlocation.sqf"] call ALiVE_fnc_Dump;
};
_p;