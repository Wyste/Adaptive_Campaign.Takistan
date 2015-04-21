/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  BBrown | 4/20/2015 | TASK - finds all locations of the allowed location types
_____________________________________________________________________________*/
/*
---Usage: randCity = [[AIO_LgCITY,AIO_VILLAGE]] call AIO_fnc_findLocation;
---Returns: Array
*/

private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
_cityTypes = _this select 0;
_i = 0;
_cities = [];
_locations = configFile >> "CfgWorlds" >> worldName >> "Names";

for "_x" from 0 to (count _locations - 1) do {

	private ["_cityName", "_cityPos","_cityRadA", "_cityRadB", "_cityType"];

  _randomLoc = _locations select _x;
	_cityName  = getText  (_randomLoc >> "name");
	_cityPos   = getArray (_randomLoc >> "position");
	_cityRadA  = getNumber(_randomLoc >> "radiusA");
	_cityRadB  = getNumber(_randomLoc >> "radiusB");
	_cityType  = getText  (_randomLoc >> "type");

	if(_cityType in _cityTypes) then {
		_cities set [_i,[_cityName, _cityPos, _cityRadA, _cityRadB, _cityType]];
		_i = _i + 1;
	};
};

_randTown = _cities call bis_fnc_selectRandom;
_rtName = _randTown select 0;
_rtPos = [];

// This finds all the cities that have actual city centers and sets their coordinates to the city's center coords (One back draw is it's hardcoded to Takistan, make sure to change/remove this block when porting to other maps)
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
_randTown