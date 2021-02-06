#include "ace_medical_macros.hpp"
#include "function_macros.hpp"

params["_patient"];

private _fractures = [_patient] call FUNC(getFractures);
private _numLegFractures = 0;

if(_fractures select HITPOINT_INDEX_LLEG > 0) then
{
	_numLegFractures = _numLegFractures +  1;
};
if(_fractures select HITPOINT_INDEX_RLEG > 0) then 
{
	_numLegFractures = _numLegFractures +  1;
};
_numLegFractures