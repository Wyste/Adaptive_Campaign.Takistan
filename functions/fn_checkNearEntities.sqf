/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste          | 05/09/2015    | Checks near entities against minimum and returns boolean
______________________________________________________________________________________________________________________*/
// RETURN: BOOLEAN
// USAGE : [_pos, _rad, _minimum, _types, _sides, playerFlag] call AIO_fnc_checkNearEntities

_position	= (_this select 0) call PO3_fnc_getPos;
_radius		= if(count _this > 1) then { _this select 1 }else{ 100 };
_minCount	= if(count _this > 2) then { _this select 2 }else{ 0 };
_types		= if(count _this > 3) then { _this select 3 }else{ ["CAManBase","LandVehicle"] };
_sides		= if(count _this > 4) then { _this select 4 }else{ [RESISTANCE,OPFOR] };
_playerFlag	= if(count _this > 5) then { _this select 5 }else{ true };

_validEntities	= [];
_nearEntities	= _position nearEntities [_types,_radius];

{
	if( ( _playerFlag && isPlayer _x || !_playerFlag && !(isPlayer _x) ) //if NOT a player!
		&& (side _x) IN _sides && (alive _x) // COUNT ENTITIES THAT IS ALIVE OF SPECIFIED SIDE
	) then { _validEntities set [ count _validEntities, _x] };
} forEach _nearEntities;

_return = if( count _validEntities >= _minCount ) then { true }else{ false };

_return;