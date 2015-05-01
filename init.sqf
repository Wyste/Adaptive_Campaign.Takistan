/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste/BBrown | 4/20/2015 | Main Init - Starts and runs things.
___________________________________________________________________________*/

//--- Start Init
["Adaptive Intel | AlivE - Executing init.sqf..."] call ALiVE_fnc_Dump;

//--- DEFINES/ INCLUDES
call compile preprocessFile "common_defines.sqf";
call compile preprocessFile "tasks.sqf";


//--- Disable Saving
enableSaving [false, false];

//--- Game Briefing
//[] call compileFinal preprocessfilelinenumbers "scripts\briefings\briefing.sqf";

//--- Intro
//[] call compileFinal preprocessfilelinenumbers "intro.sqf";

//--- Add things to the sign at base, starts off the mission.
if (isServer || isDedicated) then {
  //Run this once to start the intel spawns for the mission.
  [] call compileFinal preprocessfilelinenumbers "tasks\fn_spawnintel.sqf";
};

//--- End Init
["Adaptive Intel | AlivE - END OF INIT..."] call ALiVE_fnc_Dump;