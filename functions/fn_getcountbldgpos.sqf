/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/03/2015    | Counts building positions for passed building
______________________________________________________________________________________________________________________*/
// RETURN: Integer (count of positions in building)
// USAGE : _positions = [_building] call AIO_fnc_getcountbldgpos

if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_getcountbldgpos.sqf"] call ALiVE_fnc_Dump;
  ["fn_getcountbldgpos.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_building", "_count"];

_building = _this select 0;
_count = 0;
while {str(_building buildingPos _count) != "[0,0,0]"} do {
	_count = _count + 1;
};
["SCRIPT FINISHED| fn_getcountbldgpos.sqf"] call ALiVE_fnc_Dump;
_count