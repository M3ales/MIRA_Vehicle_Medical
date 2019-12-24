#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_medic", player], ["_unit", player]];
_bp = [_unit] call ace_medical_fnc_getBloodPressure;
if(_medic call ace_medical_fnc_isMedic) exitWith {
	round _bp
};
NOTMEDIC_LOWBP_MESSAGE