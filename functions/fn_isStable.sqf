#include "function_macros.hpp"
#include "ace_medical_macros.hpp"
/*
 * Author: M3ales
 *
 * Based on https://github.com/acemod/ACE3/blob/v3.13.5/addons/medical_ai/functions/fnc_isInjured.sqf
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * If in cardiac arrest or not <BOOLEAN>
 *
 * Example:
 * [_unit] call MIRA_Vehicle_Medical_fnc_isCardiacArrest
 * Public: Yes
 */
params[
	"_patient",
	["_isMedic", false, [false]],
	["_legacyAce", false, [false]]
];

if !(alive _patient) exitWith { false };

(!([_patient] call FUNC(isBleeding)))
	&& { 
		!([_patient] call FUNC(isUnconscious)) 
	}
	&& {
		// no fractures on legs
		!([_patient] call FUNC(hasLegFractures))
	}
	/* Don't actually care if low hr/bp, thats stable
	&& {
		private _lowHR = [_patient, _isMedic, _legacyAce] call FUNC(hasLowHR);
		private _lowBP = [_patient, _isMedic, _legacyAce] call FUNC(hasLowBP);
		!_lowHR && !_lowBP
	}
	/*