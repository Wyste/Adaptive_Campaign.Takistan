/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Removes a TOAR from Alive OPCOM instances, thus making them leave the area.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_TAORmarker] call AIO_fnc_aliveremoveobjfromside

if (AIO_DEBUG) then {["SCRIPT STARTED| fn_aliveremoveobjfromside.sqf"] call ALiVE_fnc_Dump;
  ["fn_aliveremoveobjfromside.sqf",_this] call DEBUG_fnc_dumpParams;
};
private ["_marker"];

if (isServer || isDedicated) then {
  private ["_objName"];
  _objName = format["%1_obj",_this select 0];

  private["_factions","_faction","_opcom","_opcomSide","_baseObjName"];
  {
    [_x, "removeObjective", _objName] call ALiVE_fnc_OPCOM;
  } forEach OPCOM_INSTANCES;
} else {
  ["SCRIPT PROBLEM| fn_aliveremoveobjfromside.sqf - WAS NOT RUN ON DEDICATED|SERVER"] call ALiVE_fnc_Dump;
};

_marker = _this select 0;
deleteMarker _marker;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_aliveremoveobjfromside.sqf"] call ALiVE_fnc_Dump;};