/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/03/2015    | Handles Completion of HVT Task
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_unit] call AIO_fnc_killhvt

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_killhvt.sqf"] call ALiVE_fnc_Dump;
	["fn_killhvt.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_hvt","_pos","_x","_ID","_taskName"];
_hvt = _this select 0;
_x = 0;
_pos = getPos _hvt;
_ID = _hvt getVariable "id";
_taskName = format["TASK%1",_ID];
["TASKING| TASK Trying to Complete Task: %1",_taskName] call ALiVE_fnc_Dump;
[_taskName, "SUCCEEDED"] call bis_fnc_taskSetState; //--- set task as completed
[AIO_TASKS_TAORS select _ID,"GUER"]  call aio_fnc_aliveremoveobjectivefromsides; //--- Remove TAOR objective from alive.
AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";
deleteVehicle _hvt;
if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_killhvt.sqf"] call ALiVE_fnc_Dump;};