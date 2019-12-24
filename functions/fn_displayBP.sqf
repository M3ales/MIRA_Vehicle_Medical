#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_medic", player], ["_unit", player]];
_bp = [_unit] call ace_medical_status_fnc_getBloodPressure;
if(_medic call ace_medical_fnc_isMedic) then {
	_bp
}else
{
	if(_bp > NOTMEDIC_LOWBP_THRESHOLD) then {
		NOTMEDIC_LOWBP_MESSAGE
	}else{
		//shouldn't happen ever, tell its an error
		"Error"
	};
};