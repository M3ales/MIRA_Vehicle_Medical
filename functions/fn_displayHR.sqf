#include "function_macros.hpp"
#include "medical_macros.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]]
];

_hr = [_patient] call FUNC(getHeartRate);
if(_hr == 0) exitWith {
	NO_HR_MESSAGE
};

if(_isMedic) exitWith {
	round _hr
};

NOTMEDIC_LOWHR_MESSAGE