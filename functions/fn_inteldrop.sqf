/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 5/2/2015 |
________________________________________________________________*/
if (isServer || isDedicated) then {
	private["_unit","_intelItems","_selectedItem","_droppedItem"];

	_unit = _this select 0;
	_intelItems = AIO_INTELDROPABLE;

	if (AIO_DEBUG) then {
		if (random 100 >= 1) then {
			_selectedItem = _intelItems call BIS_fnc_selectRandom;
			_droppedItem = createVehicle [_selectedItem, _unit, [], 0, "None"];
			[[_droppedItem,"Capture Intel","call AIO_fnc_intelpickup","red"],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
			_droppedItem setPosATL getPosATL (_this select 0);
			["Intel Item Dropped"] call ALIVE_fnc_dump;
			_droppedItem setVariable ["id",0,true];
			_droppedItem setVariable ["pts",5,true];
		};
	} else {
		if (random 100 >= (paramsArray select 4)) then {
			_selectedItem = _intelItems call BIS_fnc_selectRandom;
			_droppedItem = createVehicle [_selectedItem, _unit, [], 0, "None"];
			[[_droppedItem,"Capture Intel","call AIO_fnc_intelpickup","red"],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
			_droppedItem setPosATL getPosATL (_this select 0);
			_droppedItem setVariable ["id",0,true];
			_droppedItem setVariable ["pts",5,true];
		};
	};
};