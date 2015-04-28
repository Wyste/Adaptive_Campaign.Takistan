/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/20/2015 | Handles generation of 'RescueHeloCrew' T1 Tasking
_____________________________________________________________________________*/
if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_T1_rescuehelo.sqf"] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_rescuehelo.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_rescuehelo.sqf| : %1",_this select 1]] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_rescuehelo.sqf| : %1",_this select 2]] call ALiVE_fnc_Dump;
};

private ["_target","_caller","_ID","_areaName","_hvt"];
_target = _this select 0;
_caller = _this select 1;
_ID		= _this select 2;

_target removeAction _ID; //--- Remove action from sign.

private ["_loc","_house","_buildings","_spawnPOS","_m","_cityPOS","_cityRadA","_cityRadB"];

_loc = [[AIO_SmCITY]] call AIO_fnc_findLocation;
_cityPOS = _loc select 1;
_cityRadA = _loc select 2;
_cityRadB = _loc select 3;

if (_cityRadB > _cityRadA) then {
	_cityRadA = _cityRadB;
};

	_areaName = format ["near %1",_loc select 0];

private ["_helo","_pilot","_psngr","_men"];

_helo = createVehicle ["RHS_AH1Z",_cityPOS,[],0,"None"];
_helo setDamage 0.5;

_pilot = createVehicle ["aef_tac_aircrew",[(_cityPOS select 0) + 10, (_cityPOS select 1) + 5],[],0,"None"];
_psngr = createVehicle ["aef_tac_aircrew",[(_cityPOS select 0) + 8, (_cityPOS select 1) + 5],[],0,"None"];

_helo  setVariable ["id",AIO_TASKS_ACTIVE];

_men = [_pilot, _psngr];
{
	_x setVariable ["id",AIO_TASKS_ACTIVE];
	removeAllWeapons _x;
	removeAllItems _x;
	removeAllAssignedItems _x;
	removeBackpack _x;
	_x addEventHandler ["killed", {
			[_x,"FAILED"] call AIO_fnc_helofinish;
	}];
	_x setVariable ["AGM_AllowUnconscious", true];
	[_x, 999999] call AGM_Medical_fnc_knockOut;
	_x setDamage 0.5;
} forEach _men;

AIO_TASKS_SPAWNED set [AIO_TASKS_ACTIVE,_helo]; publicVariable "AIO_TASKS_SPAWNED";

if (AIO_DEBUG) then { [format ["fn_T1_rescuehelo.sqf| Creating ALIVE TAOR marker at %1",_cityPOS]] call ALiVE_fnc_Dump; };
if (AIO_DEBUG) then {_cityPOS = getposATL _helo};
	_m = createMarker [format ["task_taor_%1",AIO_TASKS_ACTIVE], _cityPOS];
	_m setMarkerShape "ELLIPSE";
	_m setMarkerColor "ColorBlue";
	_m setMarkerBrush "BORDER";
	_m setMarkerSize [_cityRadA+200,_cityRadA+200];
	AIO_TASKS_TAORS set [AIO_TASKS_ACTIVE,_m]; publicVariable "AIO_TASKS_TAORS";
	[AIO_TASKS_TAORS select AIO_TASKS_ACTIVE,_cityRadA+400] call aio_fnc_aliveaddobjtoside;

AIO_TASKS_ACTIVE = AIO_TASKS_ACTIVE + 1; publicVariable "AIO_TASKS_ACTIVE";

[format["TASK%1",AIO_TASKS_ACTIVE], true, [format ["Friendly UAV's have spotted a downed AH1Z. Your mission is to locate and rescue the pilot and passenger before locals capture and execute them. Bring the personnel back to base immediately for medical attention and debriefing.", _areaName], format ["Rescue %1.", _areaName], ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_rescuehelo.sqf"] call ALiVE_fnc_Dump;};

sleep 3600;
//Wait one hour... then check to see if they still exist in the world...  If they do - you failed, and cleanup.
if (alive _pilot) exitWith { [_pilot,"FAILED"] call AIO_fnc_helofinish; };
if (alive _psngr) exitWith { [_psngr,"FAILED"] call AIO_fnc_helofinish; };