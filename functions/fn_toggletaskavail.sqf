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

<<<<<<< HEAD
	4/12/2015
=======
	4/11/2015
>>>>>>> master
Description:

	Removes a task from the global array and puts it in the unavailable array.
Usage:

<<<<<<< HEAD
**DO NOT CALL THIS WITH BIS_fnc_MP - THE PUBLIC VARIABLES HANDLE EVERYTHING
=======

>>>>>>> master
_____________________________________________________________________________*/

private["taskID","tier","makeavail"];
_taskID = _this select 0;
_tier = _this select 1;
_makeavail = _this select 2;

switch (_makeavail) do {
  case true: {
    switch (_tier) do {
        case 1: {
        AIO_T1TASKS_AVL = AIO_T1TASKS_AVL + [_taskID];
        publicVariable "AIO_T1TASKS_AVL";
        AIO_T1TASKS_NA = AIO_T1TASKS_NA - [_taskID];
        publicVariable "AIO_T1TASKS_NA";
      };
        case 2: {
        AIO_T2TASKS_AVL = AIO_T2TASKS_AVL + [_taskID];
        publicVariable "AIO_T2TASKS_AVL";
        AIO_T2TASKS_NA = AIO_T2TASKS_NA - [_taskID];
        publicVariable "AIO_T2TASKS_NA";
      };
        case 3: {
        AIO_T3TASKS_AVL = AIO_T3TASKS_AVL + [_taskID];
        publicVariable "AIO_T3TASKS_AVL";
        AIO_T3TASKS_NA = AIO_T3TASKS_NA - [_taskID];
        publicVariable "AIO_T3TASKS_NA";
      };
  };
  case false: {
    switch (_tier) do {
        case 1: {
        AIO_T1TASKS_AVL = AIO_T1TASKS_AVL - [_taskID];
        publicVariable "AIO_T1TASKS_AVL";
        AIO_T1TASKS_NA = AIO_T1TASKS_NA + [_taskID];
        publicVariable "AIO_T1TASKS_NA";
      };
        case 2: {
        AIO_T2TASKS_AVL = AIO_T2TASKS_AVL - [_taskID];
        publicVariable "AIO_T2TASKS_AVL";
        AIO_T2TASKS_NA = AIO_T2TASKS_NA + [_taskID];
        publicVariable "AIO_T2TASKS_NA";
      };
        case 3: {
        AIO_T3TASKS_AVL = AIO_T3TASKS_AVL - [_taskID];
        publicVariable "AIO_T3TASKS_AVL";
        AIO_T3TASKS_NA = AIO_T3TASKS_NA + [_taskID];
        publicVariable "AIO_T3TASKS_NA";
      };
    };
  };

};


