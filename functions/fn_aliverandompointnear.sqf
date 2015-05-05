/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | provides random point within new objective near profile to reroute towards.
______________________________________________________________________________________________________________________*/
// RETURN: Position
// USAGE : _resultPos = [position in closest objective] call AIO_fnc_randomPointNear;

if (isServer || isDedicated) then {
  private["_pos","_dist","_dir"];
  _pos = _this select 0;
  _dist = [_this, 1, 75,[1]] call BIS_fnc_Param;
  _dir = random 360;
  [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
};