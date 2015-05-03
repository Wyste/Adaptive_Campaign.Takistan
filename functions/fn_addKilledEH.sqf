/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Add a killed eventhandler for east and resistance units.
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_unit] call AIO_fnc_addKilledEH

// TODO: Add a check for being less then 1000m from an actual active intel TAOR.

if (AIO_DEBUG) then {
  ["SCRIPT STARTED| fn_addactionmp.sqf"] call ALiVE_fnc_Dump;
  ["fn_addactionmp.sqf",_this] call DEBUG_fnc_dumpParams;
};

if (isServer || isDedicated) then {
  private["_unit"];
  _unit = _this select 0;
  if ((side _unit == EAST) || (side _unit == RESISTANCE)) then {
    _unit addEventHandler ["Killed", {_this call AIO_fnc_intelDrop}];
    if (AIO_DEBUG) then { ["Inteldrop Killed EventHandler added to unit"] call ALIVE_fnc_dump; };
  } else {
    if (AIO_DEBUG) then { ["Skipping adding Inteldrop Killed EventHandler to the Unit"] call ALIVE_fnc_dump; };
  };
};