#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_medic", player], ["_unit", player]];
_bp = [_unit] call ace_medical_fnc_getBloodPressure;
_bpLow = round (_bp select 0);
_bpHigh = round (_bp select 1);
if(_medic call ace_medical_fnc_isMedic) exitWith {
	format["%1/%2", _bpLow, _bpHigh];
};
NOTMEDIC_LOWBP_MESSAGE