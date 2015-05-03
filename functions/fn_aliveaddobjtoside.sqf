/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Adds a CIV OPCOM objective with given radius to every OPCOM instance in the server.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_marker, _radius] call AIO_fnc_aliveaddobjtoside

if (AIO_DEBUG) then {
  ["SCRIPT STARTED| fn_aliveaddobjtoside.sqf"] call ALiVE_fnc_Dump;
  ["fn_aliveaddobjtoside.sqf",_this] call DEBUG_fnc_dumpParams;
};

if (isServer || isDedicated) then {
  private ["_marker","_size"];
  _marker = _this select 0;
  _size = _this select 1;
  private ["_objName","_pos"];
  _objName = format["%1_obj",_marker];
  _pos = getMarkerPos _marker;
  {
    [_x,"addObjective", [_objName, _pos, _size, "CIV", 1000] ] call ALiVE_fnc_OPCOM;
  } foreach OPCOM_INSTANCES;
};
if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_aliveaddobjtoside.sqf"] call ALiVE_fnc_Dump;};