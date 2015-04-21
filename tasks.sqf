/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/20/2015 | Main Definitions - These will be used the entire life of the mission.
______________________________________________________________________________*/

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Starting task.sqf..."] call ALiVE_fnc_Dump;};

AIO_T1TASKS = [
  ["Gather Intel",{call TASK_fnc_spawnintel}]
];

AIO_T2TASKS = [
  ["Destroy Cache",{call TASK_fnc_spawncache}],
  ["Capture/Kill HVT",{call TASK_fnc_TASKhvt}]
];

AIO_T3TASKS = [
  [],
];

publicVariable "AIO_T1TASKS";
publicVariable "AIO_T2TASKS";
publicVariable "AIO_T3TASKS";

if (AIO_DEBUG) then {["Adaptive Intel | AlivE - Ending task.sqf..."] call ALiVE_fnc_Dump;};