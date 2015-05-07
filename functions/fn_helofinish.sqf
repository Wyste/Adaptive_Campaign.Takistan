/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | Handles the finishing of 'RescueHeloCrew' T1 Tasking
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [AIO_TASKS_ACTIVE,_object,"SWITCH"] call AIO_fnc_helofinish

if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_helofinish.sqf"] call ALiVE_fnc_Dump;
  ["fn_helofinish.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_activeID","_caller","_condition","_objs","_helo","_pilot","_psngr","_ID"];

_caller = _this select 0;
_condition = toUpper(_this select 1);

_activeID = _caller GetVariable "id";

_objs = AIO_TASKS_SPAWNED select _activeID;

_helo = _objs select 0;
_pilot = _objs  select 1;
_psngr = _objs select 2;

_ID = _caller getVariable "id";

switch (_condition) do {
  case "SUCCEEDED": {
    [["Both pilots were successfully returned to base and are undergoing medical evaluation. Complete other main objectives or gather more intellegence to continue the fight!"],"AIO_fnc_alivesideMsg",false,true] spawn BIS_fnc_MP;
    private ["_taskName"];
    _taskName = format["TASK%1",_ID];
    AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";
    [[_taskName, "Succeeded"],"BIS_fnc_taskSetState", true, true] call BIS_fnc_MP;
    deleteVehicle _helo;
    deleteVehicle _pilot;
    deleteVehicle _psngr;
    [AIO_TASKS_TAORS select _ID,"GUER"]  call aio_fnc_aliveremoveobjectivefromsides;
  };
  case "FAILED": {
    [["One of the pilots were killed in action. The helicopter crew rescue is a failure. Complete other main objectives or gather more intellegence to continue the fight!"],"AIO_fnc_alivesideMsg",false,true] spawn BIS_fnc_MP; //Tell all players what happened.
    private ["_taskName"];
    _taskName = format["TASK%1",_ID];
    ["TASKING| TASK Trying to Complete Task: %1",_taskName] call ALiVE_fnc_Dump;
    [[_taskName, "Failed"],"BIS_fnc_taskSetState", true, true] call BIS_fnc_MP;
    sleep 5;
    deleteVehicle _helo;
    deleteVehicle _pilot;
    deleteVehicle _psngr;
    [AIO_TASKS_TAORS select _ID,"GUER"]  call aio_fnc_aliveremoveobjectivefromsides;
  };
  case "CHECK": {
    if (_pilot distance AIO_CAPPAD < 50 && _psngr distance AIO_CAPPAD < 50) then {
      [_pilot,"SUCCEEDED"] call AIO_fnc_helofinish; //Successfully returned both people at base - run this again as succeeded
    } else {
      ["Both pilots must be at base and alive to complete the task. Return to base with both personnel and re-attempt securing their rescue!"] call AIO_fnc_alivesideMsg; // tell the player
    };
  };
  default {
    ["fn_helofinish.sqf was called in error - check your scripts cuz this message should never show."] call AIO_fnc_alivesideMsg;
  };
};

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_helofinish.sqf"] call ALiVE_fnc_Dump;};