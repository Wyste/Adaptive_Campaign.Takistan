/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/03/2015    | Finds all enterable buildings in a given radius
______________________________________________________________________________________________________________________*/
// RETURN: Array
// USAGE : [Position, Radius] call AIO_fnc_getenterablehouses;

if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_getenterablehouses.sqf"] call ALiVE_fnc_Dump;
  ["fn_getenterablehouses.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_cityPos", "_cityRadA", "_buildings","_enterablebuildings","_b"];

_cityPos = _this select 0;
_cityRadA = _this select 1;

_buildings = [_cityPos, _cityRadA] call AIO_fnc_findbuildings;
_enterablebuildings = [];

if(count _buildings >= 1) then {
  {
    _pos = _x buildingPos 1;
    if(str(_pos) != "[0,0,0]") then {
      _enterablebuildings = _enterablebuildings + [_x];
    };
  } forEach _buildings;
};
["SCRIPT FINISHED| fn_getenterablehouses.sqf"] call ALiVE_fnc_Dump;
_enterablebuildings