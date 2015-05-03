//Function takes the "this" command passed to other functions and dumps it out to alive_dumpR to log so we can investigate what the hell is going on with the parameters.

//usage:
//    ["fn_scriptname",_this] call DEBUG_fnc_dumpParams;
private ["_script","_array"];
_script = _this select 0;
_array = _this select 1;

if (typeName _array == "ARRAY") then {
    {
        if (typeName _x == "ARRAY") then {
            [_x] call DEBUG_fnc_dumpParams;
        } else {
            [format ["DumpParams|%1|INDEX %2 | TYPE: %3 | VALUE: %4",_script, _forEachIndex, typeName _x, _x]] call ALiVE_fnc_Dump;
        };
    } forEach _array;
    [format ["DumpParams|%1|DONE",_script]] call ALiVE_fnc_Dump;
} else {
    [format ["DumpParams|%1|NON-ARRAY: %2 = %3",_script, typeName _array, _array]] call ALiVE_fnc_Dump;
};