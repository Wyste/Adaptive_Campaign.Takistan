/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Adds random mission to intellegence sign at base to handle mission assignment.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : call AIO_fnc_addrandtasktosign

if (AIO_DEBUG) then { ["SCRIPT STARTED| fn_addrandtasktosign.sqf"] call ALiVE_fnc_Dump; };

private ["_task","_msg","_script","_color"];

_task   = AIO_T1TASKS call bis_fnc_selectRandom;
_msg    = _task select 0;
_script = _task select 1;
_color  = _task select 2;
_ID     = _task select 3;

if (_ID == AIO_LAST_TASK_SPAWNED) then {
  call fn_addrandtasktosign;
} else {
  AIO_LAST_TASK_SPAWNED = _ID; publicVariable "AIO_LAST_TASK_SPAWNED";
  [[AIO_SIGN,_msg,_script,_color],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
};

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_addrandtasktosign.sqf"] call ALiVE_fnc_Dump;};