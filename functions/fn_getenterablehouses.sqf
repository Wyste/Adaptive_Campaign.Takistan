private ["_cityPos", "_cityRadA", "_buildings"];

_cityPos = _this select 0;
_cityRadA = _this select 1;

_allbuildings = [_cityPos, _cityRadA] call AIO_fnc_findbuildings;
_enterablebuildings = [];

[format [" DEBUG | AIO_fnc_getenterablehouses | Total Buildings Found: %1", count _allbuildings]] call ALiVE_fnc_Dump;

if(count _allbuildings >= 1) then {
	for "_x" from 0 to (count _allbuildings) do {
		_b = _allbuildings select _x;
		_pos = _b buildingPos 1;

		if(str(_pos) == "[0,0,0]") then {
			_enterablebuildings = _enterablebuildings + [_b];
		};
	};
};
if (AIO_DEBUG) then {[format [" DEBUG | AIO_fnc_getenterablehouses | Total number of enterable buildings: %1", count _enterablebuildings]] call ALiVE_fnc_Dump;};
_enterablebuildings