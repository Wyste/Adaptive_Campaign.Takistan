/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	BBrown | 4/23/2015 | Handles destroying of weapons cache
_____________________________________________________________________________*/
if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_killhvt.sqf"] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_killhvt.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;
};

private ["_hvt","_pos","_x","_ID"];
_hvt = _this select 0;
_x = 0;
_pos = getPos _hvt;

_ID = _hvt getVariable "id";


private ["_taskName"];
_taskName = format["TASK%1",_ID];
//--- set task as completed
[_taskName, "SUCCEEDED"] call bis_fnc_taskSetState;

//--- Remove TAOR objective from alive.
[AIO_TASKS_TAORS select _ID] call aio_fnc_aliveremoveobjfromside;

//--- Tasking completed!
AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";

deleteVehicle _hvt;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_killhvt.sqf"] call ALiVE_fnc_Dump;};