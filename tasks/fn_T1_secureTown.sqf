/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
BBrown         | 05/07/2015    | T1 Task to secure a random town/city
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE :

if (AIO_DEBUG) then {
	["SCRIPT STARTING| fn_T1_secureTown.sqf"] call ALiVE_fnc_Dump;
	//[format ["Parameters| fn_T1_secureTown.sqf| : %1",_this select 0]] call ALiVE_fnc_Dump;
};

private ["_b","_loc"];
// _b is going to be the number of groups we spawn to be within this particular town
// _b will be # of players on WEST * 3 , with a max of 16! 16 groups x5 men each (usually) would be 80 men total within a town, taht's pretty heavily saturated

_loc = [[AIO_LgCITY]] call AIO_fnc_findLocation;
_cityPOS = _loc select 1;
_cityRadA = _loc select 2;
_cityRadB = _loc select 3;

_b = (playersNumber playerSide) * 3 ;
if ( _b > 16 ) then { _b = 16 };

for "_i" from 1 to (_b/2) do {
	_grp = createGroup resistance;
	_grp = [ _cityPOS,_grp, ()]
};

for "_i" from 1 to (_b/2) do {

};

if (AIO_DEBUG) then { ["SCRIPT FINISHED| fn_T1_secureTown.sqf"] call ALiVE_fnc_Dump; };