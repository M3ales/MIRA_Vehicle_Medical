#include "ace_medical_macros.hpp"
#include "function_macros.hpp"

params["_patient"];

private _fractures = [_patient] call FUNC(getFractures);
private _numFractures = 0;

if(_fractures select HITPOINT_INDEX_HEAD == 1) then
{
	_numFractures = _numFractures +  1;
};
if(_fractures select HITPOINT_INDEX_BODY == 1) then
{
	_numFractures = _numFractures +  1;
};
if(_fractures select HITPOINT_INDEX_LARM == 1) then
{
	_numFractures = _numFractures +  1;
};
if(_fractures select HITPOINT_INDEX_RARM == 1) then
{
	_numFractures = _numFractures +  1;
};
if(_fractures select HITPOINT_INDEX_LLEG == 1) then
{
	_numFractures = _numFractures +  1;
};
if(_fractures select HITPOINT_INDEX_RLEG == 1) then
{
	_numFractures = _numFractures +  1;
};
_numFractures