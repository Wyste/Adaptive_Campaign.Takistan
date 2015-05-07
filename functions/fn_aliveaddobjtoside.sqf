/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Adds a CIV OPCOM objective with given radius to every OPCOM instance in the server.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_marker, _position, _radius, CIV | MIL, Priority] call AIO_fnc_aliveaddobjtoside

if (isServer || isDedicated) then {
  if (AIO_DEBUG) then {
    ["SCRIPT STARTED| fn_aliveaddobjtoside.sqf"] call ALiVE_fnc_Dump;
  };

  private["_objectiveParams","_factionSide","_faction","_opcom","_opcomSide","_baseObjName"];
  _objectiveParams = _this select 0;
  _factionSide = _this select 1;
  _baseObjName = _objectiveParams select 0;
  {
    _opcom = _x;
    _opcomSide = [_opcom,"side",""] call ALiVE_fnc_HashGet;
    _objectiveParams set[0, format["%1_%2",_baseObjName,_opcomSide]];
    if( _opcomSide == _factionSide) then {
      [_opcom, "addObjective", _objectiveParams] call ALiVE_fnc_OPCOM;
      if (AIO_DEBUG) then { [format["Adding %1 to %2",_baseObjName,_factionSide]] call Alive_fnc_Dump; };
    };
  } forEach OPCOM_INSTANCES;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_aliveaddobjtoside.sqf"] call ALiVE_fnc_Dump;};
};