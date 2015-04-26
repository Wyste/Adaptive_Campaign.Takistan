/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/26/2015 |
___________________________________________________________________________*/
if (AIO_DEBUG) then {["SCRIPT STARTED| fn_aliveremoveobjfromside.sqf"] call ALiVE_fnc_Dump;};
if (AIO_DEBUG) then {[format ["Parameters| fn_aliveremoveobjfromside.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;};


if (isServer || isDedicated) then {
	private ["_objName"];
	_objName = format["%1_obj",_this select 0];

	private["_factions","_faction","_opcom","_opcomSide","_baseObjName"];
	{
		[_x, "removeObjective", _objName] call ALiVE_fnc_OPCOM;
	} forEach OPCOM_INSTANCES;
} else {
	["SCRIPT PROBLEM| fn_aliveremoveobjfromside.sqf - WAS NOT RUN ON DEDICATED|SERVER"] call ALiVE_fnc_Dump;
};

deleteMarker _this select 0;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_aliveremoveobjfromside.sqf"] call ALiVE_fnc_Dump;};