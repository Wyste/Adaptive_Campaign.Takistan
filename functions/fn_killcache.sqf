/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	BBrown | 4/23/2015 | Handles destroying of weapons cache
_____________________________________________________________________________*/

private ["_pos", "_x"];

_pos = getPos cache;
_x = 0;

//--- delete cache
deleteVehicle cache;

//--- set task as completed
["cache", "SUCCEEDED"] call bis_fnc_taskSetState;

//--- Create explosion effect
while {_x <= 22} do {
	"M_Mo_82mm_AT_LG" createVehicle _pos;
	_x = _x + 1 + random 3;
	sleep (0.2 + (random 3));
};