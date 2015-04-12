/*

@filename: intelPickup.sqf

Author:

	Hazey - Modified by BBrown & Wyste

Last modified:

	4/11/2015

Description:

	Call for picking up intel.
	Also see fn_intelDrop.sqf

TODO:

	Add comment lines so people can get a better understand of how and why it works.

______________________________________________________*/

private ["_intelItems", "_x", "_cases"];

_intelItems = AIO_INTELDROPPED;
_cases = nearestObjects[getPos player, _intelItems, 4.5];

{
	deleteVehicle _x;
} forEach _cases;

player groupChat "You've recovered some intelligence.";