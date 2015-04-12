/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                          @filename: tasks.sqf

Author:

	Wyste
Last modified:

	4/12/2015
Description:

	Defines all the available missions and properties associted with.
Usage:

_____________________________________________________________________________*/

AIO_T1TASKS = []; //--- These are intel missions, and therefore don't change
AIO_T2TASKS = []; //--- These are the main missions, required to win the game.
AIO_T3TASKS = []; //--- These are special, rarely follow after T2.(10%)

// Format : ["taskID","TaskName","TaskDesc","AreaToUse"]
private ["newtask"];
for "_i" from 0 to 4 do
{
  _newtask = [_i,"Gather Intellegence","Gather intellegence from %1.",[AIO_SmCITY,AIO_VILLIAGE]];
  AIO_T1TASKS = AIO_T1TASKS + _newtask;
};

