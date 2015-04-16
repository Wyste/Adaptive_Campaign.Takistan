/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                              @filename: fn_toggletaskavail.sqf

Author:

	Wyste
Last modified:

	4/12/2015

Description:

	Removes a task from the global array and puts it in the unavailable array.
Usage:

**DO NOT CALL THIS WITH BIS_fnc_MP - THE PUBLIC VARIABLES HANDLE EVERYTHING

_____________________________________________________________________________*/




private["taskID","tier","makeavail"];
_taskID = _this select 0;
_makeavail = _this select 1;

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - toggletaskavail running..."] call ALiVE_fnc_Dump;};



//-- Needs rewritten for new task array

switch (_makeavail) do {
  case true: {
     {
      if (_x select 0 == _taskID) then { _x select 3 set true; };

     } forEach AIO_TASKS;
  };
  case false: {
    {
      if (_x select 0 == _taskID) then { _x select 3 set false; };

    } forEach AIO_TASKS;
  };
};
publicVariable "AIO_TASKS";