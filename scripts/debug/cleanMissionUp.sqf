_marker = [_this, 0, ""] call bis_fnc_param;
_trigger = [_this, 1, ""] call bis_fnc_param;
_task = [_this, 2, ""] call bis_fnc_param;

hint "Executing mission cleanup...";
sleep 5;

deleteMarker _marker;
deleteVehicle _trigger;
[_task] call bis_fnc_deleteTask;

sleep 1;
hint "Mission cleanup complete...";