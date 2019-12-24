#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_medic", player], ["_unit", player]];
_hr = _unit getVariable ["ace_medical_heartRate", 80];
if(_medic call ace_medical_fnc_isMedic) exitWith {
	round _hr
};
NOTMEDIC_LOWHR_MESSAGE