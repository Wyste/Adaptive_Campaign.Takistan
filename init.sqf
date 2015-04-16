/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                             @filename: init.sqf

Author:

	Wyste / BBrown

Special Thanks:

	Nobody-Yet

Last modified:

	4/11/2015

Description:

	Main Init - Starts and runs things.
______________________________________________________________________________*/

//--- Start Init
["Adaptive Intel | AlivE - Executing init.sqf..."] call ALiVE_fnc_Dump;
// =============================================================================
    //--- DEFINES/ INCLUDES
    call compile preprocessFile "common_defines.sqf";
    if (AIO_DEBUG) then {["Adaptive Intel | AlivE - commond_defines.sqf finished"] call ALiVE_fnc_Dump;};
// =============================================================================

//--- Disable Saving
enableSaving [false, false];

//--- Game Briefing
[] call compileFinal preprocessfilelinenumbers "scripts\briefings\briefing.sqf";

//--- Task/Mission Definitions
//[] call compileFinal preprocessfilelinenumbers "tasks.sqf";

//--- Add things to teh sign.
if (isServer || isDedicated) then {
  [missionNamespace getVariable "AIO_TASKS"] execVM "sign.sqf";
};

//--- End Init
if (AIO_DEBUG) then {["Adaptive Intel | AlivE - END OF INIT..."] call ALiVE_fnc_Dump;};

//if (!AIO_DEBUG) then {
    //Push player into intro sequence
    //[] call compileFinal preprocessfilelinenumbers "scripts\intro.sqf";
//};
// =============================================================================
// =============================================================================