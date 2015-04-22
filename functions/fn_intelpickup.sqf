/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/20/2015 | Handles the pickup of Intellegence and what happens.
_____________________________________________________________________________*/

if (AIO_DEBUG) then {["SCRIPT STARTING| fn_intelpickup.sqf"] call ALiVE_fnc_Dump;};

private ["_intelItems","_intel","_cases","_ID","_pts"];

_intelItems = AIO_INTELDROPABLE + AIO_INTELSPAWNABLE;

_intel = _this select 0;

_cases = nearestObjects[getPos player, _intelItems, 4.5];

	if (count _cases == 0) exitWith {};

	{
		_ID = _x getVariable "id";
		_pts = _x getVariable "pts";
		if (AIO_DEBUG) then {["fn_intelpickup.sqf| Removing 1 from AIO_INTEL_SPAWNED"] call ALiVE_fnc_Dump;};
		AIO_INTEL_SPAWNED set [_ID,(AIO_INTEL_SPAWNED select _ID)- 1];
		AIO_INTEL_POINTS = AIO_INTEL_POINTS + _pts;
		publicVariable "AIO_INTEL_SPAWNED";
		publicVariable "AIO_INTEL_POINTS";

		if (AIO_DEBUG) then {["fn_intelpickup.sqf| Deleting intel from world"] call ALiVE_fnc_Dump;};
		deleteVehicle _x;

		sleep 1;
		if (AIO_DEBUG) then {player sideChat format ["Your faction retrieved some INTEL. Current accumulated 'intel' is %1.",AIO_INTEL_POINTS];};
	} forEach _cases;

//Picked up 5 - good enough for government work.
if (AIO_INTEL_SPAWNED select _ID < 5) then {
	//Clean up the rest of those intels
	if (AIO_DEBUG) then {["fn_intelpickup.sqf| Objective Completed - Cleanup other remaining intel items."] call ALiVE_fnc_Dump;};
	[_ID] call AIO_fnc_delallspawnedintelgroup;
	AIO_INTEL_COMPLETED = AIO_INTEL_COMPLETED + 1;
	publicVariable "AIO_INTEL_COMPLETED";
	//run the intel script again, cuz it need to repopulate if needed.
	[] call TASK_fnc_spawnintel;
};

//Look at current point total and make random tier 2 missions available... :D

if (AIO_INTEL_POINTS >= 20) then {
	AIO_INTEL_POINTS = AIO_INTEL_POINTS - 20;
	publicVariable "AIO_INTEL_POINTS";

	private ["_task"];
	_task = [AIO_T1TASKS] call BIS_fnc_selectRandom;
	_task call DEBUG_fnc_debugarray;
	//One random teir 2 mission is now available and going to be assigned to sign board.
	[[AIO_SIGN select 0,_task select 0,_task select 1,_task select 2],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
	["Headquarters has used gathered intellegence to identify a high value mission. Return to base to accept the tasking!"] call AIO_fnc_alivesideMsg;
};
if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_intelpickup.sqf"] call ALiVE_fnc_Dump;};