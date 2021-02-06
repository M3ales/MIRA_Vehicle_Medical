#include "function_macros.hpp"

params[
	"_patient"
];

([_patient] call FUNC(getFractures)) findIf { _x != 0 } > -1