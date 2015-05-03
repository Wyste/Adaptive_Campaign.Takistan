// debug array!

private ["_array"];
_array = _this select 0;

if (typeName _array == "ARRAY") then {
  {
  [format ["ARRAYDEBUG: ELEMENT %1 | Type: %2 | Value: %3", _forEachIndex, typeName _x, _x]] call ALiVE_fnc_Dump;
  } forEach _array;
  [format ["ARRAYDEBUG: DONE"]] call ALiVE_fnc_Dump;
} else {
  [format ["ARRAYDEBUG: NOT AN ARRAY: YOU PASSED A %1 with Value: %2", typeName _array, _array]] call ALiVE_fnc_Dump;
};