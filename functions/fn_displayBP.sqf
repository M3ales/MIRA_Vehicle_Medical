#include "function_macros.hpp"
#include "medical_macros.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]]
];

_bp = [_patient] call FUNC(getBloodPressure);
_bp params ["_bpLow", "_bpHigh"];
if(_isMedic) exitWith {
	format["%1/%2", (round _bpHigh), (round _bpLow)]
};
NOTMEDIC_LOWBP_MESSAGE