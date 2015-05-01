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

//_target removeAction _ID; //--- Remove action from sign.

private ["_loc","_house","_buildings","_spawnPOS","_m","_cityRadA","_cityRadB","_areaPOS"];

_loc = [[AIO_SmCITY,AIO_LgCITY,AIO_CITY,AIO_VILLAGE]] call AIO_fnc_findLocation;
_areaPOS = _loc select 1;
_spawnPOS = [_areaPOS,500,10] call AIO_fnc_getsecludedlocation;
_cityRadA = _loc select 2;
_cityRadB = _loc select 3;

if (_cityRadB > _cityRadA) then {
	_cityRadA = _cityRadB;
};

	_areaName = format ["near %1",_loc select 0];

private ["_helo","_pilot","_psngr","_men","_wp","_grp"];

if (AIO_DEBUG) then { [format ["fn_T1_rescuehelo.sqf| Creating Helicopter + Men at %1",_spawnPOS]] call ALiVE_fnc_Dump; };
_helo = createVehicle ["RHS_AH1Z",_spawnPOS,[],750,"None"];
if (AIO_DEBUG) then { ["fn_T1_rescuehelo.sqf| Setting Helicopter Damage to 0.5"] call ALiVE_fnc_Dump; };
_helo setDamage 0.5;

_grp = createGroup west;
private ["_menPOS"];
_menPOS = getPosATL _helo;

_pilot = _grp createUnit ["aef_tac_aircrew",_menPOS,[],10,"FORM"];
_psngr = _grp createUnit ["aef_tac_aircrew",_menPOS,[],10,"FORM"];
[_pilot,_psngr] join _grp;
_helo  setVariable ["id",AIO_TASKS_ACTIVE];

_men = [_pilot, _psngr];
{
	_x setVariable ["AGM_AllowUnconscious", true];
	//[_x, 1800 ] call AGM_Medical_fnc_knockOut;
	//_x setBleedingRemaining 1800;
	//_x setHitPointDamage ["HitBody", 0.8];
	//_x setDamage 0.8;
	_x setVariable ["id",AIO_TASKS_ACTIVE];
	_x setBehaviour "AWARE";
	_x setCombatMode "RED";
	removeBackpack _x;
	if (AIO_DEBUG) then { ["fn_T1_rescuehelo.sqf| Adding 'killed' eventhandler to men"] call ALiVE_fnc_Dump; };
	_x addEventHandler ["killed", {
			[AIO_TASKS_ACTIVE,_x,"FAILED"] call AIO_fnc_helofinish;
	}];
} forEach _men;

AGM_PSNGR = [_psngr, "Rescue Aircrew", 5, {_psngr distance AIO_CAPPAD < 20}, {[AIO_TASKS_ACTIVE,_psngr,"CHECK"] call AIO_fnc_helofinish}, false] call AGM_Interaction_fnc_addInteraction;

AGM_PILOT = [_pilot, "Rescue Aircrew", 5, {_pilot distance AIO_CAPPAD < 20}, {[AIO_TASKS_ACTIVE,_pilot,"CHECK"] call AIO_fnc_helofinish}, false] call AGM_Interaction_fnc_addInteraction;

AIO_TASKS_SPAWNED set [AIO_TASKS_ACTIVE,[_helo,_pilot,_psngr]]; publicVariable "AIO_TASKS_SPAWNED";

if(AIO_DEBUG) then {
	private ["_vehMrk"];
	[format ["fn_T1_rescuehelo.sqf| Creating vehicle marker at %1",(getPosATL _helo)]] call ALiVE_fnc_Dump;
	_vehMrk = createMarker [format["mark%1", random 100], (getPosATL _helo)];
	_vehMrk setMarkerType "hd_dot";
	_vehMrk setMarkerColor "ColorRed";
	_vehMrk setMarkerText "DEBUG: Helicopter location";
};

if (AIO_DEBUG) then { [format ["fn_T1_rescuehelo.sqf| Creating ALIVE TAOR marker at %1",_spawnPOS]] call ALiVE_fnc_Dump; };
	_m = createMarker [format ["task_taor_%1",AIO_TASKS_ACTIVE], _spawnPOS];
	_m setMarkerShape "ELLIPSE";
	_m setMarkerColor "ColorBlue";
	_m setMarkerBrush "BORDER";
	_m setMarkerSize [_cityRadA+300,_cityRadA+300];
	AIO_TASKS_TAORS set [AIO_TASKS_ACTIVE,_m]; publicVariable "AIO_TASKS_TAORS";
	[AIO_TASKS_TAORS select AIO_TASKS_ACTIVE,_cityRadA+400] call aio_fnc_aliveaddobjtoside;

AIO_TASKS_ACTIVE = AIO_TASKS_ACTIVE + 1; publicVariable "AIO_TASKS_ACTIVE";

[format["TASK%1",AIO_TASKS_ACTIVE], true, [format ["Friendly UAV's have spotted a downed AH1Z. Your mission is to locate and rescue the pilot and passenger before locals capture and execute them. Hurry to prevent their death via bloodloss, bring the personnel back to base immediately for any medical attention and debriefing.", _areaName], "Rescue downed helo.", ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_rescuehelo.sqf"] call ALiVE_fnc_Dump;};