/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	BBrown | 4/28/2015 | Handles generation of 'Friendly Tank Retrieval/Destruction' T1 Tasking
_____________________________________________________________________________*/

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_T1_rescuehelo.sqf"] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_friendlytank.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_friendlytank.sqf| : %1",_this select 1]] call ALiVE_fnc_Dump;
	[format ["Parameters| fn_T1_friendlytank.sqf| : %1",_this select 2]] call ALiVE_fnc_Dump;
};

private ["_target", "_caller", "_ID", "_areaName"];
_target = _this select 0;
_caller = _this select 1;
_ID		= _this select 2;

_target removeAction _ID; //--- Remove action from sign.

private ["_loc", "_hill", "_areaPOS", "_areaRad", "_areaType", "_areaName", "_spawnPOS", "_m"];

//--- Get required location information
_loc = [[AIO_HILL, AIO_CITY, AIO_LgCITY]] call AIO_fnc_findLocation;
_areaName = _loc select 0;
_areaPOS = _loc select 1;
_areaRad = _loc select 2;
_areaType = _loc select 4;
_spawnPOS = [_areaPOS, _areaRad, 20] call AIO_fnc_getsecludedlocation;

private ["_areaCoords", "_vehicles", "_selectedVeh", "_brief", "_title"];

//--- spawn a random armored vehicle to destroy/capture
_vehicles = ["rhsusf_m113_usarmy", "rhsusf_m1a1aimd_usarmy", "rhsusf_m1a1fep_d"];
_selectedVeh = _vehicles select (random count _vehicles);
_selectedVeh = createVehicle [,_spawnPOS,[],0,"None"];
_selectedVeh setDamage random 0.1;

//--- add KILLED eventhandler
_selectedVeh addEventHandler ["KILLED", { [_selectedVeh, "SUCCEEDED"] call AIO_fnc_friendlytankfinish; }];
_areaCoords = mapGridPosition _selectedVeh;

_selectedVeh setVariable ["id",AIO_TASKS_ACTIVE];
//--- add the tank to the capturable array
AIO_CAPTURABLE = AIO_CAPTURABLE + _selectedVeh; publicVariable "AIO_CAPTURABLE";

//--- Update the tasks spawned
AIO_TASKS_SPAWNED set [AIO_TASKS_ACTIVE,_selectedVeh]; publicVariable "AIO_TASKS_SPAWNED";

if(AIO_DEBUG) then { [format ["fn_T1_rescuehelo.sqf| Creating ALIVE TAOR marker at %1",_areaPOS]] call ALiVE_fnc_Dump};

//--- Create the TAOR marker
_m = createMarker [format ["task_taor_%1",AIO_TASKS_ACTIVE], _areaPOS];
_m setMarkerShape "ELLIPSE";
_m setMarkerColor "ColorBlue";
_m setMarkerBrush "BORDER";
_m setMarkerSize [_areaRad+200,_areaRad+200];
AIO_TASKS_TAORS set [AIO_TASKS_ACTIVE,_m]; public publicVariable "AIO_TASKS_TAORS";
[AIO_TASKS_TAORS select AIO_TASKS_ACTIVE,_areaRad+400] call AIO_fnc_aliveaddobjtoside;

//Sets the number of tasks active
AIO_TASKS_ACTIVE = AIO_TASKS_ACTIVE + 1; publicVariable "AIO_TASKS_ACTIVE";

//--- Find out whether it's in a city or on a hill, modify the task title and description accordingly
if(_areaType == AIO_LgCITY || _areaType == AIO_CITY) then {
	_brief = format["Friendly UAV's have located friendly armor that appears to be abandoned near %1. The location of it's crew is unknown and enemy forces were spotted in the area, heading in it's direction. From the looks of it, they know it's there and are on their way to capture it. Your mission is to prevent the enemy from doing so at all costs. Retrieving the vehicle should be your highest priority, however you are authorized to destroy it if need be.", _areaName];

	_title = format["Retrieve/Destroy friendly armor near %1",_areaName];
} else {
	if(_areaType == AIO_HILL) then {
		format["Friendly UAV's have located friendly armor that appears to be abandoned at grid %1. The location of it's crew is unknown and enemy forces were spotted in the area, heading in it's direction. From the looks of it, they know it's there and are on their way to capture it. Your mission is to prevent the enemy from doing so at all costs. Retrieving the vehicle should be your highest priority, however you are authorized to destroy it if need be.", _areaCoords];

		_title = format["Retrieve/Destroy friendly armor at %1",_areaCoords];
	};
};

//--- create the task for all players
[format["TASK%1",AIO_TASKS_ACTIVE], true, [_brief, _title, ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;

if(AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_friendlytank.sqf"] call ALiVE_fnc_Dump;};

sleep 3600;
//Wait one hour... then check to see if the tank still exists in the world...  If it does - you failed, and cleanup.
if(alive _selectedVeh) exitWith { [_selectedVeh,"FAILED"] call AIO_fnc_friendlytankfinish };