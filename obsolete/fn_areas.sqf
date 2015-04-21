/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/20/2015 | Finds of area and adds a bunch of info into the array.
_____________________________________________________________________________*/
if (AIO_DEBUG) then {["Adaptive Intel | AlivE - STARTING AIO_fnc_area..."] call ALiVE_fnc_Dump;};
private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
_i = 0;
_cities = [];

_locations = configfile >> "CfgWorlds" >> worldName >> "Names";

_cityTypes = [_this select 0];

for "_x" from 0 to (count _locations - 1) do {
	_randomLoc = _locations select _x;

	private["_cityName","_cityPos","_cityRadA","_cityRadB","_cityType"];
	_cityName = getText(_randomLoc >> "name");
	_cityPos = getArray(_randomLoc >> "position");
	_cityRadA = getNumber(_randomLoc >> "radiusA");
	_cityRadB = getNumber(_randomLoc >> "radiusB");
	_cityType = getText(_randomLoc >> "type");
	//_cityAngle = getNumber(_randomLoc >> "angle");
	if (_cityType in _cityTypes) then {
		//[format ["Added Location: %1 to %2... and setting element %3 to %4 area",_x,_cityType,_i,_cityName]] call ALIVE_fnc_Dump;
		_cities set [_i,[_cityName, _cityPos, _cityRadA, _cityRadB, _cityType ]];
		_i = _i + 1;
	};
};
_cities;