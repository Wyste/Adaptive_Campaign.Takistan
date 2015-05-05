/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | Provides nearest objective and posistion in array format to re-route profiles to
______________________________________________________________________________________________________________________*/
// RETURN: Array
// USAGE : _results = [_pos, _objectives, [_objectiveID]] call AIO_fnc_nearestObjectiveToIgnoring

if (isServer || isDedicated) then {
  private["_startPoint","_objective","_objCenter","_objectiveID","_objectiveList","_ignoreObjectives","_nearestObj","_nearPos","_opcomState"];
  _startPoint = _this select 0;
  _objectiveList = _this select 1;
  _ignoreObjectives = [_this,2,[],[[]]] call BIS_fnc_Param;
  _nearestObj = "";
  _nearPos = [0,0,0];

  {
    _objective = _x;
    _objectiveID = [_objective,"objectiveID",""] call ALiVE_fnc_HashGet;
    _opcomState = [_objective,"opcom_state",""] call ALiVE_fnc_HashGet;
    diag_log format["Considering %1 with state %2",_objectiveID,_opcomState];
    if( !(_objectiveID in _ignoreObjectives) && _opcomState in ["idle","reserve","defend","defending","reserving"]) then {
      _objCenter = [_objective,"center",[0,0,0]] call ALiVE_fnc_HashGet;

      if( (_startPoint distance _objCenter) < (_startPoint distance _nearPos) ) then {
        _nearestObj = _objective;
        _nearPos = _objCenter;
      };
    };
  } forEach _objectiveList;

  [_nearestObj,_nearPos];
};