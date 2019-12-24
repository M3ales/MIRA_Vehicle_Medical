#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_unit", player, [player]], ["_player", player, [player]], ["_stable", true, [true]]];

if(_stable) then {
	_threshold = GVAR(Stable_ThresholdLowHR);
}else {
	_threshold = GVAR(Unstable_ThresholdLowHR);
};

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