private ["_centerPoint", "_radiusA", "_dir", "_minDistance", "_orgX", "_orgY", "_posX", "_posY", "_randPos", "_loc"];

_centerPoint = _this select 0;
_radiusA = _this select 1;
_radiusA = _radiusA / random 3;
_minDistance = _this select 2;
_dir = random 360;

fn_RandomPosInRadius = {
	_orgX = _centerPoint select 0;
	_orgY = _centerPoint select 1;
	_posX = _orgX + (_radiusA * sin _dir);
	_posY = _orgY + (_radiusA * cos _dir);

	_randPos = [_posX, _posY, 0];
};

_loc = nearestBuilding _randPos;
while {_loc != nil} do {
    _nul = call fn_RandomPosInRadius;
};
hint "found suitable location";
_m = createMarker ["m", _randPos];
_m setMarkerType "hd_dot";
_m setMarkerColor "ColorGreen";
_m setMarkerSize [1,1];

sleep 20;
deleteMarker _m;