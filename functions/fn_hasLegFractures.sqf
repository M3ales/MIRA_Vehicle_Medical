#include "ace_medical_macros.hpp"
#include "Function_macros.hpp"

params[
	"_patient"
];

private _fractures = [_patient] call FUNC(getFractures);

((_fractures select HITPOINT_INDEX_LLEG) == 1)
	|| ((_fractures select HITPOINT_INDEX_RLEG) == 1)