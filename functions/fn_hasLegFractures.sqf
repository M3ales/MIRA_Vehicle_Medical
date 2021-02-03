#include "ace_medical_macros.hpp"

params[
	"_patient"
];

private _fractures = GET_FRACTURES(_patient);

((_fractures select HITPOINT_INDEX_LLEG) == 1)
	|| ((_fractures select HITPOINT_INDEX_RLEG) == 1)