/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste/BBrown | 4/20/2015 | T1 TASK - Destroy weapons cache
_____________________________________________________________________________*/
if (AIO_DEBUG) then {["SCRIPT STARTING| fn_T1_spawncache.sqf"] call ALiVE_fnc_Dump;};

private ["_target","_caller","_ID", "_location", "_buildings", "_bldg", "_bldgPos", "_cityPOS", "_cityRadA", "_cityRadB", "cache", "_group"];
_target = _this select 0;
_caller = _this select 1;
_ID		= _this select 2;

_target removeAction _ID; //--- Remove action from sign.

if (AIO_DEBUG) then {["DEBUG| fn_T1_spawncache.sqf| Getting random town."] call ALiVE_fnc_Dump;};

//--- Find a location to use
_location = [[AIO_LgCITY,AIO_CITY,AIO_VILLAGE]] call AIO_fnc_findLocation;

//--- Get city position and radius
_cityPOS = _location select 1;
_cityRadA = _location select 2;
_cityRadB = _location select 3;

if (_cityRadB > _cityRadA) then {
	_cityRadA = _cityRadB;
};
sleep 1;
if (AIO_DEBUG) then {["DEBUG| fn_T1_spawncache.sqf| Getting enterable houses."] call ALiVE_fnc_Dump;};

//--- Find enterable houses
_buildings = [_cityPOS, _cityRadA] call AIO_fnc_getenterablehouses;
sleep 1;
if (isNil "_buildings") exitWith {
	if (AIO_DEBUG) then {
		["DEBUG| fn_T1_spawncache.sqf| Building array does not exist. Running again..."] call ALiVE_fnc_Dump;
	};

	[] spawn TASK_fnc_T1_spawncache;
};

if (count _buildings == 0) then {
	if (AIO_DEBUG) then {
		["DEBUG| fn_T1_spawncache.sqf| Building array is empty. No houses found... Trying again."] call ALiVE_fnc_Dump;
	};

	[] spawn TASK_fnc_T1_spawncache;
};
if(AIO_DEBUG) then {["DEBUG| fn_T1_spawncache.sqf| Selecting random house from list: %1", _buildings] call ALiVE_fnc_Dump;};

//--- Select a random enterable house
_bldg = _buildings call bis_fnc_selectRandom;

if(AIO_DEBUG) then {["DEBUG| fn_T1_spawncache.sqf| House found"] call ALiVE_fnc_Dump};
sleep 1;
if(AIO_DEBUG) then {["DEBUG| fn_T1_spawncache.sqf| Finding indoor position"] call ALiVE_fnc_Dump;};

//--- Finding random indoor position for spawning the cache
_bldgPos = [_bldg] call AIO_fnc_randbldgpos;
sleep 1;

//--- Create the cache at the selected indoor position
cache = createVehicle ["Box_FIA_Wps_F", _bldgPos, [], 0, "None"];
if(AIO_DEBUG) then {["DEBUG| fn_T1_spawncache.sqf| Cache has been created"] call ALiVE_fnc_Dump;};

//-- Empty the cache... doesn't this defeat the purpose of destroying it? sarcasm = true
clearMagazineCargoGlobal cache;
clearWeaponCargoGlobal cache;

//--- Add eventhandlers to the cache
//--- Handle damage only for Satchels and Demo charges
cache addEventHandler ["handledamage", {
	if ((_this select 4) in ["SatchelCharge_Remote_Ammo", "DemoCharge_Remote_Ammo", "SatchelCharge_Remote_Ammo_Scripted", "DemoCharge_Remote_Ammo_Scripted"]) then {
		(_this select 0) setdamage 1;

		//--- event handler for killing the cache
		(_this select 0) spawn AIO_fnc_killcache;
	} else {
		(_this select 0) setdamage 0;
}}];
//--- End of eventhandlers

//--- Disable simulation of the cache
cache enableSimulationGlobal false;
publicVariable "cache";

//--- Debug
if(AIO_DEBUG) then {
	_m = createMarker [format ["box%1", random 1000],getPosATL cache];
	_m setMarkerShape "ICON";
	_m setMarkerText format ["Cache location"];
	_m setMarkerType "hd_dot";
	_m setMarkerColor "ColorRed";
};

//--- Create and assign the task to the group the caller is in
["cache", true, [format ["Intelligence suggests that there is a stockpile of weapons located somewhere in %1. Your objective is to locate and neutralize this stockpile before the enemy can make further use of it. Expect heavy resistance", _location select 0], format ["Locate and Destroy weapons cache in %1", _location select 0], ""], "", "CREATED", 1, true, true] call bis_fnc_setTask;

//--- Tasking completed!
//AIO_TASKS_COMPLETED = AIO_TASKS_COMPLETED + 1; publicVariable "AIO_TASKS_COMPLETED";

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_T1_spawncache.sqf"] call ALiVE_fnc_Dump;};