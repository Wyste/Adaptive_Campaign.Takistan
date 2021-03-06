/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/03/2015    | Handles destroying of weapons cache
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_cache] call AIO_fnc_killcache

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_killcache.sqf"] call ALiVE_fnc_Dump;
	["fn_killcache.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_cache","_pos","_x","_ID"];
_cache = _this select 0;
_x = 0;
_pos = getPos _cache;

_ID = _cache getVariable "id";

//--- delete cache
deleteVehicle _cache;

private ["_taskName"];
_taskName = format["TASK%1",_ID];
//--- set task as completed
//[_taskName, "SUCCEEDED"] call bis_fnc_taskSetState;
["TASKING| TASK Trying to Complete Task: %1",_taskName] call ALiVE_fnc_Dump;
[[_taskName, "Succeeded"],"BIS_fnc_taskSetState", true, true] call BIS_fnc_MP;

//--- Remove TAOR objective from alive.
[AIO_TASKS_TAORS select _ID,"GUER"]  call aio_fnc_aliveremoveobjectivefromsides;

//--- Tasking completed!
AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";

//--- Create explosion effect
while {_x <= 22} do {
	"M_Mo_82mm_AT_LG" createVehicle _pos;
	_x = _x + 1 + random 3;
	sleep (0.2 + (random 3));
};

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_killcache.sqf"] call ALiVE_fnc_Dump;};