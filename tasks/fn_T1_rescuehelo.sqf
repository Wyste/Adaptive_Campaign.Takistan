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

private ["_loc","_house","_buildings","_hvt","_spawnPOS","_m","_cityPOS","_cityRadA","_cityRadB"];

_loc = [[AIO_LgCITY]] call AIO_fnc_findLocation;
_cityPOS = _loc select 1;
_cityRadA = _loc select 2;
_cityRadB = _loc select 3;

if (_cityRadB > _cityRadA) then {
	_cityRadA = _cityRadB;
};

if (_loc select 4 == "Hill") then {
	_areaName = "on or near the hill marked marked on your map";
	_house = _loc select 1;
	_spawnPOS = _house;
} else {
	_areaName = format ["near %1",_loc select 0];
	_buildings = [_loc select 1, _loc select 2] call AIO_fnc_getenterablehouses;
	if (count _buildings == 0) exitWith { [] spawn TASK_fnc_T1_hvt; };
	_house = _buildings call bis_fnc_selectRandom;
	_spawnPOS = [_house] call AIO_fnc_randbldgpos;
	//cache = createVehicle ["Box_FIA_Wps_F", _bldgPos, [], 0, "None"];
};

_hvt = createVehicle ["LOP_AM_Soldier_AR",_spawnPOS,[],0,"None"];

//--- Check if he's still alive... cuz he may have fell... silly goose.
sleep 5;
if (!alive _hvt) exitWith { [] spawn TASK_fnc_T1_hvt; };

_hvt setVariable ["id",AIO_TASKS_ACTIVE];

removeAllWeapons _hvt;
removeAllItems _hvt;
removeAllAssignedItems _hvt;
removeUniform _hvt;
removeVest _hvt;
removeBackpack _hvt;
removeHeadgear _hvt;
removeGoggles _hvt;

_hvt forceAddUniform "LOP_U_ChDKZ_Fatigue_03";
_hvt addItemToUniform "rhsusf_ANPVS_14";
_hvt addVest "LOP_V_CarrierRig_WDL";
for "_i" from 1 to 4 do {_hvt addItemToVest "200Rnd_mas_556x45_T_Stanag";};
_hvt addHeadgear "H_Shemag_olive_hs";
_hvt addGoggles "rhs_googles_black";
_hvt addWeapon "LMG_mas_M249_F_v";
_hvt addPrimaryWeaponItem "optic_mas_Arco_camo";
_hvt addWeapon "Binocular";
_hvt linkItem "ItemMap";
_hvt linkItem "ItemCompass";
_hvt linkItem "tf_microdagr";
_hvt linkItem "tf_anprc152_1";
_hvt setFace "WhiteHead_22_sa";
_hvt setSpeaker "Male02PER";

_hvt addEventHandler ["killed", {
		[_this select 0] spawn AIO_fnc_killhvt;
}];

AIO_TASKS_SPAWNED set [AIO_TASKS_ACTIVE,_hvt]; publicVariable "AIO_TASKS_SPAWNED";

if (AIO_DEBUG) then { [format ["fn_T1_hvt.sqf| Creating ALIVE TAOR marker at %1",_cityPOS]] call ALiVE_fnc_Dump; };
if (AIO_DEBUG) then {_cityPOS = getposATL _hvt};
	_m = createMarker [format ["task_taor_%1",AIO_TASKS_ACTIVE], _cityPOS];
	_m setMarkerShape "ELLIPSE";
	_m setMarkerColor "ColorRed";
	_m setMarkerBrush "BORDER";
	_m setMarkerSize [_cityRadA+400,_cityRadA+400];
	AIO_TASKS_TAORS set [AIO_TASKS_ACTIVE,_m]; publicVariable "AIO_TASKS_TAORS";
	[AIO_TASKS_TAORS select AIO_TASKS_ACTIVE,_cityRadA+400] call aio_fnc_aliveaddobjtoside;

AIO_TASKS_ACTIVE = AIO_TASKS_ACTIVE + 1; publicVariable "AIO_TASKS_ACTIVE";

[format["TASK%1",AIO_TASKS_ACTIVE], true, [format ["Intelligence has indicated a HVT (High Value Target) has shown up %1. Your objective is to locate and neutralize the target before he relocates from the area.  Target is wearing green camoflague and has a wound on his right hand. Friendly UAV's in the area will identify the target is eliminated.", _areaName], format ["Kill HVT %1.", _areaName], ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_rescuehelo.sqf"] call ALiVE_fnc_Dump;};