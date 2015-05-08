/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/07/2015    | Handles 'Friendly Armor Retrieval/Destruction' T1 Task Ending
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_object, _] call AIO_fnc_endcheck

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_T1_friendlytankfinish.sqf"] call ALiVE_fnc_Dump;
	["fn_friendlytankfinish.sqf",_this] call DEBUG_fnc_dumpParams;
};

private ["_ID","_caller","_condition","_taskName"];
_caller = _this select 0;
_condition = _this select 1;
_ID = _caller getVariable "id";
_taskName = format["TASK%1",_ID];

switch (_condition) do {
  case "SUCCEEDED": {
    [["The armor was successfully captured at base. It is now available for use in your campaigne in the area. Complete other main objectives or gather more intellegence to continue the fight!"],"AIO_fnc_alivesideMsg",false,true] spawn BIS_fnc_MP;
    _caller setdamage 0;
    AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";
    ["TASKING| TASK Trying to Complete Task: %1",_taskName] call ALiVE_fnc_Dump;
    [[_taskName, "Succeeded"],"BIS_fnc_taskSetState", true, true] call BIS_fnc_MP;
    [AIO_TASKS_TAORS select _ID,"GUER"]  call aio_fnc_aliveremoveobjectivefromsides;
  };
  case "DESTROYED": {
    [["The armor was subsequently destroyed during your operation. HQ advises that insurgents are within the area and has written off the asset successfully with NATO command. Complete other objectives or gather more intellegence to continue the fight!"],"AIO_fnc_alivesideMsg",false,true] spawn BIS_fnc_MP;
    AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";
    ["TASKING| TASK Trying to Complete Task: %1",_taskName] call ALiVE_fnc_Dump;
    [[_taskName, "Succeeded"],"BIS_fnc_taskSetState", true, true] call BIS_fnc_MP;
    [AIO_TASKS_TAORS select _ID,"GUER"]  call aio_fnc_aliveremoveobjectivefromsides;
  };
  case "CHECK": {
    if (_caller distance AIO_CAPPAD < 50) then {
      [_caller,"SUCCEEDED"] call AIO_fnc_friendlytankfinish;
    } else {
      ["The vehicle is not close enough to base to register as being secure and returned. Return to base with the vehicle and re-attempt the action!"] call AIO_fnc_alivesideMsg; // tell the player
    };
  };
  default {
    ["fn_friendlytankfinish.sqf was called in error - check your scripts cuz this message should never show."] call AIO_fnc_alivesideMsg;
  };
};

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_friendlytankfinish.sqf"] call ALiVE_fnc_Dump;};