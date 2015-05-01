_target = _this select 0;
_caller = _this select 1;
_ID = _this select 2;

//[_target, _caller, _ID] call TASK_fnc_T1_spawncache;
[_target, _caller, 0] call TASK_fnc_T1_rescuehelo;
//[_target, _caller, 1] call TASK_fnc_T1_friendlytank;