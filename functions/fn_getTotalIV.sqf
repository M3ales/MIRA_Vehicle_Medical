#include "function_macros.hpp"

params[
	"_patient"
];

_ivs = _patient getVariable ["ace_medical_ivBags", []];
_sum = 0;
{
	sum = sum + (_x select 0);
}forEach _ivs;
_sum