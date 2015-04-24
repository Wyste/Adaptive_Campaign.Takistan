/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/20/2015 |

  Add multiplayer action to an item, there are CBA functions that add one to
	a player - but this time we need it to go onto the whiteboard inside base.
_____________________________________________________________________________*/

if (AIO_DEBUG) then {["SCRIPT STARTED| fn_addactionmp..sqf"] call ALiVE_fnc_Dump;};

private["_object","_screenMsg","_script","_screenColor","_msg"];

_object 	   = _this select 0;
_screenMsg 	 = _this select 1;
_script 	   = _this select 2;
_screenColor = _this select 3;

[format ["fn_addactionmp: YOU PASSED A %1 with Value: %2",typeName _object, _object]] call ALiVE_fnc_Dump;
[format ["fn_addactionmp: YOU PASSED A %1 with Value: %2",typeName _screenMsg, _screenMsg]] call ALiVE_fnc_Dump;
[format ["fn_addactionmp: YOU PASSED A %1 with Value: %2",typeName _script, _script]] call ALiVE_fnc_Dump;
[format ["fn_addactionmp: YOU PASSED A %1 with Value: %2",typeName _screenColor, _screenColor]] call ALiVE_fnc_Dump;


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