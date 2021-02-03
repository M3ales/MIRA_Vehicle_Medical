#include "functions\function_macros.hpp"
LOG("PreInit Begin");

//ace_common_getVersion is broken for some patches, we look manually to ensure data is good, probably wont work everywhere.
getArray(configFile >> "CfgPatches" >> "ace_main" >> "versionAR") params ["_aceMajor", "_aceMinor"];
if(_aceMajor >= 3 && _aceMinor >= 13) then {
	LOG(format["ACE Version is after medical rewrite"]);
	GVAR(legacyAce) = false;
}else{
	LOG(format["ACE Version is before medical rewrite"]);
	GVAR(legacyAce) = true;
};

LOG("PREP Begin");
#include "XEH_PREP.sqf"
LOG("PREP Complete");

LOG("Creating CBA Addon Options");
//General
[QUOTE(GVAR(EnableAVM)), "CHECKBOX", ["Enable AVM", "Determines if ACE Vehicle Medical will be shown at all"], ["ACE Vehicle Medical", "General"], true, 0, {}] call CBA_fnc_addSetting;

//Unstable
_unstableCategory = ["ACE Vehicle Medical", "Unstable"];
[QUOTE(GVAR(EnableUnstable)), "CHECKBOX", ["Enable Unstable List", "Determines if Unstable list will be shown"], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackCardiacArrest)), "CHECKBOX", ["Track Cardiac Arrest", "Determines if Cardiac Arrest will be monitored and reported by AVM"], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackBleeding)), "CHECKBOX", ["Track Bleeding", "Determines if Bleeding will be monitored and reported by AVM"], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackUnconscious)), "CHECKBOX", ["Track Unconscious", "Determines if Consciousness will be monitored and reported by AVM"],_unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackLowBP)), "CHECKBOX", ["Track Low Blood Pressure", "Determines if low blood pressure will be monitored and reported by AVM"], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_ThresholdLowBP)), "SLIDER", ["Low Blood Pressure Threshold", "Value below which a given patient will have 'low' blood pressure"], _unstableCategory, [1, 120, 80, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackIV)), "CHECKBOX", ["Track IVs", "Determines if total volume of IVs is displayed"], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_TrackLowHR)), "CHECKBOX", ["Track Low Heart Rate", "Determines if low heart rate will be monitored and reported by AVM"], _unstableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Unstable_ThresholdLowHR)), "SLIDER", ["Low Heart Rate Threshold", "Value below which a given patient will have 'low' heart rate"], _unstableCategory, [1, 120, 50, 0], 0, {}] call CBA_fnc_addSetting;

//Stable
_stableCategory = ["ACE Vehicle Medical", "Stable"];
[QUOTE(GVAR(EnableStable)), "CHECKBOX", ["Enable Stable List", "Determines if Stable list will be shown"], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackNeedsBandage)), "CHECKBOX", ["Track Open Wounds", "Determines if open wounds to be bandaged will be monitored and reported by AVM"], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackStitchableWounds)), "CHECKBOX", ["Track Stitchable Wounds", "Determines if stitchable body parts will be monitored and reported by AVM"], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackLowBP)), "CHECKBOX", ["Track Low Blood Pressure", "Determines if low blood pressure will be monitored and reported by AVM"], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackIV)), "CHECKBOX", ["Track IVs", "Determines if IV total volume will be displayed"], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_ThresholdLowBP)), "SLIDER", ["Low Blood Pressure Threshold", "Value below which a given patient will have 'low' blood pressure"], _stableCategory, [1, 120, 80, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_TrackLowHR)), "CHECKBOX", ["Track Low Heart Rate", "Determines if low heart rate will be monitored and reported by AVM"], _stableCategory, true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(Stable_ThresholdLowHR)), "SLIDER", ["Low Heart Rate Threshold", "Value below which a given patient will have 'low' heart rate"], _stableCategory, [1, 120, 50, 0], 0, {}] call CBA_fnc_addSetting;

//vehicles
_vehicleCategory = ["ACE Vehicle Medical", "Vehicles"];
#define VEH_ENABLE(type) [QUOTE(GVAR(CONCAT(Vehicles_Enable,type))), "CHECKBOX", [QUOTE(CONCAT(Enable on ,type)), QUOTE(CONCAT(Determines if AVM is enabled for ,type))], _vehicleCategory, true, 0, {}] call CBA_fnc_addSetting
VEH_ENABLE(Car);
VEH_ENABLE(Helicopter);
VEH_ENABLE(Plane);
VEH_ENABLE(Ship);
VEH_ENABLE(Tank);

LOG("PreInit Complete");