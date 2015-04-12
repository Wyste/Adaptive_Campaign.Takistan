_missionType = [_this, 0, ""] call bis_fnc_param;
sleep random 3;

private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
_mapCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");

_i = 0;
_cities = [];

_locations = configFile >> "CfgWorlds" >> worldName >> "Names";
_cityTypes = ["NameVillage", "NameCity", "NameCityCapital"];

for "_x" from 0 to (count _locations - 1) do {
	_randomLoc = _locations select _x;

	private ["_cityName", "_cityPos","_cityRadA", "_cityRadB", "_cityType", "_cityAngle"];
	_cityName = getText(_randomLoc >> "name");
	_cityPos = getArray(_randomLoc >> "position");
	_cityRadA = getNumber(_randomLoc >> "radiusA");
	_cityRadB = getNumber(_randomLoc >> "radiusB");
	_cityType = getText(_randomLoc >> "type");
	_cityAngle = getNumber(_randomLoc >> "angle");
	if(_cityType in _cityTypes) then {
		_cities set [_i,[_cityName, _cityPos, _cityRadA, _cityRadB, _cityType, _cityAngle]];
		_i = _i + 1;
	};
};

_randTown = _cities call bis_fnc_selectRandom;
_rtName = _randTown select 0;
_rtPos = _randTown select 1;
_rtRadA = _randTown select 2;
_rtRadB = _randTown select 3;

_rtNewRadA = _rtRadA / 2;
_rtNewRadB = _rtRadB / 2;

_rtPosX = _rtPos select 0;
_rtPosY = _rtPos select 1;

_newRtPosX = _rtPosX + _rtNewRadA;
_newRtPosY = _rtPosY - _rtNewRadB;
_newRtPos = [_newRtPosX, _newRtPosY];

fn_spawnTestMission = {
	hint "Creating test mission...";
	sleep 1;

	testMissionMarker = createMarker ["Test Mission", _newRtPos];
	testMissionMarker setMarkerType "mil_destroy";
	testMissionMarker setMarkerColor "ColorRed";
	testMissionMarker setMarkerText "Test Mission";
	testMissionMarker setMarkerSize [1,1];

	testMissionTask = ["testTask", true, ["Move to the indicated location", "ALPHA - Move to the indicated location", ""], getMarkerPos testMissionMarker, true, 1, true, true] call bis_fnc_setTask;

	testMissionTrg = createTrigger ["EmptyDetector", getMarkerPos testMissionMarker];
	testMissionTrg setTriggerArea [50, 50, 0, true];
	testMissionTrg setTriggerActivation ["WEST", "PRESENT", true];
	testMissionTrg setTriggerStatements ["this", "hint 'trigger activated'; [testMissionTask, 'SUCCEEDED', true] call bis_fnc_taskSetState; [testMissionMarker, testMissionTrg, testMissionTask] execVM 'functions\cleanMissionUp.sqf';", ""];

	_xnull = [testMissionMarker, 2, 150, [true,false], [true, false, false], false, 0.1, 0.05, "default", nil, nil, 1] execVM "LV\militarize.sqf";
	_znull = [[1],[player],1600,true,true] execVM "LV\LV_functions\LV_fnc_simpleCache.sqf";

	sleep 1;
	hint "Test Mission Created...";
};

//MAIN LOGIC
_missionDetails = switch (_missionType) do {
	case "test": {call fn_spawnTestMission};
};

nul = [] execVM "taskFinder.sqf";