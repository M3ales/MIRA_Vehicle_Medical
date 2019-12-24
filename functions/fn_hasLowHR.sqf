#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_unit", player, [player]]];
_threshold = GVAR(ThresholdLowHR);
_hr = _unit getVariable ["ace_medical_heartRate", 80];
if(_player call ace_medical_fnc_isMedic) then {
	if(_hr > _threshold) exitWith {
		false
	};
	true
}else {
	if(_hr > NOTMEDIC_LOWHR_THRESHOLD) exitWith {
		false
	};
	true
};