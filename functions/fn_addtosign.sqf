/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/20/2015 | Adds action to intellegence sign at base to handle mission assignment.
  ______________________________________*/
if (AIO_DEBUG) then {["SCRIPT STARTED| fn_addtosign.sqf"] call ALiVE_fnc_Dump;};

[[AIO_SIGN select 0,_this select 0,_this select 1,_this select 2],"AIO_fnc_addactionmp", true, true] spawn BIS_fnc_MP;

if (AIO_DEBUG) then {["SCRIPT FINISHED| fn_addtosign.sqf"] call ALiVE_fnc_Dump;};