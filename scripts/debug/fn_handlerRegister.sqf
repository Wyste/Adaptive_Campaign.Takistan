/*
@filename: handleRegister.sqf

Author:

	Hazey - Modified by BBrown & Wyste

Last modified:

	4/11/2015

Description:

	CBA magic to call event handler for intel dropping off units.
___________________________________________________________________________*/

if (isServer || isDedicated) then {
	private["_unit"];

	_unit = _this select 0;

	if((side _unit == EAST) || (side _unit == RESISTANCE)) then {
		_unit addEventHandler ["Killed", {_this call AIO_fnc_intelDrop}];
	};
};