#include "function_macros.hpp"

params[
	"_patient"
];

private _ivs = _patient getVariable ["ace_medical_ivBags", []];
private _sum = 0;
{
	_sum = _sum + (_x select 0);
}forEach _ivs;
_sum