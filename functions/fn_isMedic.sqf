#include "function_macros.hpp"
params[["_unit", player, [player]]];
if(!GVAR(medical_rewrite)) exitWith {
	//old ace
	_unit call ace_medical_fnc_isMedic;
};
//new ace
_unit call ace_medical_treatment_fnc_isMedic;