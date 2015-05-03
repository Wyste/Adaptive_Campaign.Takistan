/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/03/2015    | Checks if mission is done - if so, complete the mission.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [] call AIO_fnc_endcheck

if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_endcheck.sqf"] call ALiVE_fnc_Dump;
};

if (isServer || isDedicated) then {
  if (AIO_TASKS_COMPELTED == paramsArray select 3) then {endMission "END1";};
};