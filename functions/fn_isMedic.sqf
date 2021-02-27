#include "function_macros.hpp"

params[
	"_patient"
];

if(GVAR(legacyAce)) exitWith {
	//old ace
	_patient call ace_medical_fnc_isMedic;
};
//new ace
_patient call ace_medical_treatment_fnc_isMedic;