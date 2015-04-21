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
		class areas {};
		class toggletaskavail {};
		class gettaskdetail {};
		class findLocation {};
		class findbuildings {};
		class getenterablehouses {};
		class getflatsecludedlocation {};
		class addactionmp {};
		class spawnintel {};
		class spawncache {};
		class getcountbldgpos {};
		class randbldgpos {};
		class intelpickup {};
		class delallspawnedintelgroup {};
		class addtosign {};
		class createtask {};
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