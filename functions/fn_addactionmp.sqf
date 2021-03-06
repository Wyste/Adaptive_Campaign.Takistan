/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Add multiplayer scrollwheel action to an item
______________________________________________________________________________________________________________________*/
// RETURN: NOTHING
// USAGE : [_object, _textLabel, _ToBeCalledscript, _textColor] call AIO_fnc_addActionMP

if (AIO_DEBUG) then {
  ["SCRIPT STARTED| fn_addactionmp.sqf"] call ALiVE_fnc_Dump;
  ["fn_addactionmp.sqf",_this] call DEBUG_fnc_dumpParams;
};

private["_object","_screenMsg","_script","_screenColor","_msg"];

_object      = _this select 0;
_screenMsg   = _this select 1;
_script      = _this select 2;
_screenColor = _this select 3;

switch (_screenColor) do {
  case "red": {
    _msg = Format ["<t color='#FF0000'>%1</t>",_screenMsg];
  };
  case "green": {
    _msg = Format ["<t color='#40FF00'>%1</t>",_screenMsg];
  };
  case "blue": {
    _msg = Format ["<t color='#0040FF'>%1</t>",_screenMsg];
  };
  case "yellow": {
    _msg = Format ["<t color='#FFFF00'>%1</t>",_screenMsg];
  };
  case "purple": {
    _msg = Format ["<t color='#8000FF'>%1</t>",_screenMsg];
  };
  default {
    _msg = _screenMsg;
  };
};

if(isNull _object) exitWith {};
//--- Add action to object and calls the script specified.
_object addAction [_msg,_script, 0, 10, True, True, "", "(_target distance _this) < 4.5"];

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_addactionmp..sqf"] call ALiVE_fnc_Dump;};