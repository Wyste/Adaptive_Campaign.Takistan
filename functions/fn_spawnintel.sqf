/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                      @filename: spawnintel.sqf

Author:

	Wyste

Last modified:

	4/12/2015

Description:

	TASK - spawns intellegence in a town randomly. Also creates a trigger in which enemies can drop more intel.
_____________________________________________________________________________


target    (_this select 0): Object - the object which the action is assigned to
caller    (_this select 1): Object - the unit that activated the action
ID        (_this select 2): Number - ID of the activated action
arguments (_this select 3): Anything - arguments given to the script
*/

//--- Setup / Gathering Arguments + Mission Parameters

private ["_target","_caller","_aID","_args","_intelItems","_selectedItem","_item","_buildings","_area","_cities","_cityName","_cityPOS","_cityRadA","_cityRadB","_cityCent","_intelactive","_usearea","_targetBuildings","_targBuilding","_index","_targArr","_intelPosition"];

_target = _this select 0;
_caller = _this select 1;
_aID    = _this select 2;
_args   = _this select 3;
_intelactive = missionNamespace getVariable "AIO_INTEL_ACTIVE";
_intelItems = missionNamespace getVariable "AIO_INTELSPAWNED";

spawnedIntelItems = [];
publicVariable "spawnedIntelItems";

//--- Do nothing if this is called and 5 of this task are active.

if (_intelactive > 4) exitWith {}; //Max intels spawned - you need to wait.

//--- Selecting an area of operations
if (AIO_DEBUG) then {[" DEBUG| Selecting area for intel spawn..."] call ALiVE_fnc_Dump;};

//IF (AIO_DEBUG) then {[_args] call DEBUG_fnc_debugarray;};

  // Select random citygrouping to use
  // Select random city/area to use
  _area = _args call BIS_fnc_selectRandom;
  if (AIO_DEBUG) then {[format [" DEBUG| Selected Area Set of: %1",_area]] call ALiVE_fnc_Dump;};
  _area = missionNamespace getVariable _area;
  _index = _area call BIS_fnc_randomIndex;
    if (AIO_DEBUG) then {[format [" DEBUG| Index Selected: %1",_index]] call ALiVE_fnc_Dump;};
  _targArr = _area select _index;

  if (AIO_DEBUG) then {[" DEBUG| Array of area to use for intel spawn..."] call ALiVE_fnc_Dump;
[(_targArr select 0)] call ALiVE_fnc_Dump;
[(_targArr select 1)] call ALiVE_fnc_Dump;
[(_targArr select 2)] call ALiVE_fnc_Dump;
[(_targArr select 3)] call ALiVE_fnc_Dump;
[(_targArr select 4)] call ALiVE_fnc_Dump;
};

      _cityName = _targArr select 0;
      _cityPOS  = _targArr select 1;
      _cityRadA = _targArr select 2;
      _cityRadB = _targArr select 3;
      _cityCent = [(_cityPOS select 0) + (_cityRadA / 2),(_cityPos select 1) + (_cityRadB / 2)];
      if(_cityRadB > _cityRadA) then { _cityRadA = _cityRadB; };

//--- Spawn the stuff randomly!
if (AIO_DEBUG) then {hint "stuff spawning";};

  _targetBuildings = [_cityCent, _cityRadA] call AIO_fnc_findbuildings;

//TO-DO: Get count of current amount of players in the group based upon their personal variables
//In meantime... 10 intels please.
for "_i" from 1 to 10 step 1 do {
  if (count _targetBuildings > 0 ) then {
        _selectedItem = _intelItems call BIS_fnc_selectRandom;
        // Pull the array and select a random building from it.
        _targBuilding = _targetBuildings call BIS_fnc_selectRandom;
        // Take the random building from the above result and pass it through gRBP function to get a single cache position
        _intelPosition = [_targBuilding] call AIO_fnc_randbldgpos;
        _item = createVehicle [_selectedItem, _intelPosition, [], 0, "None"];

      // [[_item,"Capture Intel"],"AIO_fnc_addactionMP", true, true] spawn BIS_fnc_MP;


         [[_item,"Capture Intel","AIO_fnc_pickupintel",0,5,"red"],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
        // Move the Cache to the above select position
        _item setPos _intelPosition;

        spawnedIntelItems set [count spawnedIntelItems, _item];
        publicVariable "spawnedIntelItems";

        if (AIO_DEBUG) then {
          //debug to see where box spawned is if not multiplayer
          _m = createMarker [format ["box%1",random 10],getposATL _item];
          _m setMarkerShape "ICON";
          _m setMarkerType "mil_dot";
          _m setMarkerColor "ColorGreen";
        };
  };

};

//--- Did this task throw us over the limit of 5? If so - kill the action.
_intelactive = missionNamespace getVariable "AIO_INTEL_ACTIVE";
if (_intelactive > 4) then { _target removeAction _aID};