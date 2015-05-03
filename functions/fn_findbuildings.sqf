/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/03/2015    | Finds all buildings in given radius
______________________________________________________________________________________________________________________*/
// RETURN: Array
// USAGE : [Position, Number] call AIO_fnc_findbuildings;

if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_findbuildings.sqf"] call ALiVE_fnc_Dump;
  ["fn_findbuildings.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_centerPos","_radius","_buildingList","_house"];

_buildingList = [];
_centerPos = _this select 0;
_radius = _this select 1;
_buildingList = nearestObjects [_centerPos, ["house"], _radius];

if (AIO_DEBUG) then { ["SCRIPT FINISHED| fn_findbuildings.sqf"] call ALiVE_fnc_Dump; };

_buildingList