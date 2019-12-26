#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_target", player, [player]], ["_player", player, [player]], ["_stable", true, [true]]];

_threshold = GVAR(Stable_ThresholdLowBP);
if(!_stable) then {
	_threshold = GVAR(Unstable_ThresholdLowBP);
};
_bp = [_target] call ace_medical_fnc_getBloodPressure;
_bp params ["", "_highBP"];
if(_player call ace_medical_fnc_isMedic) then {
	if(_highBP > _threshold) exitWith {
		false
	};
	true
}else {
	if(_highBP > NOTMEDIC_LOWBP_THRESHOLD) exitWith{
		false
	};
	true
};