/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste/BBrown | 4/20/2015 | Main Definitions - These will be used the entire life of the mission.
______________________________________________________________________________*/
//--- Debug
  AIO_DEBUG = true;

//--- GLOBAL STATIC ITEMS
  AIO_SIGN = nearestObjects [getmarkerpos "base", ["Land_MapBoard_F"], 150];
  publicVariable "AIO_SIGN";

//--- Advanced Roles Defined.
  AIO_ENGINEERS = ["B_engineer_F","B_soldier_repair_F","B_soldier_exp_F","B_G_engineer_F"];
  AIO_MEDICS = ["B_medic_F","B_recon_medic_F"];
  AIO_UAV = ["B_soldier_UAV_F"];
  AIO_SNIPER = ["B_recon_M_F","B_spotter_F","B_sniper_F","B_soldier_M_F","B_G_Soldier_M_F"];
  AIO_AUTORIFLE = ["B_soldier_AR_F","B_support_MG_F","B_G_Soldier_AR_F"];

//--- Public Mission Define.
  AIO_INTEL_POINTS = 0;
  AIO_INTEL_ACTIVE = 0;
  AIO_INTEL_TRACKER = [];
  publicVariable "AIO_INTEL_POINTS";
  publicVariable "AIO_INTEL_ACTIVE";
  publicVariable "AIO_INTEL_TRACKER";

//--- Define intel types
  AIO_INTELDROPPED = ["Land_HandyCam_F","Land_SatellitePhone_F","Land_Suitcase_F","Land_Ground_sheet_folded_OPFOR_F"];
  AIO_INTELSPAWNED = ["Box_East_Support_F","Land_Laptop_unfolded_F","Land_Sleeping_bag_folded_F","Land_Sleeping_bag_blue_F"];

//--- Define locations
  AIO_MAPCENTER = getMarkerPos "AIO_MAPCENTER";
  AIO_LgCITY    = "NameCityCapital";
  AIO_CITY      = "NameCity";
  AIO_SmCITY    = "FlatAreaCitySmall";
  AIO_HILL      = "Hill";
  AIO_LOCAL     = "NameLocal"; //Includes Airfields and weird bases?
  AIO_VILLAGE   = "NameVillage";
  AIO_WATER     = "NameMarine";

//--STOPPED WITH BRANDON
  AIO_TASKS = [0,1,2,3,4,5];
  publicVariable "AIO_TASKS";

    if (AIO_DEBUG) then {
    ["Adaptive Intel | AlivE - Creating Tasks..."] call ALiVE_fnc_Dump;
    };

  //Format:[id,tier,bAvailable,sActionName,sMapName,sMapDesc,areas,script,args]

  AIO_TASKS = [
    [0,1,true,"Gather Intel","Gather Intellegence : ","Gather intellegence to make available more advanced missions.",
    ["AIO_VILLAGE","AIO_CITY"],{call AIO_fnc_spawnintel},0,"green"],
    [1,2,false,"Destroy Cache","Destroy Weapons Cache : ","Insurgents have been hoarding weapons, we need your squad to destroy them immediately upon discovery.",["AIO_LgCITY","AIO_SmCITY","AIO_CITY"],{call AIO_fnc_spawncache},0,"yellow"]];

  publicVariable "AIO_TASKS";

  if (AIO_DEBUG) then {
  ["Adaptive Intel | AlivE - commond_defines.sqf finished"] call ALiVE_fnc_Dump;
};