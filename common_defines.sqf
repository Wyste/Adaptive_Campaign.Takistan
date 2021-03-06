/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Main Definitions - These will be used the entire life of the mission.
______________________________________________________________________________*/
//--- Debug
  AIO_DEBUG = true;
  if (AIO_DEBUG) then {["SCRIPT STARTING| commond_defines.sqf"] call ALiVE_fnc_Dump;};

//--- GLOBAL STATIC ITEMS
  AIO_SIGN = nearestObjects [getmarkerpos "base", ["Land_MapBoard_F"], 150];
  AIO_CAPPAD = nearestObjects [getmarkerpos "base", ["Land_HelipadRescue_F"],150];
  AIO_SIGN    = AIO_SIGN select 0;    publicVariable "AIO_SIGN";
  AIO_CAPPAD  = AIO_CAPPAD select 0;  publicVariable "AIO_CAPPAD";

//--- Advanced Roles Defined.
  AIO_ENGINEERS = ["B_engineer_F","B_soldier_repair_F","B_soldier_exp_F","B_G_engineer_F"];
  AIO_MEDICS = ["B_medic_F","B_recon_medic_F"];
  AIO_UAV = ["B_soldier_UAV_F"];
  AIO_SNIPER = ["B_recon_M_F","B_spotter_F","B_sniper_F","B_soldier_M_F","B_G_Soldier_M_F"];
  AIO_AUTORIFLE = ["B_soldier_AR_F","B_support_MG_F","B_G_Soldier_AR_F"];

//--- Public Mission Define.

  AIO_TASKS_ACTIVE = 0;     publicVariable "AIO_TASKS_ACTIVE";
  AIO_TASKS_COMPLETED = 0;  publicVariable "AIO_TASKS_COMPLETED";
  AIO_TASKS_TAORS = [];     publicVariable "AIO_TASKS_TAORS";
  AIO_TASKS_SPAWNED = [];   publicVariable "AIO_TASKS_SPAWNED";

  AIO_INTEL_POINTS = 0;     publicVariable "AIO_INTEL_POINTS";
  AIO_INTEL_ACTIVE = 1;     publicVariable "AIO_INTEL_ACTIVE";
  AIO_INTEL_COMPLETED = 1;  publicVariable "AIO_INTEL_COMPLETED";
  AIO_INTEL_TAORS = [];     publicVariable "AIO_INTEL_TAORS";
  AIO_INTEL_SPAWNED = [];   publicVariable "AIO_INTEL_SPAWNED";

  AIO_LAST_TASK_SPAWNED = 999; publicVariable "AIO_LAST_TASK_SPAWNED";

  AIO_CAPTURABLE = [];      publicVariable "AIO_CAPTURABLE";

  AIO_ENEMY_FACTIONS = ["LOP_AM","LOP_IT"]; publicVariable "AIO_ENEMY_FACTIONS"; // these better have opcoms modules defiend within the editor

//--- Define intel types
  AIO_INTELDROPABLE = ["Land_HandyCam_F","Land_SatellitePhone_F","Land_Suitcase_F","Land_Ground_sheet_folded_OPFOR_F"];
  AIO_INTELSPAWNABLE = ["Box_East_Support_F","Land_Laptop_unfolded_F","Land_Sleeping_bag_folded_F","Land_Sleeping_bag_blue_F"];

//--- Define locations
  AIO_MAPCENTER = getMarkerPos "AIO_MAPCENTER";
  AIO_LgCITY    = "NameCityCapital";
  AIO_CITY      = "NameCity";
  AIO_SmCITY    = "FlatAreaCitySmall";
  AIO_HILL      = "Hill";
  AIO_LOCAL     = "NameLocal"; //Includes Airfields and weird bases?
  AIO_VILLAGE   = "NameVillage";
  AIO_WATER     = "NameMarine";

  if (AIO_DEBUG) then {["SCRIPT FINISHED| common_defines.sqf"] call ALiVE_fnc_Dump;};