_town = call AIO_fnc_findLocations;
_townPos = _town select 1;
_townRadA = _town select 2;

//_enterableBuildings = [_townPos, _townRadA] call AIO_fnc_getenterablehouses;
_nul = [_townPos, 100, 10] call AIO_fnc_getflatsecludedlocation;