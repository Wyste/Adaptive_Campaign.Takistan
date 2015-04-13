/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                  @filename: common_defines.sqf

Author:

	Wyste / BBrown

Special Thanks:

	Nobody-Yet

Last modified:

	4/11/2015

Description:

	Main Definitions - These will be used the entire life of the mission.
______________________________________________________________________________*/
//--- Debug
  AIO_DEBUG = true;


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
  publicVariable "AIO_INTEL_POINTS";

  /*if (isServer || isDedicated) then {
    AIO_SQUADOBJ1 = objNull;
    AIO_SQUADOBJ2 = objNull;
    AIO_SQUADOBJ3 = objNull;
    AIO_SQUADOBJ4 = objNull;
    AIO_SQUADOBJ5 = objNull;
  };*/

//--- Define intel types
  AIO_INTELDROPPED = ["Land_HandyCam_F","Land_SatellitePhone_F","Land_Suitcase_F","Land_Ground_sheet_folded_OPFOR_F"];
  AIO_INTELSPAWNED = ["Box_East_Support_F","Land_Laptop_unfolded_F","Land_Sleeping_bag_folded_F","Land_Sleeping_bag_blue_F"];
  //AIO_CTPLOCATIONS = ["Land_Church_01_V1_F"];

//--- Define locations
  //AIO_MAPCENTER = getArray(configfile >> "CfgWorlds" >> "Takistan" >> "centerPosition");
  AIO_MAPCENTER = getMarkerPos "AIO_MAPCENTER";
  //AIO_CITIES = allMissionObjects "LocationCityCapital_F";
  //AIO_BASES = allMissionObjects "LocationBase_F";
  //AIO_AREAS = allMissionObjects "LocationArea_F";
  if (!AIO_DEBUG) then {["Adaptive Intel | AlivE - Mapping Cities to Arrays..."] call ALiVE_fnc_Dump;};
  AIO_LgCITY    = ["NameCityCapital"] call AIO_fnc_areas;
  AIO_SmCITY    = ["FlatAreaCitySmall"] call AIO_fnc_areas;
  AIO_HILL      = ["Hill"] call AIO_fnc_areas;
  AIO_LOCAL     = ["NameLocal"] call AIO_fnc_areas; //Airfields included
  AIO_VILLIAGE  = ["NameVilliage"] call AIO_fnc_areas;
  AIO_WATER     = ["NameMarine"] call AIO_fnc_areas;

  AIO_TASKS = [0,1,2,3,4,5];
  publicVariable "AIO_TASKS";

    if (!AIO_DEBUG) then {
      ["Adaptive Intel | AlivE - Creating Tasks..."] call ALiVE_fnc_Dump;
    };

  //Format: [id,tier,bAvailable,sActionName,sMapName,sMapDesc,areas,script,args]

  AIO_TASKS = [
    [0,1,true,"Gather Intel","Gather Intellegence : ","Gather intellegence to make available more advanced missions.",
    ["AIO_VILLIAGE","AIO_SmCITY"],"call AIO_fn_spawnintel",0,"green"],
    [1,2,true,"Destroy Cache","Destroy Weapons Cache : ","Insurgents have been hoarding weapons, we need your squad to destroy them immediately upon discovery.",["AIO_LgCITY","AIO_SmCITY"],"call AIO_fn_spawncache",0,"yellow"]];

  publicVariable "AIO_TASKS";