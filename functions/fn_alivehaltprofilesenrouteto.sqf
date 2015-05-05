/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | Provides alive profiles enroute to a (to be deleted) objective some re-routing.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_opcom,_objectiveID,_reroute] call AIO_fnc_alivehaltprofilesenrouteto

if (isServer || isDedicated) then {
  private["_wp","_opcom","_objective","_objectiveID","_objectives","_sections","_profile","_profileID","_retreatToNearestHeldObj","_results","_pos","_resultPos"];
  _opcom = _this select 0;
  _objectiveID = _this select 1;
  _retreatToNearestHeldObj = [_this,2,false,[false]] call BIS_fnc_Param;

  _objectives = [_opcom,"objectives",[]] call ALiVE_fnc_HashGet;
  {
    _objective = _x;
    if(_objectiveID == [_objective,"objectiveID",""] call ALiVE_fnc_HashGet) then {
      _sections = [_objective,"section",[]] call ALiVE_fnc_HashGet;
      {
        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
        _profileID = [_profile,"profileID",""] call ALiVE_fnc_HashGet;
        [_profile,"clearWaypoints"] call ALIVE_fnc_profileEntity;
        diag_log format["Halting %1 that was headed to %2",_profileID,_objectiveID];

        if(_retreatToNearestHeldObj) then {
          _pos = [_profile,"position",[]] call ALiVE_fnc_HashGet;
          diag_log format ["Finding an objective to reroute %1",_profileID];
          _results = [_pos, _objectives, [_objectiveID]] call AIO_fnc_nearestObjectiveToIgnoring;

          if(typename (_results select 0) != "STRING") then {
            diag_log format ["Routing %1 to %2",_profileID, [(_results select 0),"objectiveID",""] call ALiVE_fnc_HashGet];
            _resultPos = [(_results select 1)] call AIO_fnc_randomPointNear;
            _wp = [_resultPos, 50, "MOVE","NORMAL",25] call ALIVE_fnc_createProfileWaypoint;
            [_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;
          } else {
            diag_log format ["Could not find an objective for %1",_profileID];
          };
        };
      } forEach _sections;
    };
  } forEach _objectives;
};