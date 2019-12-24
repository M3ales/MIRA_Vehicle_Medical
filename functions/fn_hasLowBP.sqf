#include "function_macros.hpp"
#include "medical_macros.hpp"
params[["_unit", player, [player]], ["_player", player]];
_threshold = GVAR(ThresholdLowBP);
_bp = [_unit] call ace_medical_fnc_getBloodPressure;
_lowBP = _bp select 0;
_highBP = _bp select 1;
if(_player call ace_medical_fnc_isMedic) then {
	if(_lowBP > _threshold && _highBP > _threshold) exitWith {
		false
	};
	true
}else {
	if(_lowBP > NOTMEDIC_LOWBP_THRESHOLD) exitWith{
		false
	};
	true
};