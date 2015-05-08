/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	BBrown | 4/28/2015 | Handles generation of 'Friendly Armor Retrieval/Destruction' T1 Tasking
_____________________________________________________________________________*/
//TODO: Add capturable logic if needed within this script
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

private ["_areaCoords", "_vehicles", "_selectedVeh", "_armor", "_brief", "_title"];

//--- spawn a random armored vehicle to destroy/capture
_vehicles = ["rhsusf_m113_usarmy", "rhsusf_m1a1aimd_usarmy", "rhsusf_m1a1fep_d"];
_selectedVeh = _vehicles select (random count _vehicles);
_armor = createVehicle [_selectedVeh,_spawnPOS,[],200,"None"];
_armor setDamage random 0.1;
_areaCoords = mapGridPosition _armor;

//Sets the number of tasks active

_armor setVariable ["id",AIO_TASKS_ACTIVE];
//--- add the tank to the capturable array
AIO_CAPTURABLE set [AIO_TASKS_ACTIVE,_armor];

//--- Update the tasks spawned
AIO_TASKS_SPAWNED set [AIO_TASKS_ACTIVE,_armor]; publicVariable "AIO_TASKS_SPAWNED";

//--- add KILLED eventhandler
_armor addEventHandler ["killed", {
	[_armor, "DESTROYED"] call AIO_fnc_friendlytankfinish; }
];

//--- add an AGM interaction to the tank
AGM_TANK = [_armor, "Secure Vehicle", 5, {AGM_Interaction_Target distance AIO_CAPPAD < 20}, {[AGM_Interaction_Target,"CHECK"] call AIO_fnc_friendlytankfinish}, false] call AGM_Interaction_fnc_addInteraction;

if(AIO_DEBUG) then {
	[format ["fn_T1_friendlytank.sqf| Creating ALIVE TAOR marker at %1",_areaPOS]] call ALiVE_fnc_Dump;
	_vehMrk = createMarker [format["mark%1", random 1000], _spawnPOS];
	_vehMrk setMarkerType "hd_dot";
	_vehMrk setMarkerColor "ColorRed";
	_vehMrk setMarkerText "DEBUG: Armor location";
};

//--- Create the TAOR marker
_m = createMarker [format ["task_taor_%1",AIO_TASKS_ACTIVE], _areaPOS];
_m setMarkerShape "ELLIPSE";
_m setMarkerColor "ColorBlue";
_m setMarkerBrush "BORDER";
_m setMarkerSize [_areaRad+200,_areaRad+200];
AIO_TASKS_TAORS set [AIO_TASKS_ACTIVE,_m]; publicVariable "AIO_TASKS_TAORS";
[[AIO_TASKS_TAORS select AIO_TASKS_ACTIVE,_spawnPOS,500,"CIV",1000],"GUER"] call aio_fnc_aliveaddobjtoside;

//--- Find out whether it's in a city or on a hill, modify the task title and description accordingly
private ["_verbage"];

if (_areaType ==  AIO_HILL) then {
	_verbage = format["at grid %1",_areaCoords];
} else {
	_verbage = format["near %1",_areaName];

};

	_brief = format["Friendly UAV's have located friendly armor that appears to be abandoned %1. The location of it's crew is unknown and enemy forces were spotted in the area, heading in it's direction. From the looks of it, they know it's there and are on their way to capture it. Your mission is to prevent the enemy from doing so at all costs. Retrieving the vehicle should be your highest priority, however you are authorized to destroy it if need be.", _verbage];

	_title = format["Retrieve/Destroy friendly armor %1",_verbage];

//--- create the task for all playersprivate ["_taskName"];
_taskName = format["TASK%1",AIO_TASKS_ACTIVE];
[_taskName, true, [_brief, _title, ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;
AIO_TASKS_ACTIVE = AIO_TASKS_ACTIVE + 1; publicVariable "AIO_TASKS_ACTIVE";

if(AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_friendlytank.sqf"] call ALiVE_fnc_Dump;};