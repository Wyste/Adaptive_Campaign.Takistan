/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Available task definitions and mappings.
______________________________________________________________________________*/

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Starting task.sqf..."] call ALiVE_fnc_Dump;};

AIO_T1TASKS = [
  ["Destroy Cache","call TASK_fnc_T1_spawncache","green",0], //--- Green Text
  ["Kill HVT","call TASK_fnc_T1_hvt","green",1],
  ["Rescue Mission","call TASK_fnc_T1_rescuehelo","green",2],
  // Base Defense]
  // Use C2ISTAR / Demolition To destroy a Recruitment HQ (requires finding one via ALIVE...)
  ["Hostage: Tank","call TASK_fnc_T1_friendlytank","blue",3]
];

AIO_T2TASKS = [
  ["Raze Airfield",{call TASK_fnc_T2_airfield},"red"]
];

publicVariable "AIO_T1TASKS"; // Regular missions inspired by intellegence
publicVariable "AIO_T2TASKS"; // Special mission - 10% chance to be used once every mission...

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Ending task.sqf..."] call ALiVE_fnc_Dump;};