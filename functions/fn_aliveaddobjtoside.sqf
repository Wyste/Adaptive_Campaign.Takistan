/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/26/2015 |
___________________________________________________________________________*/
if (AIO_DEBUG) then {["SCRIPT STARTED| fn_aliveaddobjtoside.sqf"] call ALiVE_fnc_Dump;};
if (AIO_DEBUG) then {[format ["Parameters| fn_aliveaddobjtoside.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;};
if (AIO_DEBUG) then {[format ["Parameters| fn_aliveaddobjtoside.sqf| : %1",_this select 1]] call ALiVE_fnc_Dump;};


if (isServer || isDedicated) then {
	private ["_marker","_size"];
	_marker = _this select 0;
	_size = _this select 1;
	private ["_objName","_pos"];
	_objName = format["%1_obj",_marker];
	_pos = getMarkerPos _marker;
	{
		[_x,"addObjective", [_objName, _pos, _size, "CIV", 1000] ] call ALiVE_fnc_OPCOM;
	} foreach OPCOM_INSTANCES;
};
if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_aliveaddobjtoside.sqf"] call ALiVE_fnc_Dump;};