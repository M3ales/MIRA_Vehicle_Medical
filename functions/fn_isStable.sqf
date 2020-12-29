#include "ace_medical_macros.hpp"
params["_unit"];

if !(alive _unit) exitWith {false};

(GET_WOUND_BLEEDING(_unit) == 0)
	&& { IS_UNCONSCIOUS(_unit) == false }
	&& { GET_FRACTURES(_unit) isEqualTo DEFAULT_FRACTURE_VALUES }