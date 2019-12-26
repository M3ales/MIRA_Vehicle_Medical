#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_medic", player], ["_unit", player]];
_bp = _unit call ace_medical_fnc_getBloodPressure;
_bp params ["_bpLow", "_bpHigh"];
if(_medic call ace_medical_fnc_isMedic) exitWith {
	format["%1/%2", (round _bpHigh), (round _bpLow)]
};
NOTMEDIC_LOWBP_MESSAGE