#include "function_macros.hpp"
params[["_unit", player, [player]]];
if(GVAR(medical_rewrite)) exitWith {
	[_unit] call ace_medical_status_fnc_getBloodPressure
};
_unit call ace_medical_fnc_getBloodPressure