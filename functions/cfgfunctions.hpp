/*
         ___     __          __  _            ____     __      __
        / _ |___/ /__ ____  / /_(_)  _____   /  _/__  / /____ / /
       / __ / _  / _ `/ _ \/ __/ / |/ / -_) _/ // _ \/ __/ -_) /
      /_/_|_\_,_/\_,_/ .__/\__/_/|___/\__/ /___/_//_/\__/\__/_/
        / _ | ______/_/ / _ | |_  /
       / __ |/ __/  ' \/ __ |_/_ <
      /_/ |_/_/ /_/_/_/_/ |_/____/
                                                    @filename: cfgfunctions.hpp

Author:

	Wyste / BBrown

Last modified:

	4/19/2015

Description:

	Creates and appends AIO_FNC to each function listed.

______________________________________________________*/

class AIO
{
	tag = "AIO";
	class functions
	{
		file = "functions";
		class aliveSideMsg {};
		class gettaskdetail {};
		class findLocation {};
		class findbuildings {};
		class getenterablehouses {};
		class getsecludedlocation {};
		class addactionmp {};
		class spawncache {};
		class getcountbldgpos {};
		class randbldgpos {};
		class intelpickup {};
		class delallspawnedintelgroup {};
		class addrandtasktosign {};
		class createtask {};
		class killcache {};
	};
};

class DEBUG
{
	tag = "DEBUG";
	class debug
	{
		file = "debug";
		class debugarray {};
	};
};

class TASK
{
	tag = "TASK";
	class TASK
	{
		file = "tasks";
		class spawnintel {};
		class T1_spawncache {};
		class T1_hvt {};
	};
};