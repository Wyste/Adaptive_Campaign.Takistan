/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                  @filename: getcountbldgpos.sqf

Author:

	Wyste

Last modified:

	4/19/2015

Description:

	Counts building positions for passed building

Returns:

	Array
______________________________________________________*/
private ["_building", "_count"];

_building = _this select 0;
_count = 0;
while {str(_building buildingPos _count) != "[0,0,0]"} do {
	_count = _count + 1;
};
_count