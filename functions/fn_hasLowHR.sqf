#include "function_macros.hpp"
#include "medical_macros.hpp"
#include "ace_medical_macros.hpp"
params[["_target", player, [player]], ["_player", player, [player]], ["_stable", true, [true]]];

_threshold = GVAR(Stable_ThresholdLowHR);
if(!_stable) then {
	_threshold = GVAR(Unstable_ThresholdLowHR);
};
_hr = GET_HEART_RATE(_unit);

if(_player call FUNC(isMedic)) then {
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