/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                @filename: fn_gettaskdetail.sqf

Author:

	Wyste
Last modified:

	4/12/2015

Description:

  Gets a detail of the defined task
_____________________________________________________________________________*/

private["_taskArray","_taskID","_result","_detail"];
_taskArray = _this select 0;
_taskID = _this select 1;
_detail = _this select 2;
_result = _taskArray select _taskID select _detail;
_result;