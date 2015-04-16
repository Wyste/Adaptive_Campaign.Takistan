/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                  @filename: fn_addactionmp.sqf

Author:

	Wyste
Last modified:

	4/11/2015
Description:

	Add multiplayer action to an item, there are CBA functions that add one to
	a player - but this time we need it to go onto the whiteboard inside base.
Usage:

	[[_item,"<t color='#FF0000'>Message</t>"],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;
_____________________________________________________________________________*/


if (AIO_DEBUG) then {["Adaptive Intel | AlivE - addactionmp..sqf running..."] call ALiVE_fnc_Dump;};
private["_object","_screenMsg","_script","_args","_pri","_screenColor","_msg"];

_object 	   = _this select 0;
_screenMsg 	 = _this select 1;
_script 	   = _this select 2;
_args		     = _this select 3;
_pri		     = _this select 4;
_screenColor = _this select 5;

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


/*
if (AIO_DEBUG) then {hint format ["%1 | %2 | %3 | %4 | %5 ",typename _object,typename  _screenMsg,typename _args,typename _pri,typename _screenColor];};
*/

if(isNull _object) exitWith {};

//--- Add action to object and calls the script specified.
_object addAction [_msg,_script, _args, _pri, True, True, "", "(_target distance _this) < 6"];

//unit addAction [title, script, arguments, priority, showWindow, hideOnUse, shortcut, condition, positionInModel, radius, radiusView, showIn3D, available, textDefault, textToolTip]