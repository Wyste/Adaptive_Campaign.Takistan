//debug array!

private["_array"];
_array = _this select 0;
{
[format ["ARRAYDEBUG: ELEMENT %1 | Type: %2 | Value: %3", _forEachIndex, typeName _x, _x ]] call ALiVE_fnc_Dump;

} forEach _array;
[format ["ARRAYDEBUG: DONE"]] call ALiVE_fnc_Dump;