private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
_mapCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");

_i = 0;
_cities = [];

_locations = configFile >> "CfgWorlds" >> worldName >> "Names";
_cityTypes = ["NameVillage", "NameCity", "NameCityCapital"];

for "_x" from 0 to (count _locations - 1) do {
	_randomLoc = _locations select _x;

	private ["_cityName", "_cityPos","_cityRadA", "_cityRadB", "_cityType", "_cityAngle"];
	_cityName = getText(_randomLoc >> "name");
	_cityPos = getArray(_randomLoc >> "position");
	_cityRadA = getNumber(_randomLoc >> "radiusA");
	_cityRadB = getNumber(_randomLoc >> "radiusB");
	_cityType = getText(_randomLoc >> "type");
	_cityAngle = getNumber(_randomLoc >> "angle");
	if(_cityType in _cityTypes) then {
		_cities set [_i,[_cityName, _cityPos, _cityRadA, _cityRadB, _cityType, _cityAngle]];
		_i = _i + 1;
	};
};

_randTown = _cities call bis_fnc_selectRandom;
_rtName = _randTown select 0;
_rtPos = _randTown select 1;
_rtRadA = _randTown select 2;
_rtRadB = _randTown select 3;

_rtNewRadA = _rtRadA / 2;
_rtNewRadB = _rtRadB / 2;

_rtPosX = _rtPos select 0;
_rtPosY = _rtPos select 1;

_newRtPosX = _rtPosX + _rtNewRadA;
_newRtPosY = _rtPosY - _rtNewRadB;
_newRtPos = [_newRtPosX, _newRtPosY];