/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/20/2015 | Handles generation of 'Kill HVT' T1 Tasking
_____________________________________________________________________________*/
if (AIO_DEBUG) then {["SCRIPT STARTING| fn_T1_hvt.sqf"] call ALiVE_fnc_Dump;};

private ["_target","_caller","_ID","_areaName","_hvt"];
_target = _this select 0;
_caller = _this select 1;
_ID		= _this select 2;

_target removeAction _ID; //--- Remove action from sign.

private ["_loc","_house","_buildings"];

_loc = [[AIO_LgCITY]] call AIO_fnc_findLocation;

if (_loc select 4 == "Hill") then {
	_areaName = "on or near the hill marked marked on your map";
	_house = _loc select 1;
} else {
	_areaName = format ["near %1",_loc select 0];
	_buildings = [_loc select 1, _loc select 2] call AIO_fnc_getenterablehouses;
	if ((isNil _buildings) or (count _buildings == 0) exitWith { [] spawn TASK_fnc_T1_hvt; };
	_house = _buildings call bis_fnc_selectRandom;
	//cache = createVehicle ["Box_FIA_Wps_F", _bldgPos, [], 0, "None"];
};



["hvt", true, [format ["Intelligence has indicated a HVT (High Value Target) has shown up %1. Your objective is to locate and neutralize the target before he relocates from the area.  Friendly UAV's in the area will identify the target is eliminated.", _areaName], format ["Kill HVT %1.", _areaName], ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_hvt.sqf"] call ALiVE_fnc_Dump;};