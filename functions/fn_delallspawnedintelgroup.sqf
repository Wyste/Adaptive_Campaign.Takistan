/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/26/2015 |
_____________________________________________________________________________*/
if (AIO_DEBUG) then {
  ["SCRIPT STARTING| fn_delallspawnedintelgroup.sqf"] call ALiVE_fnc_Dump;
  [format ["Parameters| fn_delallspawnedintelgroup.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;
};

private ["_intelItems","_items","_delgrp"];

_delgrp = _this select 0;
_intelItems = AIO_INTELDROPABLE + AIO_INTELSPAWNABLE;
_items = nearestObjects[AIO_MAPCENTER, _intelItems, 20000];
//Grabs all items of certain classes on the entire map.


private ["_taskName"];
_taskName = format["INTEL%1",_delgrp];
//--- set task as completed


//--- Remove TAOR objective from alive.
[AIO_INTEL_TAORS select _delgrp] call aio_fnc_removeobjfromside;

{
  if (_x getVariable "intelgroup" == _delgrp) then {
    deleteVehicle _x;
    if (AIO_DEBUG) then {
      [format ["DEBUG: Cleaned up objects of group : %1",_delgrp]] call ALiVE_fnc_Dump;
    };
  };
} forEach _items;

["fn_delallspawnedintelgroup.sqf| : Sleeping 15 then deleting the task"] call ALiVE_fnc_Dump;
sleep 15;
[_taskName, true] call BIS_fnc_deleteTask;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_delallspawnedintelgroup.sqf"] call ALiVE_fnc_Dump;};