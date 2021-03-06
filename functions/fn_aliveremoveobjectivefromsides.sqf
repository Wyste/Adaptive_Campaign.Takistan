/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | Removes TAOR objective from OPCOM of specified side
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_TAORmarker,true|false] call AIO_fnc_aliveremoveobjectivefromsides

if (isServer || isDedicated) then {
  if (AIO_DEBUG) then {
    ["SCRIPT STARTED| fn_aliveremoveobjectivefromsides.sqf"] call ALiVE_fnc_Dump;
    ["fn_aliveremoveobjectivefromsides.sqf",_this] call DEBUG_fnc_dumpParams;
  };
  private["_objectiveID","_factionSide","_opcom","_opcomSide","_baseObjName","_reroute"];
  _baseObjName = _this select 0;
  _factionSide = _this select 1;
  _reroute = true;
  deleteMarker _baseObjName;
  {
    _opcom = _x;
    _opcomSide = [_opcom,"side",""] call ALiVE_fnc_HashGet;
    _objectiveID = format["%1_%2",_baseObjName,_opcomSide];
    if( _opcomSide == _factionSide) then {
      // find active Logistics modules, pause them, wait until they are paused and then do the remove
      [_opcom,_objectiveID,_reroute] call AIO_fnc_alivehaltProfilesEnrouteTo;
      [_opcom, "removeObjective", _objectiveID] call ALiVE_fnc_OPCOM;
      diag_log format["Removed %1",_objectiveID];
    };
  } forEach OPCOM_INSTANCES;
};