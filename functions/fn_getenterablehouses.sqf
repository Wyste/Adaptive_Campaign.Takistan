//hint "Firing AIO_fnc_getenterablehouses";
//sleep 1;
private ["_cityPos", "_cityRadA", "_buildings"];

_cityPos = _this select 0;
_cityRadA = _this select 1;

_allbuildings = [_cityPos, _cityRadA] call AIO_fnc_findbuildings;
_enterablebuildings = [];

hint format["Total Buildings: %1", count _allbuildings];
sleep 1;
if(count _allbuildings >= 1) then {
	for "_x" from 0 to (count _allbuildings) do {
		_b = _allbuildings select _x;
		_pos = _b buildingPos 1;

		if(str(_pos) == "[0,0,0]") then {
			_enterablebuildings = _enterablebuildings + [_b];
		};
	};
};
hint format["Enterable Buildings: %1", count _enterablebuildings];
sleep 1;
_enterablebuildings