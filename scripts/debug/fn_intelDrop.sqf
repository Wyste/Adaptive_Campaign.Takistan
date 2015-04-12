/*
@filename: intelDrop.sqf

Author:

	Hazey - Modified by BBrown & Wyste

Last modified:

	4/11/2015

Description:

	Call to drop the intel and addAction to it.
	Also see fn_addActionMP.sqf
________________________________________________*/

if(isServer || isDedicated) then {
	private ["_unit", "_intelItems", "_selectedItem", "_droppedItem"];

	_unit = _this select 0;
	_intelItems = AIO_INTELDROPPED;
	AIO_droppedItems = [];

	if(aio_debug) then {
		if(random 100 >= 1) then {
			_selectedItem = _intelItems call bis_fnc_selectRandom;
			_droppedItem = createVehicle [_selectedItem, _unit, [], 0, "None"];
			[[_droppedItem, "<t color='#FF0000'>Gather Intel</t>"], "AIO_fnc_addactionMP", true, true] spawn bis_fnc_MP;
			_droppedItem setPosATL getPosATL (_this select 0);

			AIO_droppedItems set [count AIO_droppedItems, _droppedItem];
			publicVariable "AIO_droppedItems";
		};
	} else {
		if(random 100 >= (paramsArray select 0)) then {
			_selectedItem = _intelItems call bis_fnc_selectRandom;
			_droppedItem = createVehicle [_selectedItem, _unit, [], 0, "None"];
			[[_droppedItem, "<t color='#FF0000'>Gather Intel</t>"], "AIO_fnc_addactionMP", true, true] spawn bis_fnc_MP;
			_droppedItem setPosATL getPosATL (_this select 0);

			AIO_droppedItems set [count AIO_droppedItems, _droppedItem];
			publicVariable "AIO_droppedItems";
		};
	};
};