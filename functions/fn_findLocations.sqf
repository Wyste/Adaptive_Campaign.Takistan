private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
_mapCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");

_i = 0;
_j = 0;
_cities = [];

_locations = configFile >> "CfgWorlds" >> worldName >> "Names";
_cityTypes = ["NameVillage", "NameCity", "NameCityCapital"];
_cityTypeCenters = ["CityCenter"];

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
_rtPos = [];

switch (_rtName) do {
    case "Anar": {
    	_rtPos = [5984.78,5780.72];
    };
    case "Bastam": {
    	_rtPos = [5585.73,9090.32];
    };
    case "Chak Chak": {
    	_rtPos = [4387.4,688.3];
    };
    case "Falar": {
    	_rtPos = [5955.14,7264.14];
    };
    case "Feruz Abad": {
    	_rtPos = [5272.76,6149.96];
    };
    case "Garmarud": {
    	_rtPos = [9149.04,6668.42];
    };
    case "Garmsar": {
    	_rtPos = [10587.8,6310.45];
    };
    case "Loy Manara": {
    	_rtPos = [8480.1,2351.41];
    };
    case "Nagara": {
    	_rtPos = [3059.58,9909.48];
    };
    case "Nur": {
    	_rtPos = [1804.21,11845.4];
    };
    case "Rasman": {
    	_rtPos = [6292.48,11179.4];
    };
    case "Sakhe": {
    	_rtPos = [3496.14,4092.66];
    };
    case "Zavarak": {
    	_rtPos = [9839.21,11482.5];
    };
    default {
     	_rtPos = _randTown select 1;
    };
};

_m = createMarker [_rtName, _rtPos];
_m setMarkerType "hd_dot";
_m setMarkerColor "ColorBlue";
_m setMarkerSize [1,1];
sleep 10;
deleteMarker _m;

/*
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

_m = createMarker [_rtName, _newRtPos];
_m setMarkerType "hd_dot";
_m setMarkerColor "ColorBlue";
_m setMarkerSize [1,1];
sleep 10;

deleteMarker _m;
*/