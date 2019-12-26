#include "function_macros.hpp"
params[["_unit", player]];
_ivs = _unit getVariable ["ace_medical_ivBags", []];
_sum = 0;
{
	sum = sum + (_x select 0);
}forEach _ivs;
_sum