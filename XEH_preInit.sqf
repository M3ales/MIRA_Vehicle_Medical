#include "functions\function_macros.hpp"
LOG("PreInit Begin");
LOG("PREP Begin");
#include "XEH_PREP.sqf"
LOG("PREP Complete");

LOG("Creating CBA Addon Options");
//General
[QUOTE(GVAR(EnableAVM)), "CHECKBOX", ["Enable AVM", "Determines if ACE Vehicle Medical will be shown at all"], ["ACE Vehicle Medical", "General"], true, 0, {}] call CBA_fnc_addSetting;
//Unstable
[QUOTE(GVAR(EnableUnstable)), "CHECKBOX", ["Enable Unstable List", "Determines if Unstable list will be shown"], ["ACE Vehicle Medical", "Unstable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackCardiacArrest)), "CHECKBOX", ["Track Cardiac Arrest", "Determines if Cardiac Arrest will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Unstable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackBleeding)), "CHECKBOX", ["Track Bleeding", "Determines if Bleeding will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Unstable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackUnconscious)), "CHECKBOX", ["Track Unconscious", "Determines if Consciousness will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Unstable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(UnstableTrackLowBP)), "CHECKBOX", ["Track Low Blood Pressure", "Determines if low blood pressure will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Unstable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(UnstableTrackLowHR)), "CHECKBOX", ["Track Low Heart Rate", "Determines if low heart rate will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Unstable"], true, 0, {}] call CBA_fnc_addSetting;
//Stable
[QUOTE(GVAR(EnableStable)), "CHECKBOX", ["Enable Stable List", "Determines if Stable list will be shown"], ["ACE Vehicle Medical", "Stable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackNeedsBandage)), "CHECKBOX", ["Track Open Wounds", "Determines if open wounds to be bandaged will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Stable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackStitchableWounds)), "CHECKBOX", ["Track Stitchable Wounds", "Determines if stitchable body parts will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Stable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackLowBP)), "CHECKBOX", ["Track Low Blood Pressure", "Determines if low blood pressure will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Stable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(ThresholdLowBP)), "SLIDER", ["Low Blood Pressure Threshold", "Value below which a given patient will have 'low' blood pressure"], ["ACE Vehicle Medical", "Stable"], [1, 120, 80, 0], 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(TrackLowHR)), "CHECKBOX", ["Track Low Heart Rate", "Determines if low heart rate will be monitored and reported by AVM"], ["ACE Vehicle Medical", "Stable"], true, 0, {}] call CBA_fnc_addSetting;
[QUOTE(GVAR(ThresholdLowHR)), "SLIDER", ["Low Heart Rate Threshold", "Value below which a given patient will have 'low' heart rate"], ["ACE Vehicle Medical", "Stable"], [1, 120, 50, 0], 0, {}] call CBA_fnc_addSetting;

LOG("PreInit Complete");