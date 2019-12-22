//adapted from https://github.com/acemod/ACE3/blob/master/addons/medical_treatment/functions/fnc_getStitchableWounds.sqf
#include "function_macros.hpp"
params ["_unit"]; 
_openWounds = [_unit] call FUNC(getOpenWounds);   
_bleedingWounds = [];  
{  
    _x params["", "_bodyPartN", "_amountOf", "_bleedingRate"];  
    if(_amountOf > 0 && _bleedingRate > 0) then {  
        _bleedingWounds pushBack _x;  
    };  
} forEach _openWounds;
_bandagedWounds = _unit getVariable ["ace_medical_bandagedWounds",[]];  
_result = [];  
{  
    if(!(_x in _bleedingWounds)) then {  
        _result pushBack _x;  
    };  
} forEach _bandagedWounds; 
LOG(format["Stitchable Wounds: %1",  count _result]);
_result