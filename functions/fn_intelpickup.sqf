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

if (AIO_DEBUG) then {[format ["fn_intelpickup.sqf| Picking up %1 near player...",typeName _intel]] call ALiVE_fnc_Dump;};

_ID = _intel getVariable "id";
_pts = _intel getVariable "pts";
if (AIO_DEBUG) then {["fn_intelpickup.sqf| Removing 1 from AIO_INTEL_SPAWNED"] call ALiVE_fnc_Dump;};

if (_ID > 0) then {AIO_INTEL_SPAWNED set [_ID,(AIO_INTEL_SPAWNED select _ID)-1];	publicVariable "AIO_INTEL_SPAWNED";};

AIO_INTEL_POINTS = AIO_INTEL_POINTS + _pts; publicVariable "AIO_INTEL_POINTS";
if (AIO_DEBUG) then {["fn_intelpickup.sqf| Deleting intel from world"] call ALiVE_fnc_Dump;};
deleteVehicle _intel;

sleep 1;
if (AIO_DEBUG) then {player sideChat format ["Your faction retrieved some INTEL. Current accumulated 'intel' is %1.",AIO_INTEL_POINTS];};

//Picked up 5 - good enough for government work.
if (AIO_INTEL_SPAWNED select _ID < 5) then {
	//Clean up the rest of those intels
	if (AIO_DEBUG) then {["fn_intelpickup.sqf| Objective Completed - Cleanup other remaining intel items."] call ALiVE_fnc_Dump;};
	[_ID] spawn AIO_fnc_delallspawnedintelgroup;
	AIO_INTEL_COMPLETED = AIO_INTEL_COMPLETED + 1;
	publicVariable "AIO_INTEL_COMPLETED";
	//run the intel script again, cuz it need to repopulate if needed.
	[] call TASK_fnc_spawnintel;
};

//Look at current point total and make random tier 2 missions available... :D

if (AIO_INTEL_POINTS >= 20) then {
	AIO_INTEL_POINTS = AIO_INTEL_POINTS - 20;
	publicVariable "AIO_INTEL_POINTS";
	call AIO_fnc_addrandtasktosign;
	[["HQ was able to use gathered intellegence to identify a high value mission. Return to base to re-arm and accept the tasking!"],"AIO_fnc_alivesideMsg",false,true] spawn BIS_fnc_MP;
} else {
	[["Friendlies have recovered some intellegence. HQ has not yet been able to provide additional missions without more intellegence. Keep collecting intellegence as HQ processes the data."],"AIO_fnc_alivesideMsg",false,true] spawn BIS_fnc_MP;
};
if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_intelpickup.sqf"] call ALiVE_fnc_Dump;};