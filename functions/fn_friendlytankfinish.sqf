/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	BBrown | 4/28/2015 | Handles generation of 'Friendly Armor Retrieval/Destruction' T1 Task Ending
_____________________________________________________________________________*/

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_T1_friendlytankfinish.sqf"] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_friendlytankfinish.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_friendlytankfinish.sqf| : %1",_this select 1]] call ALiVE_fnc_Dump;
};

//--- Get required information
private ["_object", "_taskState", "_taskName"];
_object = _this select 0;
_taskState = _this select 1;
_ID = _object getVariable "id";

_taskName = format["TASK%1",_ID];

//--- check whether they failed or succeeded
if(_taskState == "SUCCEEDED") then {
	[_taskName, "Succeeded"] call bis_fnc_taskSetState;
	AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";
} else {
	if(_taskState == "FAILED") then {
		[_taskName, "Failed"] call bis_fnc_taskSetState;
	};
};

//--- Remove TAOR objective from alive
[AIO_TASKS_TAORS select _ID] call AIO_fnc_aliveremoveobjfromside;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_killcache.sqf"] call ALiVE_fnc_Dump;};