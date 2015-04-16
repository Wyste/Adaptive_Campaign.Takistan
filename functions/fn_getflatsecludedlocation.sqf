private ["_centerPoint", "_radiusA", "_dir", "_minDistance", "_orgX", "_orgY", "_posX", "_posY", "_randPos", "_loc"];

_centerPoint = _this select 0;
_radiusA = _this select 1;
_radiusA = _radiusA / random 3;
_radius = _this select 1;
_minDistance = _this select 2;
_dir = random 360;

fn_RandomPosInRadius = {
	_dir = random 360;
	_orgX = _centerPoint select 0;
	_orgY = _centerPoint select 1;
	_posX = _orgX + (_radiusA * sin _dir);
	_posY = _orgY + (_radiusA * cos _dir);
	_posX = _orgX + (_radius * sin _dir);
	_posY = _orgY + (_radius * cos _dir);

	_randPos = [_posX, _posY, 0];
	_randPos;
};
_p = call fn_RandomPosInRadius;
_loc = _p nearObjects _minDistance;

hint format ["_centerPoint: %1\n_radiusA: %2\n_minDistance: %3", _centerPoint, _radiusA, _minDistance];

/*
_loc = nearestBuilding _randPos;
while {(count _loc) >= 1} do {
    call fn_RandomPosInRadius;
    _p = call fn_RandomPosInRadius;
	_loc = _p nearObjects _minDistance;
	sleep 1;
};
hint "found suitable location";
_m = createMarker ["m", _randPos];
_m setMarkerType "hd_dot";
_m setMarkerColor "ColorGreen";
_m setMarkerSize [1,1];

sleep 20;
deleteMarker _m;
*/
\ No newline at end of file
if (AIO_DEBUG) then {[format [" DEBUG | fn_getflatsecludedlocation | Found suitable location: %1", _p]] call ALiVE_fnc_Dump;}