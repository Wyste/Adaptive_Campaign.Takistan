/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                         @filename: delallspawnedintelgroup.sqf

Author:

	Wyste

Last modified:

	4/19/2015
_____________________________________________________________________________*/

private ["_intelItems","_items","_delgrp"];

_delgrp = _this select 0;
_intelItems = AIO_INTELDROPPED + AIO_INTELSPAWNED;
_items = nearestObjects[AIO_MAPCENTER, _intelItems, 20000];
//Grabs all items of certain classes on the entire map.

{
  if (_x getVariable "intelgroup" == _delgrp) then {
    deleteVehicle _x;
    if (AIO_DEBUG) then {
      [format ["DEBUG: Cleaned up objects of group : %1",_delgrp]] call ALiVE_fnc_Dump;
    };
  };
} forEach _items;
