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
	["_isMedic", false, [false]]
];

!([_patient] call FUNC(isUnstable))
	&& {
		// Has wounds to stitch, or bandage
		([_patient, _isMedic] call FUNC(hasLowBP))
		|| { ([_patient, _isMedic] call FUNC(hasLowHR)) }
		|| { ([_patient] call FUNC(hasFractures)) }
		|| { count ([_patient] call FUNC(getStitchableWounds)) > 0 }
		|| { ([_patient] call FUNC(getNumberOfWoundsToBandage)) > 0 }
	}