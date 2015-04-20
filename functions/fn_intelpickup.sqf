/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                     @filename: intelpickup.sqf

Author:

	Wyste

Last modified:

	4/19/2015

Description:

	Main Definitions - These will be used the entire life of the mission.
_____________________________________________________________________________*/

if (AIO_DEBUG) then { ["Debug: Running intelpickup.sqf..."] call ALiVE_fnc_Dump;};

private ["_intelItems","_intel","_used","_ID","_cases","_case","_cache","_x","_intgrp","_curgrpintel","_pointvalue"];

_intelItems = AIO_INTELDROPPED + AIO_INTELSPAWNED;
AIO_INTEL_TRACKER = missionNamespace getVariable "AIO_INTEL_TRACKER";
AIO_INTEL_POINTS = missionNamespace getVariable "AIO_INTEL_POINTS";
AIO_INTEL_ACTIVE = missionNamespace getVariable "AIO_INTEL_ACTIVE";

_intel = _this select 0;
_used = _this select 1;
_ID = _this select 2;
_intel removeAction _ID;
_cases = nearestObjects[getPos player, _intelItems, 4.5];

	if (count _cases == 0) exitWith {};

	{
		_intgrp = _x getVariable "intelgroup";
		_curgrpintel = AIO_INTEL_TRACKER select _intgrp;
		_pointvalue = _x getVariable "intelpoints";
		AIO_INTEL_TRACKER set [_intgrp,_curgrpintel-1];
		AIO_INTEL_POINTS = AIO_INTEL_POINTS + _pointvalue;
		publicVariable "AIO_INTEL_TRACKER";
		publicVariable "AIO_INTEL_POINTS";
		deleteVehicle _x;
		sleep 1;
		player sideChat format ["Your faction retrieved some INTEL. Current accumulated 'intel' is %1 . Intel gathered for group %2 which had a value of %3",AIO_INTEL_POINTS,_curgrpintel, _pointvalue];
		//[_cache, "INS_fnc_createIntel", false, false] spawn BIS_fnc_MP;
	} forEach _cases;

//Picked up 5 - good enough for government work.
if (AIO_INTEL_TRACKER select _intgrp < 5) then {
	//Clean up the rest of those intels
	[_intgrp,0] call AIO_fnc_delallspawnedintelgroup;
	AIO_INTEL_ACTIVE = AIO_INTEL_ACTIVE - 1;
	publicVariable "AIO_INTEL_ACTIVE";
	//run the sign script again, cuz it need to repopulate if needed.
	(AIO_TASKS select 0) set [2,true];
	[AIO_TASKS select 0] execVM "addtosignsign.sqf";
};

//Look at current point total and make random tier 2 missions available... :D

if (AIO_INTEL_POINTS >= 20) then {
	AIO_INTEL_POINTS = AIO_INTEL_POINTS - 20;
	publicVariable "AIO_INTEL_POINTS";
	private ["_tier"];
	_tier = 0;
	while {_tier != 2} do {
    	_newTask = AIO_TASKS select floor(random(count AIO_TASKS));
    	_tier = _newTask select 1;
    };
    //One random teir 2 mission is now available and going to be assigned to sign board.
	//(AIO_TASKS select (_newTask select 0)) set [2,true];
	_newTask execVM "addtosign.sqf";
};