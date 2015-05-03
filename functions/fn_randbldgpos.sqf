/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | Finds a random pos within a building
______________________________________________________________________________________________________________________*/
// RETURN: Array
// USAGE : [_building] call AIO_fnc_randbldgpos

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_randbldgpos.sqf"] call ALiVE_fnc_Dump;
	["fn_randbldgpos.sqf",_this] call DEBUG_fnc_dumpParams;
};

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
if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_randbldgpos.sqf"] call ALiVE_fnc_Dump;};
_position;