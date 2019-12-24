#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_medic", player], ["_unit", player]];
_hr = _unit getVariable ["ace_medical_heartRate", 80];
if(_medic call ace_medical_fnc_isMedic) then {
	_hr
}else
{
	if(_hr > NOTMEDIC_LOWHR_THRESHOLD) then {
		NOTMEDIC_LOWHR_MESSAGE
	}else{
		//shouldn't happen ever, tell its an error
		"Error"
	};
};