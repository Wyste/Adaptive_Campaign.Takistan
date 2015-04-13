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
//hint format["%1\n%2\n%3\n%4\n%5\n%6", _randTown select 0, _randTown select 1, _randTown select 2, _randTown select 3, _randTown select 4, _randTown select 5];
_rtPos = [];

switch (_rtName) do {
    case "Anar": {
    	_randTown set [1, [5984.78,5780.72]];
    };
    case "Bastam": {
    	_randTown set [1, [5585.73,9090.32]];
    };
    case "Chak Chak": {
    	_randTown set [1, [4387.4,688.3]];
    };
    case "Falar": {
    	_randTown set [1, [5955.14,7264.14]];
    };
    case "Feruz Abad": {
    	_randTown set [1, [5272.76,6149.96]];
    };
    case "Garmarud": {
    	_randTown set [1, [9149.04,6668.42]];
    };
    case "Garmsar": {
    	_randTown set [1, [10587.8,6310.45]];
    };
    case "Loy Manara": {
    	_randTown set [1, [8480.1,2351.41]];
    };
    case "Nagara": {
    	_randTown set [1, [3059.58,9909.48]];
    };
    case "Nur": {
    	_randTown set [1, [1804.21,11845.4]];
    };
    case "Rasman": {
    	_randTown set [1, [6292.48,11179.4]];
    };
    case "Sakhe": {
    	_randTown set [1, [3496.14,4092.66]];
    };
    case "Zavarak": {
    	_randTown set [1, [9839.21,11482.5]];
    };
    default {
     	_rtPos = _randTown select 1;
        _rtRadA = _randTown select 2;
        _rtRadB = _randTown select 3;

        //Cut the radius values in half
        _rtRadA = _rtRadA / 2;
        _rtRadB = _rtRadB / 2;

        //Retreive the X and Y positions
        _rtPosX = _rtPos select 0;
        _rtPosY = _rtPos select 1;

        //Calculate new X and Y positions
        _rtPosX = _rtPosX - _rtRadA;
        _rtPosY = _rtPosY - _rtRadB;

        //Apply new coordinates
        _randTown set [1, [_rtPosX, _rtPosY]];
    };
};

_randTown;

/*
_m = createMarker [_rtName, _randTown select 1];
_m setMarkerType "hd_dot";
_m setMarkerColor "ColorBlue";
_m setMarkerSize [1,1];
sleep 30;
deleteMarker _m;
*/