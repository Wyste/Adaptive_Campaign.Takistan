/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

    Wyste | 4/20/2015 | Crude intro to mission
___________________________________________________________________________*/
if(isDedicated) exitWith{};

if (hasInterface) then {
 	["Adaptive Intel | AlivE - Running Client Intro..."] call ALiVE_fnc_Dump;
 	[] spawn {
		waitUntil {!isNull player};
	    titleText ["Wyste and BBrown from AEF present..", "BLACK IN",9999];
		sleep 5;
		titleText ["A D A P T I V E  I N T E L   |   A L i V E", "BLACK IN",10];
        sleep 15;
        [format ["Welcome %1, Please check your map for current tasking, and use accumulated intellegence to accomplish main objectives to win!",name player]] call AIO_fnc_aliveSideMsg;
    };
    waituntil {!isnull player};
};