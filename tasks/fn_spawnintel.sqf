/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/20/2015 | TASK - spawns intellegence in a town randomly.
___________________________________________________________________________*/

if (AIO_DEBUG) then {["SCRIPT STARTING| fn_spawnintel.sqf"] call ALiVE_fnc_Dump;};

if (AIO_INTEL_ACTIVE - AIO_INTEL_COMPLETED > 4) exitWith {}; //--- If 5 intel areas are populated already - EXIT

while {AIO_INTEL_ACTIVE - AIO_INTEL_COMPLETED < 5} do {

	if (AIO_DEBUG) then {["fn_spawnintel.sqf| Selecting area for intel spawn..."] call ALiVE_fnc_Dump;};

	private ["_randcity","_cityName","_cityPOS","_cityRadA","_cityRadB","_buildings","_bldg","_itemToSpawn","_spawnPOS","_item","_m"];
	_buildings = [];

	while {count _buildings < 5} do { //--- We want a city with more then 4 buildings.
		//--- Select random city and it's information.
		_randcity = [[AIO_VILLAGE,AIO_CITY]] call AIO_fnc_findLocation;
		_cityName = _randcity select 0;
		_cityPOS  = _randcity select 1;
		_cityRadA = _randcity select 2;
		_cityRadB = _randcity select 3;
		if(_cityRadB > _cityRadA) then { _cityRadA = _cityRadB; };
		//--- Select buildings within the selected city
		_buildings = [_cityPOS, _cityRadA] call AIO_fnc_getenterablehouses;
	};

	//--- Spawn max 10 intel items in this random city within building positions
	for "_i" from 1 to 10 step 1 do {
		//--- Item and location Setup
		_itemToSpawn = AIO_INTELSPAWNABLE call BIS_fnc_selectRandom; //--- Random class of intel item
		_bldg = _buildings call BIS_fnc_selectRandom; //--- Select random building from the town
		_spawnPOS = [_bldg] call AIO_fnc_randbldgpos;

		if (AIO_DEBUG) then {[format ["fn_spawnintel.sqf| Attempting to create intel at %1...",_spawnPOS]] call ALiVE_fnc_Dump;};
		_item = createVehicle [_itemToSpawn, _spawnPOS, [], 0, "None"];
		_item setVariable ["id",AIO_INTEL_ACTIVE,true];

		if (AIO_DEBUG) then { //--- Debug Markers
	          [format ["fn_spawnintel.sqf| Creating marker at %1",_spawnPOS]] call ALiVE_fnc_Dump;
			  _m = createMarker [format ["box%1",random 10],getposATL _item];
	          _m setMarkerShape "ICON";
	          _m setMarkerType "mil_dot";
	          _m setMarkerColor "ColorGreen";
		};

		//--- Add action to pickup the intel by players
		[[_item,"Capture Intel",{ call AIO_fnc_intelpickup},0,5,"red"],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;

		//--- Reset position just in case.
		_item setPos _spawnPOS;

		//Fix up the globals for proper tracking of everything
		AIO_INTEL_SPAWNED set [AIO_INTEL_ACTIVE,_i]; publicVariable "AIO_INTELSPAWNED";
	};
	AIO_INTEL_ACTIVE = AIO_INTEL_ACTIVE + 1;  publicVariable "AIO_INTEL_ACTIVE";
};

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_spawnintel.sqf"] call ALiVE_fnc_Dump;};